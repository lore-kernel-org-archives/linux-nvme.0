Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58111C54791
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 03:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5ovShcTBKHX2BVU6KMLazqD/3y5PNtydNZFt92WEu0=; b=kW3IqZx/vrSbwpTg5tGhp8JFMg
	u8k9rKx+AbXbKPIrix9JEBMkmjFNvf12Tj88jJQOs3spXpXnXi+821NrFbFaE9ScPttIhp/Qnqvv+
	eWRBBmR7JRqQYWdrpHAdteYmBxo+57wdivz1u1PqzL/uMzLgVlhfl1I4/yPsCqfceFbkXBRHB9j2J
	5ybD/utHm6ko/n2YylTAAGNCmYDgkKNKuaaiGn0vOQRlbfz4UtA8wlzY96PM7ALjmZWT4OPmLXOMY
	MKyZ0yIecHPQrT9K8AZq/eIbzELqOrRjzWGyzM40p4EwfGMDstYG5TEEJsNqgH/DSEofO5NdJ9s0g
	uUTNjBhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkFep-00000008hHX-1LaQ;
	Wed, 13 Mar 2024 03:51:59 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkFem-00000008hGQ-105U
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 03:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710301913; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=H5ovShcTBKHX2BVU6KMLazqD/3y5PNtydNZFt92WEu0=;
	b=T/r5I02+zKe8QUo2d+17M1WT7e9XUbJkaC80h7sheA9rjTgXRBlBLv3JBzmQzIcVHK5zwqbgsl49zYUKRXxAEndmBk4MQLp3qULQEq/3eOledx/x3XpXObDuCbteF/pfs6F80gmWNZ/lNZlEMdbjjej0OG/L2dJqHWiS6VbFs+I=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2Nn4YJ_1710301910;
Received: from 30.178.91.12(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2Nn4YJ_1710301910)
          by smtp.aliyun-inc.com;
          Wed, 13 Mar 2024 11:51:51 +0800
Message-ID: <559d9283-449c-4135-b4ca-168417e56ee1@linux.alibaba.com>
Date: Wed, 13 Mar 2024 11:51:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] *** nvme: add some commands tracing ***
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20240131091222.116190-1-kanie@linux.alibaba.com>
In-Reply-To: <20240131091222.116190-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_205156_839029_D1073484 
X-CRM114-Status: GOOD (  10.30  )
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

Hi Keith,

This series of patches has not been combined yet, could you please

take a look?

Best regards,

Guixin Liu

在 2024/1/31 17:12, Guixin Liu 写道:
> Hi guys:
>      I found that there are no reservation commands tracing and some
> commands's parsing aren't fit the newest NVMe spec, and aren't readble.
>
> Changes from v1 to v2:
> - Remove idr and idw parsing of dsm command.
>
> - Remove lbafl and lbafu variables and add a comment for the lbaf
> calculation in nvme_trace_admin_format_nvm().
>
> Guixin Liu (3):
>    nvme: add tracing of reservation commands
>    nvme: parse dsm command's attr deallocate when tracing
>    nvme: parse format command's lbafu when tracing
>
>   drivers/nvme/host/trace.c | 73 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 69 insertions(+), 4 deletions(-)
>

