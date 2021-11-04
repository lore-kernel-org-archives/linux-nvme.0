Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E7BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 15:44:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21631610D0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 15:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21631610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzdFGYg31PJtt6rJSVkSOc5/8FhG9aM0ruYKHwPWVNY=; b=1qyKO4GEiqP7dxj5QO5+9Smgkx
	zMoFM7ge3h39IXAflMExz/qr6ExA6DBt5+hjd2mGEVhmiWbIzTkqvkiNUDAs077jZ1+aUo1IgQL0t
	28UcXqw+LLU7bSIbgl328Q2rx4qQiSLxjDOKrI647aadzpW/f3M2u+icYgkJmOarqP7JLkfsdNbcb
	YwGRZElkYO5PRpztUpIQJEwiZ7p2/FOG3DimOxKXW2KzYUWQ40FawId0ildj6dNWdb6Pj5+C5aUC5
	BaaMD01lp29MkC/rxFlVs6cFF9yKOx8qVyPLu97kSymQ7Jdb1fDqrXs4xRQUwMTqHPTm0Mxgf/4US
	czSCqBvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mieus-009Ido-Eo; Thu, 04 Nov 2021 15:44:38 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mibve-008tWR-K0
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 12:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1636029195; x=1667565195;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=LtBy39t5zEVI3x0/1E6ODBKN5DFMdG9pColeMnfbRVk=;
 b=Bja/3DpywB31K+zOsvPlNx7U/OyB2weJzWVv5i2PV8Hh9Ou2Jwhf7uYt
 i+11kA62sfvs6EvRr3CqEil9K2L1zxOlyD+O6LVir2hV4j7tWY7i3zekt
 b9qnJ9nSEufJm8/859C/Ugyyt819v/jhCxvNNTSvbpHXIMzsT0h5F5Bf9
 deE64Zxo0BqmAf0V2lDUVVB5kvtXT/nw8om/fv5WF9vluOeQFZiSYH5uK
 3A+d+iwKxj1vIywbcUGYK3EAEVEKXaO+eRiYlUPAQXh56J7rWg2nGIfS7
 vq9A0c6U2aYVTdCMtzT7PLC3S+/M/M7ZdqMHQf/svstXniviroFQz2tot w==;
X-IronPort-AV: E=Sophos;i="5.87,208,1631548800"; d="scan'208";a="185687582"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2021 20:33:12 +0800
IronPort-SDR: iO/T3wtF8qiMbZmASoCVAgnwuoFs2X+6yQeDgbgLNAHFKNY4ntRf+/upq41rROkI/5SOjQS3nU
 ACK9mOh8cMGO3rLRi/fAeFJOkJitCH8UBZWfOmjafcE9ylXWqEK/X5GdXbGTzOL3jSziTkcLRJ
 vEuAjhD2DRFXYefxUTSCw2Xm0Jfp5cbehqgj//LR+U0seTeAPuKB496zDeQRIHRerKPJ+3KkAN
 YR/8LINteVUn5W2SWA8fHtmkzwSv+2ioOjQfbLfXbqzXnubDV8TBrGq/8Gpr86SJoYRvU6f19l
 w4vf9I8R0yfVgGXsLxNz/l/S
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 05:06:57 -0700
IronPort-SDR: aHbe5455DjTiUfIwgtN1jNHsApYUC5euGE6GA2moDRN8PCX8ZuM7ZaZhlNXPXdf1mCoepblzRb
 RfNWr1JihhbexMgM5aIZFTvlpm+mNvEy/B/fAv3LqzQU4bNTfJ7JHXq30D+zJuEben1at7cFnM
 la4v2gDvJ92D25ysxXYF7tnU2v1/Cfi3GxfUFDpgB6GbJZ7IfZgM9tqXRJiXyTFFDfBsbWoz0l
 Uj21x9AKBpC1jYxmZExMG/CsIvYjVFdN8E1ntffxnCdP9u5pHXAKdzcndbZxoVwxLNByYWpsqk
 O1k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 05:33:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HlNMq0t9cz1RtVt
 for <linux-nvme@lists.infradead.org>; Thu,  4 Nov 2021 05:33:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1636029189; x=1638621190; bh=LtBy39t5zEVI3x0/1E6ODBKN5DFMdG9pCol
 eMnfbRVk=; b=gjkF0nwoBQIODC1Re40fslJPDpfiOr+OQ31j2LQjMDBi8PHndSb
 Tex0lRKDUJ8uJYuVkpU6mzGYoegjxQYSoHassMtcUml9iAG3CK5CUnLRqk0SWgqj
 TNa27IQgrf53sXJRfVafNG0IwIX16OTlBjVHlMccp7t4UWVRsKWnJ7S3m4jS3wdr
 0SaYoixwmAZOgxshe8wWzeqanW7GfZgOo+593TEZ8nAGm1sOVxbZx5fLg+CRRWTW
 o823HP5Qk+cEx4LPZzewNRffDzrSemtys5ZoINuiBBqyRa+vYhLqCVGbVsAdMXAR
 29ZZIAR7L1gBqRMynqZe1Kh2QETYL8s50iw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id cpjd2AnSvXg1 for <linux-nvme@lists.infradead.org>;
 Thu,  4 Nov 2021 05:33:09 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HlNMd5TBrz1RtVl;
 Thu,  4 Nov 2021 05:33:01 -0700 (PDT)
