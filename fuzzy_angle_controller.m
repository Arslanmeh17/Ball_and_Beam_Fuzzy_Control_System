clc; clear;
%% Angle Controller

angle_fuzzy = mamfis(...
                   'NumInputs', 2, 'NumInputMFs', 3,...
                   'NumOutputs', 1, 'NumOutputMFs', 5,...
                   'AddRule', 'none');

angle_input_alt = -0.2;
angle_input_ust = 0.2;
angle_input_gap = linspace(angle_input_alt,angle_input_ust,5);

angular_velocity_alt = -0.6;
angular_velocity_ust = 0.6;
angular_velocity_gap = linspace(angular_velocity_alt,angular_velocity_ust,5);

power_alt = -6;
power_ust = 6;
power_gap = linspace(power_alt, power_ust, 5);

angle_fuzzy.Inputs(1).Name = 'angle';
angle_fuzzy.Inputs(1).Range = [angle_input_alt angle_input_ust];
angle_fuzzy.Inputs(1).MembershipFunctions(1).Name = 'negative';
angle_fuzzy.Inputs(1).MembershipFunctions(1).Type = 'trapmf';
angle_fuzzy.Inputs(1).MembershipFunctions(1).Parameters = [angle_input_gap(1) angle_input_gap(1) angle_input_gap(2) angle_input_gap(3)];

angle_fuzzy.Inputs(1).MembershipFunctions(2).Name = 'zero';
angle_fuzzy.Inputs(1).MembershipFunctions(2).Type = 'trimf';
angle_fuzzy.Inputs(1).MembershipFunctions(2).Parameters = [angle_input_gap(2) angle_input_gap(3) angle_input_gap(4)];

angle_fuzzy.Inputs(1).MembershipFunctions(3).Name = 'positive';
angle_fuzzy.Inputs(1).MembershipFunctions(3).Type = 'trapmf';
angle_fuzzy.Inputs(1).MembershipFunctions(3).Parameters = [angle_input_gap(3) angle_input_gap(4) angle_input_gap(5) angle_input_gap(5)];

angle_fuzzy.Inputs(2).Name = 'angular_velocity';
angle_fuzzy.Inputs(2).Range = [-0.6 0.6];
angle_fuzzy.Inputs(2).MembershipFunctions(1).Name = 'negative';
angle_fuzzy.Inputs(2).MembershipFunctions(1).Type = 'trapmf';
angle_fuzzy.Inputs(2).MembershipFunctions(1).Parameters = [angular_velocity_gap(1) angular_velocity_gap(1) angular_velocity_gap(2) angular_velocity_gap(3)];

angle_fuzzy.Inputs(2).MembershipFunctions(2).Name = 'zero';
angle_fuzzy.Inputs(2).MembershipFunctions(2).Type = 'trimf';
angle_fuzzy.Inputs(2).MembershipFunctions(2).Parameters = [angular_velocity_gap(2) angular_velocity_gap(3) angular_velocity_gap(4)];

angle_fuzzy.Inputs(2).MembershipFunctions(3).Name = 'positive';
angle_fuzzy.Inputs(2).MembershipFunctions(3).Type = 'trapmf';
angle_fuzzy.Inputs(2).MembershipFunctions(3).Parameters = [angular_velocity_gap(3) angular_velocity_gap(4) angular_velocity_gap(5) angular_velocity_gap(5)];

% plotmf(angle_fuzzy, 'input', 1, 1000);

angle_fuzzy.Outputs(1).Name = 'power';
angle_fuzzy.Outputs(1).Range = [power_alt power_ust];

angle_fuzzy.Outputs(1).MembershipFunctions(1).Name = 'big_negative';
angle_fuzzy.Outputs(1).MembershipFunctions(1).Type = 'trimf';
angle_fuzzy.Outputs(1).MembershipFunctions(1).Parameters = [power_gap(1) power_gap(1) power_gap(2)];

angle_fuzzy.Outputs(1).MembershipFunctions(2).Name = 'negative';
angle_fuzzy.Outputs(1).MembershipFunctions(2).Type = 'trimf';
angle_fuzzy.Outputs(1).MembershipFunctions(2).Parameters = [power_gap(1) power_gap(2) power_gap(3)];

