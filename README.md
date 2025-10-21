# 📦 Smart Multi-Menu Rezzer System v2.7 - User Manual

## 📋 Table of Contents
1. [Overview](#overview)
2. [Getting Started](#getting-started)
3. [Main Menu](#main-menu)
4. [Straight Line Mode](#straight-line-mode)
5. [Curved Line Mode](#curved-line-mode)
6. [Remove All Objects](#remove-all-objects)
7. [Tips & Troubleshooting](#tips--troubleshooting)

---

## 🎯 Overview

The **Smart Multi-Menu Rezzer System v2.7** is a powerful LSL script for Second Life that allows you to rez (spawn) objects in organized patterns - either in straight lines or curved arcs. With customizable spacing and parameters, you have full control over object placement.

### ✨ Key Features:
- 📏 **Straight Line Rezzing** - Place objects in a horizontal line with adjustable spacing
- 🌀 **Curved Line Rezzing** - Place objects in an arc with customizable radius, spacing, and angle
- 🗑️ **One-Click Deletion** - Remove all rezzed objects instantly
- 📊 **Live Parameter Preview** - See estimated object counts before rezzing
- 🎮 **Intuitive Menu System** - Nested dialogs for easy navigation

---

## 🚀 Getting Started

### Prerequisites:
1. **Object Name**: Ensure the object you want to rez is in your inventory with the exact name: `prayerwheel_sk`
   - ⚠️ **Important**: If your object has a different name, you'll need to edit line 15 in the script and change:
     ```
     string OBJECT__NAME = "prayerwheel_sk";
     ```
   - To your actual object name

2. **Permissions**: Make sure you have permission to rez objects in your current location

### Initial Setup:
1. 📋 **Create a new prim** in Second Life and add this script to it
2. 👆 **Touch the rezzer object** - This will display the Main Menu
3. 🎮 **Follow the on-screen menus** to select your rezzing mode

---

## 📱 Main Menu

When you touch the rezzer, you'll see the **Main Menu** with three options:

```
📦 Smart Rezzer Main Menu
Select an option:

[STRAIGHT LINE]  [CURVED LINE]  [REMOVE ALL]
```

### Menu Options:

| Button | Function |
|--------|----------|
| 🔷 **STRAIGHT LINE** | Rez objects in a horizontal line with custom spacing |
| 🔷 **CURVED LINE** | Rez objects in an arc/curve pattern |
| 🔷 **REMOVE ALL** | Delete all previously rezzed objects |

---

## 📏 Straight Line Mode

### How to Use:

1️⃣ From the **Main Menu**, click **[STRAIGHT LINE]**

2️⃣ You'll see the **Straight Line Setup** menu:
```
📏 Straight Line Setup
---------------
✰ Current Spacing: 1.0 m
---------------
Select count of objects:

[5]  [10]  [15]  [25]  [SET SPACING]  [BACK]  [REMOVE ALL]
```

3️⃣ **Choose your options:**

| Option | Description |
|--------|-------------|
| **5, 10, 15, 25** | Quick select - Rezzes that many objects with current spacing |
| **SET SPACING** | Opens a text input box to set custom spacing between objects |
| **BACK** | Returns to Main Menu |
| **REMOVE ALL** | Deletes all rezzed objects |

### Setting Custom Spacing:

1. Click **[SET SPACING]**
2. A text input box appears
3. Enter the spacing distance in meters (e.g., `2.5`)
4. Click **Sumbit** ✅
5. You'll see confirmation: `✅ Straight line spacing updated to: 2.5 m`
6. The menu automatically reopens - now select your object count
7. Objects will rez in a line with your custom spacing! 🎉

### Example:
- **Setting**: 25 objects with 2.5m spacing
- **Result**: Objects placed 2.5 meters apart horizontally
- **Total Line Length**: ~60 meters (25 × 2.5m)

---

## 🌀 Curved Line Mode

### How to Use:

1️⃣ From the **Main Menu**, click **[CURVED LINE]**

2️⃣ You'll see the **Curved Line Setup** menu:
```
🌀 Curved Line Setup
---------------
✰ Current Parameters:
Radius: 5.0 m
Spacing: 1.0 m
Angle: 180.0°
Count (est.): 28
---------------
* [PARAMS] : Set Parameters 
PARAMS FORMAT: <RADIUS> <SPACING> <ANGLE>
Example: 5 2 180
---------------

* [REZ CURVE] : Rez Objects with set Params 
* [REMOVE ALL] : Remove All the existing Objects 
---------------

Select an option:

[PARAMS]  [REZ CURVE]  [REMOVE ALL]  [BACK]
```

### Menu Options:

| Button | Function |
|--------|----------|
| **PARAMS** | Opens text input to set radius, spacing, and angle |
| **REZ CURVE** | Rezzes objects with current parameters |
| **REMOVE ALL** | Deletes all rezzed objects |
| **BACK** | Returns to Main Menu |

### Setting Custom Parameters:

1. Click **[PARAMS]**
2. A text input box appears asking for three values
3. Enter parameters in this format: `RADIUS SPACING ANGLE`
   - **RADIUS**: Distance from center point to the arc (in meters, must be > 0)
   - **SPACING**: Distance between each object along the arc (in meters, must be > 0)
   - **ANGLE**: Total arc angle to cover (0-360°, must be > 0 and ≤ 360)
4. Click **Submit** ✅
5. The system calculates the estimated object count and shows confirmation:
   ```
   ✅ Updated curve params:
   Radius=8.0 | Spacing=1.5 | Angle=180° | Count≈33
   ```
6. The menu automatically reopens with updated values
7. Click **[REZ CURVE]** to rez the objects!

### Parameter Examples:

#### Example 1: Gentle Semi-Circle
- **Input**: `10 1.5 180`
- **Result**: 34 objects in a semi-circle with 10m radius
- **Use Case**: Creating arcs for gardens or seating areas

#### Example 2: Tight Full Circle
- **Input**: `5 0.5 360`
- **Result**: ~63 objects in a complete circle with 5m radius
- **Use Case**: Creating circular fences or decorative rings

#### Example 3: Wide Quarter Circle
- **Input**: `15 2.0 90`
- **Result**: ~24 objects in a quarter-circle with 15m radius
- **Use Case**: Creating corner arrangements

### Parameter Validation:
The system validates all parameters:
- ✅ Radius must be **greater than 0**
- ✅ Spacing must be **greater than 0**
- ✅ Angle must be **greater than 0 and less than or equal to 360**

If any parameter is invalid, you'll see:
```
⚠️ Invalid values! Ensure:
• Radius > 0
• Spacing > 0
• Angle > 0 and ≤ 360
```

Try again! 🔄

---

## 🗑️ Remove All Objects

### How to Delete Rezzed Objects:

You can delete objects from **any menu** using one of these methods:

**Method 1: From Main Menu**
- Click **[REMOVE ALL]** on the main menu

**Method 2: From Straight Line Menu**
- Click **[REMOVE ALL]** in the Straight Line menu

**Method 3: From Curved Line Menu**
- Click **[REMOVE ALL]** in the Curved Line menu

### What Happens:
1. System sends delete command to all rezzed objects
2. Chat confirmation: `🗑️ Removing all rezzed objects...`
3. All objects with the delete channel (98765) are removed
4. Menu returns to Main Menu

⚠️ **Note**: This deletes **ALL** objects rezzed by this rezzer. Make sure you want to delete them all before confirming!

---

## 💡 Tips & Troubleshooting

### 📌 General Tips:

✅ **Tip 1: Preview Before Rezzing**
- The curved menu shows an estimated object count
- Use this to calculate total coverage before rezzing

✅ **Tip 2: Use Appropriate Spacing**
- Straight Line: 0.5m-5.0m works well for most objects
- Curved: Adjust spacing based on object size

✅ **Tip 3: Test First**
- Always start with smaller counts (5-10) to preview placement
- Then rez larger quantities once you're happy with the layout

✅ **Tip 4: Combine Patterns**
- You can rez multiple straight lines or curves
- Just touch the rezzer again for each new pattern
- Use Remove All when you want to reset

### 🔧 Troubleshooting:

**❌ "Objects won't rez"**
- Verify object name matches exactly: `prayerwheel_sk`
- Check you have permission to rez in this location
- Ensure object exists in your inventory

**❌ "Menu closes after entering parameters"**
- Wait for the chat confirmation message before clicking new buttons
- The menu will automatically reopen after a brief delay

**❌ "Spacing doesn't look right"**
- Check your spacing value is positive (> 0)
- For straight lines: spacing is measured in meters between object centers
- For curves: spacing affects density along the arc

**❌ "Can't delete objects"**
- Objects must have been rezzed by this rezzer (with deleteChannel 98765)
- Manually delete objects if the system delete fails

**❌ "Objects rezz in wrong direction"**
- Rotation is inherited from the rezzer object
- Rotate your rezzer object to change object orientation

### 🎓 Advanced Usage:

**Creating Complex Patterns:**
- Rez a straight line, then touch rezzer again
- Rez a curved line offset from the straight line
- Combine multiple rezzing sessions for complex layouts

**Fine-Tuning Curves:**
- Start with default parameters
- Adjust one parameter at a time
- Watch the count estimate change to understand impact

**Custom Object Names:**
- Edit line 15 of the script:
  ```lsl
  string OBJECT__NAME = "your_object_name";
  ```
- Replace `your_object_name` with your actual object name

---

## 📞 Support & Feedback

If you encounter issues or have feature requests:

1. 📝 **Check the troubleshooting section** above
2. 🔍 **Verify all parameters** are correct
3. 📧 **Contact the script creator** (Rey Dreamer) with details about the issue
4. 💬 **Share your feedback** to help improve future versions!

---

## 📜 Version Information

**Smart Multi-Menu Rezzer System v2.7**
- Enhanced with straight line spacing control
- Improved curved parameter validation
- Better menu state management

**Last Updated**: October 21, 2025 (UTC)

---

## ✅ Quick Reference Guide

| Task | Steps |
|------|-------|
| **Rez 10 objects in a line** | Touch rezzer → STRAIGHT LINE → 10 |
| **Create a semi-circle** | Touch rezzer → CURVED LINE → PARAMS → `8 1.5 180` → REZ CURVE |
| **Change spacing** | Touch rezzer → STRAIGHT LINE → SET SPACING → Enter value |
| **Delete everything** | Touch rezzer → REMOVE ALL (from any menu) |
| **Return to main menu** | Click BACK from any submenu |
| **Create full circle** | Touch rezzer → CURVED LINE → PARAMS → `5 1 360` → REZ CURVE |


