Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65122EDA6A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2NrxxLl0akHdgSNyfd6MNgmcdRb+XxaEIvh0xvYeIU=; b=kibulG4jjmfbHanxeNe5SsKQqe
	aVGc3o/H0z4TxwDibwVWY4UO7UQc4Gg5NcU/ZZCvAuOqF3zKi/w0KocN0LMreft8Nbfa/0wFsZu0O
	VP2xt9OXWlUZPKv8q3Yul8CrCqFBdE2GgvNJaeiyklTRo9xUsqW6VpU05CzhTbL5L5e2OeqG0GXBH
	VKsPqT4YCmseKKKZxwylTCrn28g4lX2jj1o3mK0B6aFYz6WgP8TLJKuz3AAVutzvErBxcfu1OwCS9
	jGevJCaDnHrMo+12P7QsFnp9luqRnrRj44lynBnRy0P95Nf1m124wMWSFMOU55tT6AmMoOdwM1LT1
	jUyJGVng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxT03-0000000Fbuy-3bsG;
	Tue, 03 Mar 2026 16:53:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxT01-0000000FbuX-3Vnq
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 16:53:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B3D1E43AF1;
	Tue,  3 Mar 2026 16:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA08C116C6;
	Tue,  3 Mar 2026 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556812;
	bh=7+EW0QiFeSk2IzY15hd8F1OEklL0Z5eUir8+W9UseSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oObzGEVYw2uP4V4spbipW3bMY3nQH2ty0fHHRuE37ZzyFQozVJQFPBysatf6v6aw4
	 vqR9hua5glv6hAghKYGUO8ByCfbCcAguxxG4bObUdmp+2b5EaTPlV80k0DDWsNR9tu
	 sykgFc2GMj9ClT7IGGSkSuj67H7n5Q+EzjChuACvJnx1yFxZVW09TwbREL4g4psa8E
	 FSoLydaJSai2FP/jHXZd3zg+REvAneND0DFUR+wIZJU1U3a8OQvOKnR4wMa3/SJnrF
	 k6YzI8sO8COVGle7HafAENAPgwAafyrUIWJ4GmgtltX+rrYHDPkcEBGfm6VjIdXqmI
	 v4m4xcpvKdW8Q==
Date: Tue, 3 Mar 2026 09:53:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, mlombard@redhat.com, jmeneghi@redhat.com
Subject: Re: [RFC-PATCH 2/2] nvme: use the namespace id for block device names
Message-ID: <aacSCnD-ag9-Llfg@kbusch-mbp>
References: <20260302222532.3400786-1-kbusch@meta.com>
 <20260302222532.3400786-2-kbusch@meta.com>
 <c2ef8067-a5c9-4be7-8e2a-9d74610d446f@suse.de>
 <aacAzGpNJ2RXedvG@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacAzGpNJ2RXedvG@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_085333_898082_FB80846E 
X-CRM114-Status: GOOD (  22.59  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 03, 2026 at 08:39:56AM -0700, Keith Busch wrote:
> On Tue, Mar 03, 2026 at 08:34:38AM +0100, Hannes Reinecke wrote:
> > The idea is nice, and I would love to go into that
> > direction.
> > But have you checked how this holds up under
> > rescan/remapping (eg things like blktest/nvme/058)?
> > Removal of the sysfs nodes might be delayed, and we cannot
> > create new entries with the same name until then.
> > So if that is taken care of, fine, but I don't see that in
> > the patch ...
> 
> I see. I set out to ensure everything was ordered, but apparently I've
> missed this case. Thanks for pointing out the test.

Okay, I think it's as simple as the head unlinking prior to actually
doing the del_gendisk creates a time when one scan work makes a new
namespace before the stale one is deleted in a different scan. This
should fix it:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3f2f9b2be87c2..e8dbb6cb85694 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4246,11 +4246,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)

 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list)) {
-		if (!nvme_mpath_queue_if_no_path(ns->head))
-			list_del_init(&ns->head->entry);
+	if (list_empty(&ns->head->list))
 		last_path = true;
-	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	/* guarantee not available in head->list */
--

This opens a different race where Controller A is deleting the last
path, and Controller B is bringing up a new namespace that reused the
NSID. An earlier patch from me should fix that by reschudeling B's
scan_work once A detects it removed the last path. It should work, but
it feels a bit off to me, so I'll think about it a little more.

