From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 21 Oct 2016 06:21:31 -0700
Subject: [PATCH 1/3] nvme-cli: follow-on discovery tweaks from thread
In-Reply-To: <1476906187-29183-2-git-send-email-james_p_freyensee@linux.intel.com>
References: <1476906187-29183-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1476906187-29183-2-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20161021132130.GA9492@infradead.org>

Hi Jay,

I'm not a huge fan with the explicit mention of the Get Log Page
command for th Discovery, but given that no one but us two seems to
care I'm not going to block the patch over it.

The rest of this patch and the connect-all version of it looks fine to
me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
