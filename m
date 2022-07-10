Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55733C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jul 2022 18:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MIGqqhowEbDUWV0HJr7lCSvMFT75jzywjFqHps3gtPg=; b=zM85DbG4ajKT2wMOb1xLrUoPw7
	4x6BfPzeSDhw1/MliySeJMpjai9vzW6gdmFqRPZfGRstjCzOocK+S9I+wSqSDRbuumDsa6o+b+0iJ
	DtSg1wLAiN/uiwL2uQZkizYwack/qzRWuAChvoPnIdssZ6GyRYA78O2+XHLZ+ObSTRuQRt8g1P2vO
	YHitkFsueiwEl5ucpUrzQABz0IZBuSHEfnqMZ4gDT5TUOCRbDyFxLBxK5QFk+WZc5Z6ULwOHNGjs0
	PoOaa71JigoNowvW2NneGB8qAgX9mPAn99VoziIgn6ulNJ44AOSs+EXALjeTrk8jPwnjgclUrrswU
	RKp/Md9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAc4M-00D2fs-Rt; Sun, 10 Jul 2022 18:54:14 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAc4A-00D2b2-Vf; Sun, 10 Jul 2022 18:54:04 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id F0F4932003CE;
	Sun, 10 Jul 2022 14:53:53 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sun, 10 Jul 2022 14:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1657479233; x=1657565633; bh=MI
	GqqhowEbDUWV0HJr7lCSvMFT75jzywjFqHps3gtPg=; b=SmRnR9YwRgWNViYLX8
	7DCP6zmvbRqukxKnuwIw99hBfEvpzNdhWrL8EpQ1SNscRbCu2EGbbVc3dtlP9eHF
	OEowA+imBVOHMeM4uWOdNcJCcVGblPPXwyXBTAs9HfMyHqyS7OHjRHJEToJnhgpj
	19XIXTKMRPZS0uvu5Iq/gYha7XGkS1kN8lk7L7hfDVmOjbZKnCI/HSCY4yBWPGZv
	53mf39tplAlezjA+lxorK0U5PV1P/m+rCdJHcxMp3B7ePXczuYilYvwQpZeISIFh
	L0CSYlGz42f3YYh+IaiSdyJmzNZg7LGLLswWrahMN0e9qSCuo0yn8vN+p5bhwuHX
	8E7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1657479233; x=1657565633; bh=MIGqqhowEbDUWV0HJr7lCSvMFT75
	jzywjFqHps3gtPg=; b=MUe3xmgI+SGiZTPiK1HAUnEvYI27th+SRe6LZ0JIK8ge
	HmdNAEZz8VUNaXmjZJd6AeQBb7MgCWjUlT37LDh9NXCDnXspIFhcCz48W1DN2D2i
	neD16JADuhgW8UKBjfIuC2Gis3btktl0QXXU4XDZ2pC7X6HYA2qrRGGf7PqbfXdi
	KWaxlWOL1c+qfrkxm5m+DTmFmZah82pkwx5UCsJ+VeY2c9WPv2tinEpPDOgHmHw4
	JTNnC3EnoPrlB2YpDY27m1O397pLVqRc7r73BLEBzoGEPYFDEJ2HCTTK2JREERVx
	7K+TII3lvK0CyOFPPzv1W1PPS8V3tjl5iHqiMBtmMw==
X-ME-Sender: <xms:QCDLYp6w_REEeaeiCrr-bkgxPYLuPu0SSMkIsthZG41TJCoSQ3Z44w>
    <xme:QCDLYm5DULOgI4zet_QVHbkIXB5bq7hMOZSvmfqE366yZLBZgAXpPSTxNHTDnbL_m
    WapXNPn4pOk8cTrP2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejuddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefg
    hfeiveeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:QCDLYgfiifpZuHYpxnAq9WJKrG0LUVSFE09UB11iAIQtLxIk3vlMMA>
    <xmx:QCDLYiLzHkPZk_kmwDt8or0kqXjzTpQPAJCgcXmBXK7NB3rI-lTB4A>
    <xmx:QCDLYtLVOT5IZU356_ULqGSEZ-n_ZXHcRa1KJqlol2K4xT3f2LcizQ>
    <xmx:QSDLYiqFKehtlNoI13qnzp3E5KJxzLCp63tABgZsPFC27cYu_mz2jg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1074CA6007C; Sun, 10 Jul 2022 14:53:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-720-gbf5afa95ff-fm-20220708.001-gbf5afa95
Mime-Version: 1.0
Message-Id: <48ceacf9-daef-4d4c-8856-8729d979458e@www.fastmail.com>
In-Reply-To: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
References: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
Date: Sun, 10 Jul 2022 20:52:30 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Guixin Liu" <kanie@linux.alibaba.com>,
 "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "Philipp Zabel" <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-apple: use nvme core helper to cancel requests in tagset
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220710_115403_508164_BF922C00 
X-CRM114-Status: UNSURE (   5.62  )
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



On Fri, Jul 8, 2022, at 05:06, Guixin Liu wrote:
> Use nvme core helper nvme_cancel_tagset and nvme_cancel_admin_tagset
> instead of same logic code.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>