Message-ID: <bd36ee58-8273-cd0a-295e-0c66b0142bcd@opensource.wdc.com>
Date: Thu, 4 Nov 2021 21:33:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [RFC PATCH 2/8] scsi: add REQ_OP_VERIFY support
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, dm-devel@redhat.com
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@redhat.com, song@kernel.org,
 djwong@kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 jejb@linux.ibm.com, martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
 javier@javigon.com, johannes.thumshirn@wdc.com, bvanassche@acm.org,
 dongli.zhang@oracle.com, ming.lei@redhat.com, osandov@fb.com,
 willy@infradead.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 clm@fb.com, dsterba@suse.com, jack@suse.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
 danil.kipnis@cloud.ionos.com, ebiggers@google.com,
 jinpu.wang@cloud.ionos.com, Chaitanya Kulkarni <kch@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-3-chaitanyak@nvidia.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211104064634.4481-3-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_053314_780443_5129F68A 
X-CRM114-Status: GOOD (  27.73  )
X-Mailman-Approved-At: Thu, 04 Nov 2021 08:44:36 -0700
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

On 2021/11/04 15:46, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/scsi/sd.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/sd.h |  1 +
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a3d2d4bc4a3d..7f2c4eb98cf8 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -106,6 +106,7 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_ZBC);
>  
>  static void sd_config_discard(struct scsi_disk *, unsigned int);
>  static void sd_config_write_same(struct scsi_disk *);
> +static void sd_config_verify(struct scsi_disk *sdkp);
>  static int  sd_revalidate_disk(struct gendisk *);
>  static void sd_unlock_native_capacity(struct gendisk *disk);
>  static int  sd_probe(struct device *);
> @@ -995,6 +996,41 @@ static blk_status_t sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
>  	return sd_setup_write_same10_cmnd(cmd, false);
>  }
>  
> +static void sd_config_verify(struct scsi_disk *sdkp)
> +{
> +	struct request_queue *q = sdkp->disk->queue;
> +
> +	/* XXX: use same pattern as sd_config_write_same(). */
> +	blk_queue_max_verify_sectors(q, UINT_MAX >> 9);

VERIFY 10, 12, 16 and 32 commands are optional and may not be implemented by a
device. So setting this unconditionally is wrong.
At the very least you must have an "if (sdkp->verify_16)" here, and call
"blk_queue_max_verify_sectors(q, 0);" if the device does not support verify.

> +}
> +
> +static blk_status_t sd_setup_verify_cmnd(struct scsi_cmnd *cmd)
> +{
> +       struct request *rq = cmd->request;
> +       struct scsi_device *sdp = cmd->device;
> +       struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
> +       u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
> +       u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
> +
> +       if (!sdkp->verify_16)
> +	       return BLK_STS_NOTSUPP;

I think this should be "return BLK_STS_TARGET;"

> +
> +       cmd->cmd_len = 16;
> +       cmd->cmnd[0] = VERIFY_16;

And what if the device supports VERIFY 10 or 12 but not VERIFY 16 ?

> +       /* skip veprotect / dpo / bytchk */
> +       cmd->cmnd[1] = 0;
> +       put_unaligned_be64(lba, &cmd->cmnd[2]);
> +       put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
> +       cmd->cmnd[14] = 0;
> +       cmd->cmnd[15] = 0;
> +
> +       cmd->allowed = SD_MAX_RETRIES;
> +       cmd->sc_data_direction = DMA_NONE;
> +       cmd->transfersize = 0;
> +
> +       return BLK_STS_OK;
> +}
> +
>  static void sd_config_write_same(struct scsi_disk *sdkp)
>  {
>  	struct request_queue *q = sdkp->disk->queue;
> @@ -1345,6 +1381,8 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
>  		}
>  	case REQ_OP_WRITE_ZEROES:
>  		return sd_setup_write_zeroes_cmnd(cmd);
> +	case REQ_OP_VERIFY:
> +		return sd_setup_verify_cmnd(cmd);
>  	case REQ_OP_WRITE_SAME:
>  		return sd_setup_write_same_cmnd(cmd);
>  	case REQ_OP_FLUSH:
> @@ -2029,6 +2067,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
>  	switch (req_op(req)) {
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_VERIFY:
>  	case REQ_OP_WRITE_SAME:
>  	case REQ_OP_ZONE_RESET:
>  	case REQ_OP_ZONE_RESET_ALL:
> @@ -3096,6 +3135,17 @@ static void sd_read_write_same(struct scsi_disk *sdkp, unsigned char *buffer)
>  		sdkp->ws10 = 1;
>  }
>  
> +static void sd_read_verify(struct scsi_disk *sdkp, unsigned char *buffer)
> +{
> +       struct scsi_device *sdev = sdkp->device;
> +
> +       sd_printk(KERN_INFO, sdkp, "VERIFY16 check.\n");

Remove this message please.

> +       if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, VERIFY_16) == 1) {
> +	       sd_printk(KERN_INFO, sdkp, " VERIFY16 in ON .\n");

And this one too.

> +               sdkp->verify_16 = 1;

Why not checking for VERIFY 10 and 12 if VERIFY 16 is not supported ?
Also, why don't you call "blk_queue_max_verify_sectors(q, UINT_MAX >> 9);" here
instead of adding the not so useful sd_config_verify() helper ?

> +       }
> +}
> +
>  static void sd_read_security(struct scsi_disk *sdkp, unsigned char *buffer)
>  {
>  	struct scsi_device *sdev = sdkp->device;
> @@ -3224,6 +3274,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  		sd_read_cache_type(sdkp, buffer);
>  		sd_read_app_tag_own(sdkp, buffer);
>  		sd_read_write_same(sdkp, buffer);
> +		sd_read_verify(sdkp, buffer);
>  		sd_read_security(sdkp, buffer);
>  	}
>  
> @@ -3265,6 +3316,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  
>  	set_capacity_and_notify(disk, logical_to_sectors(sdp, sdkp->capacity));
>  	sd_config_write_same(sdkp);
> +	sd_config_verify(sdkp);
>  	kfree(buffer);
>  
>  	/*
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index b59136c4125b..94a86bf6dac4 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -120,6 +120,7 @@ struct scsi_disk {
>  	unsigned	lbpvpd : 1;
>  	unsigned	ws10 : 1;
>  	unsigned	ws16 : 1;
> +	unsigned        verify_16 : 1;

See right above this line how write same supports the 10 and 16 variants. I
think you need the same here. And very likely, you also need the 32 version in
case the device has DIF/DIX (type 2 protection).

>  	unsigned	rc_basis: 2;
>  	unsigned	zoned: 2;
>  	unsigned	urswrz : 1;
> 


-- 
Damien Le Moal
Western Digital Research

