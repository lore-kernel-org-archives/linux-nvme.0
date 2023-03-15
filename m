Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EEBC61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sl4MzcLXay7rnJij6+Nk0Wfj4dU0fVTSGjIS/Wt7GVw=; b=SugJJW3gS37iN5d8bOw1iePnt0
	cEULM8IxuLwJj2noSLXfSRKmTlCMLDAnehM1sYqwfFsduzMMOjktwW1EPOOl0PBOhebmJo6Iec4WF
	cJHv9/lMKc4MStEtneTvF1MPz+pk6wiYpyb4R2cXgwEbJRlDVqza49A35EnShHT2mLWvM+AbUhNqu
	KmsLnn7AGwJJWVGSmea7/PaV5YB5BJXcI4G9ZmKwE3Nu5Rk38dX2IYkJr4O6ROA8vfbqrvP1OC3i8
	EeuJOh0GIauS1yf5V9OcFFSlJQiBDpmoCegztOHue2fbzCtM8dekCUn8axfK3yKbClRBubdMZ/u1J
	ab+/+HaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRTk-00DVmP-2X;
	Wed, 15 Mar 2023 13:47:44 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRTj-00DVlw-0A;
	Wed, 15 Mar 2023 13:47:43 +0000
Date: Wed, 15 Mar 2023 06:47:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-core: avoid identify with CNS 06h to discovery
 controller
Message-ID: <ZBHMf5qBgsbhtk6N@infradead.org>
References: <20230311172603.3800-1-marting@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311172603.3800-1-marting@netapp.com>
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

On Sat, Mar 11, 2023 at 10:56:03PM +0530, Martin George wrote:
> nvme_init_non_mdts_limits() currenty invokes an identify command with
> CNS 06h to both discovery and i/o controllers. But as per the NVMe-oF
> specification, this is not supported on discovery controllers:
> 
> "The Discovery controller shall support the Identify command with a
> CNS value of 01h (Identify Controller data structure); all other CNS
> values are reserved."
> 
> So ensure this identify command with CNS 06h is sent to i/o controllers
> alone and not to discovery controllers.

This looks correct, but can we go a step further and also skip it
for administrative controllers, i.e

> -	if (nvme_ctrl_limited_cns(ctrl))
> +	if (nvme_ctrl_limited_cns(ctrl) || nvme_discovery_ctrl(ctrl))

	if (ctrl->subsys->subtype != NVME_NQN_NVME ||
	    nvme_ctrl_limited_cns(ctrl))

?

