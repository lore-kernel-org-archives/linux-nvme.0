Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48320C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 08:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y8GIcAPQNfcELzND28M03TSb2LhJ8Od38wXNJ5pgqUQ=; b=3iuOP8PZTQgppJRMaNgxGCthyq
	AnG68aPnXGSYfpTh23LXulHmOLU7xmB3R6l5ott0iFbE5Ny8oslZQJWPVfJmzJiGv38bBRuBQDzbR
	zj13Z35QFYH8aCfNI5kuFjcEMR/RHsAbrPAXTmsYI7HQZmCgi231dOtOy2AKlXlCPFju43rV2E2Iu
	T4SzdodcUvmvnj4iMeURbErdlxrT6SrtwnM0u8/r6INvRTMYKihm2jQAdKXDe6vPr0M+Yimvo6lv3
	+COz1nGY+r7rgY8c3mXIENvkLdQWe3gTIlrTkXK/Xym7bpV/x167KAXvbfNeZXEHQVJMjq07WK0fX
	mmYO3SMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poKTs-00FPox-24;
	Mon, 17 Apr 2023 08:45:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poKTp-00FPn2-2r
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 08:45:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E63E21A3B;
	Mon, 17 Apr 2023 08:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681721096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8GIcAPQNfcELzND28M03TSb2LhJ8Od38wXNJ5pgqUQ=;
	b=DOwTdoWe43YEBi65Y5SqlOO1S4CA6YOjo8fjJHTOXxfUH5KrSPwV3oWbONNdByuO7dxzd4
	J6w4mucgRYSw3Xf0+rr+Ihmbo8xCFJP1QH6CvtHCwFHeWxNFXhvmPXGUr2BY4XaYrt5HNf
	zM3LdTCg6xvt3T2i/u1VPl2knxmAAlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681721096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8GIcAPQNfcELzND28M03TSb2LhJ8Od38wXNJ5pgqUQ=;
	b=2zSovtwcHUUepFcZ04rjv6xRsh8JRIidADUGn+R6SghAsUptyvC9wLow0jW8GtaiQQVmi0
	CAnlpNN8WNsxEWBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ADC513319;
	Mon, 17 Apr 2023 08:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vIfnHQgHPWTYSwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 17 Apr 2023 08:44:56 +0000
Date: Mon, 17 Apr 2023 10:44:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: WTF is going on with the nvme-cli build
Message-ID: <sqrbip3dafgf4cnmmdziect6vem2msocsxqcqmnvyrlkartomj@ilwk43vyl53s>
References: <ZDemsiJi5vXd6aia@infradead.org>
 <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
 <2a464237-975a-bfaf-ef2f-15ffd45b4d8a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a464237-975a-bfaf-ef2f-15ffd45b4d8a@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_014458_070560_3D3C6298 
X-CRM114-Status: GOOD (  10.78  )
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

On Thu, Apr 13, 2023 at 07:49:42PM +0900, Damien Le Moal wrote:
 All the time... And I do have the json development headers installed:
> 
> /usr/include/json-c/json.h
> 
> But the compile command does not add -I/usr/include/json-c: it uses the broken
> default /usr/local/include/json-c. No normal distro install anything in
> /usr/local...
> 
> And that is despite the fact that meson setup says:
> 
> Run-time dependency json-c found: YES 0.15
> 
> Something is not right.

meson uses pkg-config (and cmake) to find all the dependency. I suspect the
PKG_CONFIG_PATH contains /usr/local/lib/pkgconfig. Can you check the
pkg-config configuration?

