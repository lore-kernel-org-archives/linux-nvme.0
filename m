Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA7606A32A
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RvhQzF5I;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ILX7m7vp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=; b=RvhQzF5IkRF4r6FjVXu1J+9hng
	PB35PyqKX++0y/b2DcRra8mkD9E2JX9er5IxK9LyZgksiHuUaEO0huo8DRRYZXFusJL2Ge2+df/MU
	RAUbMaMUEpa0cSvdW79bnuFdVFbTjhYArMaXPkfOmyDsOERfBptJ9qlMuSmTKX5iAvkA865noWk0i
	y1EudU3QUBZYB8tJEBCu57aTkjtrbBUxY0kgvP9IombKkNACnhWrKHxnJNWpptjqfPyXU1Lw705tc
	qE/SGYvg7mKGzFnvkQNsgexuPyqFdb6KkOWmOj3akWbxZ/OLjaSYh/Bf88pZ5jAuJs6kBZ3lhQRmF
	4jeyYi/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbO-0000000HPYz-1FMT;
	Sat, 21 Nov 2026 16:06:10 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTEYI-00000004t1I-0hhH
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 08:28:31 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so27360715e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 00:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904108; x=1795508908; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=ILX7m7vpCdDFkS6OAva1Oz3owtjXSjr7FJmj4GCkPBM9BW+akLSSyYgVJiIdLT5e6n
         ALdibWykmFiPurfqkBb3f4IzdZpTJuzZbfTIkdTvM+8lblyxi7oZuXZDSICMbs/r22fq
         Oti2j/A46/ZJYFwCMVdG0VcYr+ScZQ9ChAUsAXFASQceqv0e/3W4KMiAnRiZIe293z9R
         X68PX+eypPqNcuwxTH5pivUdBzrtJndauZ7eygFUUUgLqyrhEsHKObV9SQt7ITTuoqkg
         v9wwbvagVgedSL3LwHLBBWEH/7sqzzCK5RfQMKzxyM5EoMtRqDrsH4zHo6or2NZFPNbK
         FBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904108; x=1795508908;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=N5nlMC8G0G4fl0kCMNJsBMCw3gITBXgh2NqAdnjljZQJS9MH7nF8tnBGi6CceeGcU9
         cpxakrw97VMqTBiVVTHR86+s0kPIWqAeoTx1lnP9MIymybzSPc1EygnYyouj3coFHhW/
         Tfusri4gKaxvJPJyZGGgVb5D89rvpqt0rWgeDy3T1j3BSe/SP3s4SGk2HwxuQ/42DPeT
         JaYaaboWAX6ZErpXGxQhy83NObST08pNrRPCrDhiBlL21bPvu/k27OoA3B5o/5TGby2o
         MDWx9J+Uw8hMdQoHNgwudle4NhIZHT8WJMIAbNyVqBgQUMD7UwQ5HoftY/plFIg2BFut
         50tw==
X-Forwarded-Encrypted: i=1; AL+hErFmEC8tWF4poCoA2hJUjMsmouH1I6tVr6q+3wMv+PFS19nhAI7QRtQqFRC9hQK8/UGPkb7qnaxWZhC7@lists.infradead.org
X-Gm-Message-State: APuU4Z/op4kyu+1yq63Uy/CBwglXmxheixfaoHaJZQtP8eY1V2JOJmkV
	fvCXKCgRTK3an5Jx1MHY2bAPlhoMxBkk7we5ixvxzIN5DnD9FBidw9dvlqns1ilbLCqH
X-Gm-Gg: AYBFou1C3OaVk2uAVNprB4WXGNOZ6UQ3StQ98PlDN+1e6A7eVLICL1vzHcBbLzxu1LD
	2V4+VYi9VzLwWVZ56xswvxQIL3PFRAzwdRmc2N7kH1ua1pzs50IpJX+gD4Xd28X3ACfF0IZpyi9
	lghArZxCGwX1a6j5uXSRIBW/EyB4AfNULnqQZI+V4lqueyZxLxx9uejexpiZAa2GCeaX6Fym5ex
	GwsnZlsx/z0ByCZ7cPsgToAZP6PQx7HZbGMMmuYd12sAYLQ23V2nXw2ppO1fB+7MGXoORrzo23s
	14YhB6wjHLX94WnEiY8Xwk0GIM1YoIFFDtMucKfBo/UkSur4YrPty2Evr6KDpwlencq6BgAASit
	v/xhjIJ+7I7nyHFr5wb5GPOgniBI6E+3Xl341+PfEucbkRgDGj42bo9gNLoRRGnIYeQTUineBIM
	jIDmq+u7ySGIdheXrM7c9pCV0ys30TMif+ilW4vGIj1MbPNvNUniKqrs1BP8WusCMsO9s+nff4f
	jrbE+KchBU7AJvbD7nI09SLt6rG/oBvI8Q53nft256ePqAuwwZGT8zwdmHfZA9u81ytSN2NlvVy
	F0Ah3dKtnwRyhzTvWf6IO/zTQ0hgwCMRnKkEiMugKxiyqSbJdkkhl19ZrhjOkdsQ3UiIU0CVBQp
	ATujcdPB0TJawCFENGgntMnjIWffmOnYjWU0QBlXpUlTP0sNzge8SLGqp
X-Received: by 2002:a05:600c:6286:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4bb55a5d634mr255399085e9.5.1794904108278;
        Tue, 17 Nov 2026 00:28:28 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm75197335e9.10.2026.11.17.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:27 -0800 (PST)
Message-ID: <afc070a816e3ae5eb3c9e2d62d4f25c59ee61df2.camel@amutable.com>
Subject: Re: [PATCH RFC v3 26/44] xenfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:28:26 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_002830_226375_16CDD138 
X-CRM114-Status: GOOD (  13.52  )
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
> Initialize xenfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. xenfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. xenfs maps the xenstore
> page and guest memory through privcmd, both data.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/xen/xenfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
> index 37ea7c5c03469..aba7d038ed735 100644
> --- a/drivers/xen/xenfs/super.c
> +++ b/drivers/xen/xenfs/super.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0
> =C2=A0#include <xen/xen.h>
> @@ -80,6 +81,7 @@ static const struct fs_context_operations
> xenfs_context_ops =3D {
> =C2=A0
> =C2=A0static int xenfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &xenfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

