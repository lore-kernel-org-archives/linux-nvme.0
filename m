Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD970CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 09:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1/+Q7v+XS9g7Cj132xK9Y4n26gvjwKtEsk1c/NTeYOs=; b=yeKdvMk0LaoyD9/rP1qhMG1aGi
	eSRHmNmQfHlduEvicAzFV1+t/6NPJIe3QXZ82lkbYFJfKA/+RaKsMTNE6pJbNGGkHEF1YLGSv7w/s
	cYm4dO5zpEX65g6Nmsye2Xr4CW0FTphuE8v96EgguiN7NMINyKoXdKltafmzvoPRKJfeSAASrRaWl
	eP3x6eUGfTxY86Qc4lJAp8+BrrGygTd8WYBW6M+SzKLNLHIl3mXsRssx6JLg+E6FwJ3Ox+ri26LX9
	ZePswhqrZ4hzXUDbm1Pb9TGpqcEzjxXbNNgToEOEF559JuvsZkkH8CGf5wouiUGH7SG8kk5baFYti
	qEs78Ryg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd2ut-0000000AzWH-2kMa;
	Fri, 26 Jun 2026 09:32:07 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd2up-0000000AzVc-3rln
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 09:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782466319; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1/+Q7v+XS9g7Cj132xK9Y4n26gvjwKtEsk1c/NTeYOs=;
	b=JvfoRYVey3SVBLKCuAbCfHNKQITErwRsqvWuXLa/ObiXv5Qe7BW3DBVd31xb7Y8jwyNK26XVwoap6Q0j2Am2S7mj8G+4hT+fI1SULLuNSEWaYrPssWWJMVOX0eEsOtAZNm8kwM8/rvaxtYvbi1TpCCagBCnl7jU8eR0sCKBWPic=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X5ePHAA_1782466317;
Received: from 30.178.82.81(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5ePHAA_1782466317 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Jun 2026 17:31:58 +0800
Message-ID: <36f89ba1-8c1f-41de-816e-605488a4a70d@linux.alibaba.com>
Date: Fri, 26 Jun 2026 17:31:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: replace sysfs_emit() with sprintf() in configfs
 show attrs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <20260622025915.1294806-1-kanie@linux.alibaba.com>
 <20260626070117.GB11368@lst.de> <2026062614-outthink-drool-fd81@gregkh>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <2026062614-outthink-drool-fd81@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_023204_634388_CA22D38A 
X-CRM114-Status: GOOD (  10.86  )
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



在 2026/6/26 15:53, Greg Kroah-Hartman 写道:
> On Fri, Jun 26, 2026 at 09:01:17AM +0200, Christoph Hellwig wrote:
>> Adding Greg to see if he agrees.
> Ick, no, sysfs_emit() should be just fine, and safe, for configfs to
> use, please don't do conversions away from it.
>
>> But if we add churn to change this, we should probably switch to
>> using seq_file for memory safety, and have some generic
>> configfs-level infrastruture for that.
> seq_file() would also be great, but really, sysfs_emit() should be all
> that you need to use here as you should only have one-value-per-file
> with no overflows possible anyway.
>
> thanks,
>
> greg k-h
Got it.

Best Regards,
Guixin Liu


