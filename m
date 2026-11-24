Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E647606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mwue5oPa;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXlVDEjo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GPdlpMaV9B9H+5mUiWoXm0dHDRx+tPUGbDQufOLp/FM=; b=mwue5oPatduI/n6jYN4nM+62SL
	xRgOgnZiNqCPaI9Ov5hOIhoRhuMc9nmI23StIIUfDgF+QqnsHbB6fh9n0gRxXB8qytIpcIXq5KScq
	JqbN8UfV4C1MMZsES3AJmUHj+ry2ZzZ9JDiorQX2NcYRCQYmwO097WN9Y4QO16aBhmvJYOuConxcC
	nLZH7dry1mfsk+LSqUBQ3BDPIULD+/QbmAE4t97UG68Di21qbiHBtYdOTxzpq8fc2bOEngbfDFovR
	ZvKHX9hjCh45AtnWHFRj1F5pdCyOjiIR1kp236bbFTUXMLzQ++Pq4mdSmXWIiGdgn7BupYx78Srdi
	aB89ATKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVwrt-00000007hoI-0A9q;
	Tue, 24 Nov 2026 20:11:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVwrr-00000007hoB-2P5Y
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 20:11:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E63DA61B62;
	Tue, 24 Nov 2026 20:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73781F000CF;
	Tue, 24 Nov 2026 20:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551114;
	bh=GPdlpMaV9B9H+5mUiWoXm0dHDRx+tPUGbDQufOLp/FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BXlVDEjoWFBKlFX4dY5Y6SZzpsmoiCusaWPr4DnP6xsb/M3XuR+4kupDz9RNMI67m
	 2Wbrg9mJ2ZaO/5B8FgxEhmJ1cYuWHpr3J6iJhdYN726R2xVcNlk/6v0161FpVE32Ic
	 2lXkCYc6BlzoFxPmt3Q0GF1D1Ox6HdAM14m1DtYDxdsh9Ds1GizqTW3UAslmZBOCd4
	 sgJ3xoCGo/+MtVLfrA2/BoAjB/mEZn9kVr/TjYsuKUhs8skYcv3JQNBi4YTeZku3yO
	 XYqQJwTpY8Ze0TJsrbXQwhqt99evufmpisy58eIET7dF7t6GrXBO6ICT97J2HrBLds
	 918HnQ2RuDMog==
Date: Tue, 24 Nov 2026 20:11:52 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
Message-ID: <20261124201152.GA2227373@google.com>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
 <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
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

