Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA5BCE8E94
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KR49KR+HZFxBqk+nnj9IYmzfGn4uGd/Z5b44dH8llOY=; b=Q5KDaaGkjjXjcd/oHwAILlGrfr
	3BuDld4BAV/UhtngOnsCFABxpRjKORkmiUJOjFGAc9oSa8Di6gy/Zd8BVMrn1xip3o+oxECCuSsLw
	D+gc32xPFcopmJw2O02J1SsX5q8xLeRmvC+hHeOJbzFsxswHdHQCX8LVst/DJbPhZUUSywjLwcWQb
	yl6IM+yCQmfP7ymbRwGHf8a8+e6Cmae8S6QQaDDzkhbyOUVQGyZJHSSXCu3rs1bFks6YIm+NtvkuO
	DRr0M60xwMCgGM9IfrUdOA6BhfCjygtFfvOyq2IYhTULL87s0ciVLcAl/JcToISzsnR6ChhDJAe/l
	OK1dnG6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t40zu-000000019Wz-3aEl;
	Thu, 24 Oct 2024 16:47:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t40xE-000000018lx-2Vde
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 16:44:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9C787A45698;
	Thu, 24 Oct 2024 16:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1057CC4CEC7;
	Thu, 24 Oct 2024 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729788295;
	bh=pFhXp2dP9syj/XZKQdEovia0qs7YtKB5m8D4phTruXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMwfKkz7CnAuwCBOei9nibrP1fmjE1BCfWe2dWld87oMTIWPMPQKsdIaZQfuDqxY6
	 nO86yF7uv2erztFhUgArAle0vXbNK1GITWEkqIO9UXj+4LAUhJDndnC6lEe3pS9Fd3
	 7K2xkcSWcktHZWsEgCIDLPmpDxbxOsDkQNlQS3FtB0unpjvNGqaMTS19o33FXRlKvX
	 RblfDYLlykkgOwi/BAtMgX2rRW/CuavBpx3UYdNbar+xOMjeQwx+leaKv1bc+LQT8n
	 7+0r6SUP6Nweh6PRSHmyo1382QMEck/3fhjPmPgObIzDbAkMMUpawEMERuKJMbvlJi
	 p/AFDV/Axt8Fw==
Date: Thu, 24 Oct 2024 10:44:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, martin.petersen@oracle.com,
	joshi.k@samsung.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCHv3] nvme: module parameter to disable pi with offsets
Message-ID: <Zxp5hNBP-dAaCrBn@kbusch-mbp.dhcp.thefacebook.com>
References: <20241024154923.3156803-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024154923.3156803-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_094456_724422_1C4CC606 
X-CRM114-Status: UNSURE (   6.17  )
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

On Thu, Oct 24, 2024 at 08:49:23AM -0700, Keith Busch wrote:
> +	if (info->pi_offset && disable_pi)
> +		head->pi_type = 0;

Added to nvme-6.12, with the typo fix: should be "disable_pi_offsets"

