Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBCC606A330
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n0qfFD9Q;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=istPBT6U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=; b=n0qfFD9QSfLVNzgBxJwL8F3O/3
	3C5icsLE4zTVno0W4bDwRm9pn+qzhRRTOKVOjHaF6q+QRyvqO4Ga7RolJPU/bks4OxFoX4dZHFRjf
	zaKh88rjU7JJ13IHYGmSwMK7IRkWZYF8ZK5FVYq6bKk7dopmTEZx6c5QytnyNob5qU6j6hv9MU7Vh
	NuBuLizsdfKusi7uJZQqVgP9Wc8x44o1fKrvM1xpw/22THEtXitjvmnYteaZaL2w9oh9INRGxb+Tc
	RR7+snmt3qd58oPtF6D0ldwlJbVNBGEokLB4F5ESri+ojT9e3maeHJP9a+PNBEO2cgrcRLN/ouGae
	5CYGlkzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbO-0000000HPbC-3Uld;
	Sat, 21 Nov 2026 16:06:10 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTEg6-00000004uoV-0Ox1
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 08:36:41 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so17252395e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904592; x=1795509392; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=istPBT6UayR4AxDblNWwBKTr1e3QhE5Rd0u09KBy++9sOCwJEJSkxDuaSyHkRRcXRF
         bq7JaaObTCr8hW5FKJbUsYa9GWx7NJECYF3wBF+L6yoju2MaVT6MK66cvd4PKFsiuA5n
         UNliyqt4rtimoKHmz5I8tKGw0aq06D8V9fYs+1IqtJYB85yNtE6WkhgjWpAMy59ySTgM
         lGaNtTwXf8vJf6KSHK2t69K611PeREKvJeMDTi+J4qQaPJ/gT7Z+WT2wMxPapV6Xk0Pu
         6mkDkZKcvSt9+W24NdXyr1a5SS6z3eWckMQ4mBb5FquvVRj2hP5jjzgE2L9W2Qr7H2G1
         7hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904592; x=1795509392;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=JpanUrkyhyTHWnCIQUyIQaKwSGjdeH2bbDiHJeae1iJilmKW8SBiN32YFWarym11MA
         9KLAbX5DhwbkVoCrRx9O/Xq4z6XerI3hxudqkPgeHIDcHyqGTJupgHGtFqJoeElg/aIA
         vE9wK9GgZHoTDVQUjiSsEqi6uIIesxKTTyKCIbvB8cfvexZBCtIZSSmMw6xjpSQSYZHa
         NYzKTJd7tCl7KzUxvigYghocbUpIk+Xolz20xR/6K5o+nYAKkJA8uSmZwux/PyBHkejb
         QtO/1C+amPFkyayUzrfCv5Rh6hEUFwn7Ed1M2pleo0W5UgFHwfjk77w2NEh7IphHYhS2
         FvLw==
X-Forwarded-Encrypted: i=1; AL+hErFjdMvtHx1DRKF1RzTCAvg4LW++YCjXhhopduo0YAfbcbNDwhdsHFftsnB19Y3Q5QUSnhf1+vpyMfZL@lists.infradead.org
X-Gm-Message-State: APuU4Z8nVi0cOKNkzTW+vITQOAaxTKaMm3vBzX2S0lQcfVjmL/y360cS
	FbIBchjlLsYpdHJ50v21umsrUdxG2xIoYaiW4ve5dckUAqiAHm3hb6mZkwN99F366jG0
X-Gm-Gg: AYBFou0R4tj3RG3BOMtS1u1Q5n1VXTSctGFF0eKD/gttVRxUILR/DPaKiWo1ELN5vMH
	NVRpesdP/sEKAfGNnUHf4/RaGZjz81nSXUb7sTCxwq8b5btslixr5ZxTesL+8j4MXvUnLZtNjRc
	gbZxxZvA4ffF119GRV7m0ft1fvo5Qd4G4oOiMIuctF53pbcCF8XHNikuTIs4s2+UvFq5bTAgnhD
	o9HtBVJfJoIW2k/EGiXnps1qMJJ9kPPGlr7dUEi3JgFNEAVQuVKOFtZye84HZBTSCvN5Xl14m/A
	VUvOuJGM8NtkSUOhAJVD43tBXAPcMjfjvJVU0+zEaxBwFec+MCvDp7kL32bh+dQSOX9UYZtt29V
	m6UIlPVaUvHRvWssWqKb5Etqh3K8Gl66311KRhq3k7L4EjzMzESpjo0ev38QImIu+7qHOU/25eA
	YZxV+1HpW4mZY6lDG2PsKlr0YktvpqDAFSedSMqIe5Z+SGCU7ixBSJDyC6YT3BfTKwa+GOChAux
	rSqZhARA35xUzC0Fa7nLa1PEH+zAfz/KJIDjelNSwALLPS4x0m1d3DkHXBA9AezwGMWk4tGdlQK
	FVhZ6wuiSlME5J0EugqgSLRbg+BXk2ma7EtKdvlnMCZB/ktvKqTMZJGnJhAzyVaD1oO99MTv5Fw
	URI6Tkr0WAiymQjDb548xcNDvKTtTJseY3DTz7GpzRfrCcW7OwDXLz8HG
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr266345525e9.21.1794904592167;
        Tue, 17 Nov 2026 00:36:32 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm52548565e9.12.2026.11.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:36:31 -0800 (PST)
Message-ID: <411502f9a4f940c223b2b88d7e19fafdce63172e.camel@amutable.com>
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org
Date: Tue, 17 Nov 2026 09:36:30 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_003634_168681_A0ED4661 
X-CRM114-Status: GOOD (  12.39  )
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
> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0arch/s390/hypfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 559b011e68800..8662169de477a 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/vfs.h>
> @@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	sbi->gid =3D current_gid();
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sbi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &hypfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

