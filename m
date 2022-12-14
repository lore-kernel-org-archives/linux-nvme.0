Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6A6C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dwdfVhpiIuADJHsAmuAaqYEscBsSNIEf7UdCzZdt70o=; b=MmerPA5xVsJYBCJIK6wzpJDIX4
	1NI0vk/SPwrKfr0jBYr8x2vD9URUViDMNLh2nU0vKDSZaLaQKDFZ38zcZc5By48X/vMEE1Jm7Yc2y
	9WZ+uy8Q2594+mJSYgrtLhzE9UDxhWCR7hAPbWQnMPR9wL1rHUwzB3uumLjXzKzWwAZczeb78TrA7
	rFutbhQfSfHvmfVdwE8PaScpjm7q1ch/uFimlV+u5PP8I05W+o1kAATT1kVOnfQNGNT71vAkjPtj9
	JH303Oo1xx3CsxlBL3w07itesC2p15Ke4Eje+DNq78K2NNgthS8AohCCz+Dvhnfs5VBDWt/YZyavd
	DohOTnLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Med-00ELld-DQ; Wed, 14 Dec 2022 07:58:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5MeZ-00ELe9-Sk
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 07:58:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B11E567373; Wed, 14 Dec 2022 08:58:03 +0100 (CET)
Date: Wed, 14 Dec 2022 08:58:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/7] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <20221214075803.GA4250@lst.de>
References: <20221213162453.584965-1-hch@lst.de> <20221213162453.584965-7-hch@lst.de> <Y5i8A84jGCnvLnbD@kbusch-mbp> <20221213185415.GB14596@lst.de> <Y5jQF51E+/vH/5Cv@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jQF51E+/vH/5Cv@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_235812_095756_D253EED6 
X-CRM114-Status: GOOD (  12.79  )
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

On Tue, Dec 13, 2022 at 12:18:47PM -0700, Keith Busch wrote:
> +	if (!ctrl->effects) {
> +		if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
> +			ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM,
> +						   &ctrl->effects);
> +			if (ret < 0)
> +				goto out_free;
> +		} else {
> +			ctrl->effects = kzalloc(sizeof(*ctrl->effects),
> +						GFP_KERNEL);
> +			if (!ctrl->effects) {
> +				ret = -ENOMEM;
> +				goto out_free;
> +			}
> +		}
> +		nvme_init_known_nvm_effects(ctrl);

I'd probably move this entire block into a helper, but otherwise
this looks reasonable.


