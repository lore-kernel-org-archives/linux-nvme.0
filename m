From: jsmart2021@gmail.com (James Smart)
Date: Mon, 8 May 2017 10:22:46 -0700
Subject: [PATCH 0/2] nvme_fc: add uevent to allow dynamic connects
In-Reply-To: <2340db12-7f96-1d05-de6a-f36ddb913e4f@suse.de>
References: <20170505231335.31726-1-jsmart2021@gmail.com>
 <2340db12-7f96-1d05-de6a-f36ddb913e4f@suse.de>
Message-ID: <a17c9b99-e1ee-c12e-eb3e-62130d72af08@gmail.com>

On 5/8/2017 4:11 AM, Johannes Thumshirn wrote:
> On 05/06/2017 01:13 AM, jsmart2021@gmail.com wrote:
>> From: James Smart <jsmart2021 at gmail.com>
>>
>> These patches add support for generating a uevent which can be
>> caugth and converted to a nvme-cli connect-all request for the
>> FC initiator and target ports.
>
> IMHO this should be a bit more generic. We do have two fabrics, FC and
> RDMA (we can leave out PCIe here I think). *Iff* we want to do this we
> at least need to do this for FC _and_ RDMA.

It's not really possible due to differences in fabrics.

With Ethernet/IP fabrics, the local host doesn't necessarily know about 
the activation/termination of other IP addresses on the network, nor 
what IP addresses map to NVME subsystems (discovery controllers or 
storage controllers) nor the IP port numbers for the subsystems. Thus, 
something (admin action, config scripts, etc) must at least supply how 
to start the discovery process - specifying the location of the storage 
controllers or at least the location(s) of the discovery controllers. 
Even then, dynamic changes need something to restart that scan or be 
told where to rescan. None of the initial or dynamic connectivity info 
can come from the RDMA transport.

With FC fabrics, given FC has it's own dynamic discovery engine, it can 
recognize when FC ports have nvme subsystems present - discovery 
controllers and/or storage controllers. It can determine when they come 
into existence, go away, or are in existence and had some kind of state 
change (thus please rescan). FC fabrics still use the same NVME 
discovery engines that RDMA uses - based on the discovery controllers. 
Its using the FC discovery engine to then initiate the discovery 
controller scans, eliminating the admin/config steps mandated for RDMA. 
The other things about FC is that connections are very centric to the 
initiator FC ports, due to zoning. Thus, every FC connection must 
specify the initiator FC port and the target FC port.

The user is free to not put the udev scripts in place and to utilize the 
same methods used by RDMA.   However, the FC storage environment has 
always had dynamic auto-connection and re-connection for SCSI storage 
and the eco-system has the same expectation for NVME storage. Therefore 
I believe FC should have the support in the kernel and allow for the 
user to put the udev scripts in place to support the auto-connection.

In the future, although there is currently a desire to keep connectivity 
management in user space, in order to support boot/swap support (and 
low-memory configs) on NVME fabric storage, it will likely require 
moving the discovery controller attachment in to the kernel rather than 
in the nvme cli.  (iscsi discussions ring a bell ?).  With FC, boot 
support does not require things like iBFT for boot support. It acts like 
SCSI. Making it much easier.


-- james
