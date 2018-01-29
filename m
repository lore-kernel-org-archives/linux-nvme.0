From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Mon, 29 Jan 2018 12:56:30 -0800
Subject: [LSF/MM TOPIC] Two blk-mq related topics
In-Reply-To: <20180129154455.GB17176@ming.t460p>
References: <20180129154455.GB17176@ming.t460p>
Message-ID: <1517259390.3969.41.camel@HansenPartnership.com>

On Mon, 2018-01-29@23:46 +0800, Ming Lei wrote:
[...]
> 2. When to enable SCSI_MQ at default again?

I'm not sure there's much to discuss ... I think the basic answer is as
soon as Christoph wants to try it again.

> SCSI_MQ is enabled on V3.17 firstly, but disabled at default. In
> V4.13-rc1, it is enabled at default, but later the patch is reverted
> in V4.13-rc7, and becomes disabled at default too.
> 
> Now both the original reported PM issue(actually SCSI quiesce) and
> the sequential IO performance issue have been addressed.

Is the blocker bug just not closed because no-one thought to do it:

https://bugzilla.kernel.org/show_bug.cgi?id=178381

(we have confirmed that this issue is now fixed with the original
reporter?)

And did the Huawei guy (Jonathan Cameron) confirm his performance issue
was fixed (I don't think I saw email that he did)?

James
