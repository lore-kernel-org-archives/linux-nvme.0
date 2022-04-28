Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BF9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bGejRZQlDZbKlONPKSS3UkrsnM2hYxvQnqVkfrkFAFs=; b=evQzP6ctQZl9CxuRMUSNPf1vQY
	dGGTLJwxWtIutPH+k/5YSKuOdwFtt08x/rNBcqMnso97o+hESLXSdLNHU5z5cYYsXLcQzgksm7Rm8
	zC5wxhAJA3Rw9F5nNpw9PRpgQ9ZpZcYzxHYYZntGUwMiz5WpeIc0bUBvmH+hbZh+ogxOVPrOCkSdb
	c+U+Wzm6RcE9IVctCD3kEP4mikBX7oExm5L0c3HQ6WfHEFb2yGLViKTGElkqCw/6jEG6EJ1/3Zi/G
	B9RlkWzXBE3tvrd7Gqq/ZZvVyD312soetD1lIbsmvNs0kGiyG0Yo9zjTnmVkgz5TJrt7+fcZudfK/
	fI7qK5Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk5mn-007bsK-CX; Thu, 28 Apr 2022 15:10:29 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nk5ml-007brr-UW; Thu, 28 Apr 2022 15:10:27 +0000
Date: Thu, 28 Apr 2022 08:10:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix interpretation of dmrsl
Message-ID: <YmquYxXtGXlNB0PL@infradead.org>
References: <20220421084841.2106-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421084841.2106-1-tom.ty89@gmail.com>
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

This doesn't even compile:

drivers/nvme/host/core.c: In function ‘nvme_config_discard’:
drivers/nvme/host/core.c:1638:2: error: ISO C90 forbids mixed
declarations and code [-Werror=declaration-after-statement]
 1638 |  int lts_shift = ilog2(size) - 9;
      |  ^~~

