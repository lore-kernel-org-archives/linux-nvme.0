Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2638C83F26
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jul 2025 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ApLtFpEql9jhX/JOpay3Z5EcRFeOqvph4BiAn/3xk6o=; b=solNu984SFxGViASf6K62wA5cZ
	W1c2QXHYujSqB9tjnpoK4CqN94ZGxt9rmTdV59SkDxJU8ssQ4lZClYglGuIrFM7dU7DYQep2xwEee
	Z3N9yFV6FMv5Z1DMNet+guxL9/08gsH2o86BoO3dVgNDXA9O/lqmZGqpev64CYUgQHOjMYhVn/C22
	Yhk5K7os2YB47ICiEdluvhmtwPO23d89NL91IxP0E0UNsgUv78ZHcZN+HW6AtDfBJN3KKmOWR9py1
	p62DwREzM7875hRzze7Aw1HqxzsIGwz4RQjtKslEJK2hM9MLF4l/x5p/wgf2HwleAmVrWrwPo4M3F
	AuqEc7jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uezNi-000000083Bt-3DAA;
	Thu, 24 Jul 2025 17:05:22 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uex2e-00000007lUh-0raW
	for linux-nvme@lists.infradead.org;
	Thu, 24 Jul 2025 14:35:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6FCC1F394;
	Thu, 24 Jul 2025 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753367724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ApLtFpEql9jhX/JOpay3Z5EcRFeOqvph4BiAn/3xk6o=;
	b=xI3uI77xcKivj4eOdwlsfQ1JLVG9i0pXklVGPF7s/yUV1jYiJkiC7pVDQEvH0JKs07B8Ae
	UDD6MBRDitOZRv1vLderDVTu0Dd1E5nt1tcOw069dqpM6BxyvAwFTy9H/Kvk0N2ENVcWeA
	ZDI+SO+eKLTLqrqYnb+eUfgMrEl4TOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753367724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ApLtFpEql9jhX/JOpay3Z5EcRFeOqvph4BiAn/3xk6o=;
	b=31UxL7b9D8k5QRRpaDRZJI0PDKVNomjd5FTYpo3rcr4ejb/wLt/ZA3b7z+AP/SFVvUf0MK
	nxIckIcYJTvMKbDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zUTE5VCC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K7D4Oqms
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753367723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ApLtFpEql9jhX/JOpay3Z5EcRFeOqvph4BiAn/3xk6o=;
	b=zUTE5VCCy+3pgcps/1zZip2mWgZGsQd/Sm/5z1h4f12AgT2ZvMmzCGtbdXKhsHq3ozHZjn
	oNXeV3j4jR/c04iNuswspSuitLbq6obp/J8UzkbDL3n2zVd/AYSpGSq08kevo20wyE1cO9
	dHivDtg9V82jYDkLKcCIxGbgpwNLO6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753367723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ApLtFpEql9jhX/JOpay3Z5EcRFeOqvph4BiAn/3xk6o=;
	b=K7D4OqmsN5vCA/aSwMVez8oJS5aIBYV6F327wK7fDcpde2oQBW+rVF0mvMLwKci9eS4s22
	utOxsiX13gA/zSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A45FE136DC;
	Thu, 24 Jul 2025 14:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NW5EJ6tEgmgCNQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Jul 2025 14:35:23 +0000
Date: Thu, 24 Jul 2025 16:35:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org, 
	Prashanth Nayak <prashanth.nayak@netapp.com>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/1] NVMe/TLS connection issues to SPDK
Message-ID: <c0af190a-3e46-4203-aca9-da1017d2fd2e@flourine.local>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <546f62d0-3f1d-4619-a668-d087da5b44fc@suse.de>
 <aH5gYzXAIGdsCBsn@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <c523f9c3-06fb-4aa6-958f-e49e7c5477e4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c523f9c3-06fb-4aa6-958f-e49e7c5477e4@suse.de>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,flourine.local:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B6FCC1F394
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_073528_391626_09A192DB 
X-CRM114-Status: UNSURE (   8.29  )
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

On Tue, Jul 22, 2025 at 08:27:21AM +0200, Hannes Reinecke wrote:
> Ah, the NewSessionTicket thingie. Yes, that's completely pointless for
> NVMe, as we _never_ re-use tickets for session re-establishment.
> We only ever have one session, so the use-case of several short-lived
> sessions doesn't apply here.

Not following the discussion, can you either nacking this patch or give a
reviewed tag? Thanks.

