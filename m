From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 19 Jun 2018 14:25:14 -0600
Subject: NVME-CLI : Fabrics property-get and 64 bit property (CAP)
In-Reply-To: <CAPrnrPCM79jUwngOQd0t6-pT3RocHNBnt_TS059d+NK-rodqDA@mail.gmail.com>
References: <CAPrnrPD2PtPO38cAzMfKdhS18GFj1vk032p0h0rQf0CFP+R=cw@mail.gmail.com>
 <e75d7829-9aeb-90fb-249a-c7ac4cef10bd@intel.com>
 <CAPrnrPBKcYUsuQ6krkcjB6BOzLcPz47vje4qjic5Xw9PQN3pTQ@mail.gmail.com>
 <20180619194802.GF19922@localhost.localdomain>
 <CAPrnrPCM79jUwngOQd0t6-pT3RocHNBnt_TS059d+NK-rodqDA@mail.gmail.com>
Message-ID: <20180619202514.GG19922@localhost.localdomain>

On Tue, Jun 19, 2018@11:00:00PM +0300, Eyal BenDavid wrote:
> Does it mean that a user space program can't get the missing dword by
> nvme-cli / ioctl ?

Right, no way to get this back to user space through the ioctl.

> Is there another way to get the information from user space? (e.g.
> sysfs / proc / dmesg etc)

Yeah, you should be able to see it if you've a recent enough kernel with
event tracers enabled. First enable the tracing:

  echo 1 > /sys/kernel/debug/tracing/events/nvme/enable

Then after running your nvme command, you should see the result with:

  cat /sys/kernel/debug/tracing/trace
