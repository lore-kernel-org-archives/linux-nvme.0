Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3E4CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Rc/ZgCh87+LiUV/HvO53PyD28E9OrbkTps1z5xQLZw=; b=yXV+emzRGH7bf5jkhjc7FjYYq/
	BmlRITUwtcdhg/pUln+1XxBbnfvaiJ7geUXp6zEG9JGiza31vqiRvikvp68mZ4QTDNlXvuAUKTf8+
	ZjopHqD8cG/Zm7KGG3NRwMts8oSAdu+OTFT29ooZivopb9au6RlJJB3i6Q2H5FCPsKZ4UbKYwuA2V
	069WuWytO0Qi/olTgGLRTT9yc+t4YxIxGE9TzzwIi8XZpMCKXpizGuzfGFOl8ZCDKAmJvQClOcrpJ
	zxxf+RMica1SIm2g7dpkiiIE2tKXniqaJP7TIzv1r/Tl2NcROL438JVImX2GN6HL0tIsl05q60TqG
	2hqhKwEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxZf-0000000FPGu-0XCk;
	Wed, 03 Apr 2024 10:10:31 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxZZ-0000000FPDe-1VbG
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 10:10:29 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B30E25CB0A;
	Wed,  3 Apr 2024 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712139022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Rc/ZgCh87+LiUV/HvO53PyD28E9OrbkTps1z5xQLZw=;
	b=BR8PMvtFsUluvJ5aRknJXx90W3u/A1ksA+qjrLvgG9ZWmQmmmYIJPqM/YYRjo2QDOGpYB8
	U7CfJeAXqUhRJozj2IDVaFr+Bv7qfP4T6LL41+/x0o8kdlORAp0HW3iUXD7XafnpD8phtQ
	+Ry6FBqXjiUH5FFGP2oIz7taF00IHkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712139022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Rc/ZgCh87+LiUV/HvO53PyD28E9OrbkTps1z5xQLZw=;
	b=Xqw3Ocnw1TXR6ktGvMoRFfg9WWfmb9R2M+gcTDKv4speW7jQX84YrnhdHdzePcvFMvKIW3
	4niLAqOUbxXv/fBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FF771331E;
	Wed,  3 Apr 2024 10:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aWujJQ4rDWaRCAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 03 Apr 2024 10:10:22 +0000
Date: Wed, 3 Apr 2024 12:10:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, 
	Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"axboe@fb.com" <axboe@fb.com>, Gregory Joyce <gjoyce@ibm.com>, 
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Message-ID: <sc3b5fckqc27gmpb4ifz2tcr3oxo7hm24gu3ktfwk2jg2bhifm@rvw6u5oq77pw>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
 <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
 <BYAPR04MB415105995F0F45BFCFE48FEBBC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <ZgzIC-9buT_UKaeW@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgzIC-9buT_UKaeW@kbusch-mbp.dhcp.thefacebook.com>
X-Rspamd-Queue-Id: B30E25CB0A
X-Spamd-Result: default: False [-2.74 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.13)[-0.637];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:98:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_031025_585569_AC356963 
X-CRM114-Status: GOOD (  23.10  )
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

On Tue, Apr 02, 2024 at 09:07:55PM -0600, Keith Busch wrote:
> On Tue, Apr 02, 2024 at 10:07:25PM +0000, Kamaljit Singh wrote:
> > Your question about the nvme-cli version makes me wonder if there is a
> > version compatibility matrix (nvme-cli vs kernel) somewhere you could
> > point me to? I didn't see such info in the nvme-cli release notes.
> 
> I don't believe there's ever been an intentional incompatibility for
> nvme-cli vs. kernel versions. Most of the incompatibility problems come
> from sysfs dependencies, but those should not be necessary for the core
> passthrough commands on any version pairing.
> 
> And yeah, there should be sane fallbacks for older kernels in case a new
> feature introduces a regression, but it's not always perfect. We try to
> fix them as we learn about them, so bug reports on the github are useful
> for tracking that.

Indeed, all new features are auto detected. So if the kernel provides
them, nvme-cli/libnvme will be able to use them. Obviously, sometimes
there are some regressions but we avoid to increase the minimum kernel
dependency. Many things are also behind CONFIG options, thus the only
viable way is to auto detect features. Note, these new features are
almost all exclusive in the fabric code base. The PCI related bits are
pretty stable.

> > For example, I've seen issues with newer than nvme-cli v1.16 on Ubuntu
> > 22.04 (stock & newer kernels). From a compatibility perspective I do
> > wonder whether circumventing a distro's package manager and directly
> > installing newer nvme-cli versions might be a bad idea. This could
> > possibly become dire if there were intentional version dependencies
> > across the stack.
> 
> The struggle is real, isn't it? New protocol features are added upstream
> faster than distro package updates provide their users. On the other
> hand, distros may be cautious to potential instability.

We got a lot of request to provide up to data binaries for old distros.
For this reason we have an AppImage binary to play around. So if you
want to play with the latest greatest, it's fairly simple to do so.

