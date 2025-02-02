Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F57C02196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Cc:Date:Message-Id:
	Subject:Mime-Version:From:Content-Transfer-Encoding:Content-Type:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ADJ7b6sU8EXqcKMooDphP2HOkTSKkWJf4eawCe5hRhA=; b=w6S8xDgETIXr5O4G7U4BvPZwiV
	Nz1PYU7yWngRUJEsbsseI1DGVBRb9lp6JGvoDagr8QzxjlOpa50OYLDP/Iy5nRZiP7LB0KmErGkmP
	ZA1JZIu7g2zEf+O6YQLfGMsFHBwyX5JdmZBtKstbPMhXuMGkQW5fIXyuFK0SIKI5AZliQL9XPO80Y
	+0kPiUDMouc3YL6m8p8VNeCUMqO9ZE3a2FEmEkljfvlGGKJR4EMZHplBpO/g0MljtAFJTXHOhByl5
	ZdBgRQ3Bye/SqnMKZuM0S6W/gFFTouQBQ8/PnlQNJ7VToSF9+uw+iieKDxhkyp5ZMcxFbFK493vWs
	sEhU7+Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1teqtE-0000000Eihq-0SLz;
	Mon, 03 Feb 2025 07:29:04 +0000
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tebZ3-0000000Du4z-4AT6;
	Sun, 02 Feb 2025 15:07:15 +0000
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 515C82540100;
	Sun,  2 Feb 2025 10:07:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 02 Feb 2025 10:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1738508830; x=
	1738595230; bh=ADJ7b6sU8EXqcKMooDphP2HOkTSKkWJf4eawCe5hRhA=; b=Q
	qQM7E9KRZGiZBRZGVIWPqp9sGFoqH9T2O7/JIU2Urajg8QsUjZTjQQdaQexb9auA
	DAr7kY76oqXarZrpyqgV/kAjSXRGuihteZqu+YujL/tSiWQ1uxbA2qn6huzcw0Zx
	+W9D971rSyFtYJNByzjHb8ZYPrF6GQySzZGUQlH57zRLb/jthbGyvZ08eIlTfy9j
	j2AI0EW3oArl6jkZBycgJMda0ULG8XaEafjFjyAvJb4a1fIN49yaZKs2xqvNigyu
	Tp0S6QoYMTA5jhIoLnTT1iQ5aqNp9nsNYSg/Whpc71YC2ixOhiRO9gPJlVDOWh81
	UOJyp97qOWgJgJALx16rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1738508830; x=1738595230; bh=ADJ7b6sU8EXqcKMooDphP2HOkTSK
	kWJf4eawCe5hRhA=; b=ZEKa6wGq2h0Xy3RwElajdqDpZ/LIQLaCWc6gOZQykQkA
	ZGptbFJX1qgV13OvKUoYpm7mav9Q2+KaUOXqozRGH00npeD77qoNw5jZtCsmI7Uw
	fNyP5rS1lg3Za41gMemvnOY10qjEVzTSGMUAYb14m2KuHKoBK2/4bpg75HpCY4sG
	qABiVu04dQ8O/NcOdw4DdOU5Z/FLktFW8YR0QnyEbRdSJ5zIl/bI7t3c9kt3g5Rv
	WqmswbXWQ+Q4rD0YiLULfhGhy+mQ49uG/K//qGsxndFky26FIvAYmnvIhaRmLpO+
	QzIniGhbvWxlFhv8nntwR5QQyQYsdP7MsRpJPKTr1Q==
X-ME-Sender: <xms:G4qfZ0lZLAQzF4pzOEAA7wnfjz_bNrL962ahPbg2WlVWTFCXfmsh5g>
    <xme:G4qfZz22W4TG7sNmo2np83WtKBSWNlNUS9QsA1incqekQwGbt51qwrY20sH8ITres
    H3WQ6kstRlgM9vxzV8>
X-ME-Received: <xmr:G4qfZyq-Y57fiIgh1CeqP5jGrctszMg4NXFp2-J8h31wOxMrZdXOrxmTFlu7FCNgTBK8wvrAIO4nsYkdbNEHKhqWPQSRLCqB24RzLnvHKrI3-HhCzmke1k8r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegtgffhggfukfffvefvofesthhqmhdthhdtjeen
    ucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvg
    hvqeenucggtffrrghtthgvrhhnpeejfeejudffffeukeduudeifedtjeeglefgffekudej
    leefgefhkeffgeehgedtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghpthht
    ohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjsehjrghnnhgruhdrnh
    gvthdprhgtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsthdprhgtphhtthhopegr
    shgrhhhisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrg
    hrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    oheprghlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghpthhtoheprgigsghovg
    eskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnrgesrghsrghhihhlihhnrgdrnh
    gvthdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvg
