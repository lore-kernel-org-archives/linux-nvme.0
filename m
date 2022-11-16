Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F4C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 06:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pYjVNB9yjyvuv1I4g/r6BI3C89XQUAs9yP8HbIWGcdo=; b=hNl3jO91hiT1Ec79rYf8PRd/sI
	g6umoSIvW66IOEVM2KOF8pcp6IhHFtSSGyQ0J88t2zTVm+1zZu8xd4/DuG6OoNv2J6wWwfhYc6RIy
	yh9k5XG+0fKRjjeuVwA0I7Iqn0X0hWVsRZ/im/kKELc2BM6uVc2k4RVXfzvd4cReYnMkqYcBMm36A
	RhsIo9XwhoM5C87AwjwVl5jdFBw+j6jLXuE6aZT8TGxF/SOOfnFgjRUZ71woaeMwOJ3ocjWSYIKEZ
	/Qqgs+SEQ7FfvkX5Cgu42Uc2t96KErzuxVk+MuQXFTSe3zIjMesADOAePB7eHm4sTOfUIqApHjy79
	MAQ/1qlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovBnq-000EdV-OM; Wed, 16 Nov 2022 06:21:42 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovBnm-000EcN-6s; Wed, 16 Nov 2022 06:21:38 +0000
Date: Tue, 15 Nov 2022 22:21:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tiago Dias Ferreira <tiagodfer@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@infradead.org
Subject: Re: [PATCH] Add quirk for Netac NV7000 NVMe SSD.
Message-ID: <Y3SBchKqF1xwrVcI@infradead.org>
References: <20221116031756.4987-1-tiagodfer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116031756.4987-1-tiagodfer@gmail.com>
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

I've fixed up the subject and copy and pasted a commit log from the
last NID quirk and applied the result.

Thanks a lot Tiago!

