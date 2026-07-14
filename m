Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528DEC44501
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9toQdXyzLXloRYXjzkceTNVd5G3va6NI169jt75Ysz8=; b=Jz6sRAxKXC5ZH47Vv8C3HJL0PT
	8zUKcFgEMXf9YEj9DTU/eSuQmZhjpJvgG4qGgFn3F9+3KHQ1k2jBj4jPOjSnOz6b4shdTYoc2VBsU
	lanDbBVRb2lQJwj+JFWTSj9b7POUgPFOfxoDq6wV6NkO8gFCon/IyYooATbij6vDR2ULK7Xcl9WMW
	V1Jyq8s0L/ezDXR2ZtGMoPZvyCY9ZAymMz/L3TMu+q5ccoETqobgwv/iJmBWcnAmPZXhY1Ae75k0n
	oc6WhsNSi9GCIs8Zf/nA0SPh8zU5GSYK7wJu8kCkGiMUzpok/sEaVcPWB/Qr+ZpiwmQTgPxAWU/3K
	SukZF6qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjX9N-0000000B72r-2Flj;
	Tue, 14 Jul 2026 07:01:53 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjX9I-0000000B71W-41fI
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 07:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784012498; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=9toQdXyzLXloRYXjzkceTNVd5G3va6NI169jt75Ysz8=;
	b=GcH8b5AeYAXcuT64gVss/4QSHS05pHlsHwc+o/XPV6KlTD3jZXuk0Vs+F+rmT1IXuYR5XcrOA9+R53odPnYQL/1LzkDhYYvcy6LAJCx+uvhM6x//rG/cvDIR9MMP9Dynzw1Sl/kBzDQv4XVoc4UYaJXLsGWgFKYf/JDWrTIA5eE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X73IKvG_1784012497;
Received: from 30.178.83.149(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X73IKvG_1784012497 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 15:01:38 +0800
Message-ID: <24577326-4ed5-477a-9766-ec9cf16e6abf@linux.alibaba.com>
Date: Tue, 14 Jul 2026 15:01:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: Introduce service-time iopolicy
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 onathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org
References: <20260617114602.2224074-1-kanie@linux.alibaba.com>
In-Reply-To: <20260617114602.2224074-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_000149_683843_2FE2D5AA 
X-CRM114-Status: UNSURE (   8.07  )
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

Hi, gently ping, all comments are wellcome.

Best Regards,
Guixin Liu

在 2026/6/17 19:45, Guixin Liu 写道:
> Hi all,
>    I developed the service-time iopolicy in nvme native
> multipath, please review, all comments are wellcome.
>
> Guixin Liu (2):
>    nvme-multipath: add service-time I/O policy
>    docs: nvme-multipath: document service-time I/O policy
>
>   Documentation/admin-guide/nvme-multipath.rst |  31 +++-
>   drivers/nvme/host/multipath.c                | 165 ++++++++++++++++++-
>   drivers/nvme/host/nvme.h                     |   6 +
>   drivers/nvme/host/sysfs.c                    |   5 +-
>   4 files changed, 202 insertions(+), 5 deletions(-)
>


