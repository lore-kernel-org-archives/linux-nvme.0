Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872CFCA100F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 20:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uqhJ8zcljXKttnflqKnoWfc7wAFH7lOrN9xzjLNzndQ=; b=AzSZXG55EWCxjrIM31aYU42ijz
	Vrk3f2M86z4bIJX1ckOtFeGSumaoCBbP91YpSJjuTzTu6XX6r1gzGDb0lU6uP/BHudWXxm0aOZ1/h
	SrS6AiDNTxth0yKkKr1RF3cxRl0jpe1T8XPqEwVe0uCa+BaNGZ4fFTfqxEIrSgal7l3Ewq3pBeMQ2
	DixdgrF+3LgWuzOqbtVi63dYN/MwqWMIe4cDaJn6xTNcF7mw8E19NUgMowEODP+JyHjm5S8zCFb5j
	9ezgS9ry7qIi1YxZTB+F0ZhikQTgTKDnC0zORvpbaTSYZ60400/8aLy9dixJsseON26Gb6Dvxx+XH
	Lq5qFhrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0n4C-0000000BR5f-3cLf;
	Mon, 22 Sep 2025 20:23:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0n4A-0000000BR5K-378O
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 20:23:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C905E4330B;
	Mon, 22 Sep 2025 20:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AABC4CEF0;
	Mon, 22 Sep 2025 20:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572596;
	bh=uqhJ8zcljXKttnflqKnoWfc7wAFH7lOrN9xzjLNzndQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hz6RIXYsyTG4EBITOc0LQFOrFM3zp4e/bIhD7sMw7HVMIBbh84abq5nKQHDBVEINZ
	 HJlPDUXE5kCd16BOlVKEVxDMHlLukiev+XrumDZyulv8dGFjw5fMIQ8b6L/ThsByc9
	 G7X5hkxWg5RpMORETLHF2AcwAdc/A39b8st87EprIyHdp8RupTKR4qzQBD1fXebLdA
	 ZwZ9Y6uRAzyDqj5rncJqsj0Zt37fN6ASd43oT1WMhV727C+ryZQRcTHTEs/MXhFHp8
	 hs6Xf2b+a0wcZ5xQ/PrfepSJZMzXMM+I0lADPi0Z6hZJnVwxBHOfWFI2Q9s+N2QhvC
	 fmbSIIhw/lTtQ==
Date: Mon, 22 Sep 2025 14:23:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-core: use nvme_is_io_ctrl() for I/O controller check
Message-ID: <aNGwMiuPlji4MW0A@kbusch-mbp>
References: <20250922120532.3754-1-marting@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922120532.3754-1-marting@netapp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_132318_800264_33FDDC75 
X-CRM114-Status: UNSURE (   8.01  )
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

On Mon, Sep 22, 2025 at 05:35:32PM +0530, Martin George wrote:
> Replace the current I/O controller check in
> nvme_init_non_mdts_limits() with the helper nvme_is_io_ctrl()
> function to maintain consistency with similar checks in other
> parts of the code and improve code readability.

Thanks, applied to nvme-6.18.

