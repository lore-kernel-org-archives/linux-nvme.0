Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F2BC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 12:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VhXbsLGlI96dTIe8IVakZngpQhH2r8EWXx2rnlhF9fc=; b=CmUoYVeV98yAnwHcVO+Mu0wR5f
	E98hQ8rHPon5Ioou5KZ27FrUzWgOGEBxA0NhPxLz5RDQDM7ktUwRq5ZQCd+/Ir7JZ4BTFvD/7h+2o
	SjEoZ0uV+W1pvkdG9wAW62jaUMqTgmyNF95jROwKqNRw6261R0dc6UZy0XvZfMo91qUbMRglOoPKI
	fhczGANHQH3RhPGuq4/9296zMLC7h6nKmUlCGCSeoy1Qr0rGsc6XayUF985L1R1BDHm8BY1vOpaDZ
	vWlr6SWcea3T/lbawjX0P9rr9zbkgmzRFYfellEJM/s4Ek9KWXDmC/d17pQIj6VXXkI4VRaLmMEqU
	ipPrvU/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2UJ2-000000076tY-0gqB;
	Wed, 09 Apr 2025 12:13:24 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2UIz-000000076sK-2UQX
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 12:13:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF2B521164;
	Wed,  9 Apr 2025 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744200799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhXbsLGlI96dTIe8IVakZngpQhH2r8EWXx2rnlhF9fc=;
	b=uq9Ou1IYKNSFBUYk8Qu5Yp1T3o9MhAk0s3NnOcFCA6yfuTlq+6ZrffuQbGRnbZY/8v6ZVo
	KSteZyR2YqOMr6h+ah5AOiS6x05xUyzurwx/8h7KqAANO5nVh0v6oQ2OrSbbDB5ERTae1M
	MaFjeTTMLkRNJfUy8swEWKTZqTIm6PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744200799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhXbsLGlI96dTIe8IVakZngpQhH2r8EWXx2rnlhF9fc=;
	b=Nf36imu22eCyldWCSa7zROmGL0qVmjVhZshSF3hDg7+X7fh8jpihuYD9vqBcjOspg5QoAV
	5c7//B46GRJYjHDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744200799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhXbsLGlI96dTIe8IVakZngpQhH2r8EWXx2rnlhF9fc=;
	b=uq9Ou1IYKNSFBUYk8Qu5Yp1T3o9MhAk0s3NnOcFCA6yfuTlq+6ZrffuQbGRnbZY/8v6ZVo
	KSteZyR2YqOMr6h+ah5AOiS6x05xUyzurwx/8h7KqAANO5nVh0v6oQ2OrSbbDB5ERTae1M
	MaFjeTTMLkRNJfUy8swEWKTZqTIm6PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744200799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhXbsLGlI96dTIe8IVakZngpQhH2r8EWXx2rnlhF9fc=;
	b=Nf36imu22eCyldWCSa7zROmGL0qVmjVhZshSF3hDg7+X7fh8jpihuYD9vqBcjOspg5QoAV
	5c7//B46GRJYjHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D019A137AC;
	Wed,  9 Apr 2025 12:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dmHYMV9k9mcOJwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 09 Apr 2025 12:13:19 +0000
Date: Wed, 9 Apr 2025 14:13:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <wagi@kernel.org>, 
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: nvmetcli restore fails in add_subsystem
Message-ID: <ab6c0856-8398-4bc2-881e-ebf1ff80934c@flourine.local>
References: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
 <Z_Y3AYFzE3L2ujBW@infradead.org>
 <527963f3-1b89-4604-bc76-b3a18bb330a6@flourine.local>
 <CAAiJnjoft3gSsg-TYgyiBVpWiTjWztF=3E-aJpuaeZLCNrT-hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAiJnjoft3gSsg-TYgyiBVpWiTjWztF=3E-aJpuaeZLCNrT-hg@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_051321_776964_12D10909 
X-CRM114-Status: GOOD (  11.19  )
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

On Wed, Apr 09, 2025 at 02:58:17PM +0300, Anton Gavriliuk wrote:
> The link - https://documentation.suse.com/sles/15-SP6/html/SLES-all/cha-nvmeof.html
> 
> is quite confused me,
>
> 17.4.3 Marvell
> 
> FC-NVMe is supported on QLE269x and QLE27xx adapters. FC-NVMe support
> is enabled by default in the Marvell® QLogic® QLA2xxx Fibre Channel
> driver.

I think this paragraph only talks about the host side support.

> So if "the qla2xxx driver or/and the HBA firmware do not support the
> target mode anymore.", it is not clear, will NVMe/FC target work with
> QLE269x and QLE27xx adapters or not.

Let me back paddle a bit. My failed attempt (or that one from my
colleague) might just be a bad combination of driver/HBA. Without asking
Marvell directly it's not clear what the status is.


