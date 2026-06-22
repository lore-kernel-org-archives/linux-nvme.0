Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466AACDB46F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wc1ooNmWy9UqX6nga+3XzpQ9Cs0KiDVRTjAXBzhu0Xs=; b=1ciu0kpIUZcE+0HttRRXzZ4N42
	4NS2oJzKYJuTqvb+OVbsvJWcxoVzG0KvZKj51rGB/L75eqC2zVemh1YUxBwBT4RN2Lxxqozgh2z63
	+FPXOF6HuLxT6uRMi3DuWH9zp3uDT8nuAcue2ahiejWotCF+0v9qI6y5cMQV3JAF4H1dRpFzgPmcK
	S8ZXqE8ImkjPTXbn4Zgp3yGbF1F+LhOFsdGIenXt1GfBg3eqKvTzdhhbLROsdT6MdMUsjbwo8cXkz
	AFeqAfVHVfyvZy0+2LDcGfFN9LmWD3TadxhMfqzmOd5wzT3F93Dqir4vEwQEgUZPsmHSHe0eM/3pY
	yVIA8nFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbadQ-00000004io3-1Hg3;
	Mon, 22 Jun 2026 09:08:04 +0000
Received: from out199-17.us.a.mail.aliyun.com ([47.90.199.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbadM-00000004imu-3Asf
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 09:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782119274; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wc1ooNmWy9UqX6nga+3XzpQ9Cs0KiDVRTjAXBzhu0Xs=;
	b=E5hJO8Ge38zzI1QQkkosGWS8hZi4BE6AeTmqR6YDUbjtl9i1IqXFYkZkR+fjm9AOJ48gTH4Zx6R2evDpxvwyTElRyyxqhQz/CbYnBWSV07TxxM+6y0vZb+WxZBIFneap9h2Re+ucyHhOclyKBPo3PnF5aod4oEPakn1d7uYCOkE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5Ko3rp_1782119272;
Received: from 30.178.82.96(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5Ko3rp_1782119272 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 17:07:53 +0800
Message-ID: <890db845-1905-477f-8f49-444d9ff6d567@linux.alibaba.com>
Date: Mon, 22 Jun 2026 17:07:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: expose path_state via sysfs
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20260617121543.2291455-1-kanie@linux.alibaba.com>
 <498d2a2f-8545-470e-b42a-dd47e26a948a@flourine.local>
 <f4488a80-2e8c-4782-af48-40e5806929d9@linux.alibaba.com>
 <4b1f2cbe-2d94-42be-8a5c-4d1263df5659@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <4b1f2cbe-2d94-42be-8a5c-4d1263df5659@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_020801_424600_9BA63465 
X-CRM114-Status: UNSURE (   7.17  )
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



在 2026/6/22 15:50, Daniel Wagner 写道:
> Ah, I thought this info is already in the sysfs but it's just the ns
> head one. Though I think it would be better to expose the complete state
> not the filtered one via nvme_path_is_disabled().
Yes, Nilay suggested that we can expose the disable reason too.

I will change this in v2.

Best Regards,
Guixin Liu


