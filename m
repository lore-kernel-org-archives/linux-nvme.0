Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B421C982CC
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 02:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mDSCRtbRBZ9SAfXUv7nOs0Qws2x1gfCPS/gYeWzF24A=; b=fFhQ7tPTZ9MSD9KBiNJEnRsVo2
	byWJOt+z5SnHY7k1Obljja5TyNEqBvS6QuXZZaPJfFzMPwr5pmbL2pzcczLbzbnoZXKTusLH1w8Tq
	eKIoT81qBKSKUQ5KAgMjugENfA5ffsTjTL0v1KSi9e30jtv8PbQbUauY6+a6RYgbhAejHYjonBHIf
	Ognu9jI0JESE/CLVpCtJ0gePH40Ft30+X9qrxaebi1/L8XIHAI3TcJ2nd+PAKg2SwpALx+7d4zrsi
	xBQi7djGL3TrG1vvcthjMXJk2h4lu5C/jv94n31dKcFcSGZXK6GjBTv9aAnMjk70SYr/FwewTe2+c
	EqQGPplQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x86xa-0000000Gki9-0UJK;
	Sun, 20 Sep 2026 02:07:18 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x86xW-0000000Gkhm-47VL
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 02:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789870032; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mDSCRtbRBZ9SAfXUv7nOs0Qws2x1gfCPS/gYeWzF24A=;
	b=NJjNffw0XHSkcsidReZWCudvy99wJeBzPd051n5KxV85ilWHSmyEHAR5W7hGG4YrcDgbPv8Y9BQu8jBLDToVRxxLC0CI0pKHx7/MFpg+mqz4i+LgpO+wxDr/ve8NfxRKLFQdkvfbEly0uEXFlGVWCHYYlYRSgQaR5DCT2RQfrIc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XBEe8F6_1789870030;
Received: from 30.178.84.196(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBEe8F6_1789870030 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 10:07:11 +0800
Message-ID: <1c0f7d1d-ec4f-4d41-b78c-7a7e0cc4628f@linux.alibaba.com>
Date: Sun, 20 Sep 2026 10:07:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] nvme-multipath: expose path_state via sysfs
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, John Garry <john.g.garry@oracle.com>,
 linux-nvme@lists.infradead.org
References: <20260724090004.1146014-1-kanie@linux.alibaba.com>
 <097fa1af-41eb-461b-873e-b5f27e1ae872@linux.alibaba.com>
 <20260918132555.GA17993@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260918132555.GA17993@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_190715_577850_2BE18FF8 
X-CRM114-Status: UNSURE (   5.89  )
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



在 2026/9/18 21:25, Christoph Hellwig 写道:
> On Mon, Sep 07, 2026 at 10:15:24AM +0800, Guixin Liu wrote:
>> Hi, any comments here?
> Looks good to me.  I'd probably merge both patches into one, though.
OK, I will merge them into one patch in v5, thanks.

Best Regards,
Guixin Liu