angle_fuzzy.Outputs(1).MembershipFunctions(3).Name = 'zero';
angle_fuzzy.Outputs(1).MembershipFunctions(3).Type = 'trimf';
angle_fuzzy.Outputs(1).MembershipFunctions(3).Parameters = [power_gap(2) power_gap(3) power_gap(4)];

angle_fuzzy.Outputs(1).MembershipFunctions(4).Name = 'positive';
angle_fuzzy.Outputs(1).MembershipFunctions(4).Type = 'trimf';
angle_fuzzy.Outputs(1).MembershipFunctions(4).Parameters = [power_gap(3) power_gap(4) power_gap(5)];

angle_fuzzy.Outputs(1).MembershipFunctions(5).Name = 'big_positive';
angle_fuzzy.Outputs(1).MembershipFunctions(5).Type = 'trimf';
angle_fuzzy.Outputs(1).MembershipFunctions(5).Parameters = [power_gap(4) power_gap(5) power_gap(5)];


%plotmf(angle_fuzzy, 'output', 1, 1000);

rules = [...
    "angle == zero & angular_velocity == zero       => power = zero"; ...
    "angle == zero & angular_velocity == negative   => power = positive"; ...
    "angle == zero & angular_velocity == positive   => power = negative"; ...
    
    "angle == negative & angular_velocity == zero       => power = big_positive"; ...
    "angle == negative & angular_velocity == negative   => power = big_positive"; ...
    "angle == negative & angular_velocity == positive   => power = positive"; ...

    "angle == positive & angular_velocity == zero       => power = big_negative"; ...
    "angle == positive & angular_velocity == negative   => power = negative"; ...
    "angle == positive & angular_velocity == positive   => power = big_negative"; ...
    ];

angle_fuzzy = addRule(angle_fuzzy, rules);

%plotfis(angle_fuzzy)
% 
% opt = gensurfOptions('OutputIndex',1);
% gensurf(angle_fuzzy,opt)

%% Position Controller

position_fuzzy = mamfis(...
                   'NumInputs', 2, 'NumInputMFs', 3,...
                   'NumOutputs', 1, 'NumOutputMFs', 5,...
                   'AddRule', 'none');

position_alt = -0.7;
position_ust = 0.7;
position_gap = linspace(position_alt, position_ust, 5);

speed_alt = -0.5;
speed_ust = 0.5;
speed_gap = linspace(speed_alt, speed_ust, 5);

angle_alt = -0.2;
angle_ust = 0.2;
angle_gap = linspace(angle_alt, angle_ust, 5);


position_fuzzy.Inputs(1).Name = 'position';
position_fuzzy.Inputs(1).Range = [position_alt position_ust];
position_fuzzy.Inputs(1).MembershipFunctions(1).Name = 'negative';
position_fuzzy.Inputs(1).MembershipFunctions(1).Type = 'trapmf';
position_fuzzy.Inputs(1).MembershipFunctions(1).Parameters = [position_gap(1) position_gap(1) position_gap(2) position_gap(3)];

position_fuzzy.Inputs(1).MembershipFunctions(2).Name = 'zero';
position_fuzzy.Inputs(1).MembershipFunctions(2).Type = 'trimf';
position_fuzzy.Inputs(1).MembershipFunctions(2).Parameters = [position_gap(2) position_gap(3) position_gap(4)];

position_fuzzy.Inputs(1).MembershipFunctions(3).Name = 'positive';
position_fuzzy.Inputs(1).MembershipFunctions(3).Type = 'trapmf';
position_fuzzy.Inputs(1).MembershipFunctions(3).Parameters = [position_gap(3) position_gap(4) position_gap(5) position_gap(5)];

position_fuzzy.Inputs(2).Name = 'speed';
position_fuzzy.Inputs(2).Range = [speed_alt speed_ust];
position_fuzzy.Inputs(2).MembershipFunctions(1).Name = 'negative';
position_fuzzy.Inputs(2).MembershipFunctions(1).Type = 'trapmf';
position_fuzzy.Inputs(2).MembershipFunctions(1).Parameters = [speed_gap(1) speed_gap(1) speed_gap(2) speed_gap(3)];

