Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B93FCCA479
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xkZ/s7WtxAVkUPGyFHjjsumLTjVdh8+OYxSihbuC8vY=; b=NKLNZ41jsRHWNYPRGoiMfWepB6
	4ArRlQg7tL1/F2btNwusG91dcw+KJMqYeb/ROI8xIbKKoQX+gnwCPMeF1jlQkmnro6l/Xw4FB9zeW
	UdrhhWE9DnjMU1vfjOletdQqStBUO3t3ToXSj+GtSljoAwTrhudJoyzq9gDtF1acnyLbMAYYWa4PH
	SdK+5usQvqo7eauCE182NHGb70jXEKVVtQrfXtx5rLdMdGTFH/TchyJ6WnMxvgpUGK9DxXG4+85NF
	ZhfyQZt+/LJMTMaAHUqnBGEWuSrDOviBXdfvHJO/1JULhalEAcQoiuzy4t1D6fDAz1zVrN5f1qVgN
	Rx4Da/qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3DWF-00H5gc-0V; Mon, 20 Jun 2022 09:16:27 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3DWC-00H5fB-2o
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 09:16:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF0561FAC7;
	Mon, 20 Jun 2022 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655716582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkZ/s7WtxAVkUPGyFHjjsumLTjVdh8+OYxSihbuC8vY=;
	b=AT4AJuShz4HqBI2nlNRveK+IXlQV8HIOKAgtrR2dlMOMs20lwZHTyCbhE5eEk8tI/cG/fj
	quaiOztyq0SMOWroxPTUcgPBBHEEwj6WJHy+ROUkSs/TpDjBAUgInuK1DliqMkKE/IOTfX
	BqL6WAPrDjNpcJ7KOac8i/pepCoiIE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655716582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkZ/s7WtxAVkUPGyFHjjsumLTjVdh8+OYxSihbuC8vY=;
	b=hQzyTiyG7q8KmJWCAEayXC6ZF4/JTsIl4bU+RsHupP/su5ogfLFj+IAglbIHxtqzPUIhsL
	feoOPgyoZEA8q6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6ACE134CA;
	Mon, 20 Jun 2022 09:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3sI0KOY6sGKXPgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:16:22 +0000
Message-ID: <97f428d0-8039-709c-f632-db1acc9a4315@suse.de>
Date: Mon, 20 Jun 2022 11:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 5/5] blk-mq: Drop 'reserved' member of busy_tag_iter_fn
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
 <1655463320-241202-6-git-send-email-john.garry@huawei.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1655463320-241202-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_021624_331851_D923C90C 
X-CRM114-Status: GOOD (  10.54  )
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
> We no longer use the 'reserved' member in for any iter function so it
> may be dropped.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq-debugfs.c              |  2 +-
>   block/blk-mq-tag.c                  | 13 +++++--------
>   block/blk-mq.c                      | 10 ++++------
>   drivers/block/mtip32xx/mtip32xx.c   |  6 +++---
>   drivers/block/nbd.c                 |  2 +-
>   drivers/infiniband/ulp/srp/ib_srp.c |  3 +--
>   drivers/nvme/host/core.c            |  2 +-
>   drivers/nvme/host/fc.c              |  3 +--
>   drivers/nvme/host/nvme.h            |  2 +-
>   drivers/scsi/aacraid/comminit.c     |  2 +-
>   drivers/scsi/aacraid/linit.c        |  2 +-
>   drivers/scsi/fnic/fnic_scsi.c       | 12 ++++--------
>   drivers/scsi/hosts.c                | 14 ++++++--------
>   drivers/scsi/mpi3mr/mpi3mr_os.c     | 16 ++++------------
>   include/linux/blk-mq.h              |  2 +-
>   include/scsi/scsi_host.h            |  2 +-
>   16 files changed, 36 insertions(+), 57 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

