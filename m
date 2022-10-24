Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6ABECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KpthEP7YXPpISJ6CGPHYOqUT6IOWvKcBQOAkgoQ0ELw=; b=ypzE3IZQ9nh1OeGlYHyVIm4JYo
	mV2ukO3h9GHX15oY/m8iw5HugNh06sYFo/ywph4uFP6FEON/JJiwbngvrrzk/RWUIdg1SV2RhtA5z
	G0jw80Y02z1F8wkmvv4ljzYsOhWyb2zt6NSkGLKDdyu05H9KUNU6tPuKuuRCz68PMD99KTFa9V4vQ
	hIRIaKt5lMHu1UG9kqz+rxOs8Mrf/qHQSFtCGc2Y239TPKh3PYRSwucRttcCa2f6d/MPNEabUhC/d
	pV0lj8Fh3ClWODptzbdX/vxKGrTQRXDQ19WHpI+Fy39SbMgaoHiTBhs/6ut0PGmRn9j7SgWmUJbXL
	hx2q02aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on2ir-002joQ-K8; Mon, 24 Oct 2022 19:02:53 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on2in-002jnx-Vy
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 19:02:51 +0000
Received: by mail-pl1-f172.google.com with SMTP id y4so9260217plb.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 12:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpthEP7YXPpISJ6CGPHYOqUT6IOWvKcBQOAkgoQ0ELw=;
        b=ZLQbABagiGCVm/ULU8q0/st0RAHDmqkWBvRIemx92ypLN9qRoWCRq3KG3uVeOw6/mQ
         FVOGjpJvF5FXHlFl08tRMO34r8TB0Bt6byx8m5KnKeVJkN9oSfGDR7QIu1kcXSbn3us/
         Sm3BiJ0bNQ5f9cCUC7pTqOMJXWcvKbyrHY3+rc/0h8g0zqC0K53mhCh15mxpXFOlm/vY
         Zf1q+TV0oaSW5mGshtEEVxXyWPd618W6qgEfhRL7cACiH6+KPYdoTM+FNKcwnFQ1quh0
         NRn588pyCxoC0T4/HZTm9JA8buvwQDPbBTnLqtVtXi8I2tl+GrnEGvWedAGVexrJU/BL
         hk1w==
X-Gm-Message-State: ACrzQf0+Us3IwHvBjs4r0SoQUJuxYKUdqRBn8r6sPL/axQlWJFs4eZ9g
	CAsyED1hUD3xjoQP7ru25es=
X-Google-Smtp-Source: AMsMyM41hqd/uZatx/NIZkdddex4IQIsPyvThfppQJMTcjKSxixD9lMXD6LAtqRvj3T+q4RUKykUsQ==
X-Received: by 2002:a17:903:18b:b0:185:43e6:20df with SMTP id z11-20020a170903018b00b0018543e620dfmr34041445plg.4.1666638167863;
        Mon, 24 Oct 2022 12:02:47 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i27-20020a056a00005b00b0056203db46ffsm135961pfk.172.2022.10.24.12.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:02:47 -0700 (PDT)
Message-ID: <dc89c70e-4931-baaf-c450-6801c200c1d7@acm.org>
Date: Mon, 24 Oct 2022 12:02:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>,
 hch@lst.de, Keith Busch <kbusch@kernel.org>
Cc: jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
 snitzer@kernel.org, damien.lemoal@opensource.wdc.com,
 linux-kernel@vger.kernel.org, hare@suse.de, matias.bjorling@wdc.com,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, pankydev8@gmail.com, dm-devel@redhat.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
 <90b6d45e-61a5-3eb3-7525-8467f1a67587@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <90b6d45e-61a5-3eb3-7525-8467f1a67587@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_120250_052833_A640F35D 
X-CRM114-Status: GOOD (  11.21  )
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

On 9/30/22 14:24, Jens Axboe wrote:
> Noted. I'll find some time to review this as well separately, once we're
> on the other side of the merge window.

Hi Jens,

Now that we are on the other side of the merge window: do you perhaps 
want Pankaj to repost this patch series? From what I have heard in 
several fora (JEDEC, SNIA) all flash storage vendors except one (WDC) 
are in favor of a contiguous LBA space and hence are in favor of 
supporting zone sizes that are not a power of two.

As you may know in JEDEC we are working on standardizing zoned storage 
for UFS devices. We (JEDEC JC-64.1 committee members) would like to know 
whether or not we should require that the UFS zone size should be a 
power of two.

Thank you,

Bart.



