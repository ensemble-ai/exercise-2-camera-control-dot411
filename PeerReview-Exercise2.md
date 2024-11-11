# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Jason Zhou
* *email:* jzzzhou@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The position lock camera is implemented as a pushbox camera with a box the size of the player vessel. In practice, this works, and it has no immediate issues I can spot. I'm pretty sure there is a more computationally efficient way to do this, though. I'm marking this stage off a little for showing both the pushbox and the position cross. If not just for the implementation, I think it ruins the illusion a bit.

___
### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [X] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The autoscroller does not use a vector to define scrolling speed. This means the camera can only autoscroll in the x direction, as opposed to on the x-z plane. The box works as desired, though there is a bug where the hyperspeed trail appears outside of the box when attempting to push the autoscroller box. This might be caused by the super function in _process. 

___
### Stage 3 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [X] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Catchup speed works as desired, but moving the camera around from zero is jittery. The leash distance is unused, and does not affect the camera. This seems to be because you forgot to replace a "3" in the follow() function with the leash_distance. Assuming we fixed the leash_distance issue, there is a logic problem concerning being past the leash_distance and not being able to move, i.e. if the camera is past the leash_distance, it stops moving even if you switch directions. Because the lerp camera inherits the push box camera, it draws both a cross and a push box.

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [X] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Has the same problems as stage 3, since the target focus camera inherits the lerp camera. Otherwise, the separation of the catchup timer into x and z is awkward if you stop moving in one direction before the other.


___
### Stage 5 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Works pretty much exactly as desired. The only problem is that the box sizes are not allowed to be asymmetrical.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
- [Static typed variable spacing](https://github.com/ensemble-ai/exercise-2-camera-control-dot411/blob/341ea38bde217ef9758dd4896a53dbae595740d7/Obscura/scripts/camera_controllers/push_box.gd#L7) - There should be one whitespace between the colon and the data type for static typed variables.

- [Function line break spacing](https://github.com/ensemble-ai/exercise-2-camera-control-dot411/blob/341ea38bde217ef9758dd4896a53dbae595740d7/Obscura/scripts/camera_controllers/push_box.gd#L85) - Two line breaks should separate each function.

- [Multiple statements in one line](https://github.com/ensemble-ai/exercise-2-camera-control-dot411/blob/341ea38bde217ef9758dd4896a53dbae595740d7/Obscura/scripts/camera_controllers/lerp_camera.gd#L23) - In GDScript, it is recommended to keep the number of statements in each line to one.

- [Signal orering](https://github.com/ensemble-ai/exercise-2-camera-control-dot411/blob/341ea38bde217ef9758dd4896a53dbae595740d7/Obscura/scripts/vessel.gd#L14) - There is a line added to the vessel that does not follow GDScript code ordering. Signals should above everything besides the script description. (There's similarly an error in the original assignment with const ordering, but that's an aside.)

- [Line length](https://github.com/ensemble-ai/exercise-2-camera-control-dot411/blob/341ea38bde217ef9758dd4896a53dbae595740d7/Obscura/scripts/camera_controllers/four_way_speedup_camera.gd#L31) - There are a few lines that exceed 100 characters in length. Try to make these smaller by separating statements into multiple lines, if needed.

#### Style Guide Exemplars ####
- Consistent naming conventions - In general, new variable and function names follow snake case as recommended.

- Good code ordering - Besides the signal thing, variables and functions are declared in proper order.

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
- Improper inheritance - All of the new cameras inherit from the push box camera, when the majority of them did not need to. Especially with the lerp cameras, the only relevant inherited parts of the push box camera were two lines of code under _ready() and the draw_logic() function. The only camera controller that I feel was worth inheriting from the push box camera was the speedup push box camera. Instead, they should inherit from the CameraBaseController.

- Commit count - The entire current assignment was pushed to main in a single commit. Consider committing more for smaller changes.

- Scene tree naming - All of the cameras are named some variation of PushBoxCamera because it was duplicated. Consider changing the names for readability.

#### Best Practices Exemplars ####
- File organization - All of the new cameras were organized in  res://scripts/camera_controllers, same as the original cameras.