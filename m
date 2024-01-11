Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF0FC47077
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jey8sG5zd318dPkvpOvnDMBlpjCEu614NhJBUhHedyw=; b=ru5jica0A7CzWWvS+DPkC2xN6X
	Up8ZGqOsQ2GgQowm4F3x/Lj4gTM1S/z2GrWMkMWR3g1LVT9m8tAgomh0v+QVOpMfKP04RvwyqOhFJ
	Nwc6Oir+oUhcCI4V3v8N+VoLcyNHDN4eehiKAfto5+qlT0mthH7a7xPpgPjOaZKHvZtHNyWNR/JXq
	c844B18MzcdFxa/Ru1qP909XcrgxvfV9wa61eHRC/namUB9aaLJczUWgrEukHEUNexBA64vUuNJ+b
	RITUZwQ2rfbomV40RlzHxTYiI7aM5Zu6JTy+di8yR2Dm8AXYbgWMlFUy/g0mocZaFzlgCbS09I6U5
	zG60le6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNts8-00HZn9-0H;
	Thu, 11 Jan 2024 12:09:20 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNts5-00HZjv-0d
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 12:09:18 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-PihgD_1704974952;
Received: from 30.178.83.75(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-PihgD_1704974952)
          by smtp.aliyun-inc.com;
          Thu, 11 Jan 2024 20:09:13 +0800
Message-ID: <42a75437-a589-4534-b53f-19a8361c98c5@linux.alibaba.com>
Date: Thu, 11 Jan 2024 20:09:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: support reservation feature
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
 Bitao Hu <yaoma@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
 <a1f89413-cc09-4fa7-9918-86183d340454@grimberg.me>
 <d9cf6a40-e0bc-4b2c-b421-b313e1f57f10@linux.alibaba.com>
In-Reply-To: <d9cf6a40-e0bc-4b2c-b421-b313e1f57f10@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_040917_396752_7A542F6D 
X-CRM114-Status: UNSURE (   2.54  )
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

Sorry, my email server report that the linux-nvme@lists.infradead.org

which leads me to believe that the email was not sent.

Please ignore the repeated email.

Best regards,

Guixin Liu


