Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C59CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tkl1F+PeL8LjSKVfU4hFQjEK6MtNlA5RxXorsZD4Ex0=; b=yVPJEizHV/ZogWypxmrEGxsnUw
	PdCOV/8hjqMdRY85XK7nZO5GzYg2DkAsDtg4fl1qI/CRn6sIMAQyFYqvj0U+oiPHz4dJWGqACyGuB
	gGeZEqZa5Bs5Ba/NLAwKbafgDpzT5Em87N52SE93fWFFQCqqgcCzzbusW/bRGrWdhc/k/bKyo0nIN
	fHWLq+Qp3i4F0asLOqW9/6iWLfDDMx7/gM1MOcg6GE6DS3krX5NJFmCA/b2MUSNnqXkKWn4akhWW4
	/7erLQaNv52d5LrAJtIU065RMAvvK/1+N2ZO6S9UD4YyXe32QBrC/F3ywWb/UHNBIHiReEb2BO7mn
	fhmg2SIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0FF-0000000Abui-08Jq;
	Fri, 26 Jun 2026 06:40:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0FC-0000000AbuG-2NsB
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:40:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E087A68B05; Fri, 26 Jun 2026 08:40:50 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:40:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for
 nvme_ns_head::current_path
Message-ID: <20260626064050.GE10731@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-6-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-6-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_234054_773425_0C8A0CE6 
X-CRM114-Status: GOOD (  15.22  )
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

On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
> +++ b/drivers/nvme/host/multipath.c
> @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>  	bool changed = false;
>  	int node;
>  
> +	/*
> +	 * This helper is used by namespace failover/teardown and I/O policy
> +	 * update paths. We only compare the head->current_path[] pointer value
> +	 * and do not dereference the referenced namespace, so suppress the
> +	 * context analysis warning for this lockless inspection of the
> +	 * __rcu_guarded pointer.
> +	 */
>  	for_each_node(node) {
> -		if (ns == rcu_access_pointer(head->current_path[node])) {
> +		if (context_unsafe(ns ==
> +				rcu_access_pointer(head->current_path[node]))) {

I think we need a helper for this, as for a simple pointer value
comparison without a dereference we don't really need either
rcu_access_pointer nor locking.

Maybe somthing like a

	rcu_compare_pointer(rcu_pointer, nonrcu_pointer)

?

