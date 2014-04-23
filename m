From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 23 Apr 2014 11:35:02 -0400
Subject: Smart support
In-Reply-To: <1397948471.23478.30.camel@espiritosanto.int.convergent.io>
References: <1397948471.23478.30.camel@espiritosanto.int.convergent.io>
Message-ID: <20140423153502.GG13050@linux.intel.com>

On Sat, Apr 19, 2014@04:01:11PM -0700, Daniel Stodden wrote:
> 
> Hi everyone.
> 
> I've been browsing a bit of the kernel NVMe drivers. 
> 
> Right now I'm mainly wondering about SMART support. I got as far as
> finding present scsi emulation code and the nvme-user.git repo.
> 
> What's the roadmap for nvme-scsi? Is it going to evolve into a full scsi
> device translation layer? Is someone working on a smartctl driver?

Hi Daniel,

I must confess to knowing little or nothing about what SMART requires.
If smartctl would benefit from having an NVMe-specific driver then it'd
be great if somebody worked on that.  If the nvme-scsi module needs a
couple of small enhancements to make the existing smartctl work properly,
then by all means let's add them.  You can see nvme-scsi does translate
LOG_PAGE_TEMPERATURE_PAGE and LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE
already, and does so by requesting the SMART page from the NVMe device.
Is there more that is needed for smartctl's purposes?
