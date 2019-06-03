From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Jun 2019 14:18:47 -0700
Subject: Oops when disconnecting from inaccessible subsystem
In-Reply-To: <3332C781-D747-42FC-8B1F-B4748961253C@intel.com>
References: <3332C781-D747-42FC-8B1F-B4748961253C@intel.com>
Message-ID: <5fdea4d4-4f01-bb84-27ee-b6b51aa8a11c@grimberg.me>



> Hi,
> 
> I see a 100% reproducible kernel oops when trying to disconnect from an inaccessible subsystem.  This was tested with 5.2-rc2 + Sagi's "fix queue mapping when queue count is limited" patches.

default/read/poll queues? how much queues overall?


> 
> Failure is seen when using either the kernel or SPDK fabrics target.  So far I've only tested with rdma.  Simply connect to a subsystem, remove the subsystem from the target, and then try to disconnect.

Happens with tcp as well?
