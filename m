Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A7DCF9C6C
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2024 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wzFBalLByJ99n8/R64qcr0eBTHtm0s+ODMdkp44xeBw=; b=nLSTGrYXh8pIhAZrM16bKiJXtq
	PoW1zcaiYWzUJ8noBrklGFShZcSJoM/hxnMNNtIteLBjvxoZ5Gw30Ob8iyLwHRSFMz+imU3qK+mOK
	suVOZle//MEs7tw2CrcMOROjP6RxvgyKVmaR2kBx56V4VBjZ1W1xv5RY0J6su/JE3txDRHJzCOS3P
	hrHzm8/Da2vNFrEMHUiRv4eY0v2qlntZa6wHTS5SZmvm7gYVdS2Rovl5OFFjUXc+1R4K1FkAXDBni
	qn1sCYeS3QAQ3V5go3I69ScftOI8StDUVCuk5HlehvF6whMCij7JGC8rd13bPpZkpU1Os9WRAX8Hr
	wX6cbLgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssOe3-0000000FMxL-1S2w;
	Sun, 22 Sep 2024 15:37:07 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssOe0-0000000FMww-31t2
	for linux-nvme@lists.infradead.org;
	Sun, 22 Sep 2024 15:37:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 97179A40EC5;
	Sun, 22 Sep 2024 15:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9F2C4CEC3;
	Sun, 22 Sep 2024 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727019423;
	bh=wzFBalLByJ99n8/R64qcr0eBTHtm0s+ODMdkp44xeBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzK2Cvtnc83ZIeujeSwznPzcMp+mnJvcEt4gba5JLn7YNiFJIjwia3GSPCsmToxme
	 m2c+yZhh1/1MAmogDrhfiyhs47J1OGMJYjaeYP2cdHZ7ZuWCRAHJ4adtqgdAwPqfVT
	 fvga82JB93HlEciMhn7sq9spbL7KrduHQfBkV8uyQ6EISlDm3KZfh2gE3CyzfzSvKy
	 JAdOjItT9+dqfeHMKuad3YDigTnstR1qmJn8NzabbleFyeZr2xi5C83M4Gq8p+ymzx
	 wNjsDe8A+89V8tazk/TbSwPhvobaytWicGyURSEyDxiui3/XLxdpg/nwoyjERKhYqw
	 3TIam3NtyYBJg==
Date: Sun, 22 Sep 2024 17:36:59 +0200
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-sysfs: add 'fna' attribute
Message-ID: <ZvA5m6D0_tA-qKC9@kbusch-mbp>
References: <20240921154707.4362-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921154707.4362-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_083704_847680_65D59C60 
X-CRM114-Status: UNSURE (   9.36  )
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

On Sun, Sep 22, 2024 at 12:45:53AM +0900, Tokunori Ikegami wrote:
> The fna attriute is needed for the format NVM command.

At least for multi-namespace subsystems, I would agree knowing this
value is important to understand the potentially undesired reprecussions
of running a format command, but that logic ought to just go in tooling.
And the meaning of the reported value here is not immediately obvious to
a typical user without the spec in front of you, so I'm a little
skeptical on exporting this attribute.

nvme-cli already checks this on a format request, at least. You probably
are not formatting very frequently anyway, so avoiding an identify
command for such a low frequency event seems a bit overkill to me.

