Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8689CC27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1wHp5rr4jOhLspjXHo/w85f8BHmVNISjWiprmsF2ncc=; b=PWwoxkFiVIzuIxZwfgvOnol8iG
	nLDU8zXOXk/Dz1uoY/1sAUm+aupLkStFqB/fjVfp/r9WPoD5vA9GzJoSrc4ptlDrX41wHJ4t7B58w
	tu0pF5S9W07spw8lvF9CC7gpGJqOc8oMxxAasDgi+B40Oz+dBW6TGbIFSA5D8dRqKbND1UnxJVfS0
	6MPy10UpMfJqSIknfmXaVPXnxrrW1JDKJph9jtpSPej1N9ej7LW/Y2RkGxjfpAMlSQz7Ii1Zm3BY1
	jl5w14Zj9FDaijwR+GnhqOU00XHhpa+r0q1Y6P/ijxN5mtFt5u6aCUSbwQbyutH6eR9ytA+Uu+0if
	uP4bwYIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHoPt-0000000HYcs-0o3s;
	Thu, 13 Jun 2024 17:39:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHoPq-0000000HYaD-0unE
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 17:39:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D401E61B95;
	Thu, 13 Jun 2024 17:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C36C2BBFC;
	Thu, 13 Jun 2024 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300352;
	bh=cM/32dqi6fZt6LQTmM2EuhniCZp3BnJkhJ9u/IvhkK4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vLmEkgNiXKte5/uSoWuxw8K2LivuOoveM9eY5IF53RdFd2/aHR3HPlsyeJbzOxJCM
	 0ab8T/A/5ugDDiTNIKpJUsZI5NNfA2P5ojQ6p4L9AOmyGZy7hmApe2Ie1KuPnd2oWQ
	 kXNonU/JFutpllQ1SgrHvwSMciwJbVQ2fuUAAt4YrxDI6cXqqJmXwL82KdipaQUc/E
	 27x5unmbWSKF3Y27/q/MwCanDS7OIVp5BbCztEwJpnc1QSFA3CWP0Fu1cfZtxAyc7T
	 fdohD6WjscUhX3c/2T1Lu6zPrXCytxcvyKT19RP1XnEvWL9VBWu28a3Yjg/+b/qIzM
	 +1cPrEz6SQm/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2E965CE0760; Thu, 13 Jun 2024 10:39:12 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:39:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <c65e7fef-cfee-4360-b03c-cfdd832912a4@paulmck-laptop>
References: <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
 <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
 <ZmsS9DZWl8TccvKz@kbusch-mbp.dhcp.thefacebook.com>
 <046f42c5-34b5-41a2-9680-5ef86ef25c01@paulmck-laptop>
 <ZmsZ_lKgOlB6Wypy@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsZ_lKgOlB6Wypy@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_103914_446671_99E3214F 
X-CRM114-Status: GOOD (  21.46  )
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
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 13, 2024 at 10:10:38AM -0600, Keith Busch wrote:
> On Thu, Jun 13, 2024 at 09:01:47AM -0700, Paul E. McKenney wrote:
> > 
> > Is there a way to avoid this issue by making this be a statement parameter
> > to a macro?
> 
> Something like this? It appears to work for the intended use, at least.
> 
> ---
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 3dc1e58865f77..cdd2e5c0d5cdb 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -204,6 +204,30 @@ static inline void list_replace_rcu(struct list_head *old,
>  	old->prev = LIST_POISON2;
>  }
>  
> +
> +static inline void __list_cut_start(struct list_head *list,
> +				    struct list_head *head,
> +				    struct list_head *entry)
> +{
> +	list->next = entry;
> +	list->prev = head->prev;
> +	__list_del(entry->prev, head);
> +}
> +
> +static inline void __list_cut_end(struct list_head *list,
> +				  struct list_head *entry)
> +{
> +	entry->prev = list;
> +	list->prev->next = list;
> +}
> +
> +#define list_cut_rcu(list, head, entry, sync)		\
> +	do {						\
> +		__list_cut_start(list, head, entry);	\

At this point, old readers might see the new list starting from "head"
and new readers see the new (shorter) list, again, starting from "head".
Presumably no readers can yet see "list".

> +		sync;					\

There are now no old readers, and thus no readers that can see
any elements in the list starting from "entry".

> +		__list_cut_end(list, entry); 		\

And this fixes up the list now headed by "list".

So:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

And another argument for lambdas, not that there is a shortage of
arguments against them.  ;-)

> +	} while (0)
> +
>  /**
>   * __list_splice_init_rcu - join an RCU-protected list into an existing list.
>   * @list:	the RCU-protected list to splice
> --

