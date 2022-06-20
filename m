Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0273C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 09:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2V9KSRIUnTh1AKpdFntEf9h9/SEqHZY2hYmAfEYCjwM=; b=LCUnbXgvamMaKA7pQHjtuXVEjx
	3cFTCFkmqJNQaFpe4PIoU137z9ww1rxdIfma3njeAINxgDWx0wemL33CZyKHa3GxfdfyF5cudOVFt
	ywWHY2Dw1xAaoQusTatJiDdiwso9/0i9+QTwa3HD1Wg3pVdKKkHiUa/E5IOjOLIU4OQAmmxaw/Ou/
	D66s59i2wKahGz8t2OiiVAtg11Q2/GGhqfBUvIvmv2aP+yIr/Vd0ZVLUjlPnF1UvOo4bGPOVTx5f9
	odkMpxKu0hv3nPSJJ7a3uEcubRzmuS2M408mwQf5wjEdUpCA3Vy3IU1vGZLuM4yK2p30W0DkI5+tF
	wWUtusTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3DVS-00H5Pt-PL; Mon, 20 Jun 2022 09:15:38 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3DVQ-00H5Ot-76
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 09:15:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEB761F383;
	Mon, 20 Jun 2022 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655716534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2V9KSRIUnTh1AKpdFntEf9h9/SEqHZY2hYmAfEYCjwM=;
	b=eEInt02yyEclQvA3D0SEGYc+rq9mULoWJl23aC/cc/WeOmQgssYUM0bgKG81gyKXZ1AEwL
	zwgK1/zm7xktivSvVNd+3KJm6nF+rTnXLRHJ8Fs3moVubMR7NY2YZM6mlgTfBOjHY+1pRg
	DaVklmB3dW5hOQSdHB0NUAhfDHKFrq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655716534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2V9KSRIUnTh1AKpdFntEf9h9/SEqHZY2hYmAfEYCjwM=;
	b=KPcE/23utxmgudhl1CPBNXRHmmtKptsgtoHx9pw6K9ndhhzbUSv/5Bnae1veZijcAWD+Kb
	SDp56DXqSUrZPPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD3BF134CA;
	Mon, 20 Jun 2022 09:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id u6HQLbY6sGITPgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:15:34 +0000
Message-ID: <28d5b284-f9a6-27f8-58e7-ccbbe8fe3214@suse.de>
Date: Mon, 20 Jun 2022 11:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/5] blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, bvanassche@acm.org, hch@lst.de,
 jejb@linux.ibm.com, martin.petersen@oracle.com, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-4-git-send-email-john.garry@huawei.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1655463320-241202-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_021536_456957_958E812E 
X-CRM114-Status: GOOD (  11.79  )
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

On 6/17/22 12:55, John Garry wrote:
> With new API blk_mq_is_reserved_rq() we can tell if a request is from
> the reserved pool, so stop passing 'reserved' arg. There is actually
> only a single user of that arg for all the callback implementations, which
> can use blk_mq_is_reserved_rq() instead.
> 
> This will also allow us to stop passing the same 'reserved' around the
> blk-mq iter functions next.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq.c                    | 6 +++---
>   block/bsg-lib.c                   | 2 +-
>   drivers/block/mtip32xx/mtip32xx.c | 5 ++---
>   drivers/block/nbd.c               | 3 +--
>   drivers/block/null_blk/main.c     | 2 +-
>   drivers/mmc/core/queue.c          | 3 +--
>   drivers/nvme/host/apple.c         | 3 +--
>   drivers/nvme/host/fc.c            | 3 +--
>   drivers/nvme/host/pci.c           | 2 +-
>   drivers/nvme/host/rdma.c          | 3 +--
>   drivers/nvme/host/tcp.c           | 3 +--
>   drivers/s390/block/dasd.c         | 2 +-
>   drivers/s390/block/dasd_int.h     | 2 +-
>   drivers/scsi/scsi_error.c         | 3 +--
>   drivers/scsi/scsi_priv.h          | 3 +--
>   include/linux/blk-mq.h            | 2 +-
>   16 files changed, 19 insertions(+), 28 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

