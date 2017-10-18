From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Oct 2017 10:21:12 -0600
Subject: [PATCH 1/5] nvme-core: Make nvme_init/uninit_ctrl setup/teardown
 symmetric
In-Reply-To: <4627b34e-449a-cd93-ac70-a628d558cac3@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-2-git-send-email-sagi@grimberg.me>
 <20171018150859.GD32530@localhost.localdomain>
 <4627b34e-449a-cd93-ac70-a628d558cac3@grimberg.me>
Message-ID: <20171018162111.GA1780@localhost.localdomain>

On Wed, Oct 18, 2017@06:29:40PM +0300, Sagi Grimberg wrote:
> Can you explain how would I see naming clashes? I'm not sure I
> understand what you are referring to.

It's been a while since I tested this. I used to observe -EEXIST errors
setting up the kobj's from something as simple as this:

  dd if=/dev/nvme0n1 of=/dev/null conv=noerror 2> /dev/null &
  echo 1 > /sys/class/nvme/nvme0/device/remove
  echo 1 > /sys/bus/pci/rescan

The rescan would recreate nvme0n1 that still exists from the open
handle. I'm not seeing an error today; not sure what changed, but I'm
looking into that now.
