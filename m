Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0B0C48BC3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 22:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhVHfbYrXzhfXFBgvCaTvPo61AcJ2SJpQ0r3nOcOMWo=; b=4OEa3wx+6JOCVIRI39pGRg79XV
	tATlodxCiYcFYYSgcj8JACV86N6LQ3v6dZGwn5MU/+6waNcJS9RfpbbEA7ijC0b70lYrZKCXg+mVY
	yH/fj/CeI/VTcUJI015JCRRFYr2epkr1jd+/truty45TjRBrDfkfbiP9muWVzTPT2zcAWI9jYjbZd
	0pf8IHbj+PC2hwd6UYBlYX4u4+n3B0h6yijWmxE029IvrjZid1/qW09mgfVjICpJpCxDDR2pfd+Gw
	4btGHnshXqbgIK4tZE9kP8PLvddGTCJT3dvjKb2ht7ZXWioSRwDHsrF2NKtOYRBCwDYsMI5WeIslE
	D4EGLSDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCOY-0000000CTLT-1LIa;
	Mon, 19 Feb 2024 22:45:54 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCOQ-0000000CTGH-0tbb
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 22:45:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8E85220C1;
	Mon, 19 Feb 2024 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708382742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhVHfbYrXzhfXFBgvCaTvPo61AcJ2SJpQ0r3nOcOMWo=;
	b=ffBLsxdkxs2Vl2iAehHqNwc/J/goXUBfsvO3BNlP2NGTF1DhODsMjvGv1o/JZf/aFhBx7k
	jsDKJmnyATkUa2KxIqRua8yDpw/ferwWezTZN1hzjjbcnHgUbPW4jmp9J4fypF+b/rRs6/
	w1WN/hkgkKf3ys8LyQqTkzAanKcx7HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708382742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhVHfbYrXzhfXFBgvCaTvPo61AcJ2SJpQ0r3nOcOMWo=;
	b=qSDppZHj9xv7ph4gNovDdeF0vGhlKJd4Cwy3Dz0LIkby7qqEPkEO+ZjfJ1aqKVFqPl7cCc
	zcV8tkGZfhuNHcDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708382742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhVHfbYrXzhfXFBgvCaTvPo61AcJ2SJpQ0r3nOcOMWo=;
	b=ffBLsxdkxs2Vl2iAehHqNwc/J/goXUBfsvO3BNlP2NGTF1DhODsMjvGv1o/JZf/aFhBx7k
	jsDKJmnyATkUa2KxIqRua8yDpw/ferwWezTZN1hzjjbcnHgUbPW4jmp9J4fypF+b/rRs6/
	w1WN/hkgkKf3ys8LyQqTkzAanKcx7HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708382742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhVHfbYrXzhfXFBgvCaTvPo61AcJ2SJpQ0r3nOcOMWo=;
	b=qSDppZHj9xv7ph4gNovDdeF0vGhlKJd4Cwy3Dz0LIkby7qqEPkEO+ZjfJ1aqKVFqPl7cCc
	zcV8tkGZfhuNHcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 784A8139D0;
	Mon, 19 Feb 2024 22:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id khfXCxPa02ULVQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Feb 2024 22:45:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Matthew Wilcox" <willy@infradead.org>
Cc: "Mike Rapoport" <rppt@kernel.org>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
In-reply-to: <ZdO2eABfGoPNnR07@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>,
 <Zb9pZTmyb0lPMQs8@kernel.org>, <ZcACya-MJr_fNRSH@casper.infradead.org>,
 <ZcOnEGyr6y3jei68@kernel.org>, <ZdO2eABfGoPNnR07@casper.infradead.org>
Date: Tue, 20 Feb 2024 09:45:36 +1100
Message-id: <170838273655.1530.946393725104206593@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_144546_433127_A3BD1494 
X-CRM114-Status: GOOD (  21.45  )
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

On Tue, 20 Feb 2024, Matthew Wilcox wrote:
> On Wed, Feb 07, 2024 at 05:51:44PM +0200, Mike Rapoport wrote:
> > On Sun, Feb 04, 2024 at 09:34:01PM +0000, Matthew Wilcox wrote:
> > > I'm doing my best to write documentation as I go.  I think we're a bit
> > > better off than we were last year.  Do we have scripts to tell us which
> > > public functions (ie EXPORT_SYMBOL and static inline functions in header
> > > files) have kernel-doc?  And could we run them against kernels from, sa=
y,
> > > April 2023, 2022, 2021, 2020, 2019 (and in two months against April 202=
4)
> > > and see how we're doing in terms of percentage undocumented functions?
> >=20
> > We didn't have such script, but it was easy to compare "grep
> > EXPORT_SYMBOL\|static inline" with ".. c:function" in kernel-doc.
> > We do improve slowly, but we are still below 50% with kernel-doc for
> > EXPORT_SYMBOL functions and slightly above 10% for static inlines.
>=20
> Thanks for doing this!  Data is good ;-)
>=20
> I just came across an interesting example of a function which I believe
> should NOT have kernel-doc.  But it should have documentation for why it
> doesn't have kernel-doc!  Any thoughts about how we might accomplish that?
>=20
> The example is filemap_range_has_writeback().  It's EXPORT_SYMBOL_GPL()
> and it's a helper function for filemap_range_needs_writeback().
> filemap_range_needs_writeback() has kernel-doc, but nobody should be
> calling filemap_range_has_writeback() directly, so it shouldn't even
> exist in the htmldocs.  But we should have a comment on it saying
> "Use filemap_range_needs_writeback(), don't use this", in case anyone
> discovers it.  And the existance of that comment should be enough to
> tell our tools to not flag this as a function that needs kernel-doc.
>=20

Don't we use a __prefix for internal stuff that shouldn't be used?

NeilBrown

