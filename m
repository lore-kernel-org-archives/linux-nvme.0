Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F37C27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wC5OZnq3v1yIVM8bLFl+GWjkjb1gTIbLriEcW2SBytQ=; b=VftSmTAdm50dHGuLBCbZhfMyi1
	vxVIR+Zz6VkoSXAEsK2mEUTP9aEaH7pGO1HgKgJmNWsAjRUPVE5xrdc6J8Af+770fclN1IS0pZ17Q
	736Kkz8hSOP+GdR2zFZX82HVKAGuDx+7wlitgqxTA/7klkmQmPtr1t3NnA1YIqQvJlA9p5lhrFiG+
	RAGszzjC3XPe/vx77voQePn7TICG/4uJhf+NKM5rUR74LJrDSkiSOmrS7/W/zzzVoGtBHlMLN7Ev1
	wcIJgq1wI3obP5R8pGCugHXGkA2QE7Rf9791BPNaRQ2pdfXhppJR7yl1BMrHZmj0budHU38NdZ1Ug
	DgV2V3rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH4XU-00000009Xcl-0EZG;
	Tue, 11 Jun 2024 16:40:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH4XR-00000009XbN-0BHZ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 16:40:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A473868BEB; Tue, 11 Jun 2024 18:39:55 +0200 (CEST)
Date: Tue, 11 Jun 2024 18:39:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <20240611163955.GA12787@lst.de>
References: <20240611152055.2317197-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611152055.2317197-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_094001_274526_B26746D4 
X-CRM114-Status: GOOD (  12.83  )
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

On Tue, Jun 11, 2024 at 08:20:55AM -0700, Keith Busch wrote:
>  	mutex_lock(&ctrl->namespaces_lock);
>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -		if (ns->head->ns_id > nsid)
> -			list_splice_init_rcu(&ns->list, &rm_list,
> -					     synchronize_rcu);
> +		if (ns->head->ns_id > nsid) {
> +			list_del_rcu(&ns->list);
> +			list_add_tail_rcu(&ns->list, &rm_list);
> +		}

Is this actually valid for a (S)RCU protected list?  If the entry gets
added to the new list before the grace period has completed, we could
trick a concurrent traversal into following the new list unless I'm
mistaken (although chances I'm mistaken on RCU corner cases aren't that
low..).


