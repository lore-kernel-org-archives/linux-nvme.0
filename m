From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Nov 2018 18:33:37 -0700
Subject: Two M.2 NVMe drives with same NQN, one gets removed
In-Reply-To: <CAGmwwfeJEVkw2uf1oVoEYgNtuLPRrDqWHXQi-KXTdofsUdH2Dg@mail.gmail.com>
References: <CAGmwwfeJEVkw2uf1oVoEYgNtuLPRrDqWHXQi-KXTdofsUdH2Dg@mail.gmail.com>
Message-ID: <20181117013337.GA23062@localhost.localdomain>

On Fri, Nov 16, 2018@06:17:22PM -0600, John Van Bockel wrote:
> Hi,
> 
> I have an Intel NUC8i7HVK mini-computer and a pair of Intel 760p 1TB M.2 NVMe
> SSD drives.  With Fedora 29 and Ubuntu 18.10 (both 4.18 kernels), the
> nvme kernel
> module insists upon disabling one of the two NVMe drives when it notices that
> both have been assigned the same NVMe Qualified Name (NQN).  The one that gets
> removed by the nvme module is not always the same.  Whichever remains enabled
> performs perfectly.
> 
> [root at NUCnFutz ~]# dmesg | grep -i nvme
> 
> [    3.372662] nvme nvme0: pci function 0000:72:00.0
> [    3.372710] nvme nvme1: pci function 0000:73:00.0
> [    3.484113]  nvme0n1: p1 p2 p3 p4
> [    3.584531] nvme nvme1: ignoring ctrl due to duplicate subnqn
> (nqn.2017-12.org.nvmexpress:uuid:11111111-2222-3333-4444-555555555555).
> [    3.584533] nvme nvme1: Removing after probe failure status: -22

This is a firmware bug. The maker is aware and have a fix undergoing
validation. I am not sure what is gating its release so I've pinged the
management for an update and will respond as soon as I hear a reply.

Thanks,
Keith
