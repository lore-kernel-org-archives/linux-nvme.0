Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18329C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1CdPsYcJMiRyRao0OFv69oSt2+3EiKlT7x2/BM9HIJY=; b=yysRju8qQrDIzaAjv+OqfhQlIk
	vP0fYFaPziekQCdK0Rd21q/VMvtmS98Yz4M+zigrVOIQGndJ1RzH1xCFEVtjwxD6c9e7XbL8epz/F
	xnI+X2l+gdw6TUZDcePw3YZpuxGCDR3MFmVgUQrknuhCtN6gGDxgPk54I2YFN5PESe6UNK3Q+ToIF
	mytLL4CdLIW/mBc5X/SjDiyTqpEK3Muw5Bkqzy9mwuuvHWtCC+WtVlC/T4W+GhUYD4lBHxriCiZ6T
	dv+FLIOw7sOogB68K+7QeubVQ2g5KrnlZHV8iibTvIogGAFmMrGMXcGsjVsH7/q+BCS49VPQ/k/5e
	VXL474DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2ErH-008Ew6-HX; Fri, 17 Jun 2022 16:30:07 +0000
Received: from mail-pl1-f170.google.com ([209.85.214.170])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2ErE-008Ets-EL
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 16:30:05 +0000
Received: by mail-pl1-f170.google.com with SMTP id d5so4286657plo.12
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 09:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1CdPsYcJMiRyRao0OFv69oSt2+3EiKlT7x2/BM9HIJY=;
        b=lZCv+umWAboQvs8Xwe4gs5icstu7S6VLjmFcKtDd2yn7nYnt5Ki9BDAfJsEhD/CXYv
         JH2bjTcy8BIZ/fAxYhnReYb7E1haBuQt0XU4Argiz0xYjWfheTi3oZOXCKCr4NuhkCaB
         xj8VW5lXFjod0SIV78dIyBO6Toy2IA/+IjxHaioV06zv/E6UK9x+W7N8B3c5eatmGy9/
         XxBGIuVGd1YkRWmxnTA3gZTx8krF3Nm+4xI3tHPKoeAHPIqYbZPz1s9bBlswxvH1xHlr
         LiQKFfax7QvcgXB2lYsZcbN5Vt0l3mkr5ml06VSk9G3GFTVM3Tbtor9QxjjlqBx8EvoO
         ZvUA==
X-Gm-Message-State: AJIora/o/w9G91I9F/U/QnIzrFqbRQOe1Qnmd9xSLD0T4YWC2As20c5q
	K4JuK7pdfWjV3uVqUyRwiGY=
X-Google-Smtp-Source: AGRyM1t/wDXMzo+bOEkKIQH/k9xjz21/990h5UWigbcfj8KAhJoJx1iRoTgXlJGSllOagISeEk0Fkg==
X-Received: by 2002:a17:90a:6444:b0:1ea:b662:c12e with SMTP id y4-20020a17090a644400b001eab662c12emr11580102pjm.199.1655483397636;
        Fri, 17 Jun 2022 09:29:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b0015e8d4eb25bsm3756460plb.165.2022.06.17.09.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:29:56 -0700 (PDT)
Message-ID: <336492df-d74d-9eb9-4b51-d6d1f915493a@acm.org>
Date: Fri, 17 Jun 2022 09:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/5] scsi: fnic: Drop reserved request handling
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-5-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655463320-241202-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_093004_533171_12EB6534 
X-CRM114-Status: UNSURE (   7.04  )
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

On 6/17/22 03:55, John Garry wrote:
> The SCSI core code does not support reserved requests, so drop the
> handling in fnic_pending_aborts_iter().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

