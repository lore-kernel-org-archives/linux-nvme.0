Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351B2C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XuZdnAT/CQoJVHT3dd2kMfmEP+YdLoqLBmiyeRwGCT0=; b=SaHLM/evyvqu70SBSRCYzwrzfM
	GYr0i3xAlZHJHKWSdaMZ6rj2jyXTdXHTbmvA5tX+yyKMX6K2PJoTzNQ65YLaktk6Y/ZMbBZgutgv9
	PatkzoygSZeBTNa3yN2Q4BsOyZhS1I0AyZU4tMe/BZlMv0q2ZELzmYaztcc4/4liSNV3/i9vLTzMR
	LkJ/yY02BjJIvcjqTmD9VlgXcA4aryqt0+CyhKfrmMTHAMUleqrRRCWuIdPeK16LX75bpcnc/Hr9U
	hNrDIjXkjkDxR20M7B08Anhx1CrMXzCwc+GObJPJidtSvV/f2eRGrbCg0WSrcwy+MTLJVL3cKOhd9
	Ds33ooYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puHWy-005TxU-2d;
	Wed, 03 May 2023 18:48:48 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puHWw-005Twa-07
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 18:48:47 +0000
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-63b51fd2972so3963304b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 May 2023 11:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139725; x=1685731725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuZdnAT/CQoJVHT3dd2kMfmEP+YdLoqLBmiyeRwGCT0=;
        b=V73vQF+F2Ej/8+n85ILzmFvJh1v77XloVwHmjjAfJIFRuHOftiPIAyvt3pVdivHm2e
         ivEnGJjartHlZ0qkf+Xf/AGsvY+yXThRoJk6mw5Ev455q/Lo6AH+Y7d+k//f1uD0RECn
         eOCYD4Sog3AU5EE097A5hfo0gw7dvEacRaIhHhxV2hGmDICwmRK+A5mIRQvFGRv148xX
         hAcVU3rP2xzX7kh9DQRLACgmPAuyH+mWXWpJapt+VwYYhccQGzPyrUKjh6kzWgrPg4De
         zIVXJDyA70yszMh5+kl9tNpipUFYorwEQZRr/o5B9vDAq2TZBH+wH+G9DUuP4dHy4e+8
         SmeQ==
X-Gm-Message-State: AC+VfDz4HU2VPFzXAzAZospB+Yy3346uhnXhQNVqtz8Lef2qtJakiev5
	+oS9FTx6yG7tbXpoFpbEAFk=
X-Google-Smtp-Source: ACHHUZ5F6Az63900qigR1giHZvAPngXjFjcguLu9ABSQRGHDFzMdwXwdp/xGRc4SUkbW0gFEAodEnw==
X-Received: by 2002:a05:6a20:258e:b0:ef:b02a:b35b with SMTP id k14-20020a056a20258e00b000efb02ab35bmr28209835pzd.0.1683139724862;
        Wed, 03 May 2023 11:48:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c683:a90b:5f41:5878? ([2620:15c:211:201:c683:a90b:5f41:5878])
        by smtp.gmail.com with ESMTPSA id b20-20020a056a0002d400b006348cb791f4sm23919397pft.192.2023.05.03.11.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 11:48:44 -0700 (PDT)
Message-ID: <81ce524d-6186-e016-f597-153d214036bf@acm.org>
Date: Wed, 3 May 2023 11:48:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC 14/16] scsi: sd: Add WRITE_ATOMIC_16 support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com, djwong@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
 jejb@linux.ibm.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-15-john.g.garry@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230503183821.1473305-15-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_114846_073435_D2C53675 
X-CRM114-Status: GOOD (  12.54  )
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

On 5/3/23 11:38, John Garry wrote:
> +static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
> +					sector_t lba, unsigned int nr_blocks,
> +					unsigned char flags)
> +{
> +	cmd->cmd_len  = 16;
> +	cmd->cmnd[0]  = WRITE_ATOMIC_16;
> +	cmd->cmnd[1]  = flags;
> +	put_unaligned_be64(lba, &cmd->cmnd[2]);
> +	cmd->cmnd[10] = 0;
> +	cmd->cmnd[11] = 0;
> +	put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
> +	cmd->cmnd[14] = 0;
> +	cmd->cmnd[15] = 0;
> +
> +	return BLK_STS_OK;
> +}

A single space in front of the assignment operator please.

> +
>   static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>   {
>   	struct request *rq = scsi_cmd_to_rq(cmd);
> @@ -1149,6 +1166,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>   	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
>   	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
>   	bool write = rq_data_dir(rq) == WRITE;
> +	bool atomic_write = !!(rq->cmd_flags & REQ_ATOMIC) && write;

Isn't the !! superfluous in the above expression? I have not yet seen 
any other kernel code where a flag test is used in a boolean expression 
and where !! occurs in front of the flag test.

Thanks,

Bart.

