// ============================================================
// SMART MULTI-MENU REZZER SYSTEM v2.7 (FINAL FIX)
// By Rey Dreamer [secondlife:///app/agent/5dc4a3e7-2bfe-4e67-9578-47214f879985/about]
// Enhanced with straight line spacing control
// ============================================================
//
// 📜 FEATURES:
// • Nested menus: Straight Line / Curved Line / Remove All
// • Straight line with selectable count AND custom spacing
// • Curved line placement with adjustable params
// • Dynamic count preview
// • Keeps curved menu open after entering params
// • Deletes all rezzed objects on command
//
// ============================================================
string OBJECT__NAME = "prayerwheel_sk"; // Object name in inventory
integer CHANNEL;
integer LISTEN_HANDLE;
key toucher;

// 📏 STRAIGHT LINE VARIABLES
float STRAIGHT_SPACING = 1.0; // Spacing for straight line objects

// 🌀 CURVED LINE VARIABLES
float ARC_RADIUS = 5.0;
float SPACING = 1.0;
float ARC_ANGLE = 180.0;
integer ARC_COUNT = 0;

// 🔄 STATE TRACKING
string LAST_MENU = "MAIN"; // Track which menu to return to after timer

integer deleteChannel = 98765; // Used for region delete command

// ============================================================
// 📋 Utility: Update estimated count for curve
// ============================================================
updateCount()
{
    float angleRad = ARC_ANGLE * DEG_TO_RAD;
    ARC_COUNT = (integer)(angleRad * ARC_RADIUS / SPACING);
    if (ARC_COUNT < 2) ARC_COUNT = 2;
}

// ============================================================
// 📋 Utility: Show main menu
// ============================================================
showMainMenu()
{
    LAST_MENU = "MAIN";
    list buttons = ["STRAIGHT LINE", "CURVED LINE", "REMOVE ALL"];
    llDialog(toucher, "📦 Smart Rezzer Main Menu\nSelect an option:", buttons, CHANNEL);
}

// ============================================================
// 📏 Straight Menu
// ============================================================
showStraightMenu()
{
    LAST_MENU = "STRAIGHT";
    string desc = "📏 Straight Line Setup\n"+"---------------\n"
                  + "✰ Current Spacing: " + (string)STRAIGHT_SPACING + " m\n"+"---------------\n"
                  + "Select count of objects:";
    
    list buttons = ["5", "10", "15", "25", "SET SPACING", "BACK", "REMOVE ALL"];
    llDialog(toucher, desc, buttons, CHANNEL);
}

// ============================================================
// 🌀 Curved Menu
// ============================================================
showCurvedMenu()
{
    LAST_MENU = "CURVED";
    updateCount();
    string desc = "🌀 Curved Line Setup\n"+"---------------\n"+"✰ Current Parameters:\n"
                  + "Radius: " + (string)ARC_RADIUS + " m\n"
                  + "Spacing: " + (string)SPACING + " m\n"
                  + "Angle: " + (string)ARC_ANGLE + "°\n"
                  + "Count (est.): " + (string)ARC_COUNT + "\n"+"---------------\n"
                  +"* [PARAMS] : Set Parameters \n"
                  + "PARAMS FORMAT: <RADIUS> <SPACING> <ANGLE>\n"
                  + "Example: 5 2 180\n"+"---------------\n\n"
                  +"* [REZ CURVE] : Rez Objects with set Params \n"
                  + "* [REMOVE ALL] : Remove All the existing Objects \n"+"---------------\n"

                  + "Select an option:";
    
    list buttons = ["PARAMS", "REZ CURVE", "REMOVE ALL", "BACK"];
    llDialog(toucher, desc, buttons, CHANNEL);
}

// ============================================================
// 📦 Rez Straight Line
// ============================================================
rezStraight(integer count)
{
    vector base = llGetPos();
    rotation rot = llGetRot();

    llSetText("Rezzing " + (string)count + " objects in a straight line...\nSpacing: " + (string)STRAIGHT_SPACING + " m",<1,1,0>,1.0);
    
    integer i;
    for (i = 0; i < count; i++)
    {
        vector offset = <STRAIGHT_SPACING * i, 0, 2>;
        llRezObject(OBJECT__NAME, base + (offset * rot), ZERO_VECTOR, rot, deleteChannel);
        llSleep(0.3);
    }
}

// ============================================================
// 🌀 Rez Curved Line
// ============================================================
rezCurve()
{
    vector base = llGetPos();
    rotation rot = llGetRot();
    updateCount();

    llSetText("Rezzing curve:\nRadius=" + (string)ARC_RADIUS
        + "m | Angle=" + (string)ARC_ANGLE + "° | Spacing=" + (string)SPACING
        + "m | Count=" + (string)ARC_COUNT, <0,1,0>,1.0);

    float angleRad = ARC_ANGLE * DEG_TO_RAD;
    float startAngle = -angleRad / 2;
    float step = angleRad / (ARC_COUNT - 1);

    integer i;
    for (i = 0; i < ARC_COUNT; i++)
    {
        float theta = startAngle + (step * i);
        vector offset = <llCos(theta) * ARC_RADIUS, llSin(theta) * ARC_RADIUS, 0>;
        llRezObject(OBJECT__NAME, base + (offset * rot), ZERO_VECTOR, rot, deleteChannel);
        llSleep(0.3);
    }
}

