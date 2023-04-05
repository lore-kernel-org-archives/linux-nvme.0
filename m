Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A69C7619A
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zNYmufouAHGHJmTMrqNZcIfEb2pP6Kr6/5nqw3Qs1XM=; b=S3ePyoZscaMboaK777xoxE8X+G
	8b3xKnD2Jx5zv6k5uNDNAO7F7MyBX2MPOQduJPUU76lC4hi/wsjY+ClDBJdSP9PK/1XrLX4uWb7iI
	FUNvqgJr2snRSzjx0TWnzmAdEA3O5ENb1ZUu/ui8rb8WNz8ME2/pbeFk4USrnE0kZuKp0g/6boMsT
	d7t5bIHgmwGVC9FiHuy4T3Ln8XYqyhUmnxtBwxVYRZojUA3TOaoHIVpvXXo6HePEfTJnw96g0Kx8Y
	FfD7sAauTVKlGrSBSjzDAq1QSDNaTj6r5IDkJYH2a8/Ek9LZymENhPFi5+rYrmKurUT1JaiI74L/x
	zxPwnyjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4xA-004qTy-2A;
	Wed, 05 Apr 2023 15:21:40 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4x9-004qTq-1d;
	Wed, 05 Apr 2023 15:21:39 +0000
Date: Wed, 5 Apr 2023 08:21:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chris Leech <cleech@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH v2 1/1] nvme-tcp: fence TCP socket on receive error
Message-ID: <ZC2SAy1YtT63JK8T@infradead.org>
References: <20230320220947.3244247-1-cleech@redhat.com>
 <20230321163025.9437-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321163025.9437-1-cleech@redhat.com>
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

applied to nvme-6.4.

Let me know if you really need this in 6.3, but it seems like we're
pretty late in the cycle and this a rather old bug.

Nit: a Fіxes tag would have been nice.

