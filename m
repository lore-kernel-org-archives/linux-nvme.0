Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC09606A331
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2HEFUFG3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJEhYlnn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UD6R5o+6RbaHaSppSQR3YWlOAJjGAmF+PnVW+7XYeQM=; b=2HEFUFG32gysY9fbAdSqM+WBfW
	EjGcbFFsJ5aVHnJ3YaNPWCloe+P4L5rvmgNUIZcQ0SJ26PAFb2zlYpASzbXbsAJryo4U6hPZnehL+
	8OvDSq9H2S7nwui6B63LkPlpJ2rmEruvrhI+kSnvESzr1+3KumSLGKH7OAqNsxrTsMKNffOJ4dcX2
	3aT8wPzXfGTSXzT3DxUVbWwsG7mgGCdNiya3vrY5z9QSfsbxddibvVbmsMeSu6qFV7Gbd7392HwGu
	d2mv8g7xkoMz7XW2V8lyN0MNXQMyhF7Ik0vOIag2DpHTD2P3YANiWwkUwayNoEPSyo1aMz5u3qSi3
	MPCoppwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRse2-0000000DFLz-27Q5;
	Fri, 13 Nov 2026 14:52:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRsdx-0000000DFHk-0cuB
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 14:52:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9653262792
	for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 14:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125481F000C5;
	Fri, 13 Nov 2026 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581564;
	bh=UD6R5o+6RbaHaSppSQR3YWlOAJjGAmF+PnVW+7XYeQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJEhYlnnCekWeLgObXGrHZYYIZzZ6wUTzshfi7jv/jC90gKb9kTrpZzwqKcDyILnv
	 MkWys54WhsOSDM90rbLGAQuWz8SF2YEP+sxiYJwOZyMdU+fNHyXHIYQBNKQJLA3nc5
	 fcnk87ehNWBdDWOlaxs+oOscPtRXCSK0aljfaW77pBuK0/EJVJH8HO4HMHpZVJ7lAE
	 ZA/+Am9yKCwrJQ14qdw9ISMloTQgkdckzOlfEpGMDxnfFe6Bh0OtKODrNnDl4jxKZJ
	 rPFgEcjO6sDGrqyVkv3FY0ix+wV9GDTkbdFv1wKQRJcBEqo5fdlxgBj5V7TvJNOXrl
	 xAUzeL0MOan+A==
Message-ID: <sashiko-outbox-213023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 06/10] handshake: Add a kunit test for the
 completion gate
To: "Chuck Lever" <cel@kernel.org>
Cc: linux-nvme@lists.infradead.org, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261112-tls-session-tags-v2-6-a587a50de7fc@kernel.org>
References: <20261112-tls-session-tags-v2-0-a587a50de7fc@kernel.org>
 <20261112-tls-session-tags-v2-6-a587a50de7fc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:52:43 +0000
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
- [Low] handshake: unrelated sessiontags KUnit changes squashed into
  commit
--

commit b879c6737fc8615a84b7321f23d468457911d409
Author: Chuck Lever <cel@kernel.org>

handshake: Add a kunit test for the completion gate

This commit exports handshake_try_complete() and handshake_finish_complete()
for KUnit and adds a test case verifying completion gate exclusivity, along
with updates to the session-tag duplicate KUnit tests.

> diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-tes=
t.c
> index 21fccfa94d897..b6992d1fa4ce4 100644
> --- a/net/handshake/handshake-test.c
> +++ b/net/handshake/handshake-test.c

[ ... ]

> @@ -651,7 +729,7 @@ static void handshake_sessiontags_duplicate(struct ku=
nit *test)
>  	info.nlhdr =3D nlh;
> =20
>  	KUNIT_EXPECT_EQ(test, handshake_get_sessiontags(&tags, &info), 0);
> -	KUNIT_EXPECT_EQ(test, stringset_count(&tags), 2);
> +	KUNIT_EXPECT_EQ(test, stringset_count(&tags), 1);
>  	stringset_finalize(&tags);
>  	KUNIT_EXPECT_EQ(test, stringset_count(&tags), 1);
>  	KUNIT_EXPECT_TRUE(test, stringset_is_member(&tags, "dup"));
> @@ -660,6 +738,30 @@ static void handshake_sessiontags_duplicate(struct k=
unit *test)
>  	kfree_skb(skb);
>  }
> =20
> +static void handshake_sessiontags_duplicate_at_cap(struct kunit *test)
> +{
> +	struct genl_info info =3D {};
> +	struct nlmsghdr *nlh;
> +	struct sk_buff *skb;
> +	DEFINE_STRINGSET(tags);
> +	unsigned int i;
> +
> +	skb =3D handshake_done_msg(test, &nlh);
> +	for (i =3D 0; i < HANDSHAKE_MAX_SESSIONTAGS; i++)
> +		nla_put_string(skb, HANDSHAKE_A_DONE_TAG, "dup");
> +	nla_put_string(skb, HANDSHAKE_A_DONE_TAG, "last");
> +	nlmsg_end(skb, nlh);
> +	info.nlhdr =3D nlh;
> +
> +	KUNIT_EXPECT_EQ(test, handshake_get_sessiontags(&tags, &info), 0);
> +	KUNIT_EXPECT_EQ(test, stringset_count(&tags), 2);
> +	stringset_finalize(&tags);
> +	KUNIT_EXPECT_TRUE(test, stringset_is_member(&tags, "last"));
> +
> +	stringset_destroy(&tags);
> +	kfree_skb(skb);
> +}

[ ... ]

> @@ -755,6 +861,10 @@ static struct kunit_case handshake_api_test_cases[] =
=3D {
>  		.name			=3D "sessiontags duplicate",
>  		.run_case		=3D handshake_sessiontags_duplicate,
>  	},
> +	{
> +		.name			=3D "sessiontags duplicates at cap",
> +		.run_case		=3D handshake_sessiontags_duplicate_at_cap,
> +	},
>  	{
>  		.name			=3D "sessiontags truncate at cap",
>  		.run_case		=3D handshake_sessiontags_truncate,

[Severity: Low]
Were these session-tag duplicate KUnit changes meant to be folded into
the preceding commit "handshake: Pick up session tags passed during the
DONE downcall"?

In that commit, handshake_get_sessiontags() already skips duplicate tags
via handshake_sessiontag_is_dup(), so handshake_sessiontags_duplicate()
fails its stringset_count(&tags) =3D=3D 2 check until this commit updates i=
t,
and the commit message here only describes the completion gate test.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-tls-sessio=
n-tags-v2-0-a587a50de7fc@kernel.org?part=3D6

