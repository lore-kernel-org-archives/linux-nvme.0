Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C56C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqexkMqOBvbAISOxS9YABgfHQQXyjchsxH0b922RYYk=; b=cvjKjPRIzjHrbGzuFehm5Td4MZ
	PNgrBxKte0V5gMhmJugIAR7a4tHcXUsQsrX/aNEyCvsXx/iBPuKOrcuMcuxdXMlOxCJJLkkHTPEkm
	Gx7MZHAPDro3fDm4TyYw05YzZP6cTD1pDjF5oVnAdPXM2W8aiI7pagkbWiMXl/nbweHkcHy3NzOX7
	sruG7T4Y0nrl02i3XlP1hue+ajbdaM/CVtO52DHFMZW6Z+Vvw2l2p4XR9Njco/gcDu4hsN7u0yFLd
	XzDOk4eLb6Pabdj2DxxfaYMNKIFK/A19beb5Xdi+GRPwD91bnXZokWkybJobD4/GSNatX6oFGq+aE
	fvlFD3Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1lhb-00000000Gtz-0hXA;
	Mon, 07 Apr 2025 12:35:47 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1kEF-0000000HTfg-13il
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 11:01:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 711371F388;
	Mon,  7 Apr 2025 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744023681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kqexkMqOBvbAISOxS9YABgfHQQXyjchsxH0b922RYYk=;
	b=bDPu3mB8hgh6KDkleeHaIvAIGkbNsY7hHiPjjiCx+RKcK30KZbzNGZe5IryRaPC5l630eP
	cIWGZiFotN/LZY3eMm4/YeLjnwGUlMNIkAsCzjynmrhjHlfvTvoq8MFd2JMWggtLIYRMw+
	1OR6uu5FBv/BRaLUPebTIXwL3Ve4oCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744023681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kqexkMqOBvbAISOxS9YABgfHQQXyjchsxH0b922RYYk=;
	b=9XbV1jB6uJ47oo3PdxK3MhQVgGulgYtxI3TZ7Z5P9zNXFN2aKdzfWR7Fu+kIny8rLt7JCX
	kMn0H1DhwxOC4MAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bDPu3mB8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9XbV1jB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744023681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kqexkMqOBvbAISOxS9YABgfHQQXyjchsxH0b922RYYk=;
	b=bDPu3mB8hgh6KDkleeHaIvAIGkbNsY7hHiPjjiCx+RKcK30KZbzNGZe5IryRaPC5l630eP
	cIWGZiFotN/LZY3eMm4/YeLjnwGUlMNIkAsCzjynmrhjHlfvTvoq8MFd2JMWggtLIYRMw+
	1OR6uu5FBv/BRaLUPebTIXwL3Ve4oCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744023681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kqexkMqOBvbAISOxS9YABgfHQQXyjchsxH0b922RYYk=;
	b=9XbV1jB6uJ47oo3PdxK3MhQVgGulgYtxI3TZ7Z5P9zNXFN2aKdzfWR7Fu+kIny8rLt7JCX
	kMn0H1DhwxOC4MAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 568ED13691;
	Mon,  7 Apr 2025 11:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dNC8EoGw82dPYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 07 Apr 2025 11:01:21 +0000
Date: Mon, 7 Apr 2025 13:01:20 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCH 1/3] tree: add support for discovering nvme paths using
 sysfs multipath link
Message-ID: <da954049-0c85-4675-80da-ec6e30752ae2@flourine.local>
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-2-nilay@linux.ibm.com>
 <6a1f8acc-acf6-4a72-abdd-84aa81623ec7@flourine.local>
 <6a43255d-df71-4121-9aa2-5f094094d190@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a43255d-df71-4121-9aa2-5f094094d190@linux.ibm.com>
X-Rspamd-Queue-Id: 711371F388
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_040123_439217_BA07A165 
X-CRM114-Status: GOOD (  18.21  )
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

On Mon, Apr 07, 2025 at 03:06:33PM +0530, Nilay Shroff wrote:
> >> Please note that
> >> this change is fully backward compatible.
> > 
> > Could you elaborate what that means? libnvme should still work on older
> > kernels.
> Yeah I think as it's given that libnvme should work with older kernels, I 
> probably don't need to spell that out explicitly. The intention is just
> to mention that this change would not break running libnvme on older kernels.
> But I think I could remove this sentence.

For some reason I read 'this change is NOT fully backward compatible'. My
bad, sorry.

> > Also could you add a tests for this? The is already a test for the
> > current sysfs tree parser, see test/sysfs.
> > 
> Yes I'd add a testcase for this change. How about extending the existing 
> test/sysfs/tree-dump.c? Or do you want me to add a new test case for this
> change?

Ideally you just need to add new sysfs dump
(scripts/collect-sysfs.sh) and have the corresponding output placed in
the data directory. If not, yes please extend tree-dump.c.

