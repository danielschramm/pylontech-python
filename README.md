# pylontech-python
Functions to communicate to Pylontech Batteries using RS-485 serial communication

Known and supported batteries:
- US2000 / US2000C
- US3000 / US3000C
- US5000 / US5000C

Note:<br>
This Python module is expected to work with the 48 V / low voltage batteries.

## Structure of this module

It is a 3 Layer model - each can be used as lib:

1. pylontech_base.py - Communication layer, RS485 to pylontech with raw frame support.
2. pylontech_decode.py and pylontech_encode.py for decoding and encoding the frame content.
3. pylontech_stack.py high level abstraction for the whole stack.
   It iterates over batteries and calculates overall results and combines battery results to lists.
   Some detail information from layer 2 might not be implemented in this layer.

## Installation using pypi.org

- run 'pip install pylontech-python'


## build and Installation from source using pip:

- The build requires pip to be installed
- Run <code>pip wheel -r requirements.txt</code> (installs e.g. pyserial)
  this downloads the required packages
- Run <code>pip wheel .</code>
  this builds the wheel package
- Run <code>pip install --force-reinstall ./*.whl</code>
  this installs the packages (both downloaded and build)<br>
  <code>--force-reinstall</code> is used if you like to modify, rebuild and reinstall it.


# Example:

## using the python interactive shell
An example to use pylontech-python in the python-shell:

    >>> from pylontech import PylontechStack
    >>> x = PylontechStack("/dev/ttyUSB0",baud=115200,manualBattcountLimit=5)
    >>> x.battcount
    2

## Application examples:

A new example has been added to show how to publish data from a single stack
and all its battery packs via MQTT to HomeAssistant.
