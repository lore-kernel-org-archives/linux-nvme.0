Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1F606A327
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SLpdJT4p;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nTYDbCcA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=; b=SLpdJT4pI3dB9sqZTJn4TP1QsZ
	X82BPs212Xt0zmrQRPTxSVyzl22k3P27VtebrowO3XgHGu5r+Jyb4Hk8TF/EkChVUKIgHl35U9dGR
	nVHigX83VaE8tgA2Pd/Vuo/jT7BgV9XI7qnZbm3MSTyOQF5C5F5/LoFnn7Bnx0U//m6DkvGRkwKv3
	Wiyyw1YpPnwZTLIqBAxsKSLgz8hzdL1pz1Zi5kmFzC/V0M/l2wS5VMOu5UywR6MMHBNzwIl2JY+uv
	DmT/gBU2jrK4amQoREGbHUjwCqUe17Leu2VdSiSysCl2LUC1H1TlkR1GXxuFb6UWCuOTWOfPaqU87
	8iF2u6lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3S-0000000ECxh-05RX;
	Fri, 13 Nov 2026 19:35:22 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoFF-0000000CJMd-2Eap
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:10:59 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-490d59c3edaso395263f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564655; x=1795169455; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=nTYDbCcAVLNw+PcFb0NpKZyWQD/glC5DwRgTCudix7J1u7Qzl5wqyVhgBY0rqql1c7
         AcIr5i+Munv6j13NHRWxUhJ3O0wDm5wim46f1s0K5VjnDsuKsVCSOyi8x0ab30uWtNfQ
         825WVTTnlL9GUsz9aoNX4GAHOz43h42fSptaKebQeab0JTiQM0kL+qP4/tTvlvUbZZ/z
         9ccJF2AFKR5MBSQyDQAoUUjTSA0aKf0rDb6oqHudD8afdSXEy4BnvBP2lWy3Xd34U2xD
         KAFnsCfIOnmfFEOLP+RlfA9akLjh4psuXP3ii9Ku0lzKcdT5lpbiZw2Uf3Jr+OcaLtxS
         nMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564655; x=1795169455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=1wz3y0b0RmrTfjMaUL0y4Bsbneyko6acShTyjBrV+dhDwwGmwPPmXpOAykqKabcspw
         xGjba8OWo5i9RX40cDyir54Sq+dzLm2I8P1++TF73XGhdpCV2fRjKxRZaaC0nmR5kH+/
         e/tpXtC1aVhZtlNgOp9vlyUFqGQhPtDCuQt46MX9sJqfBOZQfdqpFB0C0giXMDbDtXYY
         F49bIgbWLIOA4s99vetd+Ad9l/508i7tlXPd12TrmeB1+5/Xa3ENe+VgSj8EpD3qRhqb
         kjPUG8TZ8EQiS6ZrIUogmqdn4j8fQXJtHE5TUHyaDJvggbSDds8ymUNGWYTljDs2FBkr
         z4cQ==
X-Forwarded-Encrypted: i=1; AL+hErGIIFHiU33KW1LDvzp/FAmrpQL9kuhKZz3uMOgZq/FUhcgUnFXRbzSIDzdtQuLd8FiCKXZRmHVI7pIl@lists.infradead.org
X-Gm-Message-State: APuU4Z9I4rTeMnms27X5ocmL9+SfOSPIXxdeUo4Ng6vh+hMTSO84qqxA
	FgL9P/9hOhAqUZl+8YfAfUM0gR1iJ7IyaPDs3Km1izAwJRs3Jveh5TEYNuY9qnib6pih
X-Gm-Gg: AYBFou0EcdA6CXaoIlKtJhprGeMSw1MheEHvAOmSlRuMYh5bLR3w+7zmQ2cJYsWhrzr
	5CKVUn08Z7rrNkPLrMaDaSAYeBETbVMlDIY+a8tinK/5/dHUASzGgBAIyZC+14KtfX+t6vfudqy
	o+AO7jI5m6vrgsa3QavVStfJMeFGWjjY9nRFIVMkefXUajI2XvyPnJAwy3OlNtU8i9uR6ERycBH
	baIn5EszY9jHFzTy7WSoRx0XeSpolMwTq4EX7tMzraDTye5FGc8nLQzvXNIwd/lOBE/qhv9lCFx
	WyXSlPC/13ToO0F0QXqttxWNT++ow6putu+cBRj3/YxyuR1sHKOh3Fnn0VB8sGeeA2YLkHJasKe
	3h5fzpg/Njq+J/PSXNKbU7Kilk4HRnBduB8nTrPVd+n9tslsnKiHjNSvd6qscHSoFAm44sW2qlD
	caEGUsETuQ2b3Z+l3d2mzSTfXyEIBmDlaZFRIeNOLUzSuVXnenjGBW7VPiLMvdrTZHb5y0q62S3
	z4vbaU8hEE80IKvuxU5xBI5QA6LyXLFbk+qJsd4Iq6Zkg9Wg4oqJXJXzWGLCtQqLKIfVzWEQMDv
	ZaGusywa3dN+8DLsU0BWECQdzcZb8uIR14ngvfqNojK0gx0EzE4cOK82ukvFFFA=
X-Received: by 2002:a05:6000:470e:b0:499:ffd4:f519 with SMTP id ffacd0b85a97d-49b02d4c2cfmr11662822f8f.23.1794564655454;
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm4988050f8f.0.2026.11.13.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Message-ID: <0894c601b3f3c5b92008c6c399faaa539b658307.camel@amutable.com>
Subject: Re: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:10:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021057_587433_BCE32230 
X-CRM114-Status: GOOD (  12.78  )
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
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables
> or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/inode.c b/security/inode.c
> index 080402367674..93997a9f16fc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -64,6 +65,7 @@ static const struct fs_context_operations
> securityfs_context_ops =3D {
> =C2=A0
> =C2=A0static int securityfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &securityfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

