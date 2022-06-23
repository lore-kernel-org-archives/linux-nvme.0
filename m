Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FB1C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=68nt+J0G/haWsaqcORubs5/O2GXyfdJNdDR4QR4VCKw=; b=0mIlvyK8qnruga78iTTazkejKw
	HiLWF0qimWk0nm7uXF/bMBQGMAXW4d5ZVCQ/RhJgnm1MtNRrgBi97vbeJVGmRX0nVLIZejbBDuW0R
	8u+w2i2XBBfYy0Aublb7BuePMqyxxcaNpCirzRh6d8/DW24jI+oSdXp2yrGZIPQpO/78lmi57vdvs
	R4bYGg0Fu+5HnDHMoipmrX79ZyGp5Evcu+TnRm22yddx8MnsKZE8DUU5RBHBTAQOUiuMrO6LeDaqO
	gfyAN8mN6gXO4SKYJrY4oNsYYZOnu5/BGgr+zliY+cXJA0rPGpbR4J+tJ6ismYZAppJ8TR2Ye0xhT
	uaRLjMpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Mbz-00FHKK-97; Thu, 23 Jun 2022 13:11:07 +0000
Received: from mail-pl1-f178.google.com ([209.85.214.178])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Mbu-00FHIl-4P
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 13:11:06 +0000
Received: by mail-pl1-f178.google.com with SMTP id d5so18104619plo.12
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jun 2022 06:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=68nt+J0G/haWsaqcORubs5/O2GXyfdJNdDR4QR4VCKw=;
        b=YhXIEx4D0ItwCrwgcfWZ6ssdQz1fSNKObnbUqIEm4ZS17tZCsbLTMH3TIPoU3Dau3B
         IXyztxGfAoBOLvVQUbCQ05yZzSPoVC58vWX3T4ahMigys8PUqc87nUtUIbXp7ybmKfXv
         TKDTjyfvkhbVheaJIQbjYT7s6vSxQh6tFBCUGVrAA63BiP7rdjduVq/YEpnB12OnQ3sl
         vWh4kB3cCYV9a8yqFjMQpvfQ0ulHsUiTMx/oXcuM2Dc+GdfJQrSq2hfWpObT6VMXHvbE
         NNW14PxyEcvsRNiELVivQyrBsqUzzm9vLmv0+32C9EpWPtCgq0iaof4K1/opAqO+Pu7p
         sLBA==
X-Gm-Message-State: AJIora9VzuNMWA9r7Wy23llO0TxiOF+jquYpPjr1UQpVezgter+tyrY1
	gj2AKCtqUX9Yj2APw2SfZsk=
X-Google-Smtp-Source: AGRyM1ug8aOaBKwK2eQ4pDHsrijU8aBX0RbI1irUvRXGrh/3bVzmBklJ17kBxFIfIHeCUSDk8qqjYg==
X-Received: by 2002:a17:90b:4c8a:b0:1e3:60f:58c3 with SMTP id my10-20020a17090b4c8a00b001e3060f58c3mr4043995pjb.230.1655989860307;
        Thu, 23 Jun 2022 06:11:00 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id jf12-20020a170903268c00b0016a0ac06424sm11978240plb.51.2022.06.23.06.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:10:59 -0700 (PDT)
Message-ID: <3a2a2d1a-ab52-687d-d521-4a05d7047701@acm.org>
Date: Thu, 23 Jun 2022 06:10:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/6] blk-mq: Drop local variable for reserved tag
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, nbd@other.debian.org
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
 <1655810143-67784-7-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655810143-67784-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_061102_216347_D4ECA99B 
X-CRM114-Status: UNSURE (   6.89  )
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

On 6/21/22 04:15, John Garry wrote:
> The local variable is now only referenced once so drop it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