position_fuzzy.Inputs(2).MembershipFunctions(2).Name = 'zero';
position_fuzzy.Inputs(2).MembershipFunctions(2).Type = 'trimf';
position_fuzzy.Inputs(2).MembershipFunctions(2).Parameters = [speed_gap(2) speed_gap(3) speed_gap(4)];

position_fuzzy.Inputs(2).MembershipFunctions(3).Name = 'positive';
position_fuzzy.Inputs(2).MembershipFunctions(3).Type = 'trapmf';
position_fuzzy.Inputs(2).MembershipFunctions(3).Parameters = [speed_gap(3) speed_gap(4) speed_gap(5) speed_gap(5)];

% plotmf(angle_fuzzy, 'input', 1, 1000);


position_fuzzy.Outputs(1).Name = 'angle';
position_fuzzy.Outputs(1).Range = [angle_alt angle_ust];

position_fuzzy.Outputs(1).MembershipFunctions(1).Name = 'big_negative';
position_fuzzy.Outputs(1).MembershipFunctions(1).Type = 'trimf';
position_fuzzy.Outputs(1).MembershipFunctions(1).Parameters = [angle_gap(1) angle_gap(1) angle_gap(2)];

position_fuzzy.Outputs(1).MembershipFunctions(2).Name = 'negative';
position_fuzzy.Outputs(1).MembershipFunctions(2).Type = 'trimf';
position_fuzzy.Outputs(1).MembershipFunctions(2).Parameters = [angle_gap(1) angle_gap(2) angle_gap(3)];

position_fuzzy.Outputs(1).MembershipFunctions(3).Name = 'zero';
position_fuzzy.Outputs(1).MembershipFunctions(3).Type = 'trimf';
position_fuzzy.Outputs(1).MembershipFunctions(3).Parameters = [angle_gap(2) angle_gap(3) angle_gap(4)];

position_fuzzy.Outputs(1).MembershipFunctions(4).Name = 'positive';
position_fuzzy.Outputs(1).MembershipFunctions(4).Type = 'trimf';
position_fuzzy.Outputs(1).MembershipFunctions(4).Parameters = [angle_gap(3) angle_gap(4) angle_gap(5)];

position_fuzzy.Outputs(1).MembershipFunctions(5).Name = 'big_positive';
position_fuzzy.Outputs(1).MembershipFunctions(5).Type = 'trimf';
position_fuzzy.Outputs(1).MembershipFunctions(5).Parameters = [angle_gap(4) angle_gap(5) angle_gap(5)];

rules = [...
    "position == zero & speed == zero       => angle = zero"; ...
    "position == zero & speed == negative   => angle = positive"; ...
    "position == zero & speed == positive   => angle = negative"; ...
    
    "position == negative & speed == zero       => angle = positive"; ...
    "position == negative & speed == negative   => angle = big_positive"; ...
    "position == negative & speed == positive   => angle = zero"; ...

    "position == positive & speed == zero       => angle = negative"; ...
    "position == positive & speed == negative   => angle = zero"; ...
    "position == positive & speed == positive   => angle = big_negative"; ...
    ];

position_fuzzy = addRule(position_fuzzy, rules);

% opt = gensurfOptions('OutputIndex',1);
% gensurf(position_fuzzy,opt)

%% Beam Friction Estimation

beam_friction = mamfis(...
                   'NumInputs', 2, 'NumInputMFs', 3,...
                   'NumOutputs', 1, 'NumOutputMFs', 3,...
                   'AddRule', 'none');

angularvelocity_alt = -0.03;
angularvelocity_ust = 0.03;
angularvelocity_gap = linspace(angularvelocity_alt,angularvelocity_ust,3);

input_power_alt = -3;
input_power_ust = 3;
input_power_gap = linspace(input_power_alt,input_power_ust,5);

power_offset_alt = -3;
power_offset_ust = 3;
power_offset_gap = linspace(power_offset_alt,input_power_ust,5);

beam_friction.Inputs(1).Name = 'angularvelocity';
beam_friction.Inputs(1).Range = [angle_input_alt angle_input_ust];
beam_friction.Inputs(1).MembershipFunctions(1).Name = 'negative';
beam_friction.Inputs(1).MembershipFunctions(1).Type = 'trimf';
beam_friction.Inputs(1).MembershipFunctions(1).Parameters = [angularvelocity_gap(1) angularvelocity_gap(1) angularvelocity_gap(2)];

