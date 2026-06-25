Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDFCCDB47F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 07:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SMhXXgVGsMbZ7qD7648/UkUos4+PEbhwC33ZLIU4VC4=; b=nStBCUbI1SBTGg4OnmyNjNvBLr
	y/amxX2lN6jIb1nRQ3cv6K3XP/nX/RaxgY9M1gSZ7v35wV63VYJYk+KyPeNVhpoGLChOpyDirzLYb
	+7MppyAgDUGq6fai96k4WHiK9pWSgCUpkIPvhglGg5BwUiylSb9bEy/dUgimWp4KKvaZayVW8xe2D
	t6W6qlSAdLv7MDHRM+cYyHRkPk/+55GpmgXY7rdgvx5XqX0BNFxoWgXW+R6WXZOORm2adqVrF188f
	Iqel5RfVmcKZ99tYyzb+x53/CaO6PuWLnBVV+mwQp1wHP8v89CT+qlJj5PH/vdhSRc1aG5Wy2BK5P
	qqanCg/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wceKr-00000008kgH-2lcr;
	Thu, 25 Jun 2026 07:17:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wceKp-00000008kfx-0Ne9
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 07:17:16 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2C137186E;
	Thu, 25 Jun 2026 07:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782371833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMhXXgVGsMbZ7qD7648/UkUos4+PEbhwC33ZLIU4VC4=;
	b=0cZcAcIGgL6QxIrqIvQFWDMbkUBgtlXqnboM8LrzsDP2xWSw6jg1s2EjYcxl41ASYWkp4r
	Lsc2lsLFxPWiNp+7I4DsYIxSv8/gKrAqu/73RoWIlFBjqR+YVQpAzeOj9XIwMS2VsQL4xz
	M+lOi580zM8HDsbL5FpTWc60GczsdDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782371833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMhXXgVGsMbZ7qD7648/UkUos4+PEbhwC33ZLIU4VC4=;
	b=9Y+rws9lZvkfBUwIeFTxHJfIDDQmeDXIuWFDgyzaL9QiL6SkZO4IXzhSfLPBnhptJluZwr
	+ZbtF+98n8h6GHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782371831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMhXXgVGsMbZ7qD7648/UkUos4+PEbhwC33ZLIU4VC4=;
	b=AqLv3R22C1cRTTaWPJ4UG+OVbE+39471G/mUjLynZmYIk58Tb1K80JGyalx0/t4xj/yZe2
	ODs4/RmSWmaaWtQ9EQo8ZWvV5LSZfp52mqn3wKoUR6WY2dKCEXofuc6wnL8rikcrGv5RYw
	JX8CBtmR+pJEKaDi3ClsT9ZGukjcLYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782371831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMhXXgVGsMbZ7qD7648/UkUos4+PEbhwC33ZLIU4VC4=;
	b=rPqt7vb7e2IvLMp3DEr/qNvMIgaW8X+n8mDOIE17UzqfJ1612qyFuUtnE/HgkeOkBvU7Ph
	RBvqh80eorM2uNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF60A779A8;
	Thu, 25 Jun 2026 07:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d/+9MffVPGrndQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 25 Jun 2026 07:17:11 +0000
Date: Thu, 25 Jun 2026 09:17:07 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvmet: add namespace-level debugfs for reservation
 state
Message-ID: <5b2a11e8-bb66-4111-9090-bcdbb0458fcf@flourine.local>
References: <20260622104418.2070277-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622104418.2070277-1-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_001715_277329_4EC087ED 
X-CRM114-Status: GOOD (  12.40  )
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

On Mon, Jun 22, 2026 at 06:44:16PM +0800, Guixin Liu wrote:
> This series adds debugfs support for inspecting NVMe target reservation
> (PR) state at the namespace level.
> 
> Patch 1 introduces per-namespace debugfs directories under each subsystem,
> providing the infrastructure for namespace-specific debug entries.
> 
> Patch 2 adds a 'reservation' file that exposes the persistent reservation
> state including enable status, generation counter, holder information, and
> the full registrant list.
> 
> Example output with two registered hosts and an active holder:
> 
>   $ cat /sys/kernel/debug/nvmet/testnqn/ns1/reservation
>   enable : 1
>   generation : 2
>   notify_mask : 0x0
>   rtype : write_exclusive
>   holder : hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
>   registrants:
>     hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
>     hostid=22222222-2222-2222-2222-222222222222, rkey=0x2222

I expect blktests will make use of this interface eventually. The parser
for this wont be dead simple, sure doable but not simple. If you see a
way to make a bit simpler I wouldn't mind.  

