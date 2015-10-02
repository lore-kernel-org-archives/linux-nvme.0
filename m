From: hch@lst.de (Christoph Hellwig)
Date: Fri,  2 Oct 2015 16:04:00 +0200
Subject: nvme header reshuffle
Message-ID: <1443794643-12730-1-git-send-email-hch@lst.de>

This series reworks the header organisation in the nvme driver.  Currently
there are two headers: include/uapi/linux/nvme.h, which contains the ioctl
ABI and a lot of hardware description constants and include/linux/nvme.h
which contains more hardware descriptions constants as well as driver
internals.

This series splits them into one header each for the ioctl ABI, hardware
descr?ption and driver internals.
