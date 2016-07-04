From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 4 Jul 2016 01:48:17 -0700
Subject: [PATCH] nvme-fabrics: add-remove ctrl repeat fix
In-Reply-To: <1467400412-13052-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1467400412-13052-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20160704084817.GA1217@infradead.org>

On Fri, Jul 01, 2016@12:13:32PM -0700, Jay Freyensee wrote:
> Fix by: "Ming Lin" <mlin at kernel.org>

So is this authored by you or by Ming?  In the latter case this
should be a

From: "Ming Lin" <mlin@kernel.org>

The patch itself looks fine, I'll queue it up after we've sorted
out the above question, thanks to both of you.

But I think we'll also need a kref_get_unless_zero in __nvmf_host_find
to make this code fully correct, I'll prepare a patch for that.
