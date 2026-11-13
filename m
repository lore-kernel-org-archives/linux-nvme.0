Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782B606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=q+vhpPc5;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nPKR/9MH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=; b=q+vhpPc5LiUUvzVHmNz6MHq6vl
	R47tMZPidyrYY1RhMgM8zPNzZlMdSKzrTZ20Nta9W32kXIjI9Ly6a8VRSoKsLitDSMlPHEmTWJ/IX
	joSdNb440+YCiJ3YXk1xu8KLPPuufi+VekMwqiDpsDBtFXreg4D39xzZ+MJk5xPxOlbASoLl1+bOA
	/1ZiDW773/VF3DyMI3ibrfXgUu/ykvCRvee/z6cLsmxyM7GKALImi8/wRME1ECv/UkAQB3WmtgA1q
	CUMbnZRrnxQXLWRepxnpGfPgPFNQA5mdFNGJpNKNXziBT8Jqtc1nBfiw6OIVGKNjj4NRR99CdtRbq
	4SlzJ/Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3j-0000000EDba-2Uxv;
	Fri, 13 Nov 2026 19:35:40 +0000
Received: from mail-wm2-x09.google.com ([2a00:1450:4864:31::9])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRqWf-0000000CkzF-0vKh
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 12:37:06 +0000
Received: by mail-wm2-x09.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so3542035e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573423; x=1795178223; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=nPKR/9MH2BbUFnlFGMS/4Cy3Ax6OHiB2ALuGL/c4r3dAn6HcmRO1Tem5fkTSBYz4B3
         NDvlkdcsPdvVcr0K67T8KVcBculbjCpzzWV5KvAKUal8Rq62U/VuTbyyNgHVTkXe4Mvb
         nx5i4PHD0MJB1Yp6sGM3LSVUF6KyTb67WGKtqC6SxzZLpBNsg0BWTSbOlMnb8YVvVEnM
         G18Pq38fXPT+vSL0vhvaeQEt6MMrGhYISEzSiCQiMvALTAPTN9bqy2U43eRtp6G2Xd3J
         kcO3FJSi0KoHX/zj3vAjvGvvARowauKkvZiMsXWn2qzWCKHIeRoGlmwi8iMqfXWC4u6Q
         cHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573423; x=1795178223;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=l5K9apHqtt8kvJCc9fHNmXGN0sdjc+uIoOW68ZPqOZInd2riNAvkpPB9EXsEYjwnt8
         YRjEJTLFZvPJG2O5DRUEG1GO5851cZJ4zuPOrolUVUSiKfKrlxWI21t6SFl8B0l9uOC+
         uYcC6NFsqA9sAPYpTRWNpWYChdws77apyXvgAViQo2pCHzDaTECBzda0782bSvZflhhv
         EvBvRwBalyknySBOAhyCeK2PEXgJ/2zRADbn4VivxP1t4xLw7Fx2vbhlgVnyAtOu+5Xq
         7WpRJG4dCR+TIv1xXyWe3JTSJ3M996J0j4x/p72Tk0hrhuo2Kp+mC3P8zP5OIgTeqt1C
         YoyA==
X-Forwarded-Encrypted: i=1; AL+hErGMwrlPl+45w1ueOaKqzOu3JOxr8PttvIkVOOvH8IgWz3BXJR1nZkhecQr9qG5C2OMeF3MjhDCbyxXZ@lists.infradead.org
X-Gm-Message-State: APuU4Z8PmJthN/xFiUBCVcGzZUizCiKDm3nB0nQTmw1TPmZok0qzq2m8
	aDxEX1yGA5qTw1rH3jgS3ngJ7+FWvUIWT7nm6XeKq5efccySovFksJuRWC7Sr5xaAytF
X-Gm-Gg: AYBFou0qQS5G/4kMWlkoldxz6kfrRdZEPIHv7AVP2C/dLGCxjhNsRuj2hOr2tJLJpL2
	7P87bPOL8owNc6mItOsPhqeEykzKTcYCdufuVmEfJHzBvOrZNnYTpGSuHXbcXvaKpDh2RYiq+aC
	+swAlMWkAntQn+mN8BO3+b/V+G+z5Yo+2RHhJzHrGy1ehfWofVUynhqncDMZT47BPWPBgIEZe8O
	4PhGwIjrzioB9z+K7XUQEteOAZdxhsVuTh+Xy2wbR3p+8+1gikr3GWXK51kgaYP4FYOpHUpMDLU
	UrfdlKCOjdkIEPoRQ8oV8KySTzVrVumuVSTmxR3zczTSgKt/k0mA0d3pTc8qgW8VIENo8pozqOD
	/7wCFfaiHNRfefzRsXOdbX7ceHwGh2lPt7LMc5WLajVPQug3gzdFNy2Av4uqCbdCCAkNSIzoJx3
	a9SPf5PioIR6qWD2Fj58k/ghMuYZlwwpCj5sQuwtuv5JfP6aFSONp/c/WPicQk6/a2oNhWyn59F
	0PTF5AbUfhToSRoKJORo1oKArnToRAWJ+5xL0NO/Olb7SOhr5ACByMwrRJ0JfT9q9NkvBaVU0RN
	PgNoD0ZhjN43l8LQFnckOnTvJid7zGZ6eeg1hAmAEKNGzfriivk7GfWHl9a1K3UjVwRjgFokm8i
	dgxITPVqD
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr49782945e9.34.1794573423157;
        Fri, 13 Nov 2026 04:37:03 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm57437255e9.13.2026.11.13.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:37:02 -0800 (PST)
Message-ID: <f12140be54ffc4d1e8e4026f80c41c75cf5727e0.camel@amutable.com>
Subject: Re: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
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
Date: Fri, 13 Nov 2026 13:36:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_043705_275663_F99C5AB6 
X-CRM114-Status: GOOD (  15.41  )
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
> fsg_lun_open() takes any regular file as the backing file of a LUN.
> The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/usb/gadget/function/storage_common.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/storage_common.c
> b/drivers/usb/gadget/function/storage_common.c
> index 75831f2c7abe..83683ade20c2 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -211,6 +211,11 @@ int fsg_lun_open(struct fsg_lun *curlun, const
> char *filename)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(filp)) {
> +		LINFO(curlun, "file on a pseudo filesystem: %s\n",
> filename);
> +		goto out;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If we can't read the file, it's no good.
> =C2=A0	 * If we can't write the file, use it read-only.

