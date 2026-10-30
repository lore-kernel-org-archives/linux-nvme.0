Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DA606A335
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lLzIAVFT;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1gZBGSiZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wCq4yPoU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1gZBGSiZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wCq4yPoU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vhkrKRzVq61WO+VDqVg4XCpohR1qz7EtQY5/jU1KiBY=; b=lLzIAVFTGkKxZMuZinU5n6+YSJ
	G6FmrFaNi/B4VuvWLaz1Ld8rk6DXsnrREoVKEUdwRmxjOYLH2on8IwNYGYyZs5kSiqenERPu9fYDa
	m4+m2UxGd8+3kulbri6/tNeb7Vcszy+OV2LMBQaCNfcPC7/Gd1VOpPabHtWfUF0IpYOjO8zqQd2Hq
	4LoGmsLEIp6D+OmrB2TNa8HdZNBj2pTGB9hF92OBiw2YGYTGJOMrp4Grkwk2CreoOR1Ib2FTmQYOm
	fbUVckcXAXSCT8TcergFp9aykuhfWJGuMlNZoDiRZHFDX6+T0PI4Pc4mOCcrfNJh01UXnD5zLlwyo
	nrv2a+Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMjrK-0000000BOfi-3ZxR;
	Fri, 30 Oct 2026 10:29:18 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMjrI-0000000BOfN-10g0
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 10:29:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD1151F387;
	Fri, 30 Oct 2026 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793356153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhkrKRzVq61WO+VDqVg4XCpohR1qz7EtQY5/jU1KiBY=;
	b=1gZBGSiZtG3aW1MBmsV6bRh3u5lHn3dbugJKnlOYNLHbThRxhfmejBdRlq37JNilnicy18
	pw4FBESxfN32fnyXdQ3pMTLvGSSsT+vT5Q1T4HlDu1KS1f0ejZdryBqU0uQq7SrKMa38Qp
	qzQYh4rJwU/3ku8MPMDzgWSVIUnA4EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793356153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhkrKRzVq61WO+VDqVg4XCpohR1qz7EtQY5/jU1KiBY=;
	b=wCq4yPoUvWnZjn854ow7phJW7TgLunTMAQP0p84sbGGpA33ZGEi1MRKaCYgqO5zsVOcn0Q
	VZ5LkI9k+zVXghDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793356153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhkrKRzVq61WO+VDqVg4XCpohR1qz7EtQY5/jU1KiBY=;
	b=1gZBGSiZtG3aW1MBmsV6bRh3u5lHn3dbugJKnlOYNLHbThRxhfmejBdRlq37JNilnicy18
	pw4FBESxfN32fnyXdQ3pMTLvGSSsT+vT5Q1T4HlDu1KS1f0ejZdryBqU0uQq7SrKMa38Qp
	qzQYh4rJwU/3ku8MPMDzgWSVIUnA4EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793356153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhkrKRzVq61WO+VDqVg4XCpohR1qz7EtQY5/jU1KiBY=;
	b=wCq4yPoUvWnZjn854ow7phJW7TgLunTMAQP0p84sbGGpA33ZGEi1MRKaCYgqO5zsVOcn0Q
	VZ5LkI9k+zVXghDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82EF713419;
	Fri, 30 Oct 2026 10:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PAdlF3lx5GoHHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 30 Oct 2026 10:29:13 +0000
Date: Fri, 30 Oct 2026 11:29:12 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/18] nvme-fc: Hold inflight requests while in
 FENCING state
Message-ID: <45d52d19-dbfc-49b9-a445-a8fb9e69abef@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-16-mkhalfella@purestorage.com>
 <d9563967-9ddb-4cd7-9149-d1f37522e1fa@flourine.local>
 <20261021212357.GZ2931-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021212357.GZ2931-mkhalfella@purestorage.com>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_032916_429335_671C1A88 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 02:23:57PM -0700, Mohamed Khalfella wrote:
> Adding new FCPOP_STATE_HELD will result in a more invasive change and it
> will result in nvme-fc no using nvme_cancel_tagset(). My intent with
> this change is to bring nvme-fc closer to other transport and only
> cancel inflight requests. synchronize_rcu() is a simpler in this case.

I am totally against introducing yet another synchronization method. Fix
it properly.

