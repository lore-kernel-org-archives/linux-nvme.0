From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Oct 2018 18:58:27 +0200
Subject: [PATCH 00/16] Fixes for issues detected by static analyzers
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181009165827.GA22410@lst.de>

On Mon, Oct 08, 2018@02:28:38PM -0700, Bart Van Assche wrote:
> Hi Keith, Christoph and Sagi,
> 
> This patch series addresses several issues reported by static analyzers like
> sparse, smatch and Coverity. Please consider these patches for Linux kernel
> v4.20.

Thanks Bart!

I've applied 1,3,5,11 and 13-16 for now.

This excludes the FC patches, for which I want to wait for feedback
from James, the integrity one that needs chnanges as noted by Keith,
the patch earlier submitted by Chaitanya, and the nvme_init_identify
that really looks odd - we have plenty of calls like that in the
kernel, so I have to disagree with that Coverity warning.
