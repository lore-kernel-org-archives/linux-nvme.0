Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9839C25B79
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 09:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oYjSnrci3lnkELm39McfY0zcvYjuR0bQF6Lliwvwqb8=; b=Ig+4UIOeSUyVoNy3GUGoYSUnYo
	jVRY7T65xrx4dOQ0cQhgP9xPHEaWhEqiOnLD9YbErH2XLZsGlj2dkRpNRgqTbfuqEZrp492Xp4S4b
	gDwjbrPGdLApfAUR61MIeNFi0SFZf77p9JXXrulwgJBv6uRn13BYaEI7Cy7ds1hm34Hvuqs1CeVcR
	+iqeZ5Ndjv4fMMmV/vLA23gpgm74EOAB/BDSywJfF27zxHnbAq1Bg5AgjoTZJjHf9DQNncGRPB8Gk
	XFRwE01321Vv7frSx9HcJGKqu3mOv0sjssoYFWWcifmfd+LNOV7DfP0BKAeHm4rGZsz2aZIuwZPED
	yKi0kdQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4Z4-00000005cuJ-1tV4;
	Thu, 23 May 2024 09:16:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA3TZ-00000005SoG-0q3S
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 08:07:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1323B68D07; Thu, 23 May 2024 10:06:53 +0200 (CEST)
Date: Thu, 23 May 2024 10:06:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Message-ID: <20240523080652.GA1086@lst.de>
References: <20240522091534.472449-1-sagi@grimberg.me> <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm> <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com> <20240522162845.GA16783@lst.de> <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me> <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_010701_599108_55EF452F 
X-CRM114-Status: GOOD (  12.47  )
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

On Wed, May 22, 2024 at 03:36:19PM -0600, Keith Busch wrote:
> +	mutex_lock(&ctrl->namespaces_lock);
> +	list_del_rcu(&ns->list);
> +	mutex_unlock(&ctrl->namespaces_lock);

This needs a synchronize_srcu().  Maybe factor out a helper to share the
code with nvme_ns_remove?

> -	down_write(&ctrl->namespaces_rwsem);
> +	mutex_lock(&ctrl->namespaces_lock);
>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
>  		if (ns->head->ns_id > nsid)
> -			list_move_tail(&ns->list, &rm_list);
> +			list_splice_init_rcu(&ns->list, &rm_list, synchronize_rcu);

Overly long line here.

>  	}
> -	up_write(&ctrl->namespaces_rwsem);
> +	mutex_unlock(&ctrl->namespaces_lock);
>  
>  	list_for_each_entry_safe(ns, next, &rm_list, list)
>  		nvme_ns_remove(ns);
>  
> +	synchronize_srcu(&ctrl->srcu);

The synchronize_srcu should go right after the mutex_unlock as it
synchronizes the ctrl->namespaces access.

> +	mutex_lock(&ctrl->namespaces_lock);
> +	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
> +	mutex_unlock(&ctrl->namespaces_lock);
>  
>  	list_for_each_entry_safe(ns, next, &ns_list, list)
>  		nvme_ns_remove(ns);
> +
> +	synchronize_srcu(&ctrl->srcu);

Same here.

>  	kref_get(&ns->kref);
> -	up_read(&ctrl->namespaces_rwsem);
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);

The kref_get here has to become a kref_get_unless_zero (aka nvme_get_ns).


