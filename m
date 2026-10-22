Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43447606A31D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Kdp+DeE3;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=MBzYWAKv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QNazrkwv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRfdmrRzUcc8FBDDR8w5ilifQ7qCv8l38OpmivOBfdo=; b=Kdp+DeE3pHmzOU7m8Nq3dYCRI2
	c2xMXPKC5SUqnPgOlKx+//Rlw3eul8Z2VEWWrqxnZdiI2ku654pY/7Dj3P9YRR/sysKgCLFzwxHqm
	bm72iZt1HEPNO9N76ez+sUdLtFB6T+3ob7CeT8D/KZHrarv0ZdlOgXWU2TFQ6j0B6/8vQbQAFw+DV
	80vDnzXGsgXdnKu8xobzWkEDPlcncIArjv0UWVJ2P/DSzeTKxo9TBVjw5MTPHiQ4CRQm9CZUgk+kJ
	TgFxE2rXigmxXH7FKQfgfavU9JNYNdgdWXJLjMn0aVw59Er0ZqZgpgVS8u0hXYmdb2rjZsfcz/Y2J
	wPtbyZBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJkg6-0000000DL7D-0yZ7;
	Thu, 22 Oct 2026 04:45:22 +0000
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJkg2-0000000DL6n-1hxB
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 04:45:20 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4DBF7A00D2
	for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 00:45:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 22 Oct 2026 00:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792644312; x=1792730712; bh=dRfdmrRzUc
	c8FBDDR8w5ilifQ7qCv8l38OpmivOBfdo=; b=MBzYWAKvABiP6lK/PW5XgkudQ6
	4ik+J7zUoY1tc9gj3yepyRlbj2AqUOde+m56+avYWQ/pkwVKD6GZS8ns4msLU+1Y
	dbtyGvAq43dFg6pSZRMdu37Y/ljY2w10zcUDC5aVnZUKPrUc1Q6PAlYg9UbVtOe5
	aQqHaYRCf2B6uJBljhso4jYb2CJ3T3Scb/bHCTTQk0mbdt2k3zSV1NPtGCoODnlR
	G6PIjAMmTRcQU5gXH6u8eP+3rtD5i/Pr/XejosE/yOpQ71oXsZ33m4aeK4aWgYUZ
	PO5/ACRlAf+J/5ReWzPBiMBgWxg8rK08Sofoi3+PYopPDOijT3ABZt2QNRPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792644312; x=1792730712; bh=dRfdmrRzUcc8FBDDR8w5ilifQ7qCv8l38Op
	mivOBfdo=; b=QNazrkwvracX757UGe087SRtqy0IhFi4BaTqGkQpM59hoJBWDyt
	ubi6np0dPw6Fqfo56uiAJh93ugC1CvVSU5vwCfl4hXdbnfwetZhKvg5zjSBnoTh0
	jmXwcytG836mlL+6umar99MRcwYw2AQMBCVynS8EmU3c0+/K7JcS8z8QYRPcfB1B
	Wfz6WDz0ePya9WhpX8aP8jHLFmGcqRJkl5kbWyVWNAd26O/saC0I4tyLrdmCsszY
	Zyic3/Q/wRju53atC8P9mP0bBp9UEDlZzadkeSrHMKuNycVAjeZfBOQcWV2XatDO
	0m6YfjqP2IoE7UL+b1xLoOTHywa2zlnmxnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792644312; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZz4=;
	s=fm2:rsa-sha256:O/Bdp/EMDeFizHKE8WbrBIcW8ry6zuPKwbqkAFwnrVWvgP+
	aSxPwH1/aFQZwCzUE9DVlkD/viRq8C2pvul4kkgMdp26rHGkcGTp0YDysnQ6BUkM
	XSWve3ZhPJgpWp24axCoo+XW0vHGTErIm7PRsrEfcHr3U7xEEzeVQUqxyelUQkj+
	DqfKrzmBA2iNZ5OQ6WUXEUxzwzpV2VEiQ51LuiQSVj82TRB4ixJ9N/lc/Btk8JIv
	2eZxtB/nSPrPYk5efBlRb1jGMhpuQ0ohY0gmVEPFt2GOJ7VgL4TKyHmzBt30VjGD
	Q6A11Mdd6G2A12ae2eJpiPsY0Xvq6Yj9F+vMh4g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:anSg47xLwUn3hN5HkxOCR3bSMijeTxQ9konbwJ0+qBk=:dRfdmrRzUcc8FBDDR8w5ilifQ7qCv8l38OpmivOBfdo=;
