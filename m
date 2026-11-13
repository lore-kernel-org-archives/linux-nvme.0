Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E43D606A332
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Yp9m2sit;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PO4a1MOA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=; b=Yp9m2sit7VHvhhKNOmlBgM6Sre
	ys3JAO4pYSzt984s/yBaRIpV6Ind8uAMNjNuSQbihWmIlg+2pD9xFq1ynaB8augw3gL4KcKaiAEDO
	ttI01srjnPJJhNis3A/24yPfMxMw7o5XFuMfusXZSxrWfLxZtMAH0WaxT9kkwM0lc2Briyf81EfCt
	FC1K+ef0G9YMELq2YHr7J6vQ2/xpGkuHA8G7s0kZ18OcxnSj2QtxEzKdUJy/Fdrv/vyfOhjCZsG67
	dnminuaxFnRgGFUmMb2OcahM9Yl5h/Q+kbmSdof1aHS8entrSwpkfcDcjLUKlEaEL+7Q7PQOfeXh2
	Dq1H6OuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3Q-0000000ECtl-2tgP;
	Fri, 13 Nov 2026 19:35:20 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoAV-0000000CIdp-0tii
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:06:04 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso1240064a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564361; x=1795169161; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=PO4a1MOAHobDk71BOjNcWLNTVVpuBH8v4xSvK2Tx0JNmQPYF0H4NlArFGTcBYb/Wsi
         ZRqKVAQZjZvnOMhmfknvI+27y4oxziM1PIqIosxKBV/w/4ujDEbj2UpxH2m0nonuTLKD
         T3AJbPWeVG1RqT1TkoaiE37FkmTXt1URu3y81aB29y3JWcJrNDUO/nfmdbjwvm6Nqf/w
         t9QVWIR4JkuIBDC+ZInxf6t1nc22A6bXxZqQgohZXLMN9T4Zl8J7DhU53kTrj57maMDI
         hYaCY7E368geLKyS8Ssz1yUnEWyjJnRmg6ZwAlY10mZxWPih2xz9g55yJ+YzZ94/FuTX
         iyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564361; x=1795169161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=xXPcJHsijg2Evfv6mHVzYEalvgFh/RQf6OoZrNKymMNrw6DQ8ReClXgMUneq0wjxSV
         AH4SdlilrWJdgdwqrG+T4e7WbqyoGXoD7e8wXFEJ6kSOOoXKo+qBacJNZasN2DXGkChy
         GOtQ7u0NncvTZ3m3uiLaCb/XZWlMtIDeosQBPszKn1ZWL6tNWK/LmqOWoHVySubkT28X
         i56e8I2OVrLUgxEnVgvWXt8+Axx+wZCM8QHe22K+c3qHshlbBtLW97tUXNtMZaQIn+uM
         yRFkuxT2b90cu/7xyIjI3I+JeyP7Qat6B0pLylxg/JkSHjpKfx308scg+gh1gVfDdCVM
         b5Ig==
X-Forwarded-Encrypted: i=1; AL+hErED6JhdhVLfWbysPPW+x9bJb1PYvx37ZfI6hCdPZeIv9iqkt5N6lgHMqN9oirZHh3/hQ8qgTFkVuSrp@lists.infradead.org
X-Gm-Message-State: APuU4Z/DUV5Ua3PigHrOrX5HIgitD5N0OUR2tE0Ou1onMXjXEV9Am1uo
	wiYh+nJlVaHBb9qzTe/x0x1IANjpV19YufG6/AG39/WNe5FrQ6sYonN8hkYxBLN8W3zl
X-Gm-Gg: AYBFou2mj9kGkvigR7Pznxi9LiosPgLnkud5J228lCcZf71Bn3IZpouDA8Vf00JpKJI
	FGEvfUttnuO/bhXwpR844sNWFvkBFStcP2/sMDidLKeCc/1beCf1/fMXxiu8s9MVOFeZrsHyPYc
	VkCGj5QahBZfWAT7P7YizR3wGU4qwbVVQ9wxy9IbIMfvFK+e17YGQ9WgBnLmHZEOf/CDnJO6S+7
	w83I0Xc8SFzdk4aDOU/aJqqHb7lbLhEhSrIxJXH3fFc1VVO2VZWBOAMPi8zs5WJsIablyCKRgAk
	P95jhMpjLPxt5Ima8H5G2NXdGFf9TDxW4GpfztgnYHlK9Oz7WN8GXS7A/baVKUCjJoX0lHlcBgV
	OYxRhW0NmSn63F4paTh517coObcOJeM+Xk4+40lMnRYFuGHJEkOcmU7r7cPOS21JR3pFjmdbXB5
	1kG0hQxZX4LFt6ZC2EM2IxKUXQnjaQt5yGlHSrFHchH8YE1EQrk2yKmztTVH5w7WBJs1A2X3MBc
	cTessQO7sCMSYP04YiDTCNNH4B7sN4jBPDSFD9Em4pmCl6+YBhG8XpZovIt9rLhGLjlkc/+Ep21
	lkDkkP2bk/CRlcElmS8hggouW9+MVFnxROh+902GkdnNBNv+v124DwCcXh1NXC8=
X-Received: by 2002:a17:906:ef07:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c50963dc627mr169588066b.39.1794564361325;
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8651bsm73693366b.78.2026.11.13.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Message-ID: <e8b71a2778d7d7797d433e7bac1a37ee64aaa30c.camel@amutable.com>
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020603_274819_375EEAD5 
X-CRM114-Status: GOOD (  12.16  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/tracefs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..e04febd868eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/namei.h>
> @@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D TRACEFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &tracefs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

