Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F03606A331
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VciTRwuF;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qTOwNLp9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=; b=VciTRwuFqlykQebCCPzaVsE2S6
	d+203XPp+w693CBjQ8OuwJXSFUxhSPkczdM7laxzuUMEzWqefSWV0GholVsSwcWRLb+e2TIq0rHzt
	aCKig1VunGXPsZLW6TRXLs9G2eLv6fhYAHY7bvP+3qUcJRrrvoGR6R/lkqoJQ35Lq8O8ohpx2RUij
	9DqmVs/sRYrAVdgkeC5dKohHJWe5Q3TszjKbHQ1ZsuDrwWafWpJ0OAMInlP7KUqbGto6RaInpjTNm
	TcWtKqtKT2bTmxcYAstJpLZoPL8+Nlcmt28O9rneDHGD8BpcWVWfW5gJ5MNkSDE38w27HfTWyv2kN
	1kmmiWPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3X-0000000ED8r-1rgm;
	Fri, 13 Nov 2026 19:35:27 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoHg-0000000CJoI-0jaX
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:13:29 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so13721195e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564806; x=1795169606; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=qTOwNLp9X7K/G0+U9Ndsevzq7qrtLvStsgf4U6vhsGKOjfC8Tskgz98sMGWboBbTQs
         Aw3gwsnX3WqQ02c5W46T+tm1WgX3k5ZW9XJ9pUkka3Rbjz6N7zsgrXjcMCZeZHuq2yjT
         FjEBszViBNswiKeO/74AL6Q1vVx0lapteHw1LvWltNX/muP2SQ892ujlmGSmzL5oUfs8
         3auHd9ZwwgdPlANyGgIZanKUCJlHP8ibjpmmsTtiAzyfca+MonHK0vG5XIyB6l0kfeuG
         M4N5Rhj4ZOGjY/Ir/6qOhTQnI58l1I4mK8vokp/BmO/Li3PSVqx9/JAItVoFPy78UzkO
         s/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564806; x=1795169606;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=LrdSte18etVu6bdDNlyZCS7c8GgZ1d3OLMLajtbws1Vq+e/eDtwXuHjzKD8y5Az6Wf
         Nl9dpQWaOIbKaM9Km6FPCv09AbW7Zm60uV73BIhX7WKiEZ/alIv6DbA/jvLen2TeyYS7
         2D26+ptmeTnhDM1EwpHcgJe5D+QRuCrfxtF/xgpTdiTxrDESuPJURDcAvKgZ69t9mP2V
         t2Z5RH2DnafVO6EFQKIO8xtAbjOhqhVmJFDk+9xoq6PkrImUY6B+SWPZybPT+l0hG+pC
         eNqofH2F813d2uhL9iJcw+UGIq8/bBi2hV6Cy7Ux7sy96LIo755dFGt0NtoNBFwg3x7I
         2u2g==
X-Forwarded-Encrypted: i=1; AL+hErE1R4Op1I+hnGApO4ZpLkVWomgVdWJ3rcWnGN3dPaj3sm6fm1+fBPRV1PcXC1ezt+WKQEOuv3jlWlKf@lists.infradead.org
X-Gm-Message-State: APuU4Z9z8itiJL5gg1oey1G1/AfYR8y2quwO8LJgjsKaOA2xUmfroPOw
	ob8qVkd/uzKDYBOfoVWFC/WcxKYKFf2EaL6kHsU/1aZSvjGlgHJz1k6atnZnP0PYQymh
X-Gm-Gg: AYBFou2aSmxns+q1BVF46+wm0ieSvy6TPvoOAUicQUYFfrLFuoZr9cmqoyT1XEOtqR1
	eJS6JTw9U9Oicxy/01O5bG3UH3TjlJkymsy6Jr/+DA75sVoXnx/NShXgW8I2edG+rBw5jczj5vn
	ip6XHbWeQgoGVkEeNRNCRXdMcR8e0hS6QRkRicqCK985LZ4apHdrF18vHyn8au3/65ZsfDUUpaW
	tlAa26Y7OzSYzP4SucjfbKVkfx7TCE7RFJDkynTtLRIwB32tDCqiOJylJfOIEfJHQmA5iKe9znq
	VmthvSYHTMzfQoe5lk9jBSKvcLyMebuA4Sct5ZdMkSwbIfNnzlSBRrgC0yvC5t3VY9HWFxkGUUs
	oU4sxSMMy9eG3fU9HhwB4IcuhVOG+SAeW9UzSEmgdgROI13ZM6WiRseV3oChj4JsqLEpPqCxZWs
	t87csajld4iKhz6ERKE3FfPSh49ljycDVSNwtz39m32NQnHHg18Zer7mlgQgr6rIKSW7ntfUgF/
	VbS/S0e58zxiuqzdGf9zGQAf3KCxqS1MjS04Xx97nfd6X9tmMaWgRHI79MAuHW10A1vFHcQidLF
	4yt5GyWP7EWcTABhwFZHOR0uzx+62RT2/TciZyd5XZucc13bLB+LBRudlBMOKJU=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43583035e9.2.1794564806374;
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm4362275f8f.49.2026.11.13.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Message-ID: <23edc29c421f5d4c1103004f79e104e9f94d42c2.camel@amutable.com>
Subject: Re: [PATCH RFC 23/41] fuse: use fc_init_pseudo() for fusectl
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
Date: Fri, 13 Nov 2026 11:13:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021328_311098_A49D42C1 
X-CRM114-Status: GOOD (  11.85  )
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
> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/fuse/control.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 21ffde596d61..4497362e7df0 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0
> =C2=A0#define FUSE_CTL_SUPER_MAGIC 0x65735543
> @@ -334,6 +335,7 @@ static const struct fs_context_operations
> fuse_ctl_context_ops =3D {
> =C2=A0
> =C2=A0static int fuse_ctl_init_fs_context(struct fs_context *fsc)
> =C2=A0{
> +	fc_init_pseudo(fsc);
> =C2=A0	fsc->ops =3D &fuse_ctl_context_ops;
> =C2=A0	return 0;
> =C2=A0}

