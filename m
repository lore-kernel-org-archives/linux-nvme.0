Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613A2C32793
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Aug 2022 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MAPhCVLefD928aNQlxwoHlELWGNsznc4+LPbx8RTGeo=; b=2/aC4VgFEVaoixMc5hzvHivJFH
	T9QI+A9jJs7k0zdv1MskGQ6WJTDruBixY35rV/g9DtPn5CjNhfdlXJupcGtubApqjwnKv/Crrw7XZ
	t8xSNQrlZyrGhAgpB07f4yxd4QCJzyZMKjeMfKg3oCXCaCKdjE1cxlb8LOMDZrPJnNwqnNtYn7Q+2
	YHI5HDtJ/FCXyUIryEbu+MQ1p1CrqO3yWVS17vQ+Uf2uwafPlQXOIsMJD34JujmiPEVMR7JcML4nv
	4k44O6/KpQ5+mnAQa+gzZUJmnXBMk0vzh0IhI0Rs9iQ0yI9mqJIgqO9fRXz2ystRjUfEUKTqFXWUM
	+fi14CWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQoME-00CNNv-Eo; Wed, 24 Aug 2022 11:15:38 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQoM8-00CNLd-EW
	for linux-nvme@lists.infradead.org; Wed, 24 Aug 2022 11:15:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 413052271B;
	Wed, 24 Aug 2022 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661339729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAPhCVLefD928aNQlxwoHlELWGNsznc4+LPbx8RTGeo=;
	b=A/Ebq4JzhylNec/si5TPVGl6oOQhl/9M5icxMHmgfc415CO1ip5LZY5N1znrIuFlcJcabA
	d+89UwxGIZ4YY5AlaomRzO9qNcvydZmzbH7za2u0rQt5PUa4aQ0y3bs0DVOgjkl96ne+KT
	G8WIC7NUHmc18mYCULmaW9wnmKeWv2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661339729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAPhCVLefD928aNQlxwoHlELWGNsznc4+LPbx8RTGeo=;
	b=t+LgmGlQn3Ob5Y/7oN1Il7hj5z72w8WC0cO0wSIoaXNEIHLA9ItE+aSNqguKRK4gsJuNn1
	biy2N8gnsJ3V3tCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2209713780;
	Wed, 24 Aug 2022 11:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rLF/B1EIBmPZLwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 24 Aug 2022 11:15:29 +0000
Message-ID: <a2f9fd7c-7562-a79c-0ee2-76dcb7dd387b@suse.de>
Date: Wed, 24 Aug 2022 13:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220821084754.340585-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_041532_667766_A41D73ED 
X-CRM114-Status: GOOD (  17.67  )
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

On 8/21/22 10:47, Ming Lei wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> In some corner cases[1], freeze wait and unfreeze API may be called on
> unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
> freeze APIs more reliably, then this kind of issues can be avoided.
> And similar approach has been applied on stopping/quiescing nvme queues.
> 
> [1] https://lore.kernel.org/linux-nvme/20220801125753.1434024-1-ming.lei@redhat.com/
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://lore.kernel.org/linux-block/CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com/#r
> 
> Add comment log.
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 16 +++++++++++++---
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af367b22871b..fe4ae3616ed1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5028,8 +5028,11 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
>   	struct nvme_ns *ns;
>   
>   	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (!test_and_clear_bit(NVME_NS_FREEZE, &ns->flags))
> +			continue;
>   		blk_mq_unfreeze_queue(ns->queue);
> +	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_unfreeze);
> @@ -5040,6 +5043,8 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
>   
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (!test_bit(NVME_NS_FREEZE, &ns->flags))
> +			continue;
>   		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
>   		if (timeout <= 0)
>   			break;
> @@ -5054,8 +5059,11 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
>   	struct nvme_ns *ns;
>   
>   	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (!test_bit(NVME_NS_FREEZE, &ns->flags))
> +			continue;
>   		blk_mq_freeze_queue_wait(ns->queue);
> +	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_wait_freeze);
> @@ -5065,8 +5073,10 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
>   	struct nvme_ns *ns;
>   
>   	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) { > +		set_bit(NVME_NS_FREEZE, &ns->flags);

Why not test_and_set_bit()?
Which would have the nice effect of adding a memory barrier ...

>   		blk_freeze_queue_start(ns->queue);
> +	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_freeze);

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

