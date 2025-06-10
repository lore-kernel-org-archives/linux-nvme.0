Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5FAC5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YfFBn389yKU+Qh7stET97wF8CHLOtW1SkgEttWpRxUI=; b=M14iUcFn4qu9wPxXhJEiLNuyTC
	tAON7U32c8d0DMRwnzlAUANEef3OeyVOP35qH2sXrYhnr3kayIoEEKjeltE9muz7onB0JqUH2csBC
	Fh1wl0yZRM5lavt6aHRx7tH23AWGkF3TS93JLg4JI9vjsJ70xrXx+KtfXgmpXgSrLMx6/pgH8C4O9
	kHcu9zjH1EZ9WmsLMypHvP3ek44SHxxpUIL+ker4VkAI8za+yVlnnqV9KFukpLerckOdLN5RN5Jpn
	V3Fa3Sc6OKM0z0S2zrd+AqKTY7UTGtudYNwJKRNL5b3/FeB8npNn8jI5vp9LPOivyFStjKDNsiS6u
	9WkZsssw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP14g-00000007LZH-2jtx;
	Tue, 10 Jun 2025 15:39:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOypO-00000006vMs-06Kp
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 13:15:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AFFE75C4A66;
	Tue, 10 Jun 2025 13:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C5BC4CEED;
	Tue, 10 Jun 2025 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561344;
	bh=KqhRqVFkbAu/zx0zq5YPd4/MLPzkapeG5ZRQvM2tBbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPOyo+kBK8aA7px7AxJJ+VWHpbstYaKb4hw+SwiT4UzuSkeDjjOrN6ghOOMJV7vhB
	 /4uxm8fXaalrQqYYXhv4jyk4LoBkgxagazq2CmRY18elzfddYvfLDNbsQa+S3XspHq
	 EYLAk2tNzxszUk1az9NJplo4uL7L/qCg/y60CrsN8vYrBXlW6hqPctJKx8tWHyDANm
	 F6iRlq8I4A2kyviCCmPzWAgbJDBy3LIz35pMcEe7suKylYsLXbmiONU4eW0PnhcB5V
	 Q9pH2Tf5s7Kr/c5KGBtHTQxBnkhx68lire1Ne7/gbuJNC/kj/EO8H6aZg0m9T9I3Wq
	 rwFlSHWKDMgow==
Date: Tue, 10 Jun 2025 16:15:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-pci: remove superfluous arguments
Message-ID: <20250610131540.GH10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_061546_098311_2A405721 
X-CRM114-Status: GOOD (  11.38  )
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

On Tue, Jun 10, 2025 at 07:06:44AM +0200, Christoph Hellwig wrote:
> The call chain in the prep_rq and completion paths passes around a lot
> of nvme_dev, nvme_queue and nvme_command arguments that can be trivially
> derived from the passed in struct request.  Remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 97 +++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 51 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

