Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04953CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 06:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUk03tD02nWAPVWUDiXz6OebsNBD2Kwac2rrRjCZDfs=; b=uWq3kI7pyByZjGTjTNM0arrIbR
	gP/ZrVq1U2Vgiz1OT75znje6FLJB6WLjrY7IPSo8SwNU/3zZnvPO8l+DkTHF2ShDMZoVdZ0NGHO74
	f909PWp+dfKYyhTSVKSydA16IETGmrtPb23PXZlQzx1EEUEjnak1myLOFA0xHefWXSBAACFAgaa4Z
	LvW+kJC337oE9ruwclJsZrMilKSVEuyNqjrnjCpH2lDsOs01q1UFbspS9vrrTA5cznYa4bAEnU75I
	Pyc0qMnwnITkrP/GMVUh6i/1FwSwhwyJqRuVlKhk5lUmdn3aWtpz57lctUz7rgiRz3cqgwe0pwRqZ
	I2+PQfgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPat0-00000003jLX-1jqV;
	Wed, 20 May 2026 06:58:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPasx-00000003jKs-1mye
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 06:58:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B1E042A82;
	Wed, 20 May 2026 06:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C46B1F000E9;
	Wed, 20 May 2026 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779260310;
	bh=RUk03tD02nWAPVWUDiXz6OebsNBD2Kwac2rrRjCZDfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DqaLa8/PbJqWvIfX3g1QZ6m7s0vV6P/N1MMIxxyrqr2lOMrev6U0V6VK95xAFoOBz
	 vhX2nXB09bPUm1JLnlRtsU4qkz95Gi6qoVtmlkzXt9yTo1mhunZoZEUw34scmTtXdR
	 55z7JNqZoYpfZy00Oc+7U1kIBE5cUwrv60zH+aOWrj7NstXhh+ZBjxtpv4Y8+T1eYv
	 xYG22ekc35s/Lz6N2UUk2b+citri2O6waxzjPOr9AMi9PeO/SbuFIlN4OByocOHtDF
	 8z9Os9R4vVzFdiZcw+CsJI3hRLR8fMlgoKXqUxHBH3IREO1BSACFv4NK3FkKpPfiNU
	 MGz8g6GnZ0oqw==
Message-ID: <493f4c2d-8926-47d3-8865-e4ab4b8873ed@kernel.org>
Date: Wed, 20 May 2026 08:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] block: fix invalid zone append status
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-3-kbusch@meta.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260519172326.3462354-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_235831_490146_7A3AAB85 
X-CRM114-Status: UNSURE (   8.36  )
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

On 2026/05/19 19:23, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A bio submitted to a zone block device that breaks the limits is invalid
> rather than an IO error. Fix up the return code to report it that way,
> as the previously used IOERR is considered a path failure.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Same comment as the previous patch. This could go in regardless of the other
fixes I think.


-- 
Damien Le Moal
Western Digital Research

