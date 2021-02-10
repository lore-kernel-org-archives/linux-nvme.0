Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A64C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 14:45:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5591664D87
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 14:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5591664D87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h4XpLkuyiBS1wmAD25xY1AMOstCT3Fh6Q2/zH0opbM0=; b=rNiyfpo0QWx5rXex6sCztMvc7
	pvV8SkHU64vHBJ3WwRsrHggNiu6tODP1zDUPz0N/rVPoLIWSbV2oKXd0x7RGr+fstC1TCDcNYZkkr
	SuSVL7K55ICEcv4wdMs8hGWqYEZIakvGShwmh2n/azs20dmsfD8O0N4DNzZAllu5k0saPu0l6V58T
	CEbpV65Ig0igpcjz4+WKuZ8auXxfk9l+gzFyieFAnS7ZeJGAUd4VOxcHAmuANI5qnO3REFgnzoJnd
	WfaefVoSfVYKEAq8MkQUP+GukstD/KrPcbf/uH20pXWruf72gHa4lsNF0/MJmxPreZC4jMDEa1Ide
	s/m9a389g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9qk0-0005QE-9e; Wed, 10 Feb 2021 14:45:16 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9qjy-0005Pf-4x
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 14:45:14 +0000
Received: by mail-il1-x129.google.com with SMTP id y15so2012268ilj.11
 for <linux-nvme@lists.infradead.org>; Wed, 10 Feb 2021 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ysd4jTSM/A3Qbvo3IAamzntPbVEsPTPu5msfcyC0amY=;
 b=n/cl3sU4LxnsDfTlbLqkffWFtoeo/limIQtoBM8kz/2fWU2gL1fPfJ2kXfAXu+gcVa
 nhqwc2x/5b+bogrjP+YNHvnzG7LtQmY33VDtQ62/D9hiL2S5l/2QbIzpsE289QYd6INV
 nCKWcb+Gosn6FHz6FRn6UaGFwchiiA21g7C/I/Rk/3JMwzK3Fhid1vmH6BBZR5XNUD66
 mKBuFGIU1gH3EN9fT9WHhMQLyByOlJPpbX8FOwRPocPek2Odww3BhWLT08k9vvqR5dY3
 ibIT8pO4WLWI49PogeDRiDHb7DJoJlU8HLwX0Gkep21uFk+o/WsAEuuS+dVFarSG+vSz
 c8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ysd4jTSM/A3Qbvo3IAamzntPbVEsPTPu5msfcyC0amY=;
 b=HSTL60/9tdCbIJQAUB0PlTX1iI1/nJZsBDsm3tKfBU0DSXkvPsgMkRP6M5uWOnirLg
 4kPVv80XMEjOaQKZAZ7P5Ozrcarc/UlGG6ELd1Sti9VdABzBxHkbW+acdT8RWZJJ3A9p
 oaJJykjmc6edDZ/hXPBb3zNS9zlWhGD71EHg1d2tfKaXDg3CtLNV2Oyf6nknl3KeoZyo
 K1BdtIniTpLGJG3zBR8DeIQOnlbcNZcM+JMAmJDI3pcQBMVd/nsFROcD4R4r+SeiAKWD
 qWp5xPGFMScu14zsiy+XpmFfbXwho7pNkRmdd50MkAmYI/kLhEm89JQnY1J6Sb5FQl28
 STMw==
X-Gm-Message-State: AOAM532VNN30KG5qtHViylrj3Qoi91U9sdV/zhUFsClEgbU/VVH1Mxwn
 uyS4Tt1Nc6Q3YsnDnSsLq9qThxZX4BZoDgg7
X-Google-Smtp-Source: ABdhPJzLNMS1CqKK3WC8WmbvmcLOE3sfTRaTeeyEbcdTj69ndKl5ePzTxDZuwjdkwGqxqKGNIyEpJA==
X-Received: by 2002:a92:4b06:: with SMTP id m6mr1345567ilg.177.1612968312334; 
 Wed, 10 Feb 2021 06:45:12 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id h9sm1086368ili.43.2021.02.10.06.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Feb 2021 06:45:12 -0800 (PST)
Subject: Re: [PATCH v4 0/8] block: add zone write granularity limit
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cfe15751-e07e-101f-49d8-a2f184e30618@kernel.dk>
Date: Wed, 10 Feb 2021 07:45:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_094514_230706_3ECD640E 
X-CRM114-Status: GOOD (  19.70  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/27/21 9:47 PM, Damien Le Moal wrote:
> The first patch of this series adds missing documentation of the
> zone_append_max_bytes sysfs attribute.
> 
> The following 3 patches are cleanup and preparatory patches for the
> introduction of the zone write granularity limit. The goal of these
> patches is to have all code setting a device queue zoned model to use
> the helper function blk_queue_set_zoned(). The nvme driver, null_blk
> driver and the partition code are modified to do so.
> 
> The fourth patch in this series introduces the zone write granularity
> queue limit to indicate the alignment constraint for write operations
> into sequential zones of zoned block devices. This limit is always set
> by default to the device logical block size. The following patch
> documents this new limit.
> 
> The last 2 patches introduce the blk_queue_clear_zone_settings()
> function and modify the SCSI sd driver to clear the zone related queue
> limits and resources of a host-aware zoned disk that is changed to a
> regular disk due to the presence of partitions.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
