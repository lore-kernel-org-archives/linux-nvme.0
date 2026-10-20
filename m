Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85E606A333
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UxS+u+qV;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Uc1tQUzO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Juo5nlyG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Uc1tQUzO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Juo5nlyG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TiiWp0U7IU3ZOr9wtJZIzgg6WfTemiPc3VI8BpBKs9Q=; b=UxS+u+qV65UvW1NN49AqgndT8s
	xw6f1kY3G/+KLMTkLMUHgqsMXHHd7kTqb5Bouhfu4Gg+/qJjYiAnJjztMuA8sOPGZGRRSiySHA956
	ixjLI/hzMplg7X3CdOARA45B/qd1klYHVfkz0f0DpJc3JZpd9O4rE6fdxGMDG1pE9BKRDtkw7440R
	SrGxraWKuhgsi2ugBcQKDHvLdmv/GEyPdDFVjsKwl2rv19In2k+etYGuZLlX1TT067jE4VOGS707b
	D5/vblFtwUFgz0/R1iTACQ4ITNKWUtoT7kw4US+ENgQV0cV+cdJTYuYUnzcw1sc7wtHSG1ZuBpSup
	xn9RVukg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ9EL-00000009hqw-2IR7;
	Tue, 20 Oct 2026 12:46:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ9EE-00000009hq7-0n6W
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 12:46:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 544CE21BF1;
	Tue, 20 Oct 2026 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792500364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiiWp0U7IU3ZOr9wtJZIzgg6WfTemiPc3VI8BpBKs9Q=;
	b=Uc1tQUzOGE1fU5Rd/Q40eBKynCWiMKmhIHLBpuPqPQjnuMmOtsjr9NEGxYhQlZJt04cc0V
	pka7QDupMVx3sckmEpWrM2iK/x2HiEszxv1UptqLy3aeLkiDeIgJT8Bc9NqE1dcPIEgiRT
	UoDqArz/RlJlOAqPyTf+pXfOxicflNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792500364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiiWp0U7IU3ZOr9wtJZIzgg6WfTemiPc3VI8BpBKs9Q=;
	b=Juo5nlyGp8ODkkdQEPpiUW+V/VLNBQkn64iZGyUP2ZgBYamI010s6Vf+GBVHc+GIJmVaLW
	j01B6w4E11Q7pVAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792500364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiiWp0U7IU3ZOr9wtJZIzgg6WfTemiPc3VI8BpBKs9Q=;
	b=Uc1tQUzOGE1fU5Rd/Q40eBKynCWiMKmhIHLBpuPqPQjnuMmOtsjr9NEGxYhQlZJt04cc0V
	pka7QDupMVx3sckmEpWrM2iK/x2HiEszxv1UptqLy3aeLkiDeIgJT8Bc9NqE1dcPIEgiRT
	UoDqArz/RlJlOAqPyTf+pXfOxicflNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792500364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiiWp0U7IU3ZOr9wtJZIzgg6WfTemiPc3VI8BpBKs9Q=;
	b=Juo5nlyGp8ODkkdQEPpiUW+V/VLNBQkn64iZGyUP2ZgBYamI010s6Vf+GBVHc+GIJmVaLW
	j01B6w4E11Q7pVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20528136CC;
	Tue, 20 Oct 2026 12:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jMkIO4ti12q5UQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 12:46:04 +0000
Date: Tue, 20 Oct 2026 14:46:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 17/18] nvme: Add support for CQT to nvme host
Message-ID: <4459053b-35eb-4359-99a6-05393a9a62d6@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-18-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920182936.2317916-18-mkhalfella@purestorage.com>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,purestorage.com:email,grimberg.me:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_054607_619072_833098AE 
X-CRM114-Status: GOOD (  13.43  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Sep 20, 2026 at 11:28:15AM -0700, Mohamed Khalfella wrote:
> TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> limit for attempting Cross-Controller Recovery. Add ctrl->cqt, read its
> value from controller identify response, expose it via sysfs, and have
> nvme_fence_timeout_ms() account for it.
> 
> Use CQT to drive time-based recovery in fc, rdma, and tcp transports.
> Add a fenced_work delayed work to each transport controller. If CCR
> fails, fencing_work switches to error recovery immediately if CQT is not
> supported. Otherwise it schedules fenced_work after the remaining fence
> timeout, which also switches to error recovery when scheduled.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

the sysfs entry needs to be documented, with this

Reviewed-by: Daniel Wagner <dwagner@suse.de>

