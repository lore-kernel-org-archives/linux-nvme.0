Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4398EE49A0
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 06:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLiTY7kyVnVlx/it+YhyIz7mPUa8ybbsHmAK53uaOlE=; b=pQD9GJMFEBiqWiSAr01dwVvJ4q
	tGjDEMXQYcgjt1q3YRMqeIPVZ47LS9cMN2b1vrhCPCftFecGZOPdAU6ZwWxtWeI+RCM+Yr/P2/gvI
	hXktv//BsfVFQH55E+J2fxLpspISB7sd2AE1qG7wlQzW7JAWkfh8CDpgsx71lCcH6ctjPsQmMd3U+
	UNraApJynDfWuJ8gSx32W0Ft9Mvc+ZuQhINiBPcSyZ8Y7Cs2DBEq3T5Z+rzFH10ARcejkCUTthNfN
	42fvdhvvjJPeJ7kpTHyCKKAfjt2RITI+6VEHy5jIwwtg+AD1uTZ4XyCNiF2SlOFIH0bdrIN8IYttp
	gsCv1ehw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXy5g-00DE3y-29;
	Mon, 21 Aug 2023 06:08:40 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXy5c-00DE3I-2g
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 06:08:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72C0F204BF;
	Mon, 21 Aug 2023 06:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692598112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLiTY7kyVnVlx/it+YhyIz7mPUa8ybbsHmAK53uaOlE=;
	b=BpOixEM93ibOvHy5R5DwjIy6tSVL6BstwNe4J6azbRVoVWgih3gK+Kqs47Y7ZG6rbwwqfM
	OBcYxJ91bwBkV53JWWBrwgbAOrXM8fgc6Dw6EkkM4TUvpeU8SgeLbtCGRaObYGPwHIQAvk
	US1U5N4HDkDVZgDvvy2e5gV6Hfg6zAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692598112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLiTY7kyVnVlx/it+YhyIz7mPUa8ybbsHmAK53uaOlE=;
	b=urLc0Hy0o7cwfgV9YOmn5tpg64CyYzgf2w4eHi7BMvMray8pHAU6/q4Zy6Z4fKJZ4fCfx+
	Y6ih3ndYSzfCruAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6458913421;
	Mon, 21 Aug 2023 06:08:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yQlwGGD/4mT+eAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 21 Aug 2023 06:08:32 +0000
Date: Mon, 21 Aug 2023 08:08:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Message-ID: <vzcluo7jktlrut4iavcdyrsdedcg4cpsm72ewuqwrq2sjqkce3@ik3imkps3llf>
References: <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
 <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
 <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
 <b4fe7c1f-1581-bad2-9203-6f4c87d6a599@grimberg.me>
 <69b5e07b-f16a-0a9e-bee2-28877dbecab3@suse.de>
 <0569a67e-1264-1dcc-d44a-23bf8256a9e9@grimberg.me>
 <3wmt5cd5yd5ru3uzp5grcspkvi27ijztnxwxhov7chmf6wicg5@6dj2qed6ulja>
 <e797a124-ac6a-0205-65a5-9806c6955d4c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e797a124-ac6a-0205-65a5-9806c6955d4c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_230837_034928_12E5B32F 
X-CRM114-Status: GOOD (  25.05  )
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

On Sun, Aug 20, 2023 at 01:55:47PM +0300, Sagi Grimberg wrote:
> > My gut feeling tells me in the long run it's good to have some generic
> > way to inform userspace of options format or feature changes. I am
> > pondering if sysfs wouldn't be the better place for this.
> 
> You would need a global entry for that, its not controller/subsystem
> specific. For that we have the misc device...

Ah, that explains why we have this interface after all.

> > ...,traddr=%s@v2,...
> > 
> > If I got this right, the current libnvme token parser would just ignore
> > the versioning string.
> 
> I don't think that this is a elegant option, there would need for some
> documentation entry for what is the versioning stuff. Plus, a
> feature/capability may not even relate directly to an existing token
> necessarily (if we generalize this).

I agree. It is clumsy.

> > Obviously, the simplest way is to introduce just a new token and be done
> > with it. I somewhat don't like it. Maybe I am trying to over engineer
> > this.
> 
> It could be a form of token that can emphasize its not a token like
> ",feat=<feat_name>" or "cap=<cap_name>"...
> 
> But this would definitely need to be done in a way that is compatible
> with userspace moving forward.

The libnvme parser is ignore anything it doesn't know yet. Introducing
'feat' or 'cap' is not a problem at all. Also it should be fairly simple
to add. The resulting code is likely to be very similar too; testing if
feat/cap or dns_ip_addr token is available and then use the dns name.

Given this, I am in favor of the feat/cap approach.

