Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D47C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 07:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1jx3fHLv9cnT/6JpHh6Gcjioz/Ao8bJ9Z8/98AwhZwE=; b=f5UW3qq793ZAFzPD4l0elNPvCQ
	Z/i86pBT7sNFCjr4hKGrI8ycNkU7qw+FuCSkNwezFPkrx+7hDxV5jOVnWGKn70c7XqUOG1Y8ED+bE
	UDbBlMrkBgg4JW0hoeVhGCuv33bwUU7GEY7s9bpHlo7wMw5/1B994FB5nVsYoSlCA9BIzDd/pqlh7
	Q2nh5asv9vnMRGhmJmNZ9Ujv+iKNZ23hBHfObbahNTqrYYGwagyATlgjrZZ9F0M28gsxHnAA8auQ1
	8uPrXJ8WHwuczBhHuQ++64j2U89fIXgkTU/K3NTOtOrb30uaEI/rWJWgHwnTrq9c2um218HPydTNk
	SAgJfnRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmr3U-005Dw8-1K;
	Thu, 13 Apr 2023 07:07:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmr3R-005Dux-1A
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 07:07:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61EE421883;
	Thu, 13 Apr 2023 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681369650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1jx3fHLv9cnT/6JpHh6Gcjioz/Ao8bJ9Z8/98AwhZwE=;
	b=KbP2hIqpj1QH7h3lhZeISQ6Wj0LDp422yxgwbPh9K44bC7f+SiWXWI4dzfKU+3FjLMGsiA
	zuK6fCKCetTjtvPZ3JHm44yrDpFZsYDkW8RW/IVkU9n21ABZ/+P+seaMymKiEKL8W9X27B
	/LXngu7UoAJJ+Z0oXOItIkVBhrNvntE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681369650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1jx3fHLv9cnT/6JpHh6Gcjioz/Ao8bJ9Z8/98AwhZwE=;
	b=iki54OCtLiu3G55QqgIoh+YgxNE3dV8XRTbTTWDK6HwTqjUJOyguwx5w+YIZsi9Dsu0HnA
	9XoxVenmJDGicEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53AA913421;
	Thu, 13 Apr 2023 07:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3dZGFDKqN2RIcAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 13 Apr 2023 07:07:30 +0000
Date: Thu, 13 Apr 2023 09:07:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: WTF is going on with the nvme-cli build
Message-ID: <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
References: <ZDemsiJi5vXd6aia@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDemsiJi5vXd6aia@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_000737_562027_CF2FD894 
X-CRM114-Status: GOOD (  13.07  )
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

Hi Christoph,

On Wed, Apr 12, 2023 at 11:52:34PM -0700, Christoph Hellwig wrote:
> can you please urgently fix nvme-cli to have a sane build system
> again?

Please, let's not be so drastic and I would argue all build system have their
wards. We just need to figure out how to handle them.

> Right now it tries to download random packages over the internet
> instead of not building components or failing the configuration.

Which version are you using? I've recentely change the default behavior of the
fallback mechanisme but might have missed something. Alternatively, it also
possible to change the global default for this feature.

The flag in question is:

  meson setup --wrap-mode=nofallback .build

