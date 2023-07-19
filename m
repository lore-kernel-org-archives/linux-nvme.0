Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F043EEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+IstS7F9F8Il8HqVrzQ0p69NvdM40mvsGaSZsZtZp3g=; b=S6IB8BGgKvUQzhTNHmSUMrYAs4
	4AG7unvuNB1Hgs19SkCXoP/oeGA8WcknkjAGU6Cdk3Kmpo9EnmEv6qAsLQ2QKzuU2bYD3n00K2PZ9
	y3VMiIaIimV0ppa8x5yNOf38A9aLgMUAhe+DNpJpO2XSxXJazszao/QVjuIeFykpjep0QkFQaWuTH
	ySd89i4YbvrMv7Dalg+DEVTD0uA2i8HyF2W16tUz8MD8h4xBSt95hVpYgPe5LnyAqiPqurcWfLgDP
	Y4SLLBd3QVvXr2AhH4eGxQqO+N98LQOIoL0IIDSlvwYlqiCiLfkaADB/KQbRq8db8J1FuAxbtOkHI
	A7kk+2NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM62g-007N4R-0L;
	Wed, 19 Jul 2023 12:12:30 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM62c-007N3r-2F
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 12:12:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C6DE21BF3;
	Wed, 19 Jul 2023 12:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689768743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IstS7F9F8Il8HqVrzQ0p69NvdM40mvsGaSZsZtZp3g=;
	b=mMMvHGNueQtCrzTj1AAzgkLdGSWBKC2zQvr9COlA8prV3oP7D8x5Kx1GmxsbWmvO2xzuzE
	S385DvsMY7cZVvc+io/9S0mkyRBlScoMsbO6qhHM3/nJh3f2GCvRkNHl1Oo0xrBsO68ViN
	JtnVFtOJyZJYc5v8XxU89CNjxwFdx6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689768743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IstS7F9F8Il8HqVrzQ0p69NvdM40mvsGaSZsZtZp3g=;
	b=6TfiIgk6p6w68vrGUDUGA8kNfs8IF/JIbpm4cSg2t00HG1ow8VJbFMpCUXvHQ8op10pWyA
	pOJEmkPgtcJrIMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EAF713460;
	Wed, 19 Jul 2023 12:12:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BVx3ByfTt2SvegAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Jul 2023 12:12:23 +0000
Date: Wed, 19 Jul 2023 14:12:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Message-ID: <fjx7ojmvl7campt6ccexvt7rhpfopw3spkopdfigmkjlkjinb3@vfj2gzjic55v>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
 <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
 <egbrvnkgv7dpbcqudnvp5xzj75ng6qh3fe7exedwmmffixibex@cdr4jraimzgk>
 <ZLfLT5Oirckc+o7W@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLfLT5Oirckc+o7W@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_051226_900244_EC01507B 
X-CRM114-Status: GOOD (  15.10  )
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

On Wed, Jul 19, 2023 at 01:38:55PM +0200, Keith Busch wrote:
> Yeah, dm-mpath is such a setup this was intended to prevent, as well as
> out-of-tree alternatives. Not that I advocating one way or another at
> this point; I'm just trying to set the context for why this message
> exists for discussing your patchset.

Fair enough.

> I'm curious why a proprietary module is even used, though. Is the
> driver's native handling doing something undesirable, or is this to
> cater to some vendor specific behavior outside the spec? If the former,
> I'd like to understand the problem and see if there's something we can
> improve.

Unfortunatly, I don't have any insides into PowerPath, or what it tries to
achieve. I suspect it's more vendor specific handling features. I'll ask if
there is a feature gap we could address in upstream.

