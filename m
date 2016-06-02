From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Thu, 2 Jun 2016 10:30:55 -0300
Subject: [PATCH v2] nvme/quirk: Add a delay before checking for adapter
 readiness
In-Reply-To: <20160602082244.GA12071@infradead.org>
References: <201606011754.u51HsNPs003785@mx0a-001b2d01.pphosted.com>
 <20160602082244.GA12071@infradead.org>
Message-ID: <201606021331.u52DUpIs043702@mx0a-001b2d01.pphosted.com>

On 06/02/2016 05:22 AM, Christoph Hellwig wrote:
> Hi Guilherme,
>
> the code looks fine code wise.  But based on the previous disccusion
> we only need the delay after a firmware activation, right?  Even if
> we don't have a good way to implement that (yet) it would be good
> to document that fact in a comment.

Thanks Christoph, I agree with you.
Will send a v3 with a comment about the quirk's need only in 
reset_controller after firmware activation.

Cheers,


Guilherme
