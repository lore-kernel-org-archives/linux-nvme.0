From: kbusch@kernel.org (Keith Busch)
Date: Tue, 14 May 2019 08:23:37 -0600
Subject: PROBLEM: call trace triggered in 5.1.1 in
 drivers/nvme/host/pci.c, 5.0.11 ok
In-Reply-To: <20190514141439.GA14213@lst.de>
References: <CAC=wYCGgPQPjUUjQTZh4H7b8WRQFGmbKCBRAq75g1BXjBR0L0Q@mail.gmail.com>
 <20190514052027.GB6294@lst.de>
 <CAC=wYCFhKR5YrAwL1agz=USg3DAkx5BtXAfv64nOfTrwTji40Q@mail.gmail.com>
 <20190514055832.GA6843@lst.de>
 <CAC=wYCECcfqoDDMcgVj-4dAEUxNpY62vAEMOD8-eGrZK8wOV-g@mail.gmail.com>
 <20190514135434.GA19837@localhost.localdomain>
 <20190514141220.GA25519@ming.t460p> <20190514141439.GA14213@lst.de>
Message-ID: <20190514142337.GA19881@localhost.localdomain>

On Tue, May 14, 2019@04:14:39PM +0200, Christoph Hellwig wrote:
> On Tue, May 14, 2019@10:12:22PM +0800, Ming Lei wrote:
> > The two aren't merged because the default segment size(BLK_MAX_SEGMENT_SIZE) is 64KB,
> 
> Yep.
> 
> > and the following patch may fix this issue:
> 
> Or this one posted yesterday for that matter:
> 
> https://marc.info/?l=linux-block&m=155772952511144&w=2

Nice, either one looks good. We could also safely cap it to
(limits->max_hw_sectors << 9) instead of UINT_MAX.
