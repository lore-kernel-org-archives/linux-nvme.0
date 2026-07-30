Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B689C54FDF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tWAYNlMVBPdQyim6GUs7iwNAzsnICSy5PY+t3i/Y8c=; b=f/zGw3mYnbbMtUDjHK8X9dpca6
	nEZKIQq7kGNLv6ZQCfBgbwC0OjbnsB1LHfPQjl6ljeC6TMN8jigOWESwBnM+l8SU2MjCoWrzHFNKB
	Ioc5S0Gy4Ckk0UIwlkSF/2l1cJdplwBRKzvB189N2xuzKmFVH3tclCZkFTbPLKutm8Lq95NG8FKlj
	FUGgBmF8LEzp+3MGFKndE8TCa8z40zg78t33mzM8aAmITgIXjGFeZ7PamNs5VOQOl9Qc2S4855TVY
	1kswenfO6qTf+i7LXZ3MU1LtgywwBHbSQZfpS3O1CGpUon9eCPLkM4aRXkENFms9irW2pHB3E0SqO
	FamhQmug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpM3U-00000009qgs-0gah;
	Thu, 30 Jul 2026 08:23:52 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpM3Q-00000009qfg-2Js4
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 08:23:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FF9B7D2F2;
	Thu, 30 Jul 2026 08:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785399822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tWAYNlMVBPdQyim6GUs7iwNAzsnICSy5PY+t3i/Y8c=;
	b=zl70By1QI57Feu1MdVYCkgOkVvPH3gsREE9qWioHRFyNm/sAy69V0JlQhk2XKQfiof5c/w
	juNy83kWWxUCCy6kM+2wWHP407Ye8K1558bHwDGGOwOTM3ABPd5djea4fYpMYqILM2BsHW
	ITbC6TeNg5Oq3UZzXVybfumotjyLe2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785399822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tWAYNlMVBPdQyim6GUs7iwNAzsnICSy5PY+t3i/Y8c=;
	b=r2xIZMIKgpwnqodqIh3AP0b4pAUoRxLrvyP3yBbnvB//rO+mXy8YPpMywyxo8ujHWYs1on
	a+IGcayqA3EUZAAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785399818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tWAYNlMVBPdQyim6GUs7iwNAzsnICSy5PY+t3i/Y8c=;
	b=H84/YI8O4XDBftPS1/i6IpEKicMb+LJTqEwOAJZO/NNd+T4NeAp1YkqlviGwJd4t5VXmNe
	7751yX3VTvTSF9wUMBRSC26iy2dVD2VWdzgYuodq0RYLGHa4Uofy7wH2nJmGdPIWYG56Ov
	EYUCl9I1Ls1LF0cJs1neQFKMh3WqGaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785399818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tWAYNlMVBPdQyim6GUs7iwNAzsnICSy5PY+t3i/Y8c=;
	b=bInTNFD5IPGP5QlZ+8c8GwDuTQg9JhoBzueza27ozQ5wjjSUlw+3zcjX0ElibF7cSDZBxh
	zJ9O5sFBUk26ljCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6757C779CC;
	Thu, 30 Jul 2026 08:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JPSnGAoKa2o5NAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 30 Jul 2026 08:23:38 +0000
Message-ID: <421467fb-f66a-4bdd-b841-4027e65d3e6b@suse.de>
Date: Thu, 30 Jul 2026 10:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-pci: release descriptor pools on probe failure
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-4-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260730043105.3071328-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,alibaba.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_012348_742028_8AF1B614 
X-CRM114-Status: GOOD (  15.76  )
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

On 7/30/26 6:31 AM, Guixin Liu wrote:
> The per-NUMA-node descriptor DMA pools are created lazily from
> nvme_init_hctx_common() once the admin tag set is allocated, but they are
> only destroyed in nvme_remove() via nvme_release_descriptor_pools(). Any
> probe failure after the admin tag set has been allocated unwinds through
> the out_disable label and nvme_pci_free_ctrl(), neither of which releases
> the pools, leaking the dma_pool objects.
> 
> Release the descriptor pools in the out_disable error path. It must not
> be added to nvme_pci_free_ctrl(), as that would double-free against
> nvme_remove() on the normal teardown path.
> 
> Fixes: d977506f8863 ("nvme-pci: make PRP list DMA pools per-NUMA-node")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 69932d640b53..f1b24a53aa02 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3838,6 +3838,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	nvme_dev_remove_admin(dev);
>   	nvme_dbbuf_dma_free(dev);
>   	nvme_free_queues(dev, 0);
> +	nvme_release_descriptor_pools(dev);
>   out_release_iod_mempool:
>   	mempool_destroy(dev->dmavec_mempool);
>   out_dev_unmap:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

