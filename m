From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 9 May 2019 00:56:24 +0900
Subject: [PATCH v2 6/7] nvme-pci: add device coredump support
In-Reply-To: <20190507212241.GA7113@localhost.localdomain>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
 <a4ec2c1a-1ff7-52fe-07bd-179613411536@intel.com>
 <20190507212241.GA7113@localhost.localdomain>
Message-ID: <CAC5umyhkeqD6ndh0OXauibZfz+BTd_EU9X81uebttp9gmxEYhg@mail.gmail.com>

2019?5?8?(?) 6:28 Keith Busch <kbusch at kernel.org>:
>
> On Tue, May 07, 2019@02:31:41PM -0600, Heitke, Kenneth wrote:
> > On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> > > +
> > > +static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, void *buf,
> > > +                                    size_t bytes, loff_t offset)
> > > +{
> > > +   const size_t chunk_size = ctrl->max_hw_sectors * ctrl->page_size;
> >
> > Just curious if chunk_size is correct since page size and block size can
> > be different.
>
> They're always different. ctrl->page_size is hard-coded to 4k, while
> sectors are always 512b.

Oops.  I misunderstood how ctrl->max_hw_sectors is initialized from MDTS.
Also overflow check was required here for the architectures that use
"unsigned int" size_t.
