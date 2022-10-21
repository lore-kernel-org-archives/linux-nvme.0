Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B08C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 06:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bnDZLlAxaYQyE1l6POi/8Z81Bv9KgsWQQJT9hXETUhs=; b=alwvDIpgC/tR/MnkIC1yRnRNGB
	l35hVj92Vb/HUogNS1rLQtLcN0pgDaziyGS0QxlvkZCgT9XhiiQauCL6T43piCutZ8s8BA2GY1Xow
	yyIkwoiixf6jvS59/3ZhyMUchXkNijuQrZ6cziG+oQC16NnLAS7MFnMTOtLjSiGLEMl8beFjB8vhR
	QmfwyIDtkNwBXH66KG23CJRG/W3L7shqagBMsz54DBDprhCQ9Ce1SFSN7l7di8naExF6EvZP/KvH/
	tDSwgZg1Qsq8KnxydmEaLBMBTtLmd7/nNvTLKEVH9hTSX8M8lu9J7eRSVg47gAvzkH/Ls1ZxebmHU
	aqLq3bVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olltw-005o6C-AA; Fri, 21 Oct 2022 06:53:04 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olltS-005ntv-1z
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 06:52:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCC1F2195A;
	Fri, 21 Oct 2022 06:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666335152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnDZLlAxaYQyE1l6POi/8Z81Bv9KgsWQQJT9hXETUhs=;
	b=Xlsd7YTizIACO2Z9wYyU7qzoN07rWTNdTqQUujSrlky/rhbxoK1/Y0zDcuASPlzpuug2m+
	CF2G8U+RpjO+WKIsWOfjJAqzEXUNdb6i95MYsUhJhiSakUpYfg+l9rRYtW8THyWo/RcPGU
	wZjB26IxGSZfem9GLe6WPyA1G7HEtJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666335152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnDZLlAxaYQyE1l6POi/8Z81Bv9KgsWQQJT9hXETUhs=;
	b=Rj8TbdXlnKXX0nZjcHaL1c7hXeUepPL8079OtVhZbsosjkZsElgYE7oOvC5S499iRxHaCP
	zHsoM1ldy1Q6vRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 920DA1331A;
	Fri, 21 Oct 2022 06:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ykD4IrBBUmPtHwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:52:32 +0000
Message-ID: <93bc2669-75e9-c2c8-422e-d551ac872ad9@suse.de>
Date: Fri, 21 Oct 2022 08:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 8/8] nvme: use blk_mq_[un]quiesce_tagset
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-9-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221020105608.1581940-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_235234_302163_BB0CA3CB 
X-CRM114-Status: GOOD (  16.06  )
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

On 10/20/22 12:56, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> All controller namespaces share the same tagset, so we can use this
> interface which does the optimal operation for parallel quiesce based on
> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
> 
> nvme connect_q should not be quiesced when quiesce tagset, so set the
> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
> 
> Currently we use NVME_NS_STOPPED to ensure pairing quiescing and
> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
> In addition, we never really quiesce a single namespace. It is a better
> choice to move the flag from ns to ctrl.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: rebased on top of prep patches]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 38 +++++++++-----------------------------
>   drivers/nvme/host/nvme.h |  2 +-
>   2 files changed, 10 insertions(+), 30 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


