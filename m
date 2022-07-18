Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B49FC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PguC9lL9lNXpprqzaAenF/r4bQZZwT7KM/B00jxMqRg=; b=I0r2eeT81X5hj0sE+k1JO7WjXs
	U1Nozr7dhOmf/EWisNX3Twuia2ba5cVvqlUPCK3G1AfYdKtvdZSNA7by79aj/JKtJSlwlwdTxDhgf
	W66Pxn1B7ST0fki2vIp6DKksYyE6BQSCcdrI/fNOYGJYTcCvmKfMunD7QveJB8fodr4dvTls5aOzV
	ZZRvchp7DM+np0+BsDppJ5lwDWpfIlaA/XuxbwBc+NtpucPKBA9goB3ANaic1ftmOMdwq1W6zXLqn
	Lqa+uaIF2IZ2Avv23Uzaxd4+f2B65fgPMBVRoYm7ch9x0E+XfXG919lc29SIC9ZD7Lc5wljYBGNlr
	nx/PEu+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDTBD-00GTDG-LT; Mon, 18 Jul 2022 16:01:07 +0000
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDTAx-00GT2Y-Mk; Mon, 18 Jul 2022 16:00:53 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9EC333200344;
	Mon, 18 Jul 2022 12:00:43 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Mon, 18 Jul 2022 12:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1658160043; x=1658246443; bh=Pg
	uC9lL9lNXpprqzaAenF/r4bQZZwT7KM/B00jxMqRg=; b=mhIcms0o1gX72P96t1
	QeKdb1FoL9F23ArNNpgCAZl5EPyuVk6TN7JLR9VIVtz5CihDQjZXxxX9WF7KmhCP
	+jsUXbf80oXBdBFT43yKAbh43ZER9m1DV+GlY/sMgDS6CWnL0sx+0ntmXDjKNyVx
	zPcKq8dIE0D2WGaHefDqq/R5igVkRFaS199RyUxk1R8Fr/9/ESbyEula6eX4s9N9
	44W6lT9rAKu6yPwtMK0TeDjQj+o0OLHonsK5CAW790D7s8G67LViWNG/uK6Juyhw
	AgOWznoWiZHGfbdJpOCcllxabQByhl08w+cAkf2bRNIWyJxO+WnK6tR0bOYkjuWu
	Pg/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1658160043; x=1658246443; bh=PguC9lL9lNXpprqzaAenF/r4bQZZ
	wT7KM/B00jxMqRg=; b=g+Z3HcJh+K/p9KMxKGVhFrXs97w4sDh7/yEBFuWEd7wr
	HySQk5ocvkl6QgfcZQ9csMniVjJCUqMbbmWpIGmOuk/F8QDr8dA2xFP1wC5LjFKp
	bAEY9PdapkPcJ/ZLZL8tWTeS/abYn1V9/67243PGma1Awue6DTQCZbtdJ6FS8ndJ
	uNJrjgzK20SxTzdKK/3wwT8MA/DOESMHGYyKlqZfmk2paBdV3fVNOqyeuIVCfDp7
	PwLxHXreVlN7RA9vTrmFStZqhOwc8hnAMwaGOEfmgT428U2LGJKmUwd8xik0lbEQ
	vszry9cjghm6hML10iSjyDmt0e+mbkaoeOlp0pQNHQ==
X-ME-Sender: <xms:qYPVYtoezkxmi13lLQMcLboGYbO9cIhWhgwdwe24nCJ8GCgKuFNhrA>
    <xme:qYPVYvoaaai3QuJk4DiQaDp0r1ZgKW3M7EsznNoKeLTc8c-4y2BNLOPbaJ83hY4xg
    efJeVxUTwhhSG8VWOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:qYPVYqNw1cT7EyF-QAk6LcX2k84sRYZs-HhK9yE0_SLTRkrhdLl3LA>
    <xmx:qYPVYo7TOgfhywUjcMi-b4piKyE-yPvPl9yvi_qZB5oq9Fnd_L8M2A>
    <xmx:qYPVYs5rSVVeOUeUFJwYSjTFOMWb01xLfaX_WvkvHMeJRYQ2h2dQaw>
    <xmx:q4PVYsHk_NsxYdlwPab0Hmqa82PWVP69XxfFO40K1otYMfwNxGO_cA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 517F7A6007C; Mon, 18 Jul 2022 12:00:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <cfb2ddcd-7b64-4c81-8c60-ebb2068b9363@www.fastmail.com>
In-Reply-To: <20220718050500.227804-1-hch@lst.de>
References: <20220718050500.227804-1-hch@lst.de>
Date: Mon, 18 Jul 2022 18:00:41 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "hch@lst.de" <hch@lst.de>, "Hector Martin" <marcan@marcan.st>
Cc: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 linux-nvme@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] nvme-apple: stop casting function pointer signatures
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_090051_996666_B3EF4381 
X-CRM114-Status: UNSURE (   6.68  )
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

On Mon, Jul 18, 2022, at 07:05, Christoph Hellwig wrote:
> Casting function pointers breaks control flow enforcement and is
> generally a horrible coding style.
>
> Add two wrapper to get rid of these casts.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sven Peter <sven@svenpeter.dev>

makes sense, thanks!


Sven


