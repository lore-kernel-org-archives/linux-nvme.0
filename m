Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F20D3B7DD
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 06:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cwRv2l2eT7JBVQOD4jOYLq0zhI8s2MnBUWNYWIHL1TU=; b=wpazSlXoydGT+q2o8xpaEVC/j8
	4ZuPs5mtQnD3a0daCjy6y+TflLStwUUwBR0V84w+FiWwaj59LbEOAaLP9aM/YOy0g3H/CnpMJhYO/
	9MliXUVYO1UTWhCX1jAB2UcRVN65408W2CbBq/sW7eQ5IzRVVId5s2hsFITfk7PlZBygVfxGBNYQW
	9QUMmT0HVJMK7qTVz9YU2PYifg7CtNdMOnU9CH9t9lSguiBJ+hiXfaShKyaoFurySqCIxNb0KxzRs
	kN8Vox882pb+d3/fp5kMPbJ2nfKUjdGEcPYpC8Li9Hqrko8WyQkBfCs79kro1ubtY6aEj/3VrSUdh
	Fgntst3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSyj-00000007CFm-1RLf;
	Mon, 25 Nov 2024 06:53:49 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSyf-00000007CFI-36Z3
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 06:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732517621; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cwRv2l2eT7JBVQOD4jOYLq0zhI8s2MnBUWNYWIHL1TU=;
	b=n2DHVaHrOGE6kcpsYPY+LOVV/g2TXLldSPxb8hXoj482iVnGHAygbf/XPe56tkk2ULqmo3D3H/sMIj9avPsPq1+AdUFSuEPM2A4pOPRq9EvkkS+MFjh5Qev2gn90SDPvZtiEqyuNvUzxHte4kkxSIja22UExPYwoisvVPEJUEys=
Received: from 30.178.81.212(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WK76otO_1732517617 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Nov 2024 14:53:39 +0800
Message-ID: <a336007f-88c1-41e3-826b-e080a4d78213@linux.alibaba.com>
Date: Mon, 25 Nov 2024 14:53:37 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet: handle rw's limited retry flag
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241121102454.122247-1-kanie@linux.alibaba.com>
 <20241122120959.GA25831@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241122120959.GA25831@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_225346_090696_D272CF5E 
X-CRM114-Status: GOOD (  10.39  )
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


在 2024/11/22 20:09, Christoph Hellwig 写道:
> On Thu, Nov 21, 2024 at 06:24:54PM +0800, Guixin Liu wrote:
>> When the nvme target receive an rw command with limited retry flag,
>> handle it in block backend by setting the REQ_FAILFAST_DEV flag to
>> bio.
> Do you have a use case where this makes a difference?
>
> The code itself looks fine, but I doubt it's actually useful.

In our scenario, our multipath setup places the REQ_FAILFAST_DEV flag on 
I/O to prevent

retries and immediately switch to other paths for issuing I/O commands. 
This will reflect

on the NVMe read and write commands with the limited retry flag. 
However, the current

NVMe target side does not handle the limited retry flag, and the 
target's underlying

driver still retries the I/O. I believe this will result in the I/O not 
being quickly

switched to other paths, ultimately leading to increased I/O latency.

Best Regards,

Guixin Liu


