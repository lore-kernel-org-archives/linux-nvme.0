Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD85EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 07:21:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9747E60F9B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 07:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9747E60F9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=RdhST9blZg/ReHA2mTPrt1F19U
	xOqRwlrhZTNWXtjBQ3sDoDRTG3kkq5Dfe7Yma9BaJ1q3wu3f8DJsXyBKsZ7wBxdDvsKVxD8M2v3kp
	znjxakbGMyi7PqW5ieLCIypMzmFLeO0liN9hlZ63k/nc9bfMiPb9OTnYViG6pHCylJ9zx7FqR7DZ9
	RgFAuG3nCmU+P9/FKRY5of0hHJJ9I9IyF8Cqz5WCQ+xAwy1XXPBZLw55WiS93/jnsv+orTWrdscTd
	mUKwzzOaV/LEtbiDEz6TFxFNOudXOUgClomXJxubDMfbJwV9jRK3DyMchaLUuC7uTGOOMzPRF/Cg7
	f9iLhtew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfdFS-0048ch-IW; Wed, 27 Oct 2021 07:21:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfdFP-0048ae-Cr
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 07:21:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1458668AFE; Wed, 27 Oct 2021 09:21:16 +0200 (CEST)
Date: Wed, 27 Oct 2021 09:21:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Amit Engel <amit.engel@dell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 "amit.engel@dell.com--from=amit.engel"@dell.com
Subject: Re: [PATCH] nvmet_tcp: fix header digest verification
Message-ID: <20211027072115.GA11660@lst.de>
References: <20211027064927.20452-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027064927.20452-1-amit.engel@dell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_002119_589962_9F369CBC 
X-CRM114-Status: UNSURE (   7.65  )
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

Thanks,

applied to nvme-5.15.

