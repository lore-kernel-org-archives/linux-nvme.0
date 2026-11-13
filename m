Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D05606A882
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ddvk5ybR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cifDVFcA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bB05LBt2gz1cGnfw6zM9f3lfuVOHO8kFX0AOQuYqJko=; b=ddvk5ybRwNX/aHhBv1jPK1xBja
	ELXM6wKBrrXxgpb9MBHn/n8xkYXTealHWHZ23aBtA6KxCilvR1MzyvJQUz407TTrXcG7F3j7r9A/A
	9/51a712K2J1/zNgXaTDSMum/M8Bm6XIKRrUE6hFi+7Go4fqK1fezl3cv+g3dBOlP2GjivBZ7bKYm
	yFZ2ZmAEZEsx4eyNlY1EsFO2ML0ZM8CGV2B52b09DeV77tWGdpRxS5vD3J/VmvBZCSIfQqrYZwczX
	UKKMvmYpKa/1ymhwQf8XUdNnRbBnKG5G5UrDo15SmZzt5ujxzc1ALfDs/jZiORBK4LWQojamnoEfv
	jT8Mde2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRsdy-0000000DFIQ-1HAO;
	Fri, 13 Nov 2026 14:52:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRsdw-0000000DFH4-2ITY
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 14:52:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C228162776
	for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 14:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E07F1F000C4;
	Fri, 13 Nov 2026 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581563;
	bh=bB05LBt2gz1cGnfw6zM9f3lfuVOHO8kFX0AOQuYqJko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cifDVFcAh4pm8i5TP26tJ7IYaI5f2Y9Tdowlz/x71HLt2B7trcbbIU49qMRIf1iOP
	 m4xSiOJR5beAmmVaAzCA5jOenCpa9bZ6TEjBv6wdfwIK2FEcEU6eapIbivrWGV6QT9
	 OWuNQFoMHTn0iHMYXbIqocLjA2K9egYvAtYeTPqhoFP75L3feloNzmpg9yx/EuJiO7
	 TpcvlbpwTlD/Y+FLpD/7MbQ9q8vSVTtUhQ6kX9fjuwWtDGRjk0sBn+E3bF6TX3LuKs
	 X07Obzyt7fPOoPZutwxyo2rJWzH0Uwc3pB2TlKpWtsbpC3Bjw3tLvgqfY6tPlLfLZH
	 gfxh/gAD/x1WA==
Message-ID: <sashiko-outbox-213019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 02/10] lib: Add a "stringset" data structure
To: "Chuck Lever" <cel@kernel.org>
Cc: linux-nvme@lists.infradead.org, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261112-tls-session-tags-v2-2-a587a50de7fc@kernel.org>
References: <20261112-tls-session-tags-v2-0-a587a50de7fc@kernel.org>
 <20261112-tls-session-tags-v2-2-a587a50de7fc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:52:42 +0000
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
- [Low] lib: stringset: malformed kernel-doc Return sections break
  htmldocs
--

commit 6b2f2a1d0a32f2df849790a6aef77082faf99b69
Author: Chuck Lever <cel@kernel.org>

lib: Add a "stringset" data structure

This commit introduces a sorted-array stringset data structure and API for
string membership testing and set intersection, along with its documentatio=
n.

> diff --git a/include/linux/stringset.h b/include/linux/stringset.h
> new file mode 100644
> index 0000000000000..fd41ea23f2b17
> --- /dev/null
> +++ b/include/linux/stringset.h

[ ... ]

> +/**
> + * stringset_add - Add a string to a stringset
> + * @set: An initialized stringset with available capacity
> + * @str: non-NULL string to be added to @set, in kmalloc'd memory
> + *
> + * On success, @str is now owned by @set and will be freed either
> + * by stringset_finalize() (if a content duplicate) or stringset_destroy=
().
> + * The stringset must have been allocated with sufficient capacity via
> + * stringset_alloc(). Strings must not be added after stringset_finalize=
()
> + * has been called. Callers must not hand the same pointer to stringset_=
add()
> + * more than once: ownership has already transferred, and a second add
> + * produces a double-free at stringset_destroy().
> + *
> + * Return:
> + *   %true: @str is now a member of @set
> + *   %false: @str could not be added (NULL, no capacity, or @set is
> + *           already finalized)
> + */

[Severity: Low]
Does the Return section here (and in stringset_add_dup() and
stringset_intersection()) need bullet markers (* %true: / * %false:)?

When Documentation/core-api/stringset.rst includes these kernel-doc
comments during make htmldocs, kdoc_parser strips the two leading spaces
after Return:, leaving two unindented lines (%true: and %false:) followed
by an indented continuation line without a preceding blank line or list
marker, which causes docutils to emit an "Unexpected indentation" error.
In the remaining multi-line Return sections (stringset_alloc(),
stringset_is_empty(), stringset_is_member(), and stringset_copy()),
omitting the list markers also causes the %true and %false descriptions to
collapse into a single paragraph in the rendered documentation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-tls-sessio=
n-tags-v2-0-a587a50de7fc@kernel.org?part=3D2