X-ME-Proxy: <xmx:HIqfZwkg7Qz4wQfmW-4RJhYntbKPz3J04hBaSUpSu6Ty5m0d7iry7Q>
    <xmx:HIqfZy1-Th7VE71PTDUglVgRQliVsPQyol0PWuhGZjoo1Ak53VcqhA>
    <xmx:HIqfZ3vDKkUEwua6LXYKi1C7SVN1jpT5Hzrhmme4ExXyBYaFwiePdg>
    <xmx:HIqfZ-VO1zAPMeM5mH5esC9dU0cFPhNpUGp4RBMcXPZ0qLxfUXMBhQ>
    <xmx:HoqfZ4PSuFvXaBFpL2RDtLKEeCyzOpZ3F9Ft5AzXWhGfNFMsM6rD7mGn>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 10:07:07 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] soc: apple: rtkit: Pass the crashlog to the crashed() callback
Message-Id: <784BCC93-4BA6-420D-983D-35CD51EE3684@svenpeter.dev>
Date: Sun, 2 Feb 2025 16:06:46 +0100
Cc: Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Janne Grunau <j@jannau.net>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lina Asahi <lina@asahilina.net>
To: Lina Asahi <lina@asahilina.net>
X-Mailer: iPhone Mail (22D63)
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250202_070714_740058_435E3FD7 
X-CRM114-Status: GOOD (  15.24  )
X-Mailman-Approved-At: Sun, 02 Feb 2025 23:29:02 -0800
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

=EF=BB=BF
>=20
> On 2. Feb 2025, at 14:49, Asahi Lina <lina@asahilina.net> wrote:
>=20
> =EF=BB=BFClient drivers might want a copy of the crashlog to stash into a
> devcoredump blob. Since device memory management can be very variable,
> the actual devcoredump implementation is left to client drivers. Pass
> the raw crashlog buffer to the client callback so it can use it if
> desired.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
Reviewed-by: Sven Peter <sven@svenpeter.dev>


> drivers/nvme/host/apple.c       | 2 +-
> drivers/soc/apple/rtkit.c       | 2 +-
> include/linux/soc/apple/rtkit.h | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 4319ab50c10d11ed81dcc002275f190e053c1be6..f46b3f179a00dad054c24ccaa0=
c578d64ca75ec9 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -221,7 +221,7 @@ static unsigned int apple_nvme_queue_depth(struct appl=
e_nvme_queue *q)
>   return APPLE_ANS_MAX_QUEUE_DEPTH;
> }
>=20
> -static void apple_nvme_rtkit_crashed(void *cookie)
> +static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, s=
ize_t crashlog_size)
> {
>   struct apple_nvme *anv =3D cookie;
>=20
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index e6d940292c9fbdfc4cd42020e89aca2662c5cdce..4b0783091a92324a707a0e1cd1=
6d36dd6d984678 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -368,7 +368,7 @@ static void apple_rtkit_crashlog_rx(struct apple_rtkit=
 *rtk, u64 msg)
>=20
>   rtk->crashed =3D true;
>   if (rtk->ops->crashed)
> -        rtk->ops->crashed(rtk->cookie);
> +        rtk->ops->crashed(rtk->cookie, bfr, rtk->crashlog_buffer.size);
> }
>=20
> static void apple_rtkit_ioreport_rx(struct apple_rtkit *rtk, u64 msg)
> diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtk=
it.h
> index c06d17599ae7e3d37d99495e4296932b1de3a3c7..736f530180179bd144cf85eb0f=
0bd93844d7188a 100644
> --- a/include/linux/soc/apple/rtkit.h
> +++ b/include/linux/soc/apple/rtkit.h
> @@ -56,7 +56,7 @@ struct apple_rtkit_shmem {
> *                 context.
> */
> struct apple_rtkit_ops {
> -    void (*crashed)(void *cookie);
> +    void (*crashed)(void *cookie, const void *crashlog, size_t crashlog_s=
ize);
>   void (*recv_message)(void *cookie, u8 endpoint, u64 message);
>   bool (*recv_message_early)(void *cookie, u8 endpoint, u64 message);
>   int (*shmem_setup)(void *cookie, struct apple_rtkit_shmem *bfr);
>=20
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250202-rtkit-crashdump-e848547dad67
>=20
> Cheers,
> ~~ Lina


