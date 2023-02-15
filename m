Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9ABC636D4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5FxsiYoQ6se3VI94O2pamkULyLiCOmXVuwSVmL9jK+Y=; b=DTmZjfepPPhBDVl1k5qKvvPDdI
	yM+10+gcJSecBYKL/01cVyTywG1dWmAXVQ94EGFXtJ+uurQHn2hgjUICGyWoYQeWFqJCZGmQO9xVI
	cUSDUD4tahdFisyD3dLxVbMV4U55zRylyl0IOWFr6dki8mu7lq7UkjBsuAiDGPLokh9OoB1W2BKVL
	11t2CyJmUu81fYAGShZvATDmILaTgL9kiZX30+aKshrFpkRSgrnRy1slzjS6PInKLdJN9LPM1a/N5
	ljzaLSVmQHDmsCbx1684sZYD4jErbw8Qnx3KjK+llaIp+FmQdVR8B5LskUHMy3PhTEr1xCr6tH3k6
	Hpqop7iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSEWr-005NCd-Hx; Wed, 15 Feb 2023 09:56:45 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSEWl-005NBT-BK
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 09:56:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA06E204BB;
	Wed, 15 Feb 2023 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676454993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FxsiYoQ6se3VI94O2pamkULyLiCOmXVuwSVmL9jK+Y=;
	b=ZLPj+S/Lf4EQ+FSiAhwbtS3BUia4soGM9udunJiVrVv4VxccbaNwbmB26URvGU8WmhxXeu
	I8j49Lm9LHHd0oCPezflxwvn1PZH/vMdlqnzZQOPsogQxXmwpfmQ/HgpAhn8BOh/tEqZ+p
	WC325QT3jseOcaCqvnhJu3ctJO7gJbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676454993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FxsiYoQ6se3VI94O2pamkULyLiCOmXVuwSVmL9jK+Y=;
	b=DSctR5MW0b53h+mvTl3NGWwxQJoWhLfPm2hHvC46QTv4GJeAJdZxlwYINaRbobW+Dcesbw
	pFs3Iqe8bcUTTXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD5FB13483;
	Wed, 15 Feb 2023 09:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bD4MMlGs7GPPBAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 15 Feb 2023 09:56:33 +0000
Date: Wed, 15 Feb 2023 10:56:33 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: How to look up an ns cdev from block maj:min?
Message-ID: <20230215095633.knzzi5z6737feeyu@carbon.lan>
References: <Y+v8x4m3lm8QU7Ov@fedora>
 <7f958c6d-d6e6-2346-a680-875c7fafe7e5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f958c6d-d6e6-2346-a680-875c7fafe7e5@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_015639_574012_A9208309 
X-CRM114-Status: GOOD (  18.96  )
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

On Wed, Feb 15, 2023 at 10:41:08AM +0200, Sagi Grimberg wrote:
> 
> > Hi,
> > Is there an official way for userspace to look up an ns cdev from a
> > block maj:min?
> > 
> > For example, how should a userspace program determine that /dev/ng0n1 is
> > the corresponding ns cdev when given just the block device node
> > /dev/nvme0n1?
> > 
> > Parsing the filename is an obvious option but it makes assumptions about
> > the naming convention of both the block device node and the character
> > device node.
> > 
> > Is there a better way via sysfs? (I couldn't find it.)
> 
> Not that I can see... It follows the same rules as the
> normal namespace, which means that it takes the subsystem or ctrl
> instance number (depending if multipathing is enabled) and it will have
> the same namespace instance number.
> 
> In other words, every namespace nvmeXnY will present an 'nvme generic'
> chardev in the form of ngXnY.
> 
> Looks like nvme-cli is missing the generic representation in the json
> output as well. Perhaps that is the best tool to use (once fixed with
> the json output with the below):

Looks good. I've created a PR for it.

https://github.com/linux-nvme/nvme-cli/pull/1820

Can I add your SoB?