X-ME-Sender: <xms:2JTZasuzUh28fkm4pqMMx7I60Qwls6DSpZZo1JHUfw14KJAmRnqDqQ>
    <xme:2JTZal1vw9NNZp-XaZsBQWKGWRnZ_K2k4Zpxm3uUaHMuhxMJ32OAeHYQlNe2GLsEq
    nwfLJiEL9dnu7QvEpSlId58c56tRa95yGaRikz-yqZ57nf5Qw>
X-ME-Received: <xmr:2JTZasOJu1LUfZV0sFg1w3PB4heOin-u_cRs344UuihYZgtDAnzHA8_Hj8lIY-koGxwrlEa_sIlPURUq0gs>
X-ME-Proxy-Cause: dmFkZTEMJ8jUayE0SkYB60BWWXFMhYpucllnxsu4phTjqCCNrJeQuSu8elHsUInL677RtU
    cwdERPrgcA42kg0PHszTja19jS0ahLyGEJdpJnCh8a5bbhcWzIt0O2UhSYoOdXOC2WEhlF
    NvByIgS2LziD0NBL763v2GR7nCG/Nfh0LWK2FGcplIUwLtEd6T5Dzqf6xPhr7P+NReKlDc
    yV4n1mniu4z9ohJqo2lXjBwNeb8xjHQbaHz0DxzJFGusD1NFyy6u6HteMhWMmLXEYVJurz
    7wMHwLJAPXBIXUDxDw1EFKUOlLXX5hVYkbtFIfkCpLHKSIQt9EbgisIcaybmMcU54cgst0
    IyZHMmzKmVptB1hYyoH0y8U3RD8O4x7M+LYUhMslZyZ7TIdtPPnOsQUX0jkmangUsRqRcD
    G405wfyoSxQ45FTl+tek+Y/VF7cAYehNloImN0UsMYbxtbPCQxBs817jVvExv4IegpqZwn
    dwht0ET35xcjz3Qaya8okS7MyTzaqAx3nXaExgFOHnwkJBGndM/qod1kqTuCV0HaeXhbml
    e6MeII7+eSRFLfVuiL2sOYx/+MYAU8V+KePkl8VS8x7mGFdZVeFsBzrWQEseift6RXVpon
    yg0CAzN0ObiwUW4tcRPK4g7NdIoc18E9C8gWMbBBmw5z7vUQapS/S81MH93A
X-ME-Proxy: <xmx:2JTZatXul1hneuVJWhYY2enNfcSZAd19KGPYPakrIfha9pd4fZAbgA>
    <xmx:2JTZapauZsgoRC8ttv9h07QwHWIwrowMPOPpH0WxDJ6ofYEJHsVpfA>
    <xmx:2JTZav09QrZxEAmdadoQhvuuyUm_CxMTnw6dCBztpCFJOEF4HAvrUA>
    <xmx:2JTZatC3TD0tFx1A2WtSx8vVYB-If6hOm28_ACBSIcMPZRUZmK8-ZA>
    <xmx:2JTZat6269rAKQNxPGOPY_kfbHNOpVIao61S6u94K7dFmjfPpjpdoaGJ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 00:45:11 -0400 (EDT)
Date: Thu, 22 Oct 2026 06:44:40 +0200
From: Greg KH <greg@kroah.com>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: "security@kernel.org" <security@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"open list:NVM EXPRESS TARGET DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: ZDI-CAN-34076: New Vulnerability Report
Message-ID: <2026102226-duly-imprison-a2c1@gregkh>
References: <BYAPR01MB3830CA9B77EC6FF73C27C2AF80662@BYAPR01MB3830.prod.exchangelabs.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR01MB3830CA9B77EC6FF73C27C2AF80662@BYAPR01MB3830.prod.exchangelabs.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_214518_793876_F5AC539C 
X-CRM114-Status: UNSURE (   6.07  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 09:27:25PM +0000, zdi-disclosures@trendmicro.com wrote:
> ZDI-CAN-34076: Linux Kernel nvmet Get Log Page Use of Uninitialized Resource Information Disclosure Vulnerability

Again, no patch, and sent to a public list?

Please fix your submission process...

