Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7F606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sxEo7Uv1;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aEnMXzP8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a66CGG0f;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aEnMXzP8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a66CGG0f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hHLapWaB1i4b6SBJzbLzMOxdjOfqrKxst0Z6T4Vpd08=; b=sxEo7Uv1mdpxXgjTZIBvyiV7k3
	W65eDEwPyjqh7AeOdxfcSoSffOit2qNwyVDWn5zmmr6MCYxYrOzZOgBDbEGWaIKvK0ylri0ZHfUCa
	7YCi5xSdMNSF85KD2nn8TUQ7bfId5iNJGVCwiml4UpJa5/EiUYP9wOPteovkGS8u31dKMe5sqO1W8
	mIwiLjZ/HoLyLTAGMHS11y2/tJ2gjHKhW3aK3BIarmSqCRfYj+5cFaMwzqigeu2Oj8VzTl/IhQjwg
	bv4sK26T+8n7RIcGETWxCFzOnqAxXixoHj/Ez1uSnyYbVPa0jd3wJwc9smX23rgPPmBhH/kPutIDU
	fRIooRSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMpSh-0000000C7vZ-35p6;
	Fri, 30 Oct 2026 16:28:15 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMpSb-0000000C7vD-1ofO
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 16:28:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 858E11FC04;
	Fri, 30 Oct 2026 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793377685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHLapWaB1i4b6SBJzbLzMOxdjOfqrKxst0Z6T4Vpd08=;
	b=aEnMXzP8e2WaLfXfb/qahnj/AdYGbyptvLmiS9hLLfjEde74Mw9nsTBl25kzb+uLOxGH5w
	IRNJO4CXZIwhsEmECnhCFq1x2Sot8hZrtiQJRw7U9nmCuO2xVYAoS6Jhf38XtdYKPPaPkH
	2O5JKAm8uupnO5Tp+VCVPChlrf6uGhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793377685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHLapWaB1i4b6SBJzbLzMOxdjOfqrKxst0Z6T4Vpd08=;
	b=a66CGG0fN5AukwxoHOnVpD+3iviZuA53jBtCfkblQ+nKoYO8mpm2bRCuaFCT/ewgbJv+JC
	SflwZbyljrtx0UDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aEnMXzP8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a66CGG0f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793377685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHLapWaB1i4b6SBJzbLzMOxdjOfqrKxst0Z6T4Vpd08=;
	b=aEnMXzP8e2WaLfXfb/qahnj/AdYGbyptvLmiS9hLLfjEde74Mw9nsTBl25kzb+uLOxGH5w
	IRNJO4CXZIwhsEmECnhCFq1x2Sot8hZrtiQJRw7U9nmCuO2xVYAoS6Jhf38XtdYKPPaPkH
	2O5JKAm8uupnO5Tp+VCVPChlrf6uGhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793377685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHLapWaB1i4b6SBJzbLzMOxdjOfqrKxst0Z6T4Vpd08=;
	b=a66CGG0fN5AukwxoHOnVpD+3iviZuA53jBtCfkblQ+nKoYO8mpm2bRCuaFCT/ewgbJv+JC
	SflwZbyljrtx0UDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A68C13419;
	Fri, 30 Oct 2026 16:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Kz/D5XF5GrnFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 30 Oct 2026 16:28:05 +0000
Date: Fri, 30 Oct 2026 17:28:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/2] nvme-tcp: NIC topology aware I/O queue scaling
 and queue info export
Message-ID: <2f852433-b799-47b7-bf08-0b11070e49f4@flourine.local>
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
 <28fc7035-2beb-4f67-9a55-09b31d873608@flourine.local>
 <a9d3333f-3b70-45c7-ba79-7b441336415e@linux.ibm.com>
 <7c9343a2-d69a-4215-b2c7-0d9d412c2e0d@suse.de>
 <104ce7b7-dea4-4a08-912b-a8222ff73db7@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104ce7b7-dea4-4a08-912b-a8222ff73db7@linux.ibm.com>
X-Rspamd-Queue-Id: 858E11FC04
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_092809_625078_8684218D 
X-CRM114-Status: UNSURE (   8.78  )
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

On Fri, Oct 30, 2026 at 08:35:16PM +0530, Nilay Shroff wrote:
> > Alright, then I'll move this under sysfs and spin a new version.

FWIW, I can imagine that it might be useful to add some support in
nvme-cli, so sysfs would be the choice for this.

