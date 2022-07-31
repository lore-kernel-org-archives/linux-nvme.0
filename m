Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0610C00140
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jul 2022 07:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ON9v7abyLsZiE4nt63L0RfYeslElMllMx12QZrvI8oQ=; b=CR9ceFyvBdD64VSxWf0rfEGc0n
	HJ3IDnzj+1A7jKJfH6kEs7+XLSM/kajsc8OMcpKkVMaOQfUA16Yo6KF78mf3sWpKe420/NdofGssQ
	rf4zCGQ1hWdNXfarXE1H5DYmX1zGTPW+MFSKgePab/FOdo4L7WMJFNKvaZwWsj4MlPxBQTkf4R1SO
	MrK9YhOMzXb/g0GKyGbZkNQ1bHWulH43rIxsU3uEeP/qQ/h616XAj1JrfJ7RCJ4MLVKXlLeTn/SYB
	ndHt7MRt4D6Du0mlzyEMihNlfHVqzLLX5vnfkBOxe/3969hD4+/f4Wt+WEUldnSqDvCgJl7BSZ1eQ
	NzaGAXsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oI3BV-009Jpn-VI; Sun, 31 Jul 2022 07:16:21 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oI3BB-009Jfo-BO; Sun, 31 Jul 2022 07:16:02 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 09A6842597;
	Sun, 31 Jul 2022 07:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1659251758; bh=C0N60javoyzer1itq5XZGdVF+06j+iDnfMMvzGBw7u0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XnYQjU+OUOW0EYlQR70emvx95JhwGB6+kw8NFpGiAXT6uu5Mexnr625DUkDL6RuuS
	 UEozeHSSHLJzJDSlcGiObIcZmJO+67IkJO3pwR9TBR197DsFVHCOGivwonCLdZbLns
	 zJ66zbPzQQdwL9ztxdAVadPJqiSJZnF92/jUKOVglopwKPIKLZmAMY0MTKm6HXptrR
	 TxEc33oR9jkHrKpK4PWUFjmfgvBv3B6CZoYfaiDnvh2T3bK6HeaUFYfBLQKFQQeBwe
	 dECx7CzzqVzkOF17Elp75HtFd2Dy3whBTkx3i1uTnssKPVNBhiOUKoNyWRYpV5awHQ
	 UstBCXMHl6CVQ==
Message-ID: <f959307b-6d75-263b-4a91-e152d14f4399@marcan.st>
Date: Sun, 31 Jul 2022 16:15:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme-apple: stop casting function pointer signatures
Content-Language: es-ES
To: Christoph Hellwig <hch@lst.de>, sven@svenpeter.dev
Cc: alyssa@rosenzweig.io, linux-nvme@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20220718050500.227804-1-hch@lst.de>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20220718050500.227804-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220731_001601_568141_DB5FDD14 
X-CRM114-Status: UNSURE (   7.60  )
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

On 18/07/2022 14.05, Christoph Hellwig wrote:
> Casting function pointers breaks control flow enforcement and is
> generally a horrible coding style.
> 
> Add two wrapper to get rid of these casts.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Hector Martin <marcan@marcan.st>

Yeah, casting function pointers is evil.

- Hector

