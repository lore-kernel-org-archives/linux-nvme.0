Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08387D16271
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zs6+kldJgtU8iTbr9H0jAMkrXfP2cMOttWCMfrowfqU=; b=d6nFXOys9Vf+aEdNuN+CJp6tPn
	jHJliNzBP6DSkRWNPRRc5KyChbbWxQjBs9Bfxl6C3musQbaIH+BTGJ9VjrgH7nLtRlqu4UpoNBQuC
	NQBj3HKmil5DZSk6lSdGJCr7BTmr+xCxceCgNby2HnI9HyqpQYrHv/z31OpHi5wyN2pqjjmUsAwOg
	NxWplzJEO2WhI/MsduRtErUydjw3G9lvI7z/JnZj623SV8j6tL6pvwfBQCNUavl7J8qgMYQ24Vad0
	NsrIKOvwsopcI06RhR8y2Ga+MnRRC6DLH+dOe2ikWVin0qVmM3KtGWSpFQ3xFUvi+OfUn2Oez0Gn1
	fq8u7eOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Lbh-00000005Ocw-0JAi;
	Mon, 14 Oct 2024 13:59:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Kub-00000005E2e-0hr2
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 13:15:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 875B621B46;
	Mon, 14 Oct 2024 13:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs6+kldJgtU8iTbr9H0jAMkrXfP2cMOttWCMfrowfqU=;
	b=Tgj2M5tRGpZfXTxSNImAqsbLvb92edOgply8Epi3YKJugcNri8ZvDPbjCrz12fd5vcsIsZ
	a5jt7QhV3mym1Ye6KWyjiP/bBRz5417juXzV6um13jk1f1CoWCX24U0Qt+0mx4ZgjoVuvs
	KunIt+2YS0e5EPv2cuv7s2OGuI3VI6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs6+kldJgtU8iTbr9H0jAMkrXfP2cMOttWCMfrowfqU=;
	b=L9k/1+GqMsKRGikAEpBw4Uhlj0XYu/SnXdRTc40gz3P45dbR7u/DQM6K8dUJDg0NHhMVKc
	HO1vGoXkL89AgaBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728911699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs6+kldJgtU8iTbr9H0jAMkrXfP2cMOttWCMfrowfqU=;
	b=Tgj2M5tRGpZfXTxSNImAqsbLvb92edOgply8Epi3YKJugcNri8ZvDPbjCrz12fd5vcsIsZ
	a5jt7QhV3mym1Ye6KWyjiP/bBRz5417juXzV6um13jk1f1CoWCX24U0Qt+0mx4ZgjoVuvs
	KunIt+2YS0e5EPv2cuv7s2OGuI3VI6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728911699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs6+kldJgtU8iTbr9H0jAMkrXfP2cMOttWCMfrowfqU=;
	b=L9k/1+GqMsKRGikAEpBw4Uhlj0XYu/SnXdRTc40gz3P45dbR7u/DQM6K8dUJDg0NHhMVKc
	HO1vGoXkL89AgaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61FF813A42;
	Mon, 14 Oct 2024 13:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D3SDFVMZDWd8UQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 13:14:59 +0000
Date: Mon, 14 Oct 2024 15:14:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp uaf when tls setup fails
Message-ID: <77f84f3b-86ff-4d26-ab25-a0355bcb0e40@flourine.local>
References: <8bb28305-01b3-4d68-bc74-bdbd9352b1c1@flourine.local>
 <5b68b804-337f-4cec-9d90-6f727baaabbd@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b68b804-337f-4cec-9d90-6f727baaabbd@flourine.local>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_061501_382729_453D5961 
X-CRM114-Status: UNSURE (   8.64  )
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

> The logs say that the connect to queue 3 fails, but it seems this
> command never got send out (ftrace):
> 
>     kworker/4:0H-759     [004] .....  8771.165686: nvme_setup_cmd: nvme1: qid=0, cmdid=0, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=1, sqsize=127, cattr=0, kato=0)
>           <idle>-0       [004] ..s1.  8771.172062: nvme_complete_rq: nvme1: qid=0, cmdid=0, res=0x1, retries=0, flags=0x0, status=0x0
>     kworker/5:0H-796     [005] .....  8771.172422: nvme_setup_cmd: nvme1: qid=0, cmdid=0, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=2, sqsize=127, cattr=0, kato=0)
>           <idle>-0       [005] ..s1.  8771.178292: nvme_complete_rq: nvme1: qid=0, cmdid=0, res=0x1, retries=0, flags=0x0, status=0x0
> 
> And it is very reliable to reproduce it.

It is also reproducible without TLS.

