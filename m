Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710BDC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=; b=VHYG0CM7zG/4tZZl39FXhhPJ19
	vgfssFA1NKGX2yeBCq8rF/iGgFn71vQ4x5BmLef6iqgkGqccrgB4WCdC0LDx4vr6oCQ8YipN0DKs7
	1eJNAaNxrgeX23LoIv+yYcR9du5uktaIUTv47K9KbROFvHsvrtBeBpIo6BRZysTIChVGw08zoSqab
	1An/9UASZeb3fIDEJb6tqQrrWZirM7kwb8HioOD+lK0w9WpevMBwCn4jO2f2gM9embprd6Y4uZGA1
	eUnIJzAVsQCAtkxK6ef2tC4m4YTlQTLNai591eBrRNnOvAR+I8NTckE5rBIVXNiaAp0OIPeGCFohW
	YUrDX86A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricxe-0000000A89N-3OSL;
	Fri, 08 Mar 2024 16:20:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricxc-0000000A88H-11CU
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:20:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 35D5360BA0;
	Fri,  8 Mar 2024 16:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635FFC43390;
	Fri,  8 Mar 2024 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914838;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcftqML4aYCJ5wrz0uu5BBH9gaoV9MvwoV276F4S11oCaZqboUhjY8CrCn9U6yMt3
	 Xao+TGXrMjCwLUM5qGHwZDJOgDnpU2P6MdClwIi+W9iY1TX5nF2k+1+45NXAy3Mqlr
	 kMWjz5Klrr0zJpfnI55ZhI4/OngZE2BSVSXLPSOgT+Vy4ABF8ABkGjquar8msAzYlc
	 XIS5Nka79VrF+wDO9D1Bzp0OSHCZUNJuvk7bqBk6aU6fiJkW3lKdXP5/yNLDSA0I+Y
	 m9RC9e37ZqNK5HXUqJO03WQNcq3fkf9Zi37RMERRKsRJRRbkb8O1Bn4XYA+Jz53+N/
	 SCdzMMMdTZV7g==
Date: Fri, 8 Mar 2024 09:20:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <Zes61DCKaSF9qmb7@kbusch-mbp>
References: <20240308015435.100968-1-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308015435.100968-1-brookxu.cn@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_082040_341866_3410A104 
X-CRM114-Status: UNSURE (   5.62  )
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

Thanks, applied to nvme-6.9.