On Tue, Nov 24, 2026 at 11:30:42AM +0100, Hannes Reinecke wrote:
> > Neither of those requires replacing 'struct nvme_dhchap_key' with
> > 'struct key' at runtime, or synthesizing random-UUID keys in ".nvme"
> > when raw secrets are passed.  Doing that adds a lot of complexity and
> > opportunity for bugs (as Sashiko's review already seems to show), for no
> > real gain.  Note that 'user_key_payload' still lives in slab memory just
> > like 'struct nvme_dhchap_key' does.
> > 
> > The semantics of the keyrings subsystem just don't match storage very
> > well, and it's quite hard to integrate with correctly.  In fscrypt, I
> > had to deal with a lot of bugs before moving away from the keyrings
> > subsystem almost entirely, due to issues with per-process keyring
> > scoping, delayed key destruction, locking, and LSM checks.
> > 
> Hmm.
> 
> > This series already runs into the first of these: patches 8-9 use
> > request_key(), which only searches the caller's process keyrings and
> > won't even find ".nvme".  And keys are no longer wiped synchronously
> > with kfree_sensitive(), but rather whenever the last reference is
> > dropped and the garbage collector gets around to it.
> > 
> But I sincerely would hope that the key subsystem will wipe them correctly
> eventually, right?

It happens asynchronously, and processes can look up the keys by serial
number and pin them in memory.  Even a process without permission to
access the key can pin it in memory temporarily.  Not a huge issue, but
it's an unnecessary complication, which caused problems for tests that
tried to verify that keys were gone.  It was nice to finally fix this in
fscrypt (by no longer using the keyrings subsystem).

> > Note that NVMe-TCP TLS isn't a relevant precedent here, either.  TLS
> > handshakes run in userspace (tlshd), which needs to read the PSK via
> > keyctl, whereas DH-HMAC-CHAP is done entirely in-kernel.
> > 
> > This series also gives the 'dhchap' key type a ->read() method, so even
> > pre-populated keys remain readable from userspace via keyctl_read() (by
> > default, by any possessor).
> > 
> Which is kinda the main idea. And it's no different from the current
> behaviour, where the DH-CHAP keys remain visible via sysfs.

Keys not being readable from userspace is one of the usual reasons
people think they want to use the keyrings.  The cover letter should say
what this series is actually trying to accomplish.  Currently, it only
mentions making it so that keys no longer need to be specified on the
command line.  But when stated like that, it's a userspace issue: if the
nvme program doesn't accept keys on stdin like keyctl does, that's an
issue in the nvme program, not the kernel.

So that leaves the cover letter not stating any real motivation for
these kernel changes, as far as I can tell.

> > And inserting raw secrets into ".nvme" with KEY_USR_READ makes them
> > readable via keyctl_read() by any process running as uid 0, even without
> > CAP_SYS_ADMIN and without access to sysfs or configfs.  Due to the
> > KEY_USR_* permissions on ".nvme" and the keys, such processes can also
> > invalidate or revoke in-use keys, breaking authentication.  (Separately,
> > the existing nvmet dhchap_key and dhchap_ctrl_key configfs attributes
> > are 0644 world-readable, which should be fixed regardless.)
> > 
> Again, one could argue that this was the intention.
> The idea behind this patchset is to separate key provisioning from
> key usage; the DH-CHAP key values have to be present whenever the
> nvme subsystem is doing a reset, and the current way of providing
> them via the nvme-cli command-line requires quite some instrumentation
> to insert the correct settings.
> It also makes integration with other entities providing external
> DH-CHAP keys quite hard as these entities have to deal not only with
> the kernel side (to trigger re-authentication), but also the whatever
> tooling is there to generate the nvme-cli commandline.
> 
> Moving to a separate storage for DH-CHAP keys hence seemed appealing
> to me, especially as we already have a keyring integration, so adding
> another key type for DH-CHAP felt quite a natural step.
> And it allows for an easy integration with external key providers,
> as adding keys to the key store is a quite simple process and
> doesn't require you to integrate with nvme-cli tooling.

It sounds like the idea is that the kernel would look up the 'struct
key' by description again at runtime, such as on reset?  But this series
doesn't actually do that.  The lookup just happens once, when the option
or sysfs/configfs attribute is written to.  The key is not updatable
either, so an external provider that rotates the key has to write to the
attribute.  So there's no benefit to keeping the 'struct key' around
after that write.

> > How about keeping 'struct nvme_dhchap_key' as the runtime
> > representation, and just parsing into it up front in 'opts' and
> > 'nvmet_host'?  The sysfs/configfs 'show' methods could re-encode the
> > secret if really needed, though not exposing it at all would be better.
> > 
> It really feels naff to have this structure. We already have
> a 'struct key', providing basically all the features we need.

Could you elaborate on what those features are, in your view?  It
doesn't seem like you're using anything other than the provisioning by
description, which doesn't require keeping the 'struct key' around.

> > Then if keyring-based provisioning is still wanted so config files don't
> > need raw secrets, it could work like "fscrypt-provisioning" keys: define
> > a write-only key type (no ->read(), ->update(), or ->revoke()), look up
> > the key by serial number with lookup_user_key() once when the
> > option/attribute is written, copy the decoded key (and description, if
> > needed for 'show') into 'struct nvme_dhchap_key', and immediately
> > key_put() it.
> > 
> The main idea here is to allow for external provisioning of the keys,
> which then can be looked up by nvme-cli tooling to assemble the
> actual command-line.
> The write-only key method would leave us with an abstract key serial,
> which then will have to be passed between the key provisioning tooling
> over to nvme-cli. Which really doesn't gain us anything.
> 
> > Raw secrets wouldn't touch keyrings at all, and the keyrings subsystem
> > would stay out of the runtime path.
> > 
> Main issue here is to keep compability with previous versions.We currently
> have 'dhchap_secret' and 'dhchap_ctrl_secret' sysfs
> attributes holding the encoded DH-CHAP keys.
> And these values are written to the configuration file to be
> able to re-establish the connection upon the next boot.
> So whatever we do, we need to have 'something' in here allowing
> us to identify the DH-CHAP key. So a key serial is out of question
> here (we tried that with TLS, and failed miserably).
> 
> So really we just use the keystore to be able to lookup external
> keys; I really want to get away from having to store the keys
> as a file or in encoded from in the configuration file.

If it needs to be a stable string it could be a key description instead
of a key serial.  The point is the same.  Note that the kernel can keep
around the key description to return in the sysfs attributes even if it
doesn't keep the 'struct key' itself; see dm-crypt for example.

Anyway, separately from that, the user-configurable dhchap_keyring still
seems odd.  It's consulted only when dhchap_key is written to, and that
might as well do the lookup in the process's keyrings similar to what
dm-crypt's support for keyring keys does.

- Eric

