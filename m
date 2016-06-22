From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 22 Jun 2016 09:13:07 -0700
Subject: [PATCH for-4.7] nvme: Remove RCU namespace protection
In-Reply-To: <1466548365-992-1-git-send-email-keith.busch@intel.com>
References: <1466548365-992-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160622161307.GA10592@infradead.org>

I just had a quick look over this, and I'm a bit worried about
the unlocked list walks, and the lack of grabbing a reference
in nvme_find_ns.  I think by grabbing a reference in nvme_find_ns
and dropping it once done we can already fix nvme_validate_ns and
to nvme_scan_ns_list to be fully safe, and
nvme_remove_invalid_namespaces might need some unlock and retry
loops or a discard list so that we can lock the list traversal
as well.  I think we should go that extra step to avoid any later
pitfalls.
