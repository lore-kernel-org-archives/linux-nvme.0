Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7AFC369A2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 11:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ws6xFvGXlUCt4ggsqiwgBvRy6KZqB5Rf3q1lh8njqcg=; b=Wau6B77Zr+Frsd3Hfwc9PB62Lc
	Bb5SQfHdIkEeTaIVQve2X1a4Q1BGhKJUrjf49t4qlkFO4F0klddPQs/+GHo5NaJoRXQVgY59DfxZQ
	wnNz17eHXjE8JcmHwU6ZYxqJsroraclQuCs766sOywel63mL4X3VkXmMiqXOdZ0BeJjwIxrTz9CWN
	HZf7j2J8RkM2sjFDXOsRjc061q/UZskEg0OezEGfWSZLsZUwFrcpuzpyTzKcKoyJDjb4vuHgCmOzG
	w1EqBmgRpew/A5HU0sdr2ryjaT69Jhzrkx4MRMkW72zBksJmz6rzklcJejX2kS+Dln1+UoOeNL442
	ZSBYW3TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TpC-0000000723C-2OSk;
	Wed, 09 Apr 2025 11:42:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TnY-000000071p7-0ICh
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 11:40:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E6D621164;
	Wed,  9 Apr 2025 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744198850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws6xFvGXlUCt4ggsqiwgBvRy6KZqB5Rf3q1lh8njqcg=;
	b=XAS2gOGdvOY+PxWZxJZZY+MQ6yzI5EwU7kF50Tfl+j6xyFtfyhzCGbbgoqrmnPiMBL623i
	nqEvQ53cJQLqyUmrxYC8mQWCiUjDnVTkpIxOo8iixbcFVbj0Av54bDbK8dCUEWWsbT4/kz
	idCvyzZr6Hy5+/a0BoV/lW5ojpWTQMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744198850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws6xFvGXlUCt4ggsqiwgBvRy6KZqB5Rf3q1lh8njqcg=;
	b=pC3T++EJtMiPgGjWAY5LxG1dC9lJpHP/kZAA7Uano1MHo5+5PN5K2JGwCdZ3Kgd19Cd5L0
	ZpzZCSjx705XNvBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744198850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws6xFvGXlUCt4ggsqiwgBvRy6KZqB5Rf3q1lh8njqcg=;
	b=XAS2gOGdvOY+PxWZxJZZY+MQ6yzI5EwU7kF50Tfl+j6xyFtfyhzCGbbgoqrmnPiMBL623i
	nqEvQ53cJQLqyUmrxYC8mQWCiUjDnVTkpIxOo8iixbcFVbj0Av54bDbK8dCUEWWsbT4/kz
	idCvyzZr6Hy5+/a0BoV/lW5ojpWTQMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744198850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ws6xFvGXlUCt4ggsqiwgBvRy6KZqB5Rf3q1lh8njqcg=;
	b=pC3T++EJtMiPgGjWAY5LxG1dC9lJpHP/kZAA7Uano1MHo5+5PN5K2JGwCdZ3Kgd19Cd5L0
	ZpzZCSjx705XNvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F88013691;
	Wed,  9 Apr 2025 11:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aU8KIsJc9mc1HAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 09 Apr 2025 11:40:50 +0000
Date: Wed, 9 Apr 2025 13:40:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anton Gavriliuk <antosha20xx@gmail.com>, 
	Daniel Wagner <wagi@kernel.org>, linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: nvmetcli restore fails in add_subsystem
Message-ID: <527963f3-1b89-4604-bc76-b3a18bb330a6@flourine.local>
References: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
 <Z_Y3AYFzE3L2ujBW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_Y3AYFzE3L2ujBW@infradead.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.infradead.org,suse.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_044052_259412_7AA9FFCC 
X-CRM114-Status: GOOD (  14.57  )
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

On Wed, Apr 09, 2025 at 01:59:45AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 01:53:09PM +0300, Anton Gavriliuk wrote:
> > I'm trying to set up an NVMe/FC target on Fedora Server 42 beta.
> > Config file attached.
> 
> I haven't seen such a failure, but I have also never used nvmet with
> the fc transport myself.
> 
> Daniel, have you seen anything like this by chance given that you
> are the most active nvme-fc developer at the moment?

As far I can tell, the qla2xxx driver or/and the HBA firmware do not
support the target mode anymore. I was not able to get this working
either and IIRC Hannes said something similar.

A colleague also tried to get a with a QLogic HBA working and failed.
Though he was able to get the target mode running with a Emulex HBA
(lpfc driver).

Daniel

