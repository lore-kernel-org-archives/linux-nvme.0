Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4F606A8B7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PTAXb6hB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Czea2v3j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eMV3fy5t0VpY/FSLcuKHKvnqE+X2qfbYOgi2HRBKryk=; b=PTAXb6hBbLw17OGkZnVObjHfPR
	OYMKMSKIgsBhAwVBYmD+wv9/By6FsmHWoHYnhJnstw7xaPdevN3GODky93+MQaGA5BdD082q4KAtl
	fDDnfwFf5Gt0hvQjQdOYS4PvmHez9lPeSK6WF7uU6rGudg5hbB68SpmxRkUHJcgIu01OxUVpp0HnJ
	RfOJ8043Id6xyvZiH6gfPjDBD9A7Or4WiYGEWoGoWoeXnZw+UIfZZoVtQP5ifDU7iPYOj30Tp5y9q
	5kKwcESat86jeKAIrUvlBjrixFeS++KMPHvxy6SF3kx5iXQwpOSWt9Ig7xjZjY7UX2IhAvbYepMrt
	gosFFfCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoZQ-0000000CNVU-3Ihx;
	Fri, 13 Nov 2026 10:31:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoZP-0000000CNVO-45Av
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:31:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A11A84127F;
	Fri, 13 Nov 2026 10:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F301F000C4;
	Fri, 13 Nov 2026 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565907;
	bh=eMV3fy5t0VpY/FSLcuKHKvnqE+X2qfbYOgi2HRBKryk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Czea2v3jA1Slv9RRTOWAVO9Uct8INCn23GMuIBv4jdVZnuMTZhH+mKFAI18oOIRCG
	 RKxdKzNbRyXyym3ldge//q0+JToLF2dxXYMy9NI/N/VpwkRTQCPGX7ooWAF9VfsbNK
	 tezH2L5GY4rOAYpuTb9VdBOkzXcOQxdQRHy07gDv4VcgDu+OE1z7MJpra6X3lV0NWW
	 Yzgb1PvG38+iVnu/NyB6q5K/Gdx+l31J+vCgYE8Xr/9tI8KQ2ttbnLVwk3zteVwdLC
	 k24zS6sonl4BYtTnlA1PQgclXefzp55DEWhnJ2AyPcz0M7cjvM6746fEoPRcva7OZs
	 DyGYwIS6inIPg==
Date: Fri, 13 Nov 2026 11:31:42 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Arthur Simchaev <arthur.simchaev@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, Pankaj Raghav <pankaj.raghav@linux.dev>, GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, Avi.Shchislowski@sandisk.com, Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 0/2] Support for Multiple Atomicity Mode
Message-ID: <20261113105333.3-da.gomez@kernel.org>
In-Reply-To: <20261103093839.203841-1-arthur.simchaev@sandisk.com>
References: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com> <20261103093839.203841-1-arthur.simchaev@sandisk.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
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



On 2026-11-03T11:38:39+02:00, Arthur Simchaev <arthur.simchaev@sandisk.com> wrote:
> On Tue, Sep 29, 2026 at 01:17:10PM +0200, Daniel Gomez wrote:
> > While I think this small feature is worth having (hence this RFC)
> > for users sending atomic write commands that are contiguous, the
> > question I'd also like to discuss really is how to also expose clear
> > MAM semantics to userspace for users who can send larger commands,
> > so they avoid syscall overhead [2] and splitting, and still get the
> > atomic guarantees in the LBA subranges. RWF_ATOMIC currently exposes
> > SAM semantics, but I think MAM may be confusing for users, as it's not
> > simply a larger atomic write but an atomic carrier. Thoughts? What can
> > work best to leverage MAM from userspace without conflicting with SAM?
>
> Hi Daniel,
>
> I agree that RWF_ATOMIC should keep its current meaning: the whole write is
> untorn. Letting it accept larger writes on MAM devices would silently weaken
> that guarantee for existing users.
>
> If we want userspace to send one large write with per-piece guarantees, I would
> keep RWF_ATOMIC unchanged and add a separate opt-in flag that describes the
> guarantee rather than the device mode, for example (names are placeholders):
>
>   pwritev2(fd, iov, 1, pos, RWF_ATOMIC_CHUNKED);
>
>   - statx reports a granule G (e.g. stx_atomic_write_chunk)
>   - the range is split at file offsets that are multiples of G
>   - each piece is untorn; nothing is guaranteed across pieces
>
> If G is tied to atomic_write_unit_max, a G-aligned piece never crosses an atomic
> boundary, because the block layer already requires the boundary to be a power of
> two no smaller than unit_max. A SAM device could then implement the flag with
> one atomic bio per piece, and MAM would only be an optimisation underneath. Open

You mean a "fallthrough" for MAM while making SAM path an iterator?
I was thinking in something easier to start with like simply not
supporting SAM path in this RFW_ATOMIC_CHUNKED flag suggestion, and
return an error like we do today if you send a non atomic conformat io
with RWF_ATOMIC.

The "interesting" thing is (for NVMe MAM) that you can send a large
command and it will be atomic at the chunk boundary anyways. But I guess
users may want to have guarantees of their chunk atomic granularity.

> questions would be the semantics of partial completion and errors, and how
> filesystems keep each piece mapped to one contiguous extent.

Thanks for the suggestion. I plan to work on it after this series.

>
> Before adding a new flag, though: with this series your fio example (io_uring,
> iodepth_batch_submit=4) already sends four 16k RWF_ATOMIC writes as one 64k
> command, so a single large write would only save per-I/O work in the kernel, not
> device commands. I understand real MAM hardware may not be available, but that

HW is available for those who need it. FYI, I'm currently testing this
on a real device and post more details in a new revision.

> cost can be estimated without it, e.g. by comparing host CPU usage of a batch of
> small O_DIRECT writes against one large write of the same total size on any NVMe
> device. Even a relative number (e.g. % CPU per GB written) would show whether
> the remaining overhead justifies new uAPI.

100%.

Thanks Arthur for the review. I talked with Keith at LPC about this so
I was planning to resend it. I will now, take your suggestions and send a
new version.



