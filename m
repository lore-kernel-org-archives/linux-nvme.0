Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9376AC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 20:50:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560B661051
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 20:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 560B661051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BsBx+R2p0fcvg4AClP8lvdHvD+epurhs5WTl7ZrpX1g=; b=apawpbfAYaVvqT
	ZcMpbsJpunlZb9XE7BHZqjncuZuKL88rE7u+oDgYHI6ImnkpYxpiv7vMkkAlsVC3QvE2efWZohK8n
	PqCswvqNzOOByilrz+A6AaJ9jVKycrhchlMvpvIkBXm0dgO9e+udSixAXX4Z40L70qr2ks2wI6wgS
	gWAN0uULU4HNjYKOoX9abyt/vgHL2tq661dj8VHVY+wB/64OhJF90skNtjwQPoLbdI75dohxrWujy
	8qFB36Ojo3vrVJ6HbPvhnb4cUv4uh7OiRpmP9/Ugsu4kIaISv4rSpps6v42KBomT27l7RFENi2YdA
	X3QHzuDpfcygutBnrCfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNi32-004i9T-54; Tue, 07 Sep 2021 20:50:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNi2z-004i8y-Be
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 20:50:26 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A443461051;
 Tue,  7 Sep 2021 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631047825;
 bh=ljxUEP+ogPsLHFO4NirLlDcl0tCm6QKcp9fx2i4wzmU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qoME1hZr9db2qsUIT20zdEh/5U4PZMgRDf2yv12y6AOpShRJ65OHamQ7LcK61naLe
 +1TUWY54RpWcY6kaLTi/+Ik1Z/iN1V95cO3kM9SLriBWF/FBmG/EygCjpkPvUL7Xxj
 WLaOKlKN+iOQcUIFy+h2Uy8CAz18EQAbUI2KUpbrnwJ36EzoXTmF4j8watUMBQ70Xe
 xRHMC4qwXU7MMLjO6JweCwtX6/vzzx/M0G8/Oh0+OJUnR8wFBfO7L0Wku8k5jgh121
 8N8fqlVILZF3u6sTewJZp+6JvEzKNykICj9YTHGuIjbGGsOdp64K5N+67uDW1mz/Fw
 0UjgHdgIIez2A==
Date: Tue, 7 Sep 2021 13:50:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvme-cli: fix the [data|mdata]_len param
Message-ID: <20210907205022.GB591280@dhcp-10-100-145-180.wdc.com>
References: <20210907201136.7715-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210907201136.7715-1-chaitanyak@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_135025_453271_164E6E94 
X-CRM114-Status: UNSURE (   7.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 07, 2021 at 01:11:36PM -0700, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Add missing user data buffer and metadata buffer size parameter for the
> passthru I/O commands since driver code expects these values to be set
> from the user space. Without this patch blktests/nvme/029 is failing.

Thanks, applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
