Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6852AC001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=at8qZJllNklpGVvIglzagPpypbwOZ001CdqDVCWZu6k=; b=3XSQ03qY7diiRb4NYQwC5DT899
	P2XX8zdhhWVkuxSRyPwm/Nns/QELbzhehRO2yX0mAZrO9x76gc4+Qc+8D0DZK/v/bi3dtYxYfGPrs
	p2LHpnDMLHNg73NfYv1cIsDzRVc4ZDKVkzfQTNB+hLxTasfHmCSBETghPFYpDmygw6ZuK8tukF38H
	ii0liJo8c7D+rYrmOYh89ADDaGAUgt4ENL7nFPrUpB4U6anUWQTC+AKWGpw175+0dFkRaicZ7B10X
	m2oO8+VxVyZ5dzBbGS30/ZCEn9ShKK5CuLrxdNn1l0yh4HfuqJcX3bUFlI+AfuRR+i1v+aeIl2CRs
	koaWefKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOv9x-00CQaW-0t;
	Thu, 27 Jul 2023 07:11:41 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOv9u-00CQYX-1m
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 07:11:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F137921A5E;
	Thu, 27 Jul 2023 07:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690441892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=at8qZJllNklpGVvIglzagPpypbwOZ001CdqDVCWZu6k=;
	b=w7UDgFoQSOafNyVdsVyqv/2IIJgCUEPKxyO6lVBGxD2hkzElIAWs9IXUBr2sCFROV55N9N
	p11HN0kvLet0EapcAlhM56qUtMNDb4h4afvc0mACYm6uo1q665exjOuQuDHM+l5c3fnoEu
	ISIOteqUwr9dXDRLGhd9m3iUlXNIx/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690441892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=at8qZJllNklpGVvIglzagPpypbwOZ001CdqDVCWZu6k=;
	b=y3J02R5VwGsZCFslJw1lvKSEl5FQRLBcjcU3HlZVi0UhXYU+IAvHBxUtrKec8eIz1S5/0U
	cqaGUlNAgZ+wyWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2C7A138E5;
	Thu, 27 Jul 2023 07:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id L5vVNqQYwmSeKgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 27 Jul 2023 07:11:32 +0000
Date: Thu, 27 Jul 2023 09:11:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Message-ID: <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
 <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_001138_755650_FD7405A8 
X-CRM114-Status: GOOD (  12.69  )
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

On Wed, Jul 26, 2023 at 07:54:24AM -0700, Bart Van Assche wrote:
> On 7/26/23 05:46, Daniel Wagner wrote:
> > Group all variable declarations together at the beginning of the
> > function.
> 
> An explanation of why this change has been proposed is missing from the
> patch description.

Sure, I'll add one. The coding style to declare all local variables at the
beginning of the function.

> I think the current style, with variable declarations occurring just before
> the first use of a variable, is on purpose. I like that style.

The majority of functions declare variables at the beginning of the functions.
As you can see these are only a handful of declerations which do not adhere to
the coding style.

