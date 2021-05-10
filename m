Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33AC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 15:54:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB8C6161C
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 15:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB8C6161C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rd02byij1XJvdxG4pwJy6bQ2sHQDNs1PSdYHFdO8aCk=; b=kVfRDP6ZAfJzsrtqqs6/AuV5D
	BulIk38NGgtaWEm/IID1BeFvYvImeVBKHLFJv+H7duutSmDsNLPVSeusRh+zRjoe1AKYdVvwOE3Yq
	nthzv1iqL8oJhT7aq3DcC3VyCxkVjhpG88HsBLpWEq9FgdfTaVJgSt2tVoMNy6hOTHr5b/+o17PrZ
	BCekuH64YXOXQts3SQoC2lH6Qoopgrgpj5UyNiKrjqGlkja0LkPwN5JVQp7FdumTFveTa88A0ARLb
	u+fUZWkug4q5/jOwP1M1cAFEnVPPeZArzhZXkaK9ZY7uZqcHH4ByYxFbwrv8nfdtRTouMmnjOYgZn
	kLTMEwPlA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lg8Dt-00Epta-SR; Mon, 10 May 2021 15:53:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg8Dr-00EptI-Tr
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 15:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tLvn2Uy/0LazDRA8ccjFbMxb6qWBNBIhv9y/lv6qzeE=; b=iPw1g9rEFV/weORBX8FJRUPSJY
 eV+pqLgbq3ohK2ErHlh1yOZ8IBjZQ86BUg7i/iUPyQmZ/4peVu92d4FyGkSU8W06AWdVEiutZ78JB
 eaqeIdb299t88PrL7pplLSfOxttK/DZLNDaYh25AuiPdNuDYxis/CVTm054m9+DTTJzahquiiJgWh
 aClzOmxku2cdNl5NbujXnBU33UMuwQkqRBTaujsVFIOmcsGrsjTvQLTmIgEc6waHrNsmF0G8szYqu
 U9OrwHOCOU89WiLoMn5NxxGZkng0CkOgyrkoGFATRerTfRdjzFefnbyobsA3EZfovRdClWxObjVIv
 89fxbH/g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg8Dp-008tB9-EW
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 15:53:30 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 509D9615FF;
 Mon, 10 May 2021 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620662007;
 bh=vJENp8mmAfOdR1yCN5f2ldcj94Nol2IUwtj36+P/E+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HCOkzr51my7N8rcawjWecJK8A1ICglmO5WYxOtZTgt8iWqWN0ZkFAfCRmoHAczSzO
 46P7JL/M9PPFbELjGZnGYKWr4KqUFMh50vVKpUNC39mdd36eVjop45rMdK+TQEW/wp
 24I8KknTv5wACA/V6SKmQvUaRE6nFLtOoH7EnWeVTqnklzWX6gXoVlPPy0I3qpKh1e
 +0tFdLOy7Bg5sQjAmz7bY6lCJJUVuKKkWQAbyoXTnO5Uw15U7kEPU37ZonCtGPL0pO
 VOurlX85YvrJ/vWL8SNGksnP8YVtloKnDDtT2kxdhHc1GwfcvWxcEtaIu3l995jtN0
 URiuUHAxWq7lQ==
Date: Mon, 10 May 2021 08:53:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
Message-ID: <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
References: <20210510144906.8305-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210510144906.8305-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_085329_552383_B40B3240 
X-CRM114-Status: GOOD (  17.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 10, 2021 at 04:49:06PM +0200, Hannes Reinecke wrote:
> @@ -3605,16 +3608,26 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>  		head->shared = is_shared;
>  	} else {
>  		ret = -EINVAL;
> -		if (!is_shared || !head->shared) {
> -			dev_err(ctrl->device,
> -				"Duplicate unshared namespace %d\n", nsid);
> -			goto out_put_ns_head;
> -		}
> -		if (!nvme_ns_ids_equal(&head->ids, ids)) {
> -			dev_err(ctrl->device,
> -				"IDs don't match for shared namespace %d\n",
> +		/*
> +		 * If multipath is enabled we might hit an ns head with no
> +		 * paths, but that doesn't indicate it's a shared namespace.
> +		 */
> +		if (!nvme_ns_head_multipath(head) ||
> +		    !list_empty(&head->list)) {
> +			if (!is_shared || !head->shared) {
> +				dev_err(ctrl->device,
> +					"Duplicate unshared namespace %d\n", nsid);
> +				goto out_put_ns_head;
> +			}

If not multipath, then it is not shared. The above will fail attaching
single-path namespaces to a known head.

The rest is similar to something I was working on too, though, so I
think it's the right direction.


> +			if (!nvme_ns_ids_equal(&head->ids, ids)) {
> +				dev_err(ctrl->device,
> +					"IDs don't match for shared namespace %d\n",
>  					nsid);
> -			goto out_put_ns_head;
> +				goto out_put_ns_head;
> +			}
> +		} else {
> +			/* But the ids might have changed, so reset them */
> +			head->ids = *ids;
>  		}
>  	}
>  
> @@ -3764,8 +3777,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	mutex_lock(&ns->ctrl->subsys->lock);
>  	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);
>  	mutex_unlock(&ns->ctrl->subsys->lock);
>  
>  	synchronize_rcu(); /* guarantee not available in head->list */
> -- 
> 2.26.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
