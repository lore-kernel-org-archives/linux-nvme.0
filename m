Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF421C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MwQ4wbJ2J3BpsHA9sanoJTXO4MMQzFNGd9/de0EGoBY=; b=X9zSBWLyOxHVcmjFxXgfLenLkN
	nCn2c8vjIhyDAz7Kyz0Z36f2ndjgc4gDJb75JJoU+RdtR5MBO752atUekjOYgs4CdQPLmJigsvem7
	GJdV9MXcuobFIQ+hi5HPzorHCkDdSxKu6brZuhQoqfMscIH2bxvwFXG+9laWQ6ujNQkD8Qcl62qrB
	Pyd3LM+UE6YaD5sDjuiHmr7/h3ki/RWtdTx2P6ZWxkdDhAwpYugqcF2yTdIoAvASh9iSTX9VFhz80
	ar4Bl3QgT0gVX1FUVJJM02WpkttvypPYdTpRucZPbj8l6J4YcWOGv/YDioBZTIR0STSNvVV2wiJM4
	N2/lIrGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3DVo-00H5Xf-EQ; Mon, 20 Jun 2022 09:16:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3DVl-00H5Vx-Pu
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 09:15:59 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 886301FA93;
	Mon, 20 Jun 2022 09:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655716556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwQ4wbJ2J3BpsHA9sanoJTXO4MMQzFNGd9/de0EGoBY=;
	b=0evdLip207AMccHMFhzVsCpz9WWDB8kZBWhy46M1Os/TZq8J86x5R1wXT0FMZM5wk1rAKv
	2hliiqFK/qcQVwYmwSCmlIajWgZKhDzTA6fKL8lgt9C8D8nGJqthRywxi7sAyRrSyde036
	OUUL7i7k98RUdKjS3owRzEbPwyc4AMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655716556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwQ4wbJ2J3BpsHA9sanoJTXO4MMQzFNGd9/de0EGoBY=;
	b=cQYqw4WBBdTSCSXGh9NrtwH3roY9H/MFeqRDYT+tT+h2/mPXHCiXbuc1VvoURkrcB4IcV4
	ZmMmzxRfzzuriWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63B26134CA;
	Mon, 20 Jun 2022 09:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VWQgGMw6sGJLPgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 09:15:56 +0000
Message-ID: <3a5bed1b-4daf-6f9c-6746-b0592a84d05d@suse.de>
Date: Mon, 20 Jun 2022 11:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/5] scsi: fnic: Drop reserved request handling
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
 <1655463320-241202-5-git-send-email-john.garry@huawei.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1655463320-241202-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_021558_040133_26BD401A 
X-CRM114-Status: GOOD (  13.20  )
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
> The SCSI core code does not support reserved requests, so drop the
> handling in fnic_pending_aborts_iter().
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/fnic/fnic_scsi.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
> index 3d64877bda8d..e7b7f6d73429 100644
> --- a/drivers/scsi/fnic/fnic_scsi.c
> +++ b/drivers/scsi/fnic/fnic_scsi.c
> @@ -2019,8 +2019,6 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
>   
>   	if (sc == iter_data->lr_sc || sc->device != lun_dev)
>   		return true;
> -	if (reserved)
> -		return true;
>   
>   	io_lock = fnic_io_lock_tag(fnic, abt_tag);
>   	spin_lock_irqsave(io_lock, flags);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

