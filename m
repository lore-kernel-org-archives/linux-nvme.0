Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2EFC48298
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64tngT/KzLUjUjw8EFecWr/EJmXYWKeBylH5iyJoI/o=; b=LHuuGHDSDUQ/JZPyusso/Xcvdy
	1atXW4NRseuzxGPTM1deoAA9Crrxgoqwji7z8qiywO1XB6qGDpYrNiFGR2JIAznV7yM4L15JR+u16
	5VZR8jPJfOG6bcTzo3Ey+UtOXoSwESbEEDkwBul04D4reN+vRKcUsF2ypfezmT4yPHtp4tYqObM46
	OnT4T+ttMIqcT4+P6YZZd/UEEw9Z29vfeQCKkidAMUa3n/57nO1LFfB5m4cO9N6greZa6hWw6Rkfu
	Hw5Rxx81BVlbt6usgpkMiJh6rv3a1KuvY0TZyHF/LPU+ktQQdp/yX7ouqjaGhdKbCWb1mMVIOdrvY
	BIirtc2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWw2w-00000002m9z-3zO4;
	Mon, 05 Feb 2024 10:17:50 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWw2t-00000002m7w-09l8
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 10:17:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CD8722281;
	Mon,  5 Feb 2024 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707128264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64tngT/KzLUjUjw8EFecWr/EJmXYWKeBylH5iyJoI/o=;
	b=S4S9eLQk3Lo9nTj02hyVQu1v+whHjwLOB+zXevuybfCoBeWFzw+KzWrvlSQZ/CswXkK5A/
	w5rah4w/jA+cOO9gLJUKu9jzOpGupOtv4wvLwZDFsxyGy5B7UpUp/rd7v++Iuw74EG9XOJ
	6BYPpt4WwCBa+JjpPZ/mslk5cEaOFsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707128264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64tngT/KzLUjUjw8EFecWr/EJmXYWKeBylH5iyJoI/o=;
	b=jLqGNny7OiwQ7I4FIV5JAwAqAEwpJA6YNKf/oWI2Dcz0OCJPok80Ak+CX8VhwunMEf3tQQ
	0We8bW4u4Xs5h1Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707128264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64tngT/KzLUjUjw8EFecWr/EJmXYWKeBylH5iyJoI/o=;
	b=S4S9eLQk3Lo9nTj02hyVQu1v+whHjwLOB+zXevuybfCoBeWFzw+KzWrvlSQZ/CswXkK5A/
	w5rah4w/jA+cOO9gLJUKu9jzOpGupOtv4wvLwZDFsxyGy5B7UpUp/rd7v++Iuw74EG9XOJ
	6BYPpt4WwCBa+JjpPZ/mslk5cEaOFsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707128264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64tngT/KzLUjUjw8EFecWr/EJmXYWKeBylH5iyJoI/o=;
	b=jLqGNny7OiwQ7I4FIV5JAwAqAEwpJA6YNKf/oWI2Dcz0OCJPok80Ak+CX8VhwunMEf3tQQ
	0We8bW4u4Xs5h1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BDCC136F5;
	Mon,  5 Feb 2024 10:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4Ig6Hci1wGW6KwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 05 Feb 2024 10:17:44 +0000
Date: Mon, 5 Feb 2024 11:17:43 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Re: Re: Re: race between nvme device creation and discovery?
Message-ID: <m4mtj3s5v6wlgvcnir7skajafvekloufkzsodpjpqnzgpv3gfd@mievitjqki5p>
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
 <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
 <CAFL455kN3Y-ia5twzNRyuT1a+hDWwqS93C2XJDa1+_8nEom0gQ@mail.gmail.com>
 <CAFL455mLZ5j9Jkvo+AqKaAmyjDeTpZgKN2X53uytDD1uQTutHg@mail.gmail.com>
 <p2qty2zv6h5aq7mvbqbg3hbvwe5opuquq2sahcing6s7ezq5fp@dxbadmzjur5g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p2qty2zv6h5aq7mvbqbg3hbvwe5opuquq2sahcing6s7ezq5fp@dxbadmzjur5g>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.40 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[17.91%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_021747_244896_627D967E 
X-CRM114-Status: GOOD (  17.69  )
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

On Mon, Feb 05, 2024 at 11:07:48AM +0100, Daniel Wagner wrote:
> On Mon, Feb 05, 2024 at 10:20:54AM +0100, Maurizio Lombardi wrote:
> > po 5. 2. 2024 v 10:20 odesílatel Maurizio Lombardi <mlombard@redhat.com> napsal:
> > >
> > > I think I had a similar problem with nvme-stas some time ago, it tried
> > > to delete a controller right after it appeared in sysfs, causing race conditions
> > > with the init code path.
> > 
> > This is the problem I was talking about
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2eb94dd56a4a4e3fe286def3e2ba207804a37345
> 
> We have a 'state' attribute in sysfs already, though the
> NVME_CTRL_STARTED_ONCE is modelled as flag. Not sure how this fits
> together yet, so let me play with this.

If I got this right, we could just filter out all controllers which are
in the NEW state, because all transports trigger the connect code right
after the NEW state. At this point the sysfs should be completely
populated.

