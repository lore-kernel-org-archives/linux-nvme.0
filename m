Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2CACE7AE0
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=0IzMd7U/gFIvbgav+f6CR3b3L+
	VaeSQ0zX31dSE07AnShSSMyAzeAlnTC7zInt3HgRUv4yDi5088/JEnsVzqsptc3FYh54SSeGEAdjw
	YU6p24nvDuQG7NrX9o6eDWyCnyWb/4dF5y/kRTiZVkQ4ak8Wl38qDh3WNmPSSPvE6YBByupB4JEAp
	aFU3bSgf/+X+wkZ+E5C7PLHY8TtheYABnN0BPfopBuxa5jjZKdb3gJy5RCN/TxSK6fs/1KP00EXfb
	HlZDYJFb75AYkG0KFGullAJoVNi8/qWxHdm7/+Wb5ii////o/wM8q2x1sjj9js1OpTPxsHNLEz0TX
	wImPAnCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smToJ-0000000BCK0-33g6;
	Fri, 06 Sep 2024 07:55:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smToG-0000000BCIj-3rCD
	for linux-nvme@bombadil.infradead.org;
	Fri, 06 Sep 2024 07:55:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=D4EsJoI3k38j+6r2N7C9Uqarr0
	E9UhvLFYXVAqWb0JxLAGOrKAGls1Lh9GyHZkpeJByWDpgwYlUqcxtogZP2/MMBOBvLsuSWJFxNuho
	YHgRkGSGA8rHbX7IpX2ENxwjyROG1Gwa7YDnrdqrifX4ZiZyPoe3BHmm8SDRRwcWelu57+jOFLHl8
	lzCNYezRvhoEzNxV+GBRdjcfMm9YEInyJ8KQBmIGOkBSnKgzMOnE2U4BjyN9g5Ky97j+/p39yc2zk
	iVo4D8CNlHVPdZ3M4cYPzmmLDQSUVhrhorZAIyZXJ/fJzpKbaLHJ4m0l78CvmfEtGSz5XIzkcdxWi
	dNK6FxOw==;
Received: from 89-138-71-253.bb.netvision.net.il ([89.138.71.253] helo=[10.100.102.74])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smToB-00000003b5J-2wnl;
	Fri, 06 Sep 2024 07:55:09 +0000
Message-ID: <e39bc8fc-3e20-4e3f-b906-1c63953ab76b@grimberg.me>
Date: Fri, 6 Sep 2024 10:55:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] nvme: Convert comma to semicolon
To: Shen Lichuan <shenlichuan@vivo.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240906065815.40300-1-shenlichuan@vivo.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906065815.40300-1-shenlichuan@vivo.com>
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

