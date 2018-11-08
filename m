From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 01:52:32 -0800
Subject: [PATCH v2 03/11] nvmet: Allow Keep Alive for Discovery controller
In-Reply-To: <1539709883-12424-4-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-4-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108095232.GC29432@infradead.org>

> +	if ((ctrl->subsys->type == NVME_NQN_DISC) && !kato)
> +		kato = NVMET_DISC_KATO;

No need for the inner braces here.

> +#define NVMET_DISC_KATO		120000 /* ms */

I'd rename it to NVMET_DISC_KATO_MS to make the unit obvious
and remove the need for the comment.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