// ============================================================
// 🗑️ Delete All
// ============================================================
deleteAll()
{
    llOwnerSay("🗑️ Removing all rezzed objects...");
    llRegionSay(deleteChannel, "DELETE");
}

// ============================================================
// STATE MACHINE
// ============================================================
default
{
    state_entry()
    {
        llOwnerSay("📦 Smart Rezzer v2.7 ready. Touch to open menu.");
    }

    touch_start(integer total_number)
    {
        toucher = llDetectedKey(0);
        CHANNEL = (integer)(llFrand(1000000) * -1);
        llListenRemove(LISTEN_HANDLE);
        LISTEN_HANDLE = llListen(CHANNEL, "", toucher, "");
        showMainMenu();
    }

    listen(integer channel, string name, key id, string msg)
    {
        // ===== MAIN MENU =====
        if (msg == "STRAIGHT LINE")
        {
            showStraightMenu();
        }
        else if (msg == "CURVED LINE")
        {
            showCurvedMenu();
        }
        else if (msg == "REMOVE ALL")
        {
            deleteAll();
            showMainMenu();
        }
        else if (msg == "BACK")
        {
            showMainMenu();
        }

        // ===== STRAIGHT MENU =====
        else if (msg == "5" || msg == "10" || msg == "15" || msg == "25")
        {
            rezStraight((integer)msg);
            showStraightMenu();
        }
        else if (msg == "SET SPACING")
        {
            llTextBox(toucher, "Enter spacing between objects (in meters):\nExample: 2.5", CHANNEL);
        }

        // ===== CURVED MENU =====
        else if (msg == "PARAMS")
        {
            llTextBox(toucher, "Enter parameters in this format:\nRADIUS SPACING ANGLE\nExample: 5 1 180", CHANNEL);
        }
        else if (msg == "REZ CURVE")
        {
            rezCurve();
            llSleep(0.2);
            showCurvedMenu();
        }

        // ===== TEXT INPUT =====
        else
        {
            // Check if it contains spaces (curved params)
            if (llSubStringIndex(msg, " ") != -1)
            {
                list parts = llParseString2List(msg, [" "], []);
                if (llGetListLength(parts) == 3)
                {
                    float tempRadius = (float)llList2String(parts, 0);
                    float tempSpacing = (float)llList2String(parts, 1);
                    float tempAngle = (float)llList2String(parts, 2);
                    
                    // Validate curved parameters
                    if (tempRadius > 0.0 && tempSpacing > 0.0 && tempAngle > 0.0 && tempAngle <= 360.0)
                    {
                        ARC_RADIUS = tempRadius;
                        SPACING = tempSpacing;
                        ARC_ANGLE = tempAngle;
                        updateCount();
                        llOwnerSay("✅ Updated curve params:\nRadius=" + (string)ARC_RADIUS +
                                   " | Spacing=" + (string)SPACING +
                                   " | Angle=" + (string)ARC_ANGLE +
                                   " | Count≈" + (string)ARC_COUNT);
                        LAST_MENU = "CURVED";
                    }
                    else
                    {
                        llOwnerSay("⚠️ Invalid values! Ensure:\n• Radius > 0\n• Spacing > 0\n• Angle > 0 and ≤ 360");
                        LAST_MENU = "CURVED";
                    }
                }
                else
                {
                    llOwnerSay("⚠️ Invalid format. Please enter 3 numbers: radius spacing angle");
                    LAST_MENU = "CURVED";
                }
                llSetTimerEvent(0.5);
            }
            else
            {
                // Single value input (straight line spacing)
                float value = (float)msg;
                if (value > 0.0)
                {
                    STRAIGHT_SPACING = value;
                    llOwnerSay("✅ Straight line spacing updated to: " + (string)STRAIGHT_SPACING + " m");
                    LAST_MENU = "STRAIGHT";
                }
                else
                {
                    llOwnerSay("⚠️ Invalid spacing value. Please enter a positive number (e.g., 2.5)");
                    LAST_MENU = "STRAIGHT";
                }
                llSetTimerEvent(0.5);
            }
        }
    }

    timer()
    {
        llSetTimerEvent(0.0);
        
        // Reinitialize listener to ensure it's still active
        llListenRemove(LISTEN_HANDLE);
        LISTEN_HANDLE = llListen(CHANNEL, "", toucher, "");
        
        if (LAST_MENU == "STRAIGHT")
        {
            showStraightMenu();
        }
        else if (LAST_MENU == "CURVED")
        {
            showCurvedMenu();
        }
        else
        {
            showMainMenu();
        }
    }
}

