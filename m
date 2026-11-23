Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B9606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U83pFXee;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7v5HFrd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oK69RON+lsCt00ViP4o69fvdYWZ6O8Adv4O6ypLAgdk=; b=U83pFXeeGQYBgRs3hsxSBs7uuS
	jS2Caa1Tq/PDHtw10fDg+r71279Diq5g9n4zEYDWv6gVwkd3Vb4jUTmPqhiSfjDD8KLIAyzyNmfJy
	k9A0QCw09Rq53IsQ669lXGwsyZ5Eod7BSXXXmYi5+rVH8S07z+nVKSbjGMjIl7FVihEcJqxEndUd7
	LpRbz5aps0TIMJCYxXE77yMyZ3wsCyaSjtwLaGKK2yy0azGaCvd2MXWn4HGRgQW4FxTzFlBIKtF3H
	nCZtg4Xubrh+B9l7v3AtA1BVBUbjHLf+CvvCM7cxWzj8XNNgEMW/aeIeMxzOLPr9Ieoy1tVLBuvFi
	2+G2oWTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVbTJ-00000004xQg-41jD;
	Mon, 23 Nov 2026 21:21:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVbTI-00000004xQW-04pn
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 21:21:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9EE8041659;
	Mon, 23 Nov 2026 21:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A1E1F000C0;
	Mon, 23 Nov 2026 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468867;
	bh=oK69RON+lsCt00ViP4o69fvdYWZ6O8Adv4O6ypLAgdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H7v5HFrdX453GUoX1AkV9s3bworAQ4Z9Vz8MM83NcgW9jAZyG2cPfzrke4f65hOjr
	 nMXfvS8nwJiRG7/buZ5j4im7v4vHTk2K77zB6brcTxvdaI+gnyj+c7GQd7zMRINk6H
	 F8pZX0S+0I2pmcsiMsTd7s+Nw7Dc6iZjUZAaXBrmIXYMmQHdAN4Ru+ybK1pM/l3Am3
	 VpBqNmU996R7gqDAvBdo5M0qTYVDe9GMVXfYPAugt5QsvIj3S6EryKXE1jGJsBt+B6
	 jCobdoJsrc27tfktCHbxurRDhXcieLMgp/xlukYErj7DqFIPf1/PvWzT5crlZ6i2kl
	 eeolWwu2pFrfg==
Date: Mon, 23 Nov 2026 21:21:05 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
Message-ID: <20261123212105.GA18468@google.com>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
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

[ +Cc keyrings@vger.kernel.org ]

On Mon, Nov 23, 2026 at 06:10:00PM +0100, Hannes Reinecke wrote:
> Hey all,
> 
> the current NVMe authentication code is using a hand-crafted key
> structure; idea was to have the initial implementation with a minimal
> set of dependencies.
> (And me not having a good grasp on how to use the kernel keyring :-)
> That had the drawback that keys always had to be specified on the
> nvme-cli commandline, which is far from ideal from a security standpoint.
> 
> So this patchset switches the authentication code over to use the
> kernel keyring. User-facing interface (namely argument to 'nvme
> connect') remain the same, but the key data is converted into keys
> which are stored as a new key type 'dhchap' with a random UUID as
> description in the kernel keyring.
> 
> With this I have updated the dhchap arguments to 'nvme connect' and
> the configfs interface to either be the keydata (ie the original
> interface) _or_ a key description referring to a pre-populated dhchap
> key in the kernel keyring. This allows for easier provisioning of keys
> and avoids the security risk from having to specify the key data on
> the kernel commandline.
[...]
>  16 files changed, 1140 insertions(+), 386 deletions(-)

This should have been Cc'ed to the keyrings mailing list.  I found it
via lore search.

As far as I can tell, this series is trying to do two main things:

    (1) parse secrets up front instead of keeping raw "DHHC-1:..."
    strings around in 'opts' and 'nvmet_host'; and

    (2) let userspace reference pre-loaded keys in a keyring so
    cleartext secrets don't have to live in config files or
    sysfs/configfs 'show' output.

(Patch 7's flush_work() change looks independent of the rest.)

Neither of those requires replacing 'struct nvme_dhchap_key' with
'struct key' at runtime, or synthesizing random-UUID keys in ".nvme"
when raw secrets are passed.  Doing that adds a lot of complexity and
opportunity for bugs (as Sashiko's review already seems to show), for no
real gain.  Note that 'user_key_payload' still lives in slab memory just
like 'struct nvme_dhchap_key' does.

The semantics of the keyrings subsystem just don't match storage very
well, and it's quite hard to integrate with correctly.  In fscrypt, I
had to deal with a lot of bugs before moving away from the keyrings
subsystem almost entirely, due to issues with per-process keyring
scoping, delayed key destruction, locking, and LSM checks.

This series already runs into the first of these: patches 8-9 use
request_key(), which only searches the caller's process keyrings and
won't even find ".nvme".  And keys are no longer wiped synchronously
with kfree_sensitive(), but rather whenever the last reference is
dropped and the garbage collector gets around to it.

Note that NVMe-TCP TLS isn't a relevant precedent here, either.  TLS
handshakes run in userspace (tlshd), which needs to read the PSK via
keyctl, whereas DH-HMAC-CHAP is done entirely in-kernel.

This series also gives the 'dhchap' key type a ->read() method, so even
pre-populated keys remain readable from userspace via keyctl_read() (by
default, by any possessor).

And inserting raw secrets into ".nvme" with KEY_USR_READ makes them
readable via keyctl_read() by any process running as uid 0, even without
CAP_SYS_ADMIN and without access to sysfs or configfs.  Due to the
KEY_USR_* permissions on ".nvme" and the keys, such processes can also
invalidate or revoke in-use keys, breaking authentication.  (Separately,
the existing nvmet dhchap_key and dhchap_ctrl_key configfs attributes
are 0644 world-readable, which should be fixed regardless.)

How about keeping 'struct nvme_dhchap_key' as the runtime
representation, and just parsing into it up front in 'opts' and
'nvmet_host'?  The sysfs/configfs 'show' methods could re-encode the
secret if really needed, though not exposing it at all would be better.

Then if keyring-based provisioning is still wanted so config files don't
need raw secrets, it could work like "fscrypt-provisioning" keys: define
a write-only key type (no ->read(), ->update(), or ->revoke()), look up
the key by serial number with lookup_user_key() once when the
option/attribute is written, copy the decoded key (and description, if
needed for 'show') into 'struct nvme_dhchap_key', and immediately
key_put() it.

Raw secrets wouldn't touch keyrings at all, and the keyrings subsystem
would stay out of the runtime path.

- Eric