beam_friction.Inputs(1).MembershipFunctions(2).Name = 'zero';
beam_friction.Inputs(1).MembershipFunctions(2).Type = 'trimf';
beam_friction.Inputs(1).MembershipFunctions(2).Parameters = [angularvelocity_gap(1) angularvelocity_gap(2) angularvelocity_gap(3)];

beam_friction.Inputs(1).MembershipFunctions(3).Name = 'positive';
beam_friction.Inputs(1).MembershipFunctions(3).Type = 'trimf';
beam_friction.Inputs(1).MembershipFunctions(3).Parameters = [angularvelocity_gap(2) angularvelocity_gap(3) angularvelocity_gap(3)];

beam_friction.Inputs(2).Name = 'input_power';
beam_friction.Inputs(2).Range = [input_power_alt input_power_ust];
beam_friction.Inputs(2).MembershipFunctions(1).Name = 'negative';
beam_friction.Inputs(2).MembershipFunctions(1).Type = 'trapmf';
beam_friction.Inputs(2).MembershipFunctions(1).Parameters = [power_offset_gap(1) power_offset_gap(1) power_offset_gap(2) power_offset_gap(3)];

beam_friction.Inputs(2).MembershipFunctions(2).Name = 'zero';
beam_friction.Inputs(2).MembershipFunctions(2).Type = 'trimf';
beam_friction.Inputs(2).MembershipFunctions(2).Parameters = [power_offset_gap(2) power_offset_gap(3) power_offset_gap(4)];

beam_friction.Inputs(2).MembershipFunctions(3).Name = 'positive';
beam_friction.Inputs(2).MembershipFunctions(3).Type = 'trapmf';
beam_friction.Inputs(2).MembershipFunctions(3).Parameters = [power_offset_gap(3) power_offset_gap(4) power_offset_gap(5) power_offset_gap(5)];

% plotmf(angle_fuzzy, 'input', 1, 1000);

beam_friction.Outputs(1).Name = 'power_offset';
beam_friction.Outputs(1).Range = [power_offset_alt power_offset_ust];

beam_friction.Outputs(1).MembershipFunctions(1).Name = 'negative';
beam_friction.Outputs(1).MembershipFunctions(1).Type = 'trapmf';
beam_friction.Outputs(1).MembershipFunctions(1).Parameters = [power_gap(1) power_gap(1) power_gap(2) power_gap(3)];

beam_friction.Outputs(1).MembershipFunctions(2).Name = 'zero';
beam_friction.Outputs(1).MembershipFunctions(2).Type = 'trimf';
beam_friction.Outputs(1).MembershipFunctions(2).Parameters = [power_gap(2) power_gap(3) power_gap(4)];

beam_friction.Outputs(1).MembershipFunctions(3).Name = 'positive';
beam_friction.Outputs(1).MembershipFunctions(3).Type = 'trapmf';
beam_friction.Outputs(1).MembershipFunctions(3).Parameters = [power_gap(3) power_gap(4) power_gap(5) power_gap(5)];




%plotmf(angle_fuzzy, 'output', 1, 1000);

rules = [...
    "input_power == zero  => power_offset = zero"; ...
    "angularvelocity == negative | angularvelocity == positive   => power_offset = zero"; ...
    "input_power == negative & angularvelocity == zero   => power_offset = negative"; ...  
    "input_power == positive & angularvelocity == zero       => power_offset = positive"; ...
    ];

beam_friction = addRule(beam_friction, rules);




%% Ball Friction Estimation

ball_friction = mamfis(...
                   'NumInputs', 2, 'NumInputMFs', 3,...
                   'NumOutputs', 1, 'NumOutputMFs', 3,...
                   'AddRule', 'none');

angle_fric_alt = -0.1;
angle_fric_ust = 0.1;
angle_fric_gap = linspace(angle_fric_alt,angle_fric_ust,5);

speed_fric_alt = -0.1;
speed_fric_ust = 0.1;
speed_fric_gap = linspace(speed_fric_alt,speed_fric_ust,3);

angle_offset_alt = -0.04;
angle_offset_ust = 0.04;
angle_offset_gap = linspace(angle_offset_alt, angle_offset_ust,5);

