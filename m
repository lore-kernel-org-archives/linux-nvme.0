Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF4606A320
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JQDgU+1v;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tHv9sGob
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=; b=JQDgU+1vNO1z2jeqnnn3AZD558
	Nkq/GaTWAY3l0fkKaa2BQUVt2IR3g45jemifPm1767UOiI1K1GVmxhxw9Yr0cWrEQely4VR+4blhH
	9MHniV2QtGHAT1Q/jlqLBBGDhkVrajtvWdOLcG98RxSdyNRLmd5reM9nZxYsPR/uJsY5yPAlCIO+d
	JPNKW3y+QlNFO1rSnb3Znkr8TaoNmYuJHPJTqajHx20bkUbD4hlg6OOCm3UXFm2X+MDhaqbR7MehM
	rX6oVzmejhk5gtnO5/MO1hPs/2oMsdj4XZZHwsoHv3VDVZakkSFEk3N1LhF7uZLnsBPfsK+sby2NV
	aR/uZT6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbO-0000000HPao-2rRv;
	Sat, 21 Nov 2026 16:06:10 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTEel-00000004uMm-46gF
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 08:35:13 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-4919a880834so2252948f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904510; x=1795509310; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=tHv9sGobpkR+mihzJQd8IlBjbYyfCZZLDIeZn5Xxg12spkGelgzlA8H2wzBzoB5+6d
         oNgvmzFrjMM/cQlKt9JRjNKXWPWQokJcFLz7RMg0M5gUi6lNNLDAh46UwS6gMxZ4j3Qf
         qKUSAxRnu0ukzju/LDqLKw/FsvR3prk8FithBmQ/Mf/aOkix916qYlTM4QMqJwJasMdS
         fUdaCd3Oq/PybJ801Mx+RoeWPYaa8cvZvTPzka7o5qIF3y5pkWUqSvITUfTsK2QzRpAO
         4gu+lbN54u5mGlXd53ozrB2iJZc3hsvEP7O4ZWVzWG7t1db+ED+zY2nNpgSeK1DY1tAd
         EhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904510; x=1795509310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=fojfJv8srmdSRUbPaoCtc3fuc4uLb0iWNN/12tNFAYP59DyNbZWOcl+AYzH6pFGAQu
         oAtn5sCuSMk92IhGsv0K8XzIbhcle+0p2Od1+tDPnHMNo9o4GXdRMtmRSfJ8/Jl8OZo/
         NyjZ3Lx/LOhPWuLSgtDUBBiQgmj/NhdVT+vjZpQuJlriNaTJm4a9UqV+MEqc78NC4Nk2
         3WlPM5kaWMiV5hVt5eKjlXUx0MdV8orYMwzJkesO5SdZZ5fvq5f9cAd8aoDppKDb/Gwo
         OE2mjGmMutGSNPoExMIbkVxKKRahhCSavHElhCA9ROc8pil9ZhCJ8Xw+A/EDW0eA6/ux
         +ruw==
X-Forwarded-Encrypted: i=1; AL+hErGRTt973FBTitDnHL+itaGJJK2N0RQomF+O1Jy1+/RTZNjW5N9yYbTQ1PFGtRJ97wp00g4mtpmLInky@lists.infradead.org
X-Gm-Message-State: APuU4Z8FH7sa8i6nioCaS2Fs3UOe5P9+GbyAGzaPhsJN8hJ2HZAC9aL+
	ZZhhksqOKxIs321KtCgThEyJ5zGtXkdymyo7U2XaPS3T3BFa+efg7PkcW20Ae5WtHIt/
X-Gm-Gg: AZFdTZetltSUgU2eh9LdyjGRd/FfmienXRWYuvp4GbwMPOMqL9gmhWd/hqNiEl7ckFq
	h56B981SLQZrpIupvKx+DtjZoABt13sZv9rBRDSpZo34y2SLYxziLP2fWjsX5pR0JwWce8MaBvE
	bCNMxRHoeNUn8d+Hjv+KimDUpWO9VWHvxnjDS2evhYULKw2snKClUWn+/h6fMV90tH8nzkoCVL7
	Kx5aeUWSSVbeCfZUgVefwSnBFmLx+Rc8rPKtx3JqoYqWnREOsDgIaiaoc8aVNLgt538P4yM1cu3
	3HyWvxvEhULy4W1GBjk0wsbndKhPmuv5BkdcNCz3bUG0mZV/BR+wKtJySDhuyr6S3WOP5DIjiVC
	gMVor+VVUqcZxTZwEA/rNhlNVOVs3xk05Sl3Z79Vq8TCS2jUpXNqMd4dSx45TUNOPvJ5lXtlgzR
	SkscwX00lSNxd5e6Et/6tSzwjS9qlwOjllSlQR9rWmu7j02vPhNyZFXsYM7qwE9sBK9kp2VZR54
	LbIiqQ7XiTzuIaeNJpM0quM0LMUd7lbgoAWSsIH5n7dJklCQPmvwfbJCUbIQNWf9ntI+KXaZamk
	TUzJnXLb9ptNPR7Nd6POK3wce3I1t14jF5ubdPtau9iQ1lqrXVK7qxiLZ4au2lU4pn4WeCKeUhf
	+5Nx+inHas1FD7z4YXi14nv6+iT2Wiq2MW++sRA9Xr9ggg+VZjvpVCmm0
X-Received: by 2002:adf:e193:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-49c728c6e6amr26569239f8f.43.1794904509932;
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm26338505f8f.36.2026.11.17.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Message-ID: <b0ec2cd8f9b7a6a2e4a54c6df2fa897bce068cbd.camel@amutable.com>
Subject: Re: [PATCH RFC v3 28/44] ocfs2: use fc_init_pseudo() for dlmfs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:35:07 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_003512_057745_9DC2617B 
X-CRM114-Status: GOOD (  13.19  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Sat, 21 Nov 2026 08:05:53 -0800
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/ocfs2/dlmfs/dlmfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index d3bfcada3e3bf..1789ec96dc130 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/slab.h>
> @@ -563,6 +564,7 @@ static const struct fs_context_operations
> dlmfs_context_ops =3D {
> =C2=A0
> =C2=A0static int dlmfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &dlmfs_context_ops;
> =C2=A0
> =C2=A0	return 0;

