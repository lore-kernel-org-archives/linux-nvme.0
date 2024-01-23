Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF51C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 05:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YJ9gvy3/N6453ZRty/9vAjQiPIZ1t9CIQ3qUo2PIBdQ=; b=MpeG0c7i1JDumlrd2wj8+QnpmK
	CkudNQsFsr/TdBaqYC0LVViL9auZUvXDz5IdwxPj0ysfYEUXhX4Lt/AV92kVCwrBL7P9hhVC4L/Aj
	c2os+6xvrSMEwOd/woon2XVqx3lN9rPqtpapFgh01O7a9ygCmvuDjDhsgi/zwHbMa3Q8ZoURHIqiS
	h1Z341KNN9VIguFD4lx1Zx9ETwVySmCGQTcOaTJkbqjzBhTOsP6jT5wwBR6qX0ZFov7UD52cROe8J
	N16QYGjFCvsYi8EQLYYVAXFf8vkMah41AHyyKMa/EgO09DvPaw3nbIcqkLUYaOR1Y/oYRff1v3tG8
	/kDsNHdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9En-00F8U4-2D;
	Tue, 23 Jan 2024 05:22:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS9Ek-00F8Se-0r
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 05:22:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F0172CE2865;
	Tue, 23 Jan 2024 05:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4967C433C7;
	Tue, 23 Jan 2024 05:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987328;
	bh=sUwtSxOaabAe1k5Flqo7FosuUxAAdIvjaNGZ0lwzaKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tI5bJoOJJNt+2Dme93P03LHvWU8iigbJCqLjfXNMfB/aRPWmiRqiwBWPste+NFugK
	 AwTy6sV2UXkqxnQDIXCiR8AN9swEee8RqyCTfUd/1Aq3SoVncdBokYFiFpetsA059h
	 pjdBGkIDsLUqyoBuLNtKFh/rBUqzgI59IlJE76BvELpr0GvL7B0ZgTuEOSSsTSk2DR
	 AJ4+5WvdQgd6KZe5Rp5SQ0AlXsA18YM3vPnqJKcnhsnZ1GCTKD+vbsWa+n7zuYzZy/
	 mH+F2ULAy4vlY/JE6b87sFrWAK4wWGAN4MR9lrDMFEjW8p9NisEUmQsDNPIX6oC04T
	 BcSy5Jl4UFLvw==
Message-ID: <ba58f732-e36d-4109-9938-1926371aa19e@kernel.org>
Date: Tue, 23 Jan 2024 14:22:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] block: pass a queue_limits argument to
 blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-11-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_212214_503069_ED2E1F81 
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

On 1/23/24 02:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_mq_alloc_disk and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


