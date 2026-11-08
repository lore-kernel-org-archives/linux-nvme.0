Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6B606A322
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZNvpdpte;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjnJiKhm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+EZH2jyGgPaBdWe8HIIwVmJ0BqWFPii6GucH24sJEzA=; b=ZNvpdpteYm3LoXPLYXxh/r8Qc/
	qjOZLq5RuB2ZLOEcfjJnYZiu20SIdZBGW2/AEZbDKjs6W31vjonQd0TYd62saHbmDee3gdGnYa7pP
	zF2SIWp0rDev3NdgniNxaf5ePAT3O4L1eyDjADurhrwcs9UnHnP2X1Evy6urp/VYafplOuhJGDts1
	VrO2tUA5xyRgMtQFmHRkF4cG0H753gPsA2tY0/crBNaIEYw0PLI1jFRC5S8nS51sgq33TVLfxj9o5
	ksxkWQQ0benh9DrfdoFRI2Oe702i/mD5DDqKmTurui6YoLv51ZBfvQME0CfgLn9BLGRKLfYUJPQCw
	2L26mGJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA2B-0000000Geuf-13Pw;
	Sun, 08 Nov 2026 21:02:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQA29-0000000GeuX-36xq
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 21:02:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B81A44D30;
	Sun,  8 Nov 2026 21:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75A31F008A3;
	Sun,  8 Nov 2026 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794171756;
	bh=+EZH2jyGgPaBdWe8HIIwVmJ0BqWFPii6GucH24sJEzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bjnJiKhmfKUiXf+7eTtV+4QKUh7nnChW7x8e0DwrWPPUbrh+hs+VoC4IixpXAhbQV
	 9MIgOxk5DHHoc863hMhcvLwhGh5ZfDk4Qwg8/B9fl44dUReY5MSDUxis6SkjwR42V9
	 enRbasVgu3VRU+As6VMvMYQl+xlTgvxU5u2dU4UYNR5lpCqmPvLRgeAryTGiamA9hT
	 TzlVIWcuqnavdHYkrasGZZmCi1FwOsUbcyeSHx9Rihy/8OBhloNtyWhwQaxky2FqIb
	 fVjEUlgpYNYyR4mDnghrtjwGnYTewWW78jcrk2wTU6qfnSKoABtuKB+IVfwmiQQKOD
	 UBzbZCHePNA/Q==
Message-ID: <sashiko-outbox-204044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/29] libmultipath: Add sysfs helpers
To: "John Garry" <john.garry@linux.dev>, james.bottomley@hansenpartnership.com, mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, snitzer@kernel.org, jmeneghi@redhat.com, bmarzins@redhat.com, dm-devel@lists.linux.dev, hch@lst.de, michael.christie@oracle.com
In-Reply-To: <20261108204733.557995-9-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
 <20261108204733.557995-9-john.garry@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:02:35 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] libmultipath: duplicate parser and ambiguous return in
  mpath_iopolicy_store()
--

commit 12aacc0c8ac98ed4ae873a73979622db40d4f52b
Author: John Garry <john.garry@linux.dev>

libmultipath: Add sysfs helpers

This commit adds sysfs helpers and attribute group definitions for showing
and updating the multipath I/O policy and displaying per-NUMA-node device
paths.

> diff --git a/lib/multipath.c b/lib/multipath.c
> index cdf8fbc5105b3..ae5a73d570b33 100644
> --- a/lib/multipath.c
> +++ b/lib/multipath.c
> @@ -620,6 +620,100 @@ void mpath_device_set_live(struct mpath_device *mpa=
th_device)

[ ... ]

> +static void mpath_iopolicy_update(enum mpath_iopolicy_e *iopolicy,
> +		int new)
> +{
> +	int old =3D READ_ONCE(*iopolicy);
> +
> +	if (old =3D=3D new)
> +		return;
> +
> +	WRITE_ONCE(*iopolicy, new);
> +
> +	pr_info("iopolicy changed from %s to %s\n",
> +		mpath_iopolicy_names[old],
> +		mpath_iopolicy_names[new]);
> +}
> +
> +bool mpath_iopolicy_store(enum mpath_iopolicy_e *iopolicy, const char *b=
uf)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mpath_iopolicy_names); i++) {
> +		if (sysfs_streq(buf, mpath_iopolicy_names[i])) {
> +			mpath_iopolicy_update(iopolicy, i);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(mpath_iopolicy_store);

[Severity: Low]
Can mpath_iopolicy_store() reuse mpath_iopolicy_parse(), and how can callers
tell whether the policy actually changed?

lib/multipath.c already defines mpath_iopolicy_parse() using
__sysfs_match_string() to match against mpath_iopolicy_names[].  Also,
because mpath_iopolicy_store() returns a bool that is true for any valid
policy name even when old =3D=3D new in mpath_iopolicy_update(), a sysfs st=
ore
caller cannot both reject invalid strings with -EINVAL and avoid clearing
cached paths and flushing requeue_work when the existing policy is written
again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108204733.5579=
95-1-john.garry@linux.dev?part=3D8

