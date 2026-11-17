Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B353F606A330
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LUPOkdh/;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JjE4WzOR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=; b=LUPOkdh/s7oN1OoVBQtZjHmpvg
	YEznhyTqP0M2Fh/dBhO1gJZmE3rZOOlgEuozIUDxhLQACWoGYH4gDqwUnVArYz4qN9ncfanzPO12n
	hzT01XVUom3yciCtU1Kp2OgfWJRVKnfay1ujX0uBe5pF/JNFBAXgHlnr9jN75t9qYyfWSKg80WoYb
	kbbuiHYYqrg08bk3jomWFaoyOdDKhX5exKzwv015SELWKXsSDnyaiXLcfgv/WyaM2xdU5SR3OsD0O
	MAMvntaLFIsbI2DjTcWgHAanjwXcsLODOOhBzcfindA/QnsZX2drBKFMYboLpGsJBebwT0haPLY/C
	Vz5Oj3/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbN-0000000HPYb-2hEK;
	Sat, 21 Nov 2026 16:06:09 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTEVz-00000004scO-1Mwu
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 08:26:08 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so62295f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903965; x=1795508765; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=JjE4WzORH8POZDZ2s7mY/+S8eXZ+6JzYPTWP2j+TJUp/mdcRRsukAaV+1al6sy3ARK
         G3dJN0c2idRC0nYimVOxiuU00q4QKjbQ0WPwjvbC4cW1Qv0dyGB4GoMoS3qfdn6qO/Wj
         epkEnFIx3aXwVFHdQ/JJfGtf+6J0Xey8sOGCc4u5NaO9gUz46swwjXjixp6FHNn/9T9i
         8GP28hoIsdRSgEEB5pWQFPvmPOGQaZSN3KuOC/q6jOoFa9xTfSQWxEaoxr//6ck3k43o
         R6jsn1lVFlnxXPBkkeN/o9Bx6mzx7JDpIUPN3tzs+jBG+cnkFKq8N7ZpjNC2QgaLwbV7
         oS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903965; x=1795508765;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=DCZCNWJLDsXqriHmnh+sJubP7btNvZBqrROi7mbl2i8EybnpirdHWIMM94utVD6PCF
         yNXoGDJ8+8qp5Ce0RNYPFas0eErLnPBqWbb/LRfEaMrWh4S0VczSe4n+Hj7lr5rt4UaO
         9pxsvd48EWiL/S+cHSb8UHODKr0MDw9H+hrkKek/vZOPTV9z8dOCAx0Dj0U896ZKpzrG
         R+bqZCcci9eJxHmCzymyav9lSxGWvTICtEl6HXzJkhke6S+Sek06Y9WKX1r/4Cdzqxk3
         Lj5R6gd9cf365kfWnyplPmwJgbF13/aHbLvY8sEqOGAT9z4SLJGkwhXrApGkwxCDju2c
         RQdw==
X-Forwarded-Encrypted: i=1; AL+hErEtvVcxwVxAKcXEeForcT14LNdp89niWyd6Wy69djWouf24hZAHSWXwlKt8KigNJkg0q3gfFX5aE3av@lists.infradead.org
X-Gm-Message-State: APuU4Z+VqiaS/dpiCDbJl2SyUM4kZCPhpIGVk/4rmwXc8zm84B0wYesK
	/uFapJGMJdQDlfRrfR6ZVjN7GR+YHGAIcnxa4AQfyhKPmMchBAK6CeaCkHICOiKYIERR
X-Gm-Gg: AYBFou3rIoC2TMerIyN06N+IzjryzvJzy/8F08XJPkcm2UPIe2yoIIb8KQK/AA6uCcI
	95X0p4mlXiaxcavmeHzfXUuMJmVdzmGDkAdFE31JUBuuHO57KwE++6fOHKDouEycSg+n9HweRjY
	yzi1GmRuvsRthMXKFR2Z5vcVrjGCNCpm72O0Z2ptBr4bcqWPZU3YCqQvs+iHaVMGNmLyhbLCBkx
	6t4feQGNCZTZERGVpxYHfeMOwCOb3R1tnOYHyV/NgS8CASa/aMjG1RPsRrQz+Bmo7N/KmHd9lPY
	YRgNFYXydjh6+Jr53y5SJ+By44G28b+tHFL5/as5znqQNDVGX0F1PNRAcCWGgWZxXx/42YYr0NZ
	8NwgMbwpBzaicNIqGof97QdmCbGKypGAJeQl+ZHi0oRXe+bbu8zQV+Zjs3yypsK4/af6QPuMRtV
	Yd2Pq/vWohXwxEz7AdMsxw3SF0bl+r62TBmQf7RCvOjzKNB8XeZIuq6J+OmBju8y7uJq9FZybPq
	uplen006HgDKFgjD1b1j/KhgatchGxMUd5oek8yd/NT7RyDVHyb5gBoKo59BxbcxDVTWz83gxKK
	xk4UYMHrXoUWnjGISAq6BQcsAB6mFRIyh5vW07Y2qLCGdz9Kc7l5KEbPzFxww56a1jnQU9QmCwy
	BGdd7n+66Txky7hvLXNHcL1A2WdB/y0K+KWTntXnFA6bSlOfA8D6Hm8aq
X-Received: by 2002:a05:600c:5493:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4bb783813a7mr42606245e9.10.1794903965400;
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9430asm12629125e9.15.2026.11.17.00.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Message-ID: <88041240268f70b218de7dfd58c41977d03a60d3.camel@amutable.com>
Subject: Re: [PATCH RFC v3 03/44] target: fileio: check that the backing
 file supports ->{read,write}_iter
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
Date: Tue, 17 Nov 2026 09:26:03 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_002607_386802_F941C6C1 
X-CRM114-Status: GOOD (  19.10  )
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
> With fd_async_io=3D1 the fileio backend calls ->read_iter() and
> ->write_iter() of the backing file directly. The synchronous path
> goes
> through vfs_iter_read() and vfs_iter_write() which check for them but
> the aio path doesn't. So a backing file without them calls a NULL
> pointer on its first I/O.
>=20
> Refuse such files when configuring the device. On the synchronous
> path
> every read or write that needed the missing method failed with EINVAL
> anyway.
>=20
> Fixes: 769031c92c8b ("scsi: target: target/file: Add support of
> direct and async I/O")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/target/target_core_file.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/target/target_core_file.c
> b/drivers/target/target_core_file.c
> index ab9824a4852f1..a5391e57e9aa5 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -144,6 +144,14 @@ static int fd_configure_device(struct se_device
> *dev)
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0	fd_dev->fd_file =3D file;
> +
> +	if (!file->f_op->read_iter || !file->f_op->write_iter) {
> +		pr_err("FILEIO: %s lacks ->read_iter or -
> >write_iter\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd_dev->fd_dev_name);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If using a block backend with this struct file, we
> extract
> =C2=A0	 * fd_dev->fd_[block,dev]_size from struct block_device.

