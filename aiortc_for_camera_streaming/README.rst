Webcam server
=============

This example illustrates how to read frames from a webcam and send them
to a browser.

The problem for this example is: you don't know how to integrate OpenCV into it.

Running
-------

First install the required packages:

.. code-block:: console
    $ sudo apt install libavdevice-dev libavfilter-dev libopus-dev libvpx-dev pkg-config
    $ sudo pip install aiohttp aiortc opencv-python

When you start the example, it will create an HTTP server which you
can connect to from your browser:

.. code-block:: console

    $ python server.py

You can then browse to the following page with your browser:

http://127.0.0.1:8080

Once you click `Start` the server will send video from its webcam to the
browser.

Credits
-------

The original idea for the example was from Marios Balamatsias.
