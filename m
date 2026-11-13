Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193E606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YvdYCYmy;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FnFVzujd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=; b=YvdYCYmyzDOMcYPV9WWl+eXGXf
	vCUeD8BpwN4D4YJ3msUx7NZ5/SdoRjEraukNUb0OejnExrS5+eyrbGX9pUkpkVaj2kDPtxcBMZS07
	rSVBaFlcuHYAFN0FyZUQXFumYtwosuLITXtEgbobQYxc8i35TD9GxsGR5HNg2/EkSbMwOn+bBn+Oi
	WYJOBKJNGFt4NVZsBaXmzwCnbJ6b7eCPuYXQs508+ysbOC9tDrKgEPO94CdwrPC7VWqyetm78xwR7
	NR7ZD0djtp+9zOkEuTL9WDHto9jWL8SrKuVltmcu5C6Ic+FzWEzJxwO1GDfYj0JVsBNqjbrBO0ClF
	H1EBcfhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3l-0000000EDeC-00In;
	Fri, 13 Nov 2026 19:35:42 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRqY2-0000000ClBI-11GU
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 12:38:31 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so3649015e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=FnFVzujdiMLOzr2GWOaH1ZVHmMFoCKgRFbS83C2anW3tpWNyxsgemW2VJuC2FzweiZ
         F4HMvrT380yaJ510DV1/oHeLvEGZonA+eGQZMrSlcHdP2Z13C/xHTcVJouV2LPmw3McC
         0OSUP4wnWSgg5TGqpguNRp/YVQas4Et39zL0Deu7V7ZkRXdIBH8xivIkT3zEDfiQqZ1q
         DgnTtpXn+Sr7zkAn6Edf078psKOvLqk6RlQaOulHD/J8PVOFsFpC/3pFKJH7vZS5MApk
         auF4ilJ47xjOnG3R5NPwg3T/Te1Kdd7qcbgvqhTzdN/3z5h3ERuY+M0baVPLEVBQPYp3
         WprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=SbudfMFfufcrxoll2NG4V9wr7uJfdtD08C950doL4iKt6NddqUQ73f8C2Nt7LFCqG/
         GXLS+K45hr3LRV0Xe96nNv0MfMb2pdlXf3CaZv5uRS4gYuTuq7TLQGqOkvJsQWLiYnlV
         uzdwTjjV03qbO/GzMuIIQm3G7oczgxlmjjeoDFiDQf0H8MPz8VDsmAUnW2gYndY0h/xg
         vs1esxNASiP/DyjKBVgKpNSX/hwGeitRwRjW17dPsemJ1CAaLtAm3OEd/nKy4t1a5uP2
         TE6pZnUlDPdDS+7y2gc23XJXd6lV7ZbjWFBaAYXE5OXwajEPigRzQesTGSr0C9ZouVi4
         wOYg==
X-Forwarded-Encrypted: i=1; AL+hErHGBCEECtlNqYW+BTXpPPlmB3yz2M2RoYOK4GfV1HEGmG5HborfjVmxnC7Knt1baW6aUdcqvTd+tyO1@lists.infradead.org
X-Gm-Message-State: APuU4Z/tIsk5sEEoF/4MVQZnsxUWD03PsUYW+Eh9ifpavCBYsd5hECUY
	4TfQlS/OgAxun6gy6BUR/TnUEiHkZRu2VbCk4LjzqTGou8SXj8un/6dZGUb+kdEhuDBy
X-Gm-Gg: AYBFou0nUK3IZUhU6lRL6bOcA9r/54H35NvVQpI1B/jwcVduNI/PdJwyqFQroTG87gN
	4bcBEamWhH6UFg5RW7h4tn2p5cEsuU7OIsR4KKxXmRJW4HiFBpXL0gLfngmTFUF9gNVnYJS+8mU
	UewdZG7meVLmILYLxmnbys6n+5L3FUHY/R1h4ZJ4ik2WUB2wJtizpBiLOtg+SIyxyhhqracn01F
	AeQ2gYqdMzsIgIjsLwQx+RLnTAh+nssabcl2jhIj51TxwNJZBuP/MVzVv3nKsCWPAOu/bYbe2kK
	oUgsr93SdKPJ9jNwZjBAkOPjtKK7v+/txOOz3pzdpy5pg9fzXeb77yxxp2N2/Ghq393A6gTtQvg
	BtbxOsilwAm7/32eK+jMhZG3uW4+C2vSnvzBgbAIB3mDt3h5v45sJ1+0gj59vmyFGiMpVyJcf+Q
	qim63aM0iYuyUv8CDRsBNTSbJpMKL+voiGK0CkKqY/2C+vGHBwmXO5corlo32HIQzMCKPVi64pY
	E60jKj3dNFo8RSP9xRvzv+n3Ia8bnsge8wYOLhppsgeHmX3quJ6HWRkYtYadx6rcoI9eKTgdZaB
	Ko46KP1g5KM/ZEG5e4CeM4FAoyJnP5mQhK0Js+MQF3f244//di9DojVKF0QsziE=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
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
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_043830_297631_624F4F88 
X-CRM114-Status: GOOD (  11.55  )
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
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