ball_friction.Inputs(1).Name = 'speedfric';
ball_friction.Inputs(1).Range = [speed_fric_alt speed_fric_ust];
ball_friction.Inputs(1).MembershipFunctions(1).Name = 'negative';
ball_friction.Inputs(1).MembershipFunctions(1).Type = 'trimf';
ball_friction.Inputs(1).MembershipFunctions(1).Parameters = [speed_fric_gap(1) speed_fric_gap(1) speed_fric_gap(2)];

ball_friction.Inputs(1).MembershipFunctions(2).Name = 'zero';
ball_friction.Inputs(1).MembershipFunctions(2).Type = 'trimf';
ball_friction.Inputs(1).MembershipFunctions(2).Parameters = [speed_fric_gap(1) speed_fric_gap(2) speed_fric_gap(3)];

ball_friction.Inputs(1).MembershipFunctions(3).Name = 'positive';
ball_friction.Inputs(1).MembershipFunctions(3).Type = 'trimf';
ball_friction.Inputs(1).MembershipFunctions(3).Parameters = [speed_fric_gap(2) speed_fric_gap(3) speed_fric_gap(3)];

ball_friction.Inputs(2).Name = 'anglefric';
ball_friction.Inputs(2).Range = [angle_fric_alt angle_fric_ust];
ball_friction.Inputs(2).MembershipFunctions(1).Name = 'negative';
ball_friction.Inputs(2).MembershipFunctions(1).Type = 'trapmf';
ball_friction.Inputs(2).MembershipFunctions(1).Parameters = [angle_fric_gap(1) angle_fric_gap(1) angle_fric_gap(2) angle_fric_gap(3)];

ball_friction.Inputs(2).MembershipFunctions(2).Name = 'zero';
ball_friction.Inputs(2).MembershipFunctions(2).Type = 'trimf';
ball_friction.Inputs(2).MembershipFunctions(2).Parameters = [angle_fric_gap(2) angle_fric_gap(3) angle_fric_gap(4)];

ball_friction.Inputs(2).MembershipFunctions(3).Name = 'positive';
ball_friction.Inputs(2).MembershipFunctions(3).Type = 'trapmf';
ball_friction.Inputs(2).MembershipFunctions(3).Parameters = [angle_fric_gap(3) angle_fric_gap(4) angle_fric_gap(5) angle_fric_gap(5)];

% plotmf(angle_fuzzy, 'input', 1, 1000);

ball_friction.Outputs(1).Name = 'angle_offset';
ball_friction.Outputs(1).Range = [angle_offset_alt angle_offset_ust];

ball_friction.Outputs(1).MembershipFunctions(1).Name = 'negative';
ball_friction.Outputs(1).MembershipFunctions(1).Type = 'trapmf';
ball_friction.Outputs(1).MembershipFunctions(1).Parameters = [angle_offset_gap(1) angle_offset_gap(1) angle_offset_gap(2) angle_offset_gap(3)];

ball_friction.Outputs(1).MembershipFunctions(2).Name = 'zero';
ball_friction.Outputs(1).MembershipFunctions(2).Type = 'trimf';
ball_friction.Outputs(1).MembershipFunctions(2).Parameters = [angle_offset_gap(2) angle_offset_gap(3) angle_offset_gap(4)];

ball_friction.Outputs(1).MembershipFunctions(3).Name = 'positive';
ball_friction.Outputs(1).MembershipFunctions(3).Type = 'trapmf';
ball_friction.Outputs(1).MembershipFunctions(3).Parameters = [angle_offset_gap(3) angle_offset_gap(4) angle_offset_gap(5) angle_offset_gap(5)];


%plotmf(angle_fuzzy, 'output', 1, 1000);

rules = [...
    "anglefric == zero  => angle_offset = zero"; ...
    "speedfric == negative | speedfric == positive   => angle_offset = zero"; ...
    "anglefric == negative & speedfric == zero   => angle_offset = negative"; ...  
    "anglefric == positive & speedfric == zero       => angle_offset = positive"; ...
    ];

ball_friction = addRule(ball_friction, rules);




gain1 = 6.270;
gain2 = 5.82;
gain3 = 15.78;
gain4 = 1.39;




% genetic güzel değerler
% gain1 = 6.270;
% gain2 = 5.82;
% gain3 = 15.78;
% gain4 = 1.39;








