Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C4CC48BF6
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+Y/obhmxT/ZX+s5HJ17sOovOS+5PKgKSqsaEvrwmzc=; b=PJwsOCq0/cabR4thu7temhKEzb
	x5qlMr0XDAloLVIC7DP4NUkHiPNVILHsseXdaQYNGPmauiu1yUAJUz1XyPnWGMwEEcwvc2AOLWyEP
	+SUJURDMUCo6WyDH+NMH6Vn5WRVyO4m3vTvGEQ99goprZg+YFesBghaFxu4KDOyzmaLJgPzsVIpUa
	oJRzukSC9Uu6J0GNC/c/n8IBNRDn0crTDP2oJlHhIU6miwVF7rFI0nvauRQqUENBbz6rzFBuuIvbm
	PkA768Fu2VAqZGNNKVdg+/KNeFovLS5Buh9CGhFJbABK68flEKgPKbY1Hr/yx5j/8ao3N/3eEK2ja
	+AFUDCCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redzh-00000001hXk-1Pp1;
	Mon, 26 Feb 2024 16:38:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redze-00000001hWJ-35Ir
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 16:38:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8FE5C61180;
	Mon, 26 Feb 2024 16:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6E0C43394;
	Mon, 26 Feb 2024 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708965497;
	bh=m+Y/obhmxT/ZX+s5HJ17sOovOS+5PKgKSqsaEvrwmzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3X8LTrSy9+Le2YRxRrRAp4qrqAqbV060Op2HUxJ0h1Mlah/sMcZTiMIudgDdnv0B
	 L0HS0zEPzntO620YXbmxKXZ65d83Q4x2Plj290NVGhNEoVL/PiWPx7TgdVmXPdyJ7E
	 hflMqVrDkYsqmdy7rZ56MAFDH767035t9pYsmj3puf1NmdVxvWK3zEwim7awsdb082
	 hX5iSAOMQoAR43zvL8VW7bwb8XlHWEgD6XMXnpDgHB2DmB2sbYcY6j040lhDHuxf+M
	 lQ2KThBBxBUpwKhYd9+2Me2NssaRTfkHFcbUMGs+cdNrE558yWolo8NOgC1in4a4c6
	 qapqsHuD4/Uwg==
Date: Mon, 26 Feb 2024 09:38:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	kch@nvidia.com, oren@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v3 0/8] Introduce new max-queue-size configuration
Message-ID: <Zdy-dsk0X7grJ66z@kbusch-mbp.mynextlight.net>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_083818_847137_61CC3CC3 
X-CRM114-Status: UNSURE (   5.15  )
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

Thanks, queued up for nvme-6.9.

