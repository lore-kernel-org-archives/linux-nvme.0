Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E2AC531D0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 04:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=telPF/K231yOgK4Ds01HfIEX4ipY8gEfCSFKQRS+6Y0=; b=E15pwGcggeQNJdbNdUyFzoHRQg
	+OhofC2CKjVBaR0JnOQ13SOkhxd5oe/hQD81PpxQCAh3su2/A47NGylIxwJ9lBV9SsF+VxtH8/dQ9
	NO5s07nbcFKBDqREGoqIHKKGHqS/cS3UHCCWImFHbTqyV7oa+Ngo3cawwaW9w6tQiTp4VjgR6w8mw
	dq9KonVvmtbQXiY/ZNjS6J8LPjrLyTk3E8qejiej0MGnw4iszwmsVH4iaFHQLv9fpSjPlw/VT4CCk
	puyB3Z3Ns/w3v+i2i1KtFwYX0EwtThmWxV4CSNmW5dV7rUXdL9Y87+SJjzDYe/KwxlBwOnJ2RjHN6
	gXrYrd6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpIW3-00000009UTJ-3K4i;
	Thu, 30 Jul 2026 04:37:07 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpIVy-00000009USC-3gQe
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 04:37:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785386219; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=telPF/K231yOgK4Ds01HfIEX4ipY8gEfCSFKQRS+6Y0=;
	b=kige9dszRHaSmXgJaLrLEvFOANWHSeonH2pzrOGze6kuS/zPKiB4kixP5jNmXJr6/7v5uQkuBlvTUW5TvkInEI4HumkYCx7xeJDtYNSHYAdQi14HIy5tupQ0F0W453kq6qD1SEGX1OwTzI6HGhs8BTuro/M+n//uEt3saG7dzpc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X83qVeT_1785386217;
Received: from 30.178.85.5(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X83qVeT_1785386217 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 12:36:58 +0800
Message-ID: <74efbc5e-6fb0-40f0-ab9a-95d4eda7a0e9@linux.alibaba.com>
Date: Thu, 30 Jul 2026 12:36:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvmet: fix Reservation Register Replace for
 unregistered host with IEKEY
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, mlombard@arkamax.eu
References: <178521959386.52051.17173420094473200063@linux.alibaba.com>
 <178527555910.84385.14037905470970123793@linux.alibaba.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <178527555910.84385.14037905470970123793@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_213703_111826_276795D2 
X-CRM114-Status: UNSURE (   2.11  )
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

LGTM.

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

