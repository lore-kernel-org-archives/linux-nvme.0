From: daniel.stodden@googlemail.com (Daniel Stodden)
Date: Wed, 23 Apr 2014 19:11:48 -0700
Subject: Smart support
In-Reply-To: <20140423153502.GG13050@linux.intel.com>
References: <1397948471.23478.30.camel@espiritosanto.int.convergent.io>
 <20140423153502.GG13050@linux.intel.com>
Message-ID: <1398305508.23478.100.camel@espiritosanto.int.convergent.io>

On Wed, 2014-04-23@11:35 -0400, Matthew Wilcox wrote:
> On Sat, Apr 19, 2014@04:01:11PM -0700, Daniel Stodden wrote:
> > 
> > Hi everyone.
> > 
> > I've been browsing a bit of the kernel NVMe drivers. 
> > 
> > Right now I'm mainly wondering about SMART support. I got as far as
> > finding present scsi emulation code and the nvme-user.git repo.
> > 
> > What's the roadmap for nvme-scsi? Is it going to evolve into a full scsi
> > device translation layer? Is someone working on a smartctl driver?
> 
> Hi Daniel,
> 
> I must confess to knowing little or nothing about what SMART requires.
> If smartctl would benefit from having an NVMe-specific driver then it'd
> be great if somebody worked on that.  If the nvme-scsi module needs a
> couple of small enhancements to make the existing smartctl work properly,
> then by all means let's add them.  You can see nvme-scsi does translate
> LOG_PAGE_TEMPERATURE_PAGE and LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE
> already, and does so by requesting the SMART page from the NVMe device.
> Is there more that is needed for smartctl's purposes?

I looked a little into it 3 days ago.

Actually I started like you said, assuming a dedicated nvme driver. Then
discovered the existing SCSI translation, so I thought solutions might
already be worked on.

Is seem that smartctl's scsi driver isn't issuing SG_IO calls, so it
fails fairly early. I'm not really good with the kernel SCSI layer, so
I'll have to look a little closer to say more.

It is as you say: if the current nvme-scsi helps keeping userland happy,
I think it's the way to go. If not, well, I guess it's a dedicated
driver then.

Might look a little further it in the near future, but don't hold your
breath yet.

Thanks everyone for the clarifications.

Daniel
