Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F8606A32D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NQp+Z18A;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=r40zf2j2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=; b=NQp+Z18AFYuaDHYPSJeHP1TRJK
	P4p1lbVdIY2czxM4NLFr+l0CDeItQXcmBfI6bU/wLWnYz5hcFmDGcJbP9ftWgJDia6SfkWM1oO3Li
	3AAkFxM2BAEqeR19rFSsIEboR+DWjMKQhZT5u+685Sun2tA9f+nnc41CLCDc3RQ0memSndayeWhlw
	Nma9oC/HqI2giXo0KIhfaZRxCr+Dlpr/mItDKKQcgNyF+uG+WO3iO9Nr8bknqo1WQdzHJdlGrCtBf
	39hBGmGXL3kgXbxGBmFj9km0yfz2KNmNXp7BGCiRHLPoqgYW4ieUFCPWmPsZRNny/Oy1RR3946FBQ
	739RK+dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3c-0000000EDKC-2Lzu;
	Fri, 13 Nov 2026 19:35:32 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoK8-0000000CKD8-0Euh
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:16:01 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso156034666b.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564958; x=1795169758; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
        b=r40zf2j22K2VwuLmu7dusOdXd8kXDBgA/uOC6POdkv7ZH5si8CfkiL1MHbsksZR3MC
         xVTKloYdBZ03JHD+ugGAfVwtW8WtKUMMkpnmU05jqsxyhiZWe+0kGr7v8aA2MtGvQSfg
         adwv//uX497edV1LaV6N1msSwXq/D1l4Y59uFjMliR9Hh41rWTmIxVtTXREsjaOTyGYc
         GPs0jGkOI2uDZHAryHXZEf5slpdc1Gp1fvp22WPqcXQIk9ZSDeg7vr1gFOhWB98IeaPj
         j6ly70cN/s+6uPXcXi3Wo4H+mCK5Fq9UT6LJfgDltC3frUAF5uYHmgAID8Uv7Ay9WILg
         8qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564958; x=1795169758;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
        b=KUo/ibEIpwQ2wsO/Ycc5oSD/xuhRn+IbroUTGTBFSr4Ma5QG0XUgAOaAxeteDIM/zP
         kUfBAi2B1EuF6OFTZPw/CUMA8ykTWAr1OfrBztyQa/yb+KMiUmOjH4F+aO9uBW29oW7F
         lATLLeBS+VQK6ApLUe/mOPlQZD/FL+0jnO7bg5RGi+HKmWsj3pezXJMHuNhauJ5i3Yoc
         XZLSrVHJT3U6TaL46L9979apLWkUjWArgl0CXnv1dS4orFKlaTem59WfD8CpTHOjYLyK
         PNuL+zjmek/Wuh6JDD+rg4y9Ek6EQNP3/IPlyx1MyaWG9D4PRmbMAfBMlxcEUFMJmPmQ
         vt1A==
X-Forwarded-Encrypted: i=1; AL+hErFKfzKDQA68D9Fuo9WGxva/XEOFB4Qihz/VZRPY23a/FySA+r7JE5icEePuTuYmmOYs+MLBGeChx4Hf@lists.infradead.org
X-Gm-Message-State: APuU4Z8UHiRl/YS3likPPRF8W7rN6wfHi58X+4YRPFeI/+Yh07TtTOEm
	2l7is+lWaOpO5YdaNZPcCrPCPV8/PDLt+fqh4MeNO5PWnU/ZwII3Y1hWKxJTxYO6/Nhm
