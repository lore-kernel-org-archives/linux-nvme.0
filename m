From: fsteiner-mail1@bio.ifi.lmu.de (Frank Steiner)
Date: Mon, 1 Jul 2019 11:04:15 +0200
Subject: disk-activity trigger not working for nvme disk
Message-ID: <79f17609-5b3d-0d29-1642-c9ce30beb7f9@bio.ifi.lmu.de>

Hi,

I hope this is the right place to ask, people on the ibm-acpi-devel
list sent me here :-)

It's about the disk-activity trigger for the led kernel subsystem.
We are trying to turn e.g. the num lock led into a hard disk activity
indicator by

echo disk-activity > /sys/class/leds/input0::numlock/trigger

This works fine on all our older thinkpad models with SATA hard disks
and works also on our PCs with SSD disks (SATA as well as NVME), but
it fails on our newer thinkpads, i.e. T570 and T580, with NVME SSDs.

The LED just stays off all the time no matter what we do with the hard
disk. As all other triggers do work, people on the ibm-acpi-devel list
supposed it might be an issue in the nvme driver (and not the thinkpad_acpi
module).

If that could be possible, is there any information I can provide
for my laptop to help figure out the reason for the non-working trigger?

As far as I can see the controller is this:
40:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a808

and "nvme list" shows that:

Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme0n1     S3TPNX0M234146       SAMSUNG MZVLB1T0HALR-000L7               1         808,83  GB /   1,02  TB    512   B +  0 B   5L2QEXA7


If this is not related to the nvme driver, do you have any idea where else
I might ask?

Thanks a lot!

cu,
Frank
-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
