Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD71D5D688
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDgMohftkB1AYMshPfUiHGlHWE94RwtMWx5NOFwHpyk=; b=s28FuT8arRzBkln0nBxGjbNLd8
	4QYgICNGZ2UOEtdAZCpViTx43E5MRWzgRf+Zxd7/M7JFcLFVmJ4cHVD2HKU4RuT8CvsIJIACSQLSQ
	YsVJWdSGDWOdjCb5vFmZe/xXPNPhtaw60L6jqs1/4qGgzrGRfLbv6zCz/1uQk0OPXDAaOurolqFyn
	b8gq3AptvcNcAFtraElRQjJ6DZ9rMfFb+WCvRBwOijuZCAAoW5fF4pwxvMsQG2R90AdG6rMCNg4ko
	FtgcO4ea0c8LKedDWRndXtPi3fwNo/UPg06BdO/LFQTNNKKeswp73Cvde7LMOyqpYscruENE5S6KF
	Ff0zzq4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98dt-00000008BSo-2NzK;
	Thu, 07 Nov 2024 19:58:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98W0-000000088yx-1L7X
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:50:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3D7BF5C1008;
	Thu,  7 Nov 2024 19:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D92C4CECC;
	Thu,  7 Nov 2024 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731008998;
	bh=6CNvQqrOUa8gRXsJX4B/HOrz3pOdmSBfWMnp3qecacY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBeglknfTwvGGTE2/eozXFSpYk0497MF0lLHflFCajo+XuPjAOqxW0OBo2sGW65hD
	 7L1mPnhXxLYFvyvdg3F2KLwWmdfbCP0E2FxS9o3T/Ap7V0jA7WSsWP0XrQpiN8YnB6
	 Q7oMYD9IZkc51HmLo2BcaJPxGId2GcrLvSJt8UBAAlJohWN/pNfrTYUdxhtNk3ldqa
	 1g7ffd+/b/L0w2qK4EFvGBkZ+mvDeJUkoAs9e1jqsIf+YwfNcMvV2536ozybQlWaaH
	 uAglhJLbwGan56xdHp3DQrSofm87hxh0TVmfqlAv2L5jGRqJhUcFrd+VCau4baZnYo
	 tbB365MOtWuBQ==
Date: Thu, 7 Nov 2024 12:49:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH RESEND v19 0/2] Implement the NVMe reservation feature
Message-ID: <Zy0Z47mZ67CF-n3l@kbusch-mbp>
References: <20241106073446.122459-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106073446.122459-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_115000_420924_2BE16A81 
X-CRM114-Status: UNSURE (   7.69  )
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

On Wed, Nov 06, 2024 at 03:34:44PM +0800, Guixin Liu wrote:
> Hi guys,
>     I've implemented the NVMe reservation feature. Please review it, all 
> comments are welcome as usual.

Thanks, applied to nvme-6.13.

