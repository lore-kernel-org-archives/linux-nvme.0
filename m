Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7922CE7719A
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jan 2025 03:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHMZYn04gl1AfniDjvtYXt1/Xlu6xa7m6tF981ertPw=; b=gaZfTgPTc24tPWYd0ytaRI+Crs
	0emgs01Fxkm3hdy8qYCboVaF88LBsHnwmq3uS6UBrKBx/qZrVVkIHri6+b5iL9Ngz2lD8uU3tndZM
	OV+n08DH5dxBgL4ndcIQm5WoWyASPBoexARKudpGKt8wqDyMoUke8NohCn/6vVHCj/jW7Bm6yN+1C
	ISU6bGXLfm1W05Yd8cipErTXlGeiyxKJF0H2RrZ4bp+uFUxMeAMgu4LJZSiF1EY7QJJFs2vfc0S58
	AizUAkE0IjU8fqhH2t8EFxV9Lvm01n19Rxvc8MYKqkkOjoILPCjFIjGLVM0m8W7QWx/9nAloypl4S
	HK+Rstpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWScK-000000006a9-34ap;
	Sat, 11 Jan 2025 03:56:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWScI-000000006Zl-236B
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jan 2025 03:56:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E3E145C547F;
	Sat, 11 Jan 2025 03:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA67BC4CED2;
	Sat, 11 Jan 2025 03:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736567813;
	bh=/0mlGhy6Pur/5CQJX9uPGU6gCOjTm7sU2qLiNtl/2Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlXNpjii24Izsyg9W9GYz4GEHaL4uKTmhA3hZ4bjdXRj13FaZekbL+dflVgJdhizy
	 2Indzo2QcRk0V620MfEc26/83XvLoCCD1aIs2cDF/GTEw9g/EXLJFcbH9OAPn2LLxE
	 SZEAFYp1hWL08jSl7vAe9e8KDP/QpIBixqFXwdQ+5TZLWHtVU2pMdQ9aBh8fpNQPc4
	 OVUxM9uXOXMmjNsspUu3A+bP16f0XxhqMhCSe5jaSQhewDytf/noG1+Tu3DR7im5x9
	 FDxcBiJvwRLKz0uUQlntyEMcGtRleKlKnF8pvDSsU10Up1xr9PfgUeVRkKz9dKzUgY
	 Lcp6KVAowCCCw==
Date: Fri, 10 Jan 2025 20:56:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: francis.p@samsung.com
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com,
	d.palani@samsung.com, sathya.m@samsung.com
Subject: Re: [PATCH] nvme-pci: use correct size to free the hmb buffer
Message-ID: <Z4HsA5tGUs1Fp4vH@kbusch-mbp>
References: <CGME20250110051900epcas5p12cd1640b8e8d7a64680c5130091ad6e6@epcas5p1.samsung.com>
 <20250109235137.8995-1-francis.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109235137.8995-1-francis.p@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_195654_576295_C389CD73 
X-CRM114-Status: UNSURE (   8.33  )
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

On Fri, Jan 10, 2025 at 05:21:37AM +0530, francis.p@samsung.com wrote:
> From: Francis Pravin <francis.p@samsung.com>
> 
> dev->host_mem_size value is updated only after the successful buffer
> allocation of hmb descriptor. Otherwise, it may have some undefined value.
> So, use the correct size to free the hmb buffer when the hmb descriptor
> buffer allocation failed.

Thanks, applied to nvme-6.14.

