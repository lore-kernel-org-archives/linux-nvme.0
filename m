From: mwilck@suse.com (Martin Wilck)
Date: Tue, 13 Nov 2018 07:59:30 +0100
Subject: multipath-tools: add ANA support for NVMe device
In-Reply-To: <20181112215323.GA7983@redhat.com>
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com>
 <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
Message-ID: <194b0202a660044a75c3751abc3295707c8d29e4.camel@suse.com>

On Mon, 2018-11-12@16:53 -0500, Mike Snitzer wrote:
> 
> I (and others) think it makes sense to at least triple check with the
> NVMe developers (now cc'd) to see if we could get agreement on the
> nvme
> driver providing the ANA state via sysfs (when modparam
> nvme_core.multipath=N is set), like Hannes proposed here:
> http://lists.infradead.org/pipermail/linux-nvme/2018-November/020765.html
> 
> Then the userspace multipath-tools ANA support could just read sysfs
> rather than reinvent harvesting the ANA state via ioctl.

If some kernels expose the sysfs attributes and some don't, what are we
supposed to do? In order to be portable, multipath-tools (and other
user space tools, for that matter) need to support both, and maintain
multiple code paths. Just like SCSI :-)

I'd really like to see this abstracted away with a "libnvme" (you name
it), which user space tools could simply call without having to worry
how it actually talks to the kernel.

Martin

-- 
Dr. Martin Wilck <mwilck at suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
