From: hch@lst.de (Christoph Hellwig)
Date: Sat,  3 Oct 2015 15:51:09 +0200
Subject: nvme header reshuffle V2
Message-ID: <1443880272-25801-1-git-send-email-hch@lst.de>

This series reworks the header organisation in the nvme driver.  Currently
there are two headers: include/uapi/linux/nvme.h, which contains the ioctl
ABI and a lot of hardware description constants and include/linux/nvme.h
which contains more hardware descriptions constants as well as driver
internals.

This series splits them into one header each for the ioctl ABI, hardware
description and driver internals.

Changes since V1:
 - rebase on top of Keith' namespace refcounting changes
