Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7259D41C32
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=69KhaJaJyrxxixUELpSq2zj7Kablj3JfKRM24rHHs6I=; b=BY/lVG3AO0qCfNttwANCUAqOSC
	HI5xD3bHYoy3bXUN1im2XLE3Tr3/9n8cxn71IdDJtgmGwMyHnCvt6lc41/TQonLBkArujDXcsudu1
	s1brgnkGvHMjfvi6NouUg/wxD4iBW/khXiRopzCDKvEdff+PftUAUCblH6UesQDA4TVp3qxRIszzY
	vgXkezlgMEdhnJkSuHPckFBrZ0bSQ5WGtu6tucOZtiXjR8Yc/Ff9XMv2+37so9IN9+4JLMFSa3wHP
	tVS8JamTF/1mH9dbpBIXb/tSIVERzEyjCwfJrVJHeT2rqpciGIJnUHQ/4haKKsjbi+a1dbY+BP54a
	ntIYOuwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBAf5-00000006S4y-020j;
	Wed, 13 Nov 2024 10:31:47 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBAVp-00000006QXE-1ZVB
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 10:22:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731493329; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=69KhaJaJyrxxixUELpSq2zj7Kablj3JfKRM24rHHs6I=;
	b=n51n4cOAZu/RzHIxGmWj8BPp20u34GajuPHQqUHU+SfYAP5yuihzpIyPm0765fIJOQTSkY4QB0AwDi6SwVl44bJj1gp1G7UOwMgNJ9Wl3oOm3hHisFbUWbhhi1AlvXBboKmYPkVMiYmUp01Y8KlgmU2HbaiMLgeiu3DRxJmZhmY=
Received: from 30.178.82.28(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJKli33_1731493325 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 18:22:06 +0800
Message-ID: <fc116473-340a-48e2-8bfa-79cd5e318e73@linux.alibaba.com>
Date: Wed, 13 Nov 2024 18:22:05 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v3 0/2] Introduce service-time multipath policy and
 document
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20241108085449.49972-1-kanie@linux.alibaba.com>
In-Reply-To: <20241108085449.49972-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_022213_851038_A5E80D9E 
X-CRM114-Status: GOOD (  10.91  )
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

Hi Christoph,

     Could you please take a look on this patchset?

Best Regards,

Guixin Liu

在 2024/11/8 16:54, Guixin Liu 写道:
> Hi,
>    This patchset introduce a new multipath policy, service-time, and also
> add a new document to introduce nvme-multipath and all policies supported.
>
> Changes from v2 to v3:
> - Add more detail to message body(Christoph).
> - Add a document to introduce nvme-multipath and all policies supported.
>
> Changes from v1 to v2:
> - Use atomic64_t to replace atomic_t (Keith).
>
> Guixin Liu (2):
>    nvme-multipath: introduce service-time iopolicy
>    docs, nvme: add a nvme-multipath document
>
>   Documentation/nvme/nvme-multipath.rst | 83 +++++++++++++++++++++++++++
>   drivers/nvme/host/multipath.c         | 53 ++++++++++++++++-
>   drivers/nvme/host/nvme.h              |  3 +
>   3 files changed, 138 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/nvme/nvme-multipath.rst
>

