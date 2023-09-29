Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DB8E728CF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Sep 2023 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fKmSy9nYMevIdhZdG3nCQj5JvLdfTswn5XDlCNJCRqs=; b=k/2xYPtBVKQfU9aqGw8pY/R4Qo
	hUjGa/iHleSgXAsUsNY5v8fJ/1f2xE+dL4qXpUyb9NE/ZIpcjM31s2V2hl7kH6YHofiQioBZsGS4a
	p0n+2tgf3anBtWgNOAxxacSzfL5nHv3wezktpN8SFkbe28ModVwV/s/FTwJNvoTdR0qOXeFc8kY9C
	bZeXDyD5f7LFwQEkOdE5hRaqO1/JIVRNCA7uyS6KZM3TJN+mIGf8sEu9+qNMnEkmKxlLp7PWGqslk
	1+xa1ozyuQnHmRqY8DsNuNPzpf7JJcsIlfDuumuxBsmB3+ll7xYC8vekPPFR2xQ4F4hbBm8mfWjxV
	BgOssyJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmHlp-008NSt-2Q;
	Fri, 29 Sep 2023 17:59:21 +0000
Received: from mail-oa1-f42.google.com ([209.85.160.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmHlm-008NRr-2v
	for linux-nvme@lists.infradead.org;
	Fri, 29 Sep 2023 17:59:20 +0000
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1e106eb414cso1163074fac.0
        for <linux-nvme@lists.infradead.org>; Fri, 29 Sep 2023 10:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010357; x=1696615157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKmSy9nYMevIdhZdG3nCQj5JvLdfTswn5XDlCNJCRqs=;
        b=RMaMg8CHoeMjYo5bNQw2IWTXP0DR88Ez4xDAef5ud2NaP9kbL/jT24Jm1xLvVAVdCb
         Is85R/HiCGEmN4jT4rlvj4dc2RsqR/CbBakUAIsUYSxqcb9MK67jQim8+QQwbqeKlIYk
         qsjzvaAsA1Sr9NaUSz7so1IczGSh8FukFRDXxU2dbOzBMqjKFF11aBdYTaPSVBVO+EQe
         8UxmZTH8aP4mC+9D1h9aAzTjZEg0kHwDeQhTsxAYuUpMQc2hTDWQfHW0rt68038Nd+/3
         8Pi1+YTP4qf/ZKSIrHP4VD5hRqIkDhItKyIqKedwEenBanHTgIHyGZdjol86XYHXFFT/
         TANQ==
X-Gm-Message-State: AOJu0Yx3MtrIMiT3yhsw2nIYg6lAL1gKRRyvXBaaVRiaSeK1y1xWsqVf
	gJia6Z/JsaJQg4Iv+J2CyZU=
X-Google-Smtp-Source: AGHT+IFGOtUOVVnTjR70judkp2CAL1bg7IpOYVhdJtj/g+DmpMMTkZUqHC4hofJt5GNiQMWUQXGnOA==
X-Received: by 2002:a05:6870:230d:b0:1bb:a912:9339 with SMTP id w13-20020a056870230d00b001bba9129339mr5301433oao.7.1696010356848;
        Fri, 29 Sep 2023 10:59:16 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id x28-20020a63b21c000000b00564b313d526sm15006265pge.54.2023.09.29.10.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 10:59:16 -0700 (PDT)
Message-ID: <2abb1fb8-88c6-401d-b65f-b7001b2203ec@acm.org>
Date: Fri, 29 Sep 2023 10:59:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] scsi: sd: Add WRITE_ATOMIC_16 support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-20-john.g.garry@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-20-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_105918_949929_631B7726 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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

On 9/29/23 03:27, John Garry wrote:
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

Please store the 'dld' value in the GROUP NUMBER field. See e.g.
sd_setup_rw16_cmnd().

> @@ -1139,6 +1156,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>   	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
>   	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
>   	bool write = rq_data_dir(rq) == WRITE;
> +	bool atomic_write = !!(rq->cmd_flags & REQ_ATOMIC) && write;

Please leave out the superfluous "!!".

Thanks,

Bart.

