Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15587C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=esbi6X81bLPlMyNmPUV0aHcJ1pNId+rjarsqbjmVgu4=; b=Js63fq82IONQmcUApoJDFJrHiI
	jMd15ODAcOHH7Xl8O570pc5qIWEHJP6pqdJH51FLgNviOUDk0NKW3cLrkjNtYEXdXWsKW1B4eop3J
	roen+myo8KG0HYRxHvSu0SZ5ul4H+Z1OuF5RQx3+MMMCNY4Pmq8KQiCLzjLn6+t7CGAHEzjHzSEi1
	OynQaFLU1wYja/JrZEbO1tkQ1qTK2utsLduPtsF6o6XRJSZEpi21E6g9NFF0McKVLtmi8QVtnz/Cr
	97LYrp7R0m8rsuiEMbzCzbajFlpFPbLLlPNDa0MXAzrwXPyscPdoqJ7nohr7yBu5CwlU3QYciPakZ
	13LSQ0CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMnog-0000000AGHO-1R3e;
	Thu, 27 Jun 2024 12:01:30 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMnoZ-0000000AGEl-2IpP
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 12:01:28 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A175E1FBED;
	Thu, 27 Jun 2024 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719489679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esbi6X81bLPlMyNmPUV0aHcJ1pNId+rjarsqbjmVgu4=;
	b=gZjV+LUONV1g3hoRnMsJvAEZipyKMhS2BIHH3kJAiFXLS6WBw2bqu2nzxC1YtcgJsLt+qV
	4znDrQoqvkWZ+yn4NZzvOArrww8Gtu6yig/K4qIQpePFLDx2RnTkCqu/T1sgHZG+fYsKsa
	RBvfWi+DYADInYDwjlCndu+Po2raP9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719489679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esbi6X81bLPlMyNmPUV0aHcJ1pNId+rjarsqbjmVgu4=;
	b=5VIOiXTiZaiq1MwUcFcAR7Q2GjsI3btJSXITnrP0GtIzqcJlVCK8FaxLmN68cuq13/hLi0
	HDhpNL2OrQBAIGDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719489679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esbi6X81bLPlMyNmPUV0aHcJ1pNId+rjarsqbjmVgu4=;
	b=gZjV+LUONV1g3hoRnMsJvAEZipyKMhS2BIHH3kJAiFXLS6WBw2bqu2nzxC1YtcgJsLt+qV
	4znDrQoqvkWZ+yn4NZzvOArrww8Gtu6yig/K4qIQpePFLDx2RnTkCqu/T1sgHZG+fYsKsa
	RBvfWi+DYADInYDwjlCndu+Po2raP9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719489679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esbi6X81bLPlMyNmPUV0aHcJ1pNId+rjarsqbjmVgu4=;
	b=5VIOiXTiZaiq1MwUcFcAR7Q2GjsI3btJSXITnrP0GtIzqcJlVCK8FaxLmN68cuq13/hLi0
	HDhpNL2OrQBAIGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 887CD137DF;
	Thu, 27 Jun 2024 12:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3WVgII9UfWa2RwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Jun 2024 12:01:19 +0000
Date: Thu, 27 Jun 2024 14:01:18 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report] Oops: general protection fault at RIP:
 0010:__nvmet_fc_free_assocs+0xbe/0x450 [nvmet_fc]
Message-ID: <ft3wp75xsypwwuihlxs57x5s5qrqwa37uegf45fsh5wko7qube@x2gkjnltl7wn>
References: <CAHj4cs_o_8hhGK9PUhqX-OV3SqE2i0y0j4f5x2LVuWWx_cHJ2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs_o_8hhGK9PUhqX-OV3SqE2i0y0j4f5x2LVuWWx_cHJ2w@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_050124_179471_86E22899 
X-CRM114-Status: UNSURE (   7.85  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jun 17, 2024 at 05:22:42PM GMT, Yi Zhang wrote:
> Reproducer:
> 1. start blktests nvme/fc nvme/010
> #NVMET_TRTYPES="fc"   NVMET_BLKDEV_TYPES="device file" ./check nvme/010
> 2. remove nvme-fcloop module during step 1
> #modprobe -fr nvme-fcloop

Known issue: removing the target module while it is use can trigger
these crashes. We should add a blktest for this and fix it obviously.

