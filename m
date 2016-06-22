From: keith.busch@intel.com (Keith Busch)
Date: Wed, 22 Jun 2016 13:35:33 -0400
Subject: [PATCH for-4.7] nvme: Remove RCU namespace protection
In-Reply-To: <20160622161307.GA10592@infradead.org>
References: <1466548365-992-1-git-send-email-keith.busch@intel.com>
 <20160622161307.GA10592@infradead.org>
Message-ID: <20160622173533.GI1448@localhost.localdomain>

On Wed, Jun 22, 2016@09:13:07AM -0700, Christoph Hellwig wrote:
> I just had a quick look over this, and I'm a bit worried about
> the unlocked list walks, and the lack of grabbing a reference
> in nvme_find_ns.  I think by grabbing a reference in nvme_find_ns
> and dropping it once done we can already fix nvme_validate_ns and
> to nvme_scan_ns_list to be fully safe, and
> nvme_remove_invalid_namespaces might need some unlock and retry
> loops or a discard list so that we can lock the list traversal
> as well.  I think we should go that extra step to avoid any later
> pitfalls.

I think I follow what you're saying. I'll resend with your suggestions.

I was hoping to target 4.7 since that's the one that introduced the
two new bugs that we need to fix, and nvme_remove_invalid_namespaces
is set for 4.8. Now that I'm looking at it again, that function needs
to kill those namespace request queues prior to removal. Then we can
safely put them on a discard list since we'll never need to iterate
those namespaces again.
