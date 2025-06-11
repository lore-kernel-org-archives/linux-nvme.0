Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5769C71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gjie3+mu1SjXTcMqJCuWX0uDkFkWq66AIWF2lqqXdtE=; b=no9xVoKmTGX8Pz
	Rrjal27fYG4p89/0KQNNgxF3Lb9Odt4Uk/z3Wep8EXdfjLFkzmrDeSLY7e89PyDYt9MfVmVrW2NOa
	ziSX9D//Jt6MyYAMsQBEq2P12XhpsaZHpn7g821GHP1JXRM9cmG7rXyKV+bp87JW0DczbQ8kYAkEx
	DyyDrE3Y2HsQWO6RWUa3A3eDb9OsrkM6O6DnHVzmry1FJE4infY/FUIs0bOh5bG90hjE28XVTPXOP
	tHmisRrKvnXnvL4vvyvFWXIigMOBTfFPWOKdxyh43HrkWxI6iMgnkHb2aq8GlPq4bssCKdd6jQn5U
	+1Zh8XShBmOjMgkujs0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPk4-0000000AmUt-1Z9w;
	Wed, 11 Jun 2025 18:00:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPLrh-0000000A0bO-3mlp
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 13:51:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9981744B94;
	Wed, 11 Jun 2025 13:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A6C4CEE3;
	Wed, 11 Jun 2025 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649901;
	bh=pTNT3csct3F+DXtUUq5feh5suoNvLizdEEFy0X5wxY0=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=FiDWk8ZQXu1f9T2WlLZvgPdhPyl7ndgWnaOM672qFhCc81SnKG+Y1NqDqSJc37oRk
	 dw9/tGVGr+3+agdmttMBJoBS6wwCUNyefaBAnIO/5cwcLT72T9cGlEgkX2uluDFfRf
	 SC1qqHX7spc/X9KV2KDT+vUqqEwho0+EHSvGv0s4P/DixdpLYlcLF/Z167ZanJy8UR
	 Aqo0+WgjP6vYxMf5MhYre3hAabbzNwkEkHAcpbrAawshUgeuw0kWnOdKN7wSXkK+Og
	 c7OispYEwQO4rmoeHzU6dapkG+VohD0jY98ME97A1oSUS1IJBGbtA0X0l2KemyedaJ
	 wdfkVx7P/JLfw==
Message-ID: <231b647f-a173-4a8a-b0f4-a314446a520b@kernel.org>
Date: Wed, 11 Jun 2025 15:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] nvme-pci: rework the build time assert for
 NVME_MAX_NR_DESCRIPTORS
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-10-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_065141_963901_E02AAE49 
X-CRM114-Status: UNSURE (   8.24  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/06/2025 07.06, Christoph Hellwig wrote:
> The current use of an always_inline helper is a bit convoluted.
> Instead use macros that represent the arithmerics used for building

Nit, typo here:

s/arithmerics/arithmetics/g

> up the PRP chain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

These are my checks:

NVME_MAX_BYTES=8388608
NVME_CTRL_PAGE_SIZE=4096
MAX_PRP_RANGE=8396798
NVME_MAX_NR_DESCRIPTORS=5
PRPS_PER_PAGE=511.0
MAX_PRP_RANGE/NVME_CTRL_PAGE_SIZE=2049.99951171875
1+NVME_MAX_NR_DESCRIPTORS*PRPS_PER_PAGE=2556.0


Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

