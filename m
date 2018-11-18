From: jvbockel@gmail.com (John Van Bockel)
Date: Sun, 18 Nov 2018 13:08:13 -0600
Subject: Two M.2 NVMe drives with same NQN, one gets removed
In-Reply-To: <20181117013337.GA23062@localhost.localdomain>
References: <CAGmwwfeJEVkw2uf1oVoEYgNtuLPRrDqWHXQi-KXTdofsUdH2Dg@mail.gmail.com>
 <20181117013337.GA23062@localhost.localdomain>
Message-ID: <CAGmwwfeTw=jvOt1U_hgFJktor1R4HmYL6_pxGc-==AbAHDQCGA@mail.gmail.com>

Hi Keith,

That's good news and very much appreciate the information and all
that you do for the open source community.  Is this an update for the
760p NVMe drives or instead a UEFI update for the NUC8i7HVK?
Either way, good news.  Just wondering which I'm keeping an eye out
for.

Other than this minor problem, I sure am liking this NUC.  I'm finding
that contemporary versions of Linux work very nicely, even the Radeon
Vega M GPU.

Thanks again.  I'll patiently keep an eye out for the FW update.  Easily
worked around for the moment.

Cheers
jvbockel at gmail.com

On Fri, Nov 16, 2018@7:37 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Fri, Nov 16, 2018@06:17:22PM -0600, John Van Bockel wrote:
> > Hi,
> >
> > I have an Intel NUC8i7HVK mini-computer and a pair of Intel 760p 1TB M.2 NVMe
> > SSD drives.  With Fedora 29 and Ubuntu 18.10 (both 4.18 kernels), the
> > nvme kernel
> > module insists upon disabling one of the two NVMe drives when it notices that
> > both have been assigned the same NVMe Qualified Name (NQN).  The one that gets
> > removed by the nvme module is not always the same.  Whichever remains enabled
> > performs perfectly.
> >
> > [root at NUCnFutz ~]# dmesg | grep -i nvme
> >
> > [    3.372662] nvme nvme0: pci function 0000:72:00.0
> > [    3.372710] nvme nvme1: pci function 0000:73:00.0
> > [    3.484113]  nvme0n1: p1 p2 p3 p4
> > [    3.584531] nvme nvme1: ignoring ctrl due to duplicate subnqn
> > (nqn.2017-12.org.nvmexpress:uuid:11111111-2222-3333-4444-555555555555).
> > [    3.584533] nvme nvme1: Removing after probe failure status: -22
>
> This is a firmware bug. The maker is aware and have a fix undergoing
> validation. I am not sure what is gating its release so I've pinged the
> management for an update and will respond as soon as I hear a reply.
>
> Thanks,
> Keith
