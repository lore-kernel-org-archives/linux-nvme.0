From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Jun 2018 14:19:15 +0200
Subject: [PATCH 1/4] nvme-fabrics: refactor queue ready check
In-Reply-To: <f3264852-771e-864c-a57d-cb33a55ca768@broadcom.com>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-2-hch@lst.de>
 <99751a08-8485-787f-95bc-862b8f9d02ed@broadcom.com>
 <20180613081616.GA23377@lst.de>
 <f3264852-771e-864c-a57d-cb33a55ca768@broadcom.com>
Message-ID: <20180614121915.GA27209@lst.de>

On Wed, Jun 13, 2018@08:54:25AM -0700, James Smart wrote:
> When I finally finished with the review on your last patch:
> [PATCH 4/4] nvme-fabrics: reverse polarity in __nvmf_check_ready
>
> I think you had addressed this issue so the patch below isn't necessary.

Even with patch 4 we'd still allow kernel-generated connect commands
in non-new, non-connecting states.  We should not generally send them,
so I think the series as-is should be ok, but if touch all this code
we might as well handle that case as well.
