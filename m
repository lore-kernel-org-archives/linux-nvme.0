Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA6606A320
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KGAaj7UL;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HJ3Cpm1e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=; b=KGAaj7ULQpvaBBdKY7owffeW0R
	fm4/BRVZHblXnKxBh9NmVRePWv4BNho1kMzUX9KjZxYdFC4PzZRwmKQnryATUly8C245akQ2zFuCw
	5VPmS+D3dmVB/0GT/H0bhQbGJRYO+20ThIOV/aITO8lj67dyDUVm5Gpp0MQQpAiLdicVk7Tmamv5C
	T3rcV7xsYmwTOA3PdaUmB6eoVIF47915lPTdNk/ccrY2zHqvXBKB/k20ZX5GgLcjusRomfbIEbg+k
	iAalVG+yKnSG4CVXJI/ixrAJ7qmatWzVULnZkmZzvnOK9720P3udvT69rydqhkKSGM5Jdnr0bRJ7a
	GnYSf/sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbN-0000000HPYn-43eJ;
	Sat, 21 Nov 2026 16:06:09 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTEX2-00000004snm-1Gul
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 08:27:13 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4a210470b49so35729665e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904030; x=1795508830; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=HJ3Cpm1elqWN15VQiugFVwKljZ+6LLxSDY6hXYl6eUCj29DvmXabXfy0/YnI7W/Ece
         nD4uVf6e0zeMo63cBayF//qyvQ7kTs+iCjOK/5c8xtdMSAhcXCyyNoIGlXDrm8zezech
         sw+Irzglr0/VL5fOREKKway3Df4969KsxncxP749749pq3jRtxUyt4EQuuU92Tf7VlzT
         bBJc7T2hXqdBo6gJf7OAIOax+/ZODjyq4JmYrJAD1uM6hH50UAx2ZWWgqMfwcAhG4YWV
         GMx8CC+nLD/OZ2f/Gl88TuzSmG5JPLqU5Wdk/DBLSbQfS2PJBKa2NfTpetTJKLJyhofH
         irAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904030; x=1795508830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=YOIbVv0k0IrOA6tiMvv99MSp9/5GtUN6UIYm/492RzNXj4zdHzzVSdR9n5Jy7wDyk4
         6eSbcn3+b+Hyu8xDZ5VgfTYNDIeFxTkbjWXDoWAoOBJOIpgIB5jNbJS8NRaddD4QlfSU
         B/gMQTGHUs6JgMv3DaGaJrkxmVBb4VO0V2n4gtpyTzAyIjnROoy8ly91v6XRXwjiVVMG
         byWQ0c7DoQqo6XTT/GWPAemuMydqQzz1CGFrmNoXoTtd0IQdFB2Mt98iJuxshPupMu9B
         Nu2ORBIRtsSJVW+XXuflMxV2GfOTw4MMcYgENwfzHjRoirmngItEl21OkVksbcE7pifm
         d5sg==
X-Forwarded-Encrypted: i=1; AL+hErHe5B+tiSsMg7TKDjBKiD2iVTk5SdTImjv4f0VMEcJ7i8CssO1vi/8LWbfAB2rxTbaBRoGCeH1J2ceR@lists.infradead.org
X-Gm-Message-State: APuU4Z83jHupqN0DB2NZWCC0vCzBeQuYdJVNqPlrOEJ2qDlixAaV0hkJ
	aYAYrvwR6t1SXOoeNW6CAQn3L4iG+5VgBqVdI/7YJMIhNE9hGwadckozv59z2GYMPVuy
X-Gm-Gg: AYBFou1bv0Dy++o/piOPaGLKFlDmKHR99yJpsY4XRCYt4PsKvzCApIoPqwuIxqMgu2c
	1MiSKgIClev8mTx1800n+20gdx9sp7ajVol7Jml+2cLPP0CY/XzvXJOg8ObnupI0avV9gd1I0yl
	Cpn3zOA5J67kL/TInTEFP5XWxdYl0W++COb3sZmggCTHRbUmbZT1IdKO+KyrZ7nOTJUVELHGRBj
	B235mivFs9QKTmYBbPd3kRd1kTezyeY3KvX+BwacDudwfJhjy3bUPQKCYDODpVaEQAn/Z9ZBy8t
	SRiamXHQH7/Gnf419kihofWFtXObEwnZn/SdG69UC2ES2w0ScGNVh2AnvAXnPMz9wCRxIjLigO6
	vOc3Xfiz3nLuF4H+JcIihN4crGDcBku2wRWmYjzx6Tf7F5AzNtSQClp90xBsRpew0dsY9csUII4
	uGtlJJUluGhZF/LtyT9aagXuzoDDa2G8+Yyvcs58cnR2us21GzPTW1aeM9+AhDHkn5XcvFwWgfr
	7t4TsF98lyNvjKvTM9+NUZ+2LNfnIM/HdRqKEr8GK+o+LNEgmTYNShT1FQtazZDcCJK/EuYL/D3
	PQB5w2nUnOXIDS1fC5DucOD7uZ+9/MfeT9smb5TYaEXnuNM8l/AQWf2ibwhPRp+Y5Bh04MsXZeP
	p5CyP3/YPkHolitbO+9j/vFHy1cGRUS20my7Wu8ygw9iwkUgsbfYqIz2K
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr134135095e9.6.1794904030378;
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7838c912sm45730155e9.4.2026.11.17.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Message-ID: <0ec7b8c90cc456b24e5b19c1db673d497ae43735.camel@amutable.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:27:08 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_002712_383678_0706804A 
X-CRM114-Status: GOOD (  13.83  )
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/android/binder/rust_binderfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/android/binder/rust_binderfs.c
> b/drivers/android/binder/rust_binderfs.c
> index 5f020226720db..04468c5b5c116 100644
> --- a/drivers/android/binder/rust_binderfs.c
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/compiler_types.h>
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/gfp.h>
> =C2=A0#include <linux/idr.h>
> @@ -667,7 +668,6 @@ static int binderfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	 * necessary and safe.
> =C2=A0	 */
> =C2=A0	sb->s_iflags &=3D ~SB_I_NODEV;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> =C2=A0	sb->s_magic =3D RUST_BINDERFS_SUPER_MAGIC;
> =C2=A0	sb->s_op =3D &binderfs_super_ops;
> =C2=A0	sb->s_time_gran =3D 1;
> @@ -759,6 +759,7 @@ static int binderfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->stats_mode =3D binderfs_stats_mode_unset;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &binderfs_fs_context_ops;
> =C2=A0
> =C2=A0	return 0;

