Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A21C4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85+E0VpvArWKg1KL7PFWDdwa9GmPlU5dScLhcsU8kLc=; b=uLgdEOAlyXGwZfARrohvQSjmb0
	ouoJuGhOtaYyuQ0+btcgY6CK2+uP4yi5kP2LNZ5KqelOGVaw9THPmWlr518qRK6O+i75h29JYekA2
	cdFDfsk2ujkH3ncLNyzjQE7Me0HxsEv9VK01rWXw3Qgq+ctorXCTIuzn7nFTBesm2s4bAJhjjqP7L
	6TraWUExlatBOC5k0qR5ZXYkMq7/6d+4A+Up0/8HSa86e5rvOK3/XT95QypA6Re2Cak9Lt2ULH5Z8
	xwphetw2zI7oT1v/WnMFAqVNRXrzFyRsekI7WX06BWXgaa96Vcm79z4qDlWiE6ogjRWU1KMxlnM5/
	fQA677WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBaWY-00FeeG-2G;
	Fri, 08 Dec 2023 13:04:10 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBaWV-00FedK-2n
	for linux-nvme@lists.infradead.org;
	Fri, 08 Dec 2023 13:04:09 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9A7B1F393;
	Fri,  8 Dec 2023 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702040644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85+E0VpvArWKg1KL7PFWDdwa9GmPlU5dScLhcsU8kLc=;
	b=P2yiZHMDTnC9HhlxBoK21+5j8O0bshSj13uY7M/RLbBZXc62TyU7wg+w9Z+PQs08N1G6YH
	Bvx4zvwv/SQ+Uu35Sj90I82zQAsj3OvDpI76JW5rTU2i8rG09sQ3fWrG6WM1e532f71l3w
	ZDy9dLE+1PmqllJaMDSUTwfcpIrObKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702040644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85+E0VpvArWKg1KL7PFWDdwa9GmPlU5dScLhcsU8kLc=;
	b=35ZEnRfUOLYrArdaXfwtRUoMvzEQRqrUVU2YZXA/hFTIMHjmoSZ0A5cYXhnSQbnHZrksA7
	ssuiy82FJ05y0SDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702040643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85+E0VpvArWKg1KL7PFWDdwa9GmPlU5dScLhcsU8kLc=;
	b=qJjTYSTT4ccQkfmW8ieIbTyZRbG2iZ9uMAJ3pJaob97JxMfebPN7lfKJAFTRqTj4ho/8XR
	9e7RLYcd+0kjoUSgWKjDvGfchCGLcSEI1flwOtv2MY93ruIHnUa3bDIwTGDUC8mIIPuPp/
	w1qFQ0bhXlH4VkEJd5UrUwykkbvdrKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702040643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85+E0VpvArWKg1KL7PFWDdwa9GmPlU5dScLhcsU8kLc=;
	b=J+ec8WjB/Gk8Q88IhbjqhY561bNd6rBtC6gP9av78FVYcD9AxYk/uFzLVfHVia4z+yanl5
	DvP8/sPz3tPBuhBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C6464138FF;
	Fri,  8 Dec 2023 13:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id I9r0LkMUc2X7eAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 13:04:03 +0000
Date: Fri, 8 Dec 2023 14:04:03 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/4] nvme: move ns id info to struct nvme_ns_head
Message-ID: <xf5gzrsqsc3a73vfjzpqsjgbvjuaifzazgtqsxeyhnyxzcksj7@ssodhov7n6ny>
References: <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-2-dwagner@suse.de>
 <ZXHzVN3jmIIsGyeq@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXHzVN3jmIIsGyeq@kbusch-mbp>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qJjTYSTT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J+ec8WjB;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-13.37 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.36)[90.55%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: D9A7B1F393
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_050408_060513_53B3C7EB 
X-CRM114-Status: GOOD (  14.93  )
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

On Thu, Dec 07, 2023 at 09:31:16AM -0700, Keith Busch wrote:
> On Thu, Dec 07, 2023 at 01:36:21PM +0100, Daniel Wagner wrote:
> > @@ -1906,7 +1908,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
> >  	 * or smaller than a sector size yet, so catch this early and don't
> >  	 * allow block I/O.
> >  	 */
> > -	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
> > +	if (ns->head->lba_shift > PAGE_SHIFT ||
> > +	    ns->head->lba_shift < SECTOR_SHIFT) {
> >  		capacity = 0;
> >  		bs = (1 << 9);
> >  	}
> 
> A minor conflict here: this series would target nvme-6.8, but the block
> tree we're based on doesn't have this code. I'll patch it up for the
> current 6.8 tree and make a note of the conflict for the next merge
> window.

I've missed that nvme-6.8 was available now. I can rebase v5 ontop of
nvme-6.8 if you want me to do it. Whatever is simpler for you.

