From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Jun 2019 15:37:56 -0700
Subject: Oops when disconnecting from inaccessible subsystem
In-Reply-To: <53AF2DF5-DE22-45D1-9CB1-A2E92EBBAC13@intel.com>
References: <3332C781-D747-42FC-8B1F-B4748961253C@intel.com>
 <5fdea4d4-4f01-bb84-27ee-b6b51aa8a11c@grimberg.me>
 <53AF2DF5-DE22-45D1-9CB1-A2E92EBBAC13@intel.com>
Message-ID: <ce5cb741-00ae-7780-cdc6-a7eaa4d8c090@grimberg.me>

>      > I see a 100% reproducible kernel oops when trying to disconnect from an inaccessible subsystem.  This was tested with 5.2-rc2 + Sagi's "fix queue mapping when queue count is limited" patches.
>      
>      default/read/poll queues? how much queues overall?
> 
> Default number of queues.  No -i, -W or -P options specified to nvme-cli.  No restrictions placed on number of queues for the SPDK target.
> 
> Sorry if the mention of including your patches confused matters.  I only mentioned it to clarify the rc2+ and tainted references in my oops message.  I'm not explicitly leveraging the fixes supplied by your patches to run my tests.

Hey Jim,

Thanks for the info,

Can you try reverting this patch:
87fd125344d6 nvme-rdma: remove redundant reference between ib_device and 
tagset

and retest?
