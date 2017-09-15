From: brudas@exadel.com (Bogdan Rudas)
Date: Fri, 15 Sep 2017 19:38:36 +0300
Subject: NVMe and SR-IOV, how to use together?
Message-ID: <CAO+XWgk1o26gj5n-3vszuoQqXzaLjKdevU133X3206FMzxO6rQ@mail.gmail.com>

Hi!

Today I've received from servers vendor modern Samsung SSD 1725a
MZPLL1T6HEHP for evaluation. I would like to use it as storage for
virtual machines. Before I will start doing anything with a device I
would like to re-check if I understand technology basics:

To divide the device among virtual machines I have to delete default
namespace and create a dedicated namespace for each VM.
When I will have at least 2 namespace, every of them will be exposed
in host operating system as virtual function of PCI device (i.e. I
will see lot of Virtual function for Non-Volatile memory controller)
Then I can do PCI passthru like I do it for any other SR-IOV PCI device.
Finally I have to remove all namespaces and re-create the single one
which will be exposed as single PCI device with no virtual functions.

Could someone review statements above and point me to useful
additional information? There are no user friendly information about
SR-IOV on NVMe devices in Linux, so I have to disturb the development
community.


Thank you!

-- 


CONFIDENTIALITY NOTICE: This email and files attached to it are 
confidential. If you are not the intended recipient you are hereby notified 
that using, copying, distributing or taking any action in reliance on the 
contents of this information is strictly prohibited. If you have received 
this email in error please notify the sender and delete this email.
