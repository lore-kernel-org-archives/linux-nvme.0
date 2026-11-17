Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E8606A331
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Kf09srR5;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oaS7mYFo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=; b=Kf09srR5Sy0a7RwUk3ld37lo/r
	Epb/k3ew4ui2pBB8jl9Ml3emAzq4bCqdWaBZwaqLLiFvYhqm+PKPgVFKsLDTGy5BOT+ur5mYxYzx1
	CNpN/4elRumuz4yzk1sU9Al2o38XHKHr30xxcTcL3OoqJ0fpRjzx3mAhxSZ+gSsSGiUQtNR5GBbLD
	Q30NCe9ZxA08+507aoD7i4seHK3S1Bim/vXv7O8t0LTDSt7Yr4CVyXH3NOOlXMgZXKScOyslaqyX7
	K8O9PQr1a++7WYbfQ/fhmLB5L8INvn6qy1eAKUycimagMeJyYI7PaUufQ3aeIWRBjvZF+DobOkx7l
	haoGO8hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbO-0000000HPaS-2Hp3;
	Sat, 21 Nov 2026 16:06:10 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTEc5-00000004tsj-0ZTy
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 08:32:26 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1762455f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904343; x=1795509143; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=oaS7mYFooEMJ16YwHEvcXpAitxtuXegJK4ioRIIrPDXRvLvWckbb/+TYBZczGh+m1w
         w8sZ1SnC6nG2KqsXAqRD4Kbd0JW6jW/0EclG+QnSlL9dI0DF35NTsSIds7G7xWVb94Y0
         WjFo1TG9ljMgg5I+65UJrSJ6g6Var78SSxuuX65+YU+hSR2NK1vaSYeM78NFLwiIYLJE
         XOLD+uT+phGUQdq0CZ2rravw6hPdMBES96dolz0gDzYNyU6W2vwKBT18YYJfA4mhlHg2
         Ski4rhwUos1qwTqBtknLfeNxyRAJUeYklGWVlHUVJUjR50jtZ9fp0JjpZH3l0+S1n2jh
         VoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904343; x=1795509143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=hDupBD1yY9mXclKMuvbCquX1wm831aDu5j9i1ZP8Fy8pu9D2F5yPbVTBAHaSUNIHkv
         l3ludxJF/9lF0rz5U4k61IfLrRXh+hgseKDGSwDwuq8nC7Zxamq74MPpY0WIv32xutiC
         bw0cfppSKcQ+fi/iSI9ETPZmM4ulMl6C4RNWjwscVrOk0QV3IjKc0aA0VMMlSI+peFBq
         45BrCa5ujdIvfzWFDeEJa3QKGm2zizdJgHLHwvFnArdJTkUxRBY0Nu+/Pnt8xXSyWXGE
         3Iun5pRDtgkl0cHxITDZJ/MK4mmr8zKHm2ik37ytNCEZu/TV7kWXmr6lH5R5WJZ+zFUR
         j9hQ==
X-Forwarded-Encrypted: i=1; AL+hErF4jYp2rLPWhGPisInfrhsDhVsMV2Y7EfkWh1GFlW7jUNvN+F8316iXvH8rdGNvH0+pGK37zTtepOYE@lists.infradead.org
X-Gm-Message-State: APuU4Z+u6jhcKUlf0UMq2mujMGUkRf9VrqJd1QGSMQ5wm1BbAZdKUh8z
	IV3FaXW8JcPVdn3gBqCAp5oZ2ZiNNaT/NLlKQm79JigWpzKU8tYSIQPMhmMhfuaUXOTX
X-Gm-Gg: AZFdTZeesASsZ2Ti5s1OWkiD4ab+gfzXPZncwMZULAEO1dOIumcbeDWHQTlRaFKnGK5
	uVTAXbl4iynBFxg7hQHnnaMYN8IIOWDzh/zapk9+lDQTVEmVwq0kHwEbY0rPA8pIrYnbmVTjHpT
	eu/aWUd/eXWPd0TD4u05YU5RQm0S3e5syIHy5RRex9VM40a71iGgR6kCpwDfT60zv3jXQ1idsI0
	h6LE+49qDqOoAaRdLd0wSbxEux2MMHE+CNDxQh4+e6WrcUpRLzeSGR0vIEO9kWHpY0NJijxfgx6
	NvfZznC2f+Xd5kewcqh/57Vdw1rF9vRW3v9pq3RtFM6iz0M9ThlEjCTDIuC3e2UaJdGuZlumKOV
	y9YfcL9HfbMTcajxBmwpJpMwd515p4UQ4W9MRp3bPztroyRnp/yLZPPiJ2bTBO41fPeTI2iP/Fp
	LT+UdguHwkpv+cLKmP5TeorRR0P36VVC7eoYuhP6wi5lgfJAjRCh2+UXgYaO9JB2QY6THvHU9cr
	frUzwu/747z//WELx94Ms2kuJmL5Kko74vnvGSGYqEa1R3iYtPGppM/g2cZOccfnUisV+58K04p
	EaWpZCQR5kwKR4HmO1rftEd/q18mfBkcbxe8uyEH0nujzfsDM7H6GFyaQXBKW3SNXnVvF6sft4J
	SZCxrjG3n4TFP9IXv31iqNDWsXE6NnvfqvfaUNvYbew53YuUlfp6vT812
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr27089117f8f.45.1794904343236;
        Tue, 17 Nov 2026 00:32:23 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm43646659f8f.44.2026.11.17.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:32:22 -0800 (PST)
Message-ID: <fd39200976086130cc82d59699a988fc3e0689cf.camel@amutable.com>
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:32:20 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_003225_187416_8C0C2441 
X-CRM114-Status: GOOD (  13.02  )
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
> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/openpromfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index fb8d84bdedfb2..6cd02d456bac9 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -419,6 +420,7 @@ static const struct fs_context_operations
> openpromfs_context_ops =3D {
> =C2=A0
> =C2=A0static int openpromfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &openpromfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

