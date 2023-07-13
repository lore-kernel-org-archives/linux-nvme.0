Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9565FC001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cxAGvmTNkrZ2ZWQdRG4kbTl4vahEG62V08kbGb5eTC4=; b=C1nKCKNIXF+aWG8ML+/FFOhtbe
	y9eWjipxwtx2KrWcR9M41Uzrb1VrJyK4tZY/yZ9w8OAkp2Nu4b8w7Hp3w7kfBASSSyRyq9Kb8WPEA
	ZJjBXXWcZkixK4GETUTRgvOUPZ/LBwTp7TUhMFgwd8WajXN1hnUnbWAoljDe97pNt7ZzLMiF1na95
	imVnHKrJtdTFlp4f5yuyR1J70kyPyveBAovVsy0395z9DrmjdyLOUMLrD0FUXn+iHFAVjfgNLgeMm
	JiFdYq7a+xY9NCg4TKsnxpmMLTrTxm+f6pST6b7oNzg8ZRxAm8j9EpaufbCe4zd+e+vsbnkBww7b3
	B+pbGAyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJy7D-003jYl-1Y;
	Thu, 13 Jul 2023 15:20:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJy7B-003jYF-2i
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 15:20:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD2060C26;
	Thu, 13 Jul 2023 15:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F8DC433C8;
	Thu, 13 Jul 2023 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689261620;
	bh=Z3PrmpxRymkulKNXOrfpqlzVymBb/sam5aW0aKcFSU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2VedWpGStvK4hv7ngr+XjBNroSU5utV9QtISVTSZ+3FxxczKMtsaddK3poiCUaul
	 Xz6otSdW/9OJaPCqX/CCaIR9MONbLnHyGJjWrGAZLiew0ZffDAZhWmpDGk+8toIbBG
	 XQTnfkYOABzYifW6PXDJrg+VWiLwyaysVjWKdERhjvwTfC/R5zd4A+BvcoNv0cuhk+
	 54rjOypVhKhDIsNd3llMZCkQKXIO0UoS7C8y4YsE37ZXFlZ9Lh08uxMSxGpGeKBLk+
	 /GNl1mcYaLiXHvAZroRRE14HcMe711DNbZDkklXmJLYFsb2dIyZw9BKAXf0lf1YlKa
	 E9ruB30/H0uCA==
Date: Thu, 13 Jul 2023 09:20:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: don't reject probe due to duplicate IDs for
 single-ported PCIe devices
Message-ID: <ZLAWMhEoQeYf19jz@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230713133859epcas5p2b0de1a117d69f54f2d1dcf027f73afef@epcas5p2.samsung.com>
 <20230713133042.3981-1-hch@lst.de>
 <20230713140156.GA2143@green245>
 <ZLAQPKOApKCg1LDu@kbusch-mbp.dhcp.thefacebook.com>
 <aa5270de-3286-c3f3-75fe-f1b5ba1dfde4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5270de-3286-c3f3-75fe-f1b5ba1dfde4@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_082021_923081_50FFB5A8 
X-CRM114-Status: UNSURE (   9.26  )
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

On Thu, Jul 13, 2023 at 09:01:18AM -0600, Jens Axboe wrote:
> You probably want:
> 
> Fixes: 2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique")
> Cc: stable@vger.kernel.org
> 
> and that should do the trick.

Done, pushed to nvme-6.5. I'll send a new pull request before
end-of-day.

