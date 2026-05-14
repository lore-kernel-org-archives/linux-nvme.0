Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851ADCD4851
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0x75qfZ974oSd0DncU4aTxFtPQ8gBmzZoEemuSqf3zc=; b=XvKmUGfqwkZQcL3BHm8UPSLPYJ
	ujVlRsw2+cFfm+iJRb8y7MU6xGTiRo6ouzFmgDJ3FlUH4JJ3bnxHw4JvloWny/WeqYtsIYMhd24iN
	qZQQF+BIpLJ5CQJw8E4pX+oi+q0Avdqwj7OdXYGj8mIZWsh0b9cB/s7FPCd1o/qMVoUIKUlUaW/wE
	JuheDPRT/dK1OCeK4CVg7AfMsWxy3IC1uFhjZn9UX9ejF43wcPkLQxS6UiFacJQXYKKlWA82E38JO
	IrunEte76pN1PUFdko6kBSHjCtSSzQnt9BOdvgSRLMdD6l8/9GMyjNpRaIcTx2dVHidvZHcptYoxX
	olGj5hNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNXFA-00000005le5-03Gp;
	Thu, 14 May 2026 14:40:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNXF7-00000005ld1-2pzR;
	Thu, 14 May 2026 14:40:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DC04A41B45;
	Thu, 14 May 2026 14:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC21C2BCB3;
	Thu, 14 May 2026 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769652;
	bh=0x75qfZ974oSd0DncU4aTxFtPQ8gBmzZoEemuSqf3zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsiUv2jWzSZcTZyJ3ZxI4lwIXNvq6oZk0wdTmalRDH6gmavvQVOau0eatDbAmNE3E
	 dKMmjjjqB5w7o8AAE5Gx0bDZjjXftJaMOVzbTlcKvHDOY5RghDgdx7AEiqxHmw0Uea
	 0uPRNF0VaaA1bWhUx53DrHwBL+qjuFHb4zI4WReKoYuaE8350LwwkwWuibHeERtE4b
	 FhjLcGiK6RZLKw7LH0OhI7xnwr+uCbpBVyX6IxX+RlfbL2diZi4omvTa849vbNUDP4
	 zur04KOX4onh4bcnu0lPpDb1Bdt3w3nYVTCvNxUmPPLWRBU2GD8ZNgHIudj9ukZsAW
	 4uHikaYewcDSg==
Date: Thu, 14 May 2026 08:40:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
Subject: Re: [PATCH v2] nvme-apple: Reset q->sq_tail during queue init
Message-ID: <agXe8lAqUu8Uwb1l@kbusch-mbp>
References: <20260514-nvme-apple-sq-reset-v2-1-84cbb5c70bf5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-nvme-apple-sq-reset-v2-1-84cbb5c70bf5@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_074053_730245_DAD3E860 
X-CRM114-Status: UNSURE (   6.70  )
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

On Thu, May 14, 2026 at 09:16:01PM +0800, Nick Chan wrote:
> Fixes a "duplicate tag error for tag 0" firmware crash during controller
> reset while setting up the admin queue on Apple A11 / T8015.

Thanks, applied to nvme-7.1.

