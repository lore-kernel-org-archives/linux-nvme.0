Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCB7C0032E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 08:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DHIA6dDjWGSNxQNfREI1yI6JJrWqioeJnbD90s/gTU=; b=EgzoM/b3nY3C8qDGrPqqEowmPj
	NieeoRmcqdgwAX4KDxF1K1jAzhm4kQdq5bFW2Jag4i6i6CFB2wHp1y9gtuuz8wFjmVOd4CwWIlz7j
	mktGyYhVxFnHJQhJyA1M3c754TcMLcZ2CoPkbPmyiJhVpNq+yFhK7HynEEzBP3qRxtjV5w4mEOr16
	eTLddiHMf6SBi7jaV9MEGBfaelZ2w2pXKlWVHlqr72bCrKj1tRtF70CaItOa7vwZz2QTGBzx9HlIW
	/XzDPzSbevC73q/JsLzDlexftY3rrzZ+EQf3vKy6iAAgsgkqaFj1xuU+EPWM0sbBKwaxteNdabjWN
	kpXmDwXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZ8A-00Bgxf-2Q;
	Wed, 25 Oct 2023 08:20:46 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZ88-00Bgx4-1J
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 08:20:45 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 48E923200A3C;
	Wed, 25 Oct 2023 04:20:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 04:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698222041; x=1698308441; bh=8D
	HIA6dDjWGSNxQNfREI1yI6JJrWqioeJnbD90s/gTU=; b=dnD4nwIV+KkClcaXKO
	dPl22Lp1a3/3mKdA8ABRbleNGQm8T5Mq6/rLKkWB9uoBERrA3NT3khWFSzpf56ir
	rzXvis6e4IZy15UWH/sZ6x6Ez2ucEiNi0aBwH2hTxfj5e0K3k5QlUdnYMtea5tcS
	pxj/tBNVzFAn8VUTO629KfOgBZKKNmmTWxv6CJcgpQNsYqv8DJw1siwfDfAobIcj
	9Zt8n+rj+c264arCMI/U8T3vpEodPRpr+ednMAzYJrPrUBxscYAJmjMQ6vMvXEb3
	VbX/PT4a0AB9bVoXjZXAQ932+dcyJC7ON0+dI90kUGBCmVUbe0Jgj9GXH24QdyXx
	8NYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698222041; x=1698308441; bh=8DHIA6dDjWGSN
	xQNfREI1yI6JJrWqioeJnbD90s/gTU=; b=fvdZGLPEzvUA474snSiMh01AX4xlK
	Ihg6hJpqyzEY4+4iV8L2fzrawv4euGO7ROfv94tL4xJKhc3oVDsNZIMY1W7B/kRE
	pMoNZz9153rO5kR7PLmgacJUSP8JdmYIK+29BvbXmC3OupZWRs2crMXdlA+PuFSg
	4GX80wXdSgbcRUbvljVQLC4ew1bv0MoP0Q+weOLtoq7D/4R8g8BFSUMFw1WdSlwE
	CcvP1UiMG4+wZMbj4Yh7tG9o/TqfsQxWaAz9tPweR4rKcSZWOCmbExc0sg8zCYLu
	Wbk1bvEvL2CEZkiPmQhFlcjjD6yfTtYiGoUsgf+/3ohlE9tuRPxopgVPQ==
X-ME-Sender: <xms:2c84ZUPDR_Zrs53WQUxlNOn47dsIPYO-AZx53XaWfFwtWM0yNTMSAg>
    <xme:2c84Za9xtrmb9g9kGGIG7tw4sHRFpQ_TJ2vD6O6D1007CxYN9t2VuM_ch-YivYmi0
    xgHBa4UnCmXRW7q_Wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2c84ZbT5hYPjE-Vnd35LUuZSZDVHKdMIZc9j_oFbANrEyCj5Me5GAg>
    <xmx:2c84Zct1Nu0bt0dNmdTfNEIe2wYBNroKfXPwwtyha_GSts5plE1iVg>
    <xmx:2c84ZcdNbMsqQOYAZ8wbEu9d9Lm5c-i98U3OB-Q9cVzChtrGggg_Iw>
    <xmx:2c84Zdqs0hCnfrsimGvnlP6-DVD3Am-40e42ZrgdRsOTphrg-WTDMw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6C417B6008D; Wed, 25 Oct 2023 04:20:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <2d945ecf-6313-488e-bed4-26d87df0f61e@app.fastmail.com>
In-Reply-To: <20231025081253.113738-3-hare@suse.de>
References: <20231025081253.113738-1-hare@suse.de>
 <20231025081253.113738-3-hare@suse.de>
Date: Wed, 25 Oct 2023 10:20:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hannes Reinecke" <hare@suse.de>, "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_012044_478208_3D0E7C4A 
X-CRM114-Status: GOOD (  17.02  )
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

On Wed, Oct 25, 2023, at 10:12, Hannes Reinecke wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The keyring and auth functions can be called from both the host and
> the target side and are controlled by Kconfig options for each of the
> combinations, but the declarations are controlled by #ifdef checks
> on the shared Kconfig symbols.
>
> This leads to link failures in combinations where one of the frontends
> is built-in and the other one is a module, and the keyring code
> ends up in a module that is not reachable from the builtin code:
>
> ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
> core.c:(.exit.text+0x4): undefined reference to `nvme_keyring_exit'
> ld: drivers/nvme/host/core.o: in function `nvme_core_init':
> core.c:(.init.text+0x94): undefined reference to `nvme_keyring_init
>
> ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
> tcp.c:(.text+0x4c18): undefined reference to `nvme_tls_psk_default'
>
> Address this by moving nvme_auth_init()/nvme_auth_exit() into
> module init/exit functions for the keyring module.
>
> Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Your patch looks good to me, and I think this fixes a
separate problem with missing the initialization of the
keyring when the kernel has only the target driver but
no host support, but it has nothing to do with the changelog
I wrote above and does not fix the build regression
I described.

     Arnd

