From: james.r.harris@intel.com (Harris, James R)
Date: Mon, 3 Jun 2019 21:26:06 +0000
Subject: Oops when disconnecting from inaccessible subsystem
In-Reply-To: <5fdea4d4-4f01-bb84-27ee-b6b51aa8a11c@grimberg.me>
References: <3332C781-D747-42FC-8B1F-B4748961253C@intel.com>
 <5fdea4d4-4f01-bb84-27ee-b6b51aa8a11c@grimberg.me>
Message-ID: <53AF2DF5-DE22-45D1-9CB1-A2E92EBBAC13@intel.com>



?On 6/3/19, 2:18 PM, "Sagi Grimberg" <sagi@grimberg.me> wrote:

    
    
    > Hi,
    > 
    > I see a 100% reproducible kernel oops when trying to disconnect from an inaccessible subsystem.  This was tested with 5.2-rc2 + Sagi's "fix queue mapping when queue count is limited" patches.
    
    default/read/poll queues? how much queues overall?

Default number of queues.  No -i, -W or -P options specified to nvme-cli.  No restrictions placed on number of queues for the SPDK target.

Sorry if the mention of including your patches confused matters.  I only mentioned it to clarify the rc2+ and tainted references in my oops message.  I'm not explicitly leveraging the fixes supplied by your patches to run my tests.
    
    > 
    > Failure is seen when using either the kernel or SPDK fabrics target.  So far I've only tested with rdma.  Simply connect to a subsystem, remove the subsystem from the target, and then try to disconnect.
    
    Happens with tcp as well?
    
I've confirmed it does not happen with tcp.

-Jim