X-Gm-Gg: AYBFou2Ap0IceBN9rVqsirUAeJ+kURdjz5Kv0zo5g2bYXG6tJ9CIOeJLLfXwTqXH8ZX
	L2GbkOFw04ImF5c4YmRGW/taDci5xwHLtQ966twginQt1xv/DyldwmJQpaNZnnGRaBPxcU2znC8
	YpbOFHICS+yQK+xk73rkddTkg2xdgL8P0rUc7VKN4MGHD5ViJORKqFJzjenpUjTFLyuPcWoy4Wc
	Ku2cQeeFbExBo3LPD4XRR3jDjyFIfP36wcyEO/vKL+/3tsD4WNNR/YmXoMdt8DgSzfZ1GFdysyt
	MARj0Ny+GAIb+4klQB8ufVjBUS0fIR+4KheYyZCLnJLDRajSeE3yqFo4X4WOOir7/Mioq9FYFOY
	nuVcLIzWUBLS9AA29uGTJDqgIGZlVZRvuSRXKxcGMZTBh9fABE75xIcHZs1T4BP0mwXUkEtws3X
	FINxcVw/I8YWzLMGBVbwqGMV4pL+ClmqUnqiavtatgRyF34dx0KntRYxR5PJwNfimji06C67w9E
	2eWM+haO6IM70tXdbrHaV0y1dbh03qXyzE2xEDgcVzgJKsB0fc54JdgZtd3d+ygF4bHqPiozAIF
	Fbx1A8hn47QJfryV3VV93MCKxi+DwMwNHDP6yqzxzpY3OTIcB7zXWK1SjvTw3vo=
X-Received: by 2002:a17:906:f59c:b0:c42:102f:15f0 with SMTP id a640c23a62f3a-c509614d4c1mr171873666b.3.1794564958075;
        Fri, 13 Nov 2026 02:15:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7d1b7sm75606066b.74.2026.11.13.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:57 -0800 (PST)
Message-ID: <c5a694991af7e9182fd475a20bf4cfd73a13e395.camel@amutable.com>
Subject: Re: [PATCH RFC 34/41] loop: refuse files on pseudo filesystems as
 backing files
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
Date: Fri, 13 Nov 2026 11:15:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021600_144363_B0C6128F 
X-CRM114-Status: GOOD (  24.16  )
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
> Currently loop accepts any regular file that implements ->read_iter()
> as
> a backing file and any that also implements ->write_iter() as a
> writable
> one. That includes files on procfs, sysfs and other pseudo
> filesystems.
> For example, /proc/kcore attaches read-only as a loop device the size
> of
> the kernel's virtual address space, 64 PiB with 5-level paging. sysfs
> attributes attach read-write as 4096 byte loop devices. Writing a
> block
> to the loop device of /sys/kernel/mm/transparent_hugepage/enabled
> changes the THP setting.
>=20
> That's not just nonsensical, it can be abused. Loop calls -
> >read_iter()
> and ->write_iter() of the backing file directly from its worker which
> runs with kernel credentials. But pseudo files enforce part of their
> access rules at read and write time against current. Dozens of sysfs
> ->show() and ->store() methods call capable(). Behind a loop device
> all
> of these checks are done against the loop worker instead of the task
> that opened the file. And setting up a loop device requires no
> capabilities, only access to the device nodes. So on v7.4-rc1:
>=20
> - uid 0 without any capabilities can't write to
> /sys/kernel/reboot/mode
> =C2=A0 as mode_store() requires CAP_SYS_BOOT. Writing "warm" through a
> loop
> =C2=A0 device works.
>=20
> - uid 0 without any capabilities can't read the files in
> =C2=A0 /sys/firmware/dmi/entries/*/ as dmi_sysfs_attr_show() requires
> =C2=A0 CAP_SYS_ADMIN. Reading them through a loop device works.
>=20
> - An unprivileged container that was handed a loop device can't
> change
> =C2=A0 gro_flush_timeout of its own network devices as
> =C2=A0 gro_flush_timeout_store() requires CAP_NET_ADMIN in the initial
> user
> =C2=A0 namespace. Writing it through a loop device works.
>=20
> The same goes for hard_offline_page, the md and sd attributes, rfkill
> and others.
>=20
> Refuse files on pseudo filesystems as loop backing files. Note that
> file_is_pseudo() looks through overlayfs so stacking overlayfs on top
> of
> sysfs doesn't get around this.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c96e35c3ef42..1482580a1979 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -537,6 +537,9 @@ static int loop_check_backing_file(struct file
> *file)
> =C2=A0	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (file_is_pseudo(file))
> +		return -EINVAL;
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

