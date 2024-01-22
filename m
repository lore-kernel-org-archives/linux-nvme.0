Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9911EC47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=OCa4Fu0Z9rt1lNSMmh3+v83t8v
	RkmNgDkMCPVRun/2wyPNkCL92uIbtF8y+zcvlAMBL+0Qyzxxg6r0VRhFapND7aLPd8LplxQl6L1IR
	tqTDijmGm9nawK+EGCaxkf9s7l9nKGfTtO5mgOIphPhH53A9QBje1J8Qf2sfpH84tRdToWh6GNsje
	Fixcofd+tSb9JqbRsHQSK+SICl5U5WyHCkInOw8dWlyLZ8oZe6xopuQYAHS9TTwZvyP7oJFy2ARvH
	h1WwGXOJmYHZU7GeJEMqnS2Dzal8Wiey4UME3tzygWKNvRkWaVjL6MzK1/6snMjJzN3dXMRwWO+nv
	6+fU96KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRqOp-00BEz4-0n;
	Mon, 22 Jan 2024 09:15:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRqOn-00BEy3-2P
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 09:15:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=HEFseXPWpm0wTh2eISIee5wpaw
	oGpqqG0FIuFcO2/PDDKweUszv+G8h8hwB0Tl5f2wDgLVc9X9ChrlMPbEIl/BTqkARwVJjwLsXff07
	NPg8VayoAY11WnWrwx7WrBh8RgvUET6NJBwtvjSnuF/RPhSJnm1uGlc6UUwlNgf7NiuCk98J3AlLm
	ssblRMW5UwhLZK/5AvS54v9C59x9V1FAZolHGoaY/vu9KJiy3nz5M2PgfJpwNX1ldBM1Z+kJzLd2l
	NXFs55HWROt1F+JRrd6hunPq+C32QL9pW+C3BXiZ2/FBvIK8twPJmC9RbllIraHUl3muTIVc5i/v2
	985slaIw==;
Received: from bzq-219-42-90.isdn.bezeqint.net ([62.219.42.90] helo=[192.168.64.172])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRqOf-00000003CrT-0NJz;
	Mon, 22 Jan 2024 09:15:15 +0000
Message-ID: <8b9c7433-1f89-4496-a60a-93e2f587096d@grimberg.me>
Date: Mon, 22 Jan 2024 11:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: unify aer type enum
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240118125145.57983-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240118125145.57983-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

