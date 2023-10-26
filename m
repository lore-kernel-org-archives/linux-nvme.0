Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330B7C25B48
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0b8ITDruWBVVJLreb8NRQa5lE1kK89PiW5sDOFZwMmM=; b=dnCGQ0xDzS79mJx0mf+R57TQ5g
	T4xPoI5XwrVk+cMNei4/V6CJeNkfqnltCUqCWB0y3R0NNLGIhIiH3oe3YfLiqxR+A/kBpGWlvhnpi
	jhFrhalnbPtE01iEBzzDIhmBBwYm/o84IdBHp2CybgrS/FCQivRJcUDtffdCG48FsIcNXy03k59MR
	4F9jde19QxK/L0aygqo+0s/281ToCt4Ejl2TpLKkbifi5L+kwS26eFkMH3r/FA9H5gbFiYiRSIT9S
	IxqBKccCukFh8KFTOWf3uEcDKBEFwLFGGp0So7Ow6amHpP+GqLyDL7KUXb2tHMki0/hFakG2CReYH
	wtH3qBRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0bD-00EZcR-1D;
	Thu, 26 Oct 2023 13:40:35 +0000
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw0bA-00EZay-0n
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 13:40:33 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 07AF25C0253;
	Thu, 26 Oct 2023 09:40:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 09:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698327627; x=1698414027; bh=0b
	8ITDruWBVVJLreb8NRQa5lE1kK89PiW5sDOFZwMmM=; b=Co7cHDqSSHyNb+EabX
	oxF0NjEuw02SVFO9iORFejrVPuBqzaPXWbZZJXM86NFFc51fjVnI7EoNCblboST6
	i3h5lFSCva6JT710UQvPm+5I61JMJsn/bHd59KugNOBNTpWbaZQTtMaR9Q4Y6Ez+
	8glVK1LOaxhr7tcMVjvcQBmOynkWQSbL7W8cBNVy6bsh5G7z/zc+hsRZ/NAEGKBa
	lexqYjMDgoRnjVNGRbDSfcew3VXlDG77zGpTkGFv+8kfK9ECxknLCuuuP8owNzLB
	sbFu4f6VF90U/Bllrg7ZB0ScR3XtLD4kC/DC6e5F/WI9rGemUHeqQSlnK5W33gW8
	LaaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698327627; x=1698414027; bh=0b8ITDruWBVVJ
	Lreb8NRQa5lE1kK89PiW5sDOFZwMmM=; b=MT4iwSa8bYDKOTIw0BYtn4KmKKsNw
	M+r8pfsXW83HuwByxD3djN5vFIU5IDumB7ixnbgJry4Ku/rM0G+4p+hbyiJaSNbH
	KRvtT5pBNq1Ou0m2B6avHiTzVEthg0WvJsbKNRBGbjl7Ed/CAQmNBNYFmBSpuetK
	0f1UtZoUaVFRJ/iJLAbblxCqUz8qqD55MoBAw+YOL6SI2O7ek8idIHkPBxWeEyue
	LbCjxxkSil71yfdTmATmE8eAa0VEWybxq1dpF9LUBT+f+DhGrMGaf7cCc0AiYRS4
	1Ob62bWus92fI/hrvDFWNptYW1wajec3h4AZJk8k2M+hmlggSEi127JEw==
X-ME-Sender: <xms:Smw6ZXysVqAwqaIiIkAwj725J4fzWhjVpILYsbV1UY4cVluh-AaycA>
    <xme:Smw6ZfT0JPb-VnCwQGLqis19nMK_iRvsrcC8v1yHE0brUGuerHv73Hfh7yd1cEZhG
    k5yndfXaEguKEfxqKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Smw6ZRXcH2JZS2NERSh1MYnmpQD5Iz6fY02P8XWr3uBw1JrEicPNaQ>
    <xmx:Smw6ZRj_isUo19BvLN0-WZCxDU1HM2FvXiMMDIlQtDOMQxRCglyA1g>
    <xmx:Smw6ZZDxwTOz7WTPIz8bgM7-XVLzDpK3ft94TRBZ9YZEQrmj1AvONA>
    <xmx:S2w6ZcOgozfvx_E6U9qvGWNcvhCzfmuhSuwc48tIJpB-wyjIfop6ug>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 84C4FB60089; Thu, 26 Oct 2023 09:40:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
In-Reply-To: <20231026130804.142586-3-hare@suse.de>
References: <20231026130804.142586-1-hare@suse.de>
 <20231026130804.142586-3-hare@suse.de>
Date: Thu, 26 Oct 2023 15:37:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_064032_492937_7EE69661 
X-CRM114-Status: UNSURE (   9.93  )
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

On Thu, Oct 26, 2023, at 15:08, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
> index 244432e0b73d..96031016079f 100644
> --- a/drivers/nvme/common/Kconfig
> +++ b/drivers/nvme/common/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> 
>  config NVME_KEYRING
> -       tristate
> +       bool
>         select KEYS

I guess that's one way to address the link failure ;-)

It feels like cheating to force it built-in even if
both target and host support is in loadable module.

     Arnd

