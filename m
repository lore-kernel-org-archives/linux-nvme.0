Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE28CA5FFC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2026 06:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lOh3B4KnaSI/IpYHokwJ1LHwip0e1vqLU/zqlAqrNhg=; b=E9efuwanyZMuWtVeJ6LB42f+CX
	M2mBDvB2y2QMSdOVmqaALQpLjwdmDADZLYIwrDqvydzPNGKDDNLq1WmkeWfPsOmUKN+3MJLxe8i+V
	t7fzHL3IjFBatc30T1fg8+IqAXBJSqsn8qJgX5dBVK1rkDB9cFp2FP05zZTTQEZE10mNe4KLajCnF
	yEp+yiBi1QMJfyjo1R2wg9EIJ5Gb95gbjLLapcRFoqDS0WVc7qirAZZkGZhZpHEfx4QVcptvPbURw
	WjYjV6qRPpBcqem3HPuG9Jhau7CgIFT+OEh1zMXlNZE2lLDtZojDKiBjxTAY72hbA+XAi1BpFBQDe
	0r80B/ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDypV-000000008Up-0Qyq;
	Tue, 06 Oct 2026 06:39:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDypS-000000008Tu-3x8A
	for linux-nvme@lists.infradead.org;
	Tue, 06 Oct 2026 06:39:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D3B51FB12;
	Tue,  6 Oct 2026 06:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791268743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOh3B4KnaSI/IpYHokwJ1LHwip0e1vqLU/zqlAqrNhg=;
	b=RIWnJVCJH465FfYcyOM2/VIvpMWSEqbN3m76BPIAoystnPVhVVaQMKQANgwShKuYTzPZeV
	GIoLX5LJ4Ay/61Ll1WsoSy9JCNvV1Oof5LSojg28RevVRaOhjDM2MrllnHDUMZwxBof1xM
	vtCzN87GsmLMqJ0unDCS9NL6uqHuCvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791268743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOh3B4KnaSI/IpYHokwJ1LHwip0e1vqLU/zqlAqrNhg=;
	b=RbuXiEMtvMr1X58BrJhBrtIb+XMWkWjdiRXFoLL519+pi9WEvkzXXI4HSMORTmgouERrhr
	Ipy92fJDP7/wQNAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wm6B5Uh1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VFRvX/u0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791268739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOh3B4KnaSI/IpYHokwJ1LHwip0e1vqLU/zqlAqrNhg=;
	b=Wm6B5Uh12em5XFZsectlWT6mOVCypYFRUYdJgMZNhbwDF3F6B7uwHaWt6bjjIfW7UT6OKo
	ShvvB+dH3kg6zqrmZ26sYb1z6AQ0bJmz2ycAeh/VEP7hSBmRsgsl/n6Y7ilwg3SuQyy1FB
	ke02jFCp4UmWcZrYZibzVlds9MHLTxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791268739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOh3B4KnaSI/IpYHokwJ1LHwip0e1vqLU/zqlAqrNhg=;
	b=VFRvX/u0dPlMBcLOqGkvD7fcCXU80IZU4EETvpKmZvCkG08qypovdWTQVYwdxG9CrOOJLz
	Kub7udq2Obd5NdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C011C136F5;
	Tue,  6 Oct 2026 06:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GjZDJoKXxGqdHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Oct 2026 06:38:58 +0000
Date: Tue, 6 Oct 2026 08:38:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	hare@suse.de, kbusch@kernel.org, hch@lst.de, gjoyce@linux.ibm.com, 
	chaitanyak@nvidia.com
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
Message-ID: <11d3490e-f8ce-4559-b1d3-f115f7dbced2@flourine.local>
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
 <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
 <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
 <9271266f-3d7e-426e-93b6-6f1f28bc9b0f@grimberg.me>
 <9691f1d3-ec06-45d2-a427-ba46df5fa57c@linux.ibm.com>
 <26f90121-b787-4d06-8741-4fac21b46ecb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f90121-b787-4d06-8741-4fac21b46ecb@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1D3B51FB12
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_233911_134624_3B764E6C 
X-CRM114-Status: GOOD (  10.55  )
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

Hi Nilay,

On Sat, Sep 12, 2026 at 05:41:07PM +0530, Nilay Shroff wrote:
> > This would preserve the existing behavior for single-queue devices while still using the
> > NIC hardware queue count to constrain the default on multi-queue devices.
> > 
> > Does this look reasonable?

Could you rebase and send also a PR on github. I'd like to run the
review bot on this.

Thanks,
Daniel

