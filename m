Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DA606A320
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lc5fto9O;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iuzB5WxL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=; b=lc5fto9O9qekqSzG7Exb4N++5z
	UE8bXdtqjtqdY+/RDogDxBaKesMuLCSknrj9VZ4N8srkxrW7pp62cP8DEgoTHkETtOSdh4LnuPbk4
	vFfBxVlvzpKQ54PrNz5OXz581WH+UH1WRSeOpnWSbmYWQH2tl1mVGmc75XdDyuWgqZkAcMqkUUL5A
	8y4yqQFfydycmggPIog21l5BWbdBE4FAUez6JNAkxZ1PUAPqOP4qUwHbVbdzLlrq7/HtPkM0gax3Y
	RTY9GzPsHIYPLPO5HclWpLNahyBRw/jCliMNqzYJlms3KgUKIymGkSGgl8Iq5YHBXwyKc77U3jEoj
	dVP7ymXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbM-0000000HPYD-0dEe;
	Sat, 21 Nov 2026 16:06:08 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTEVZ-00000004sUM-2vHT
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 08:25:43 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-492690dd5daso4102908f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903939; x=1795508739; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=iuzB5WxLKB4jKGjPmPacs1NMmOniNfT3GcWwoVnXyLNPRGBJI3kJPoA2bDPn73GqdL
         g2qAMVaBR/1rDp/xmEFTvZMttAejyZDrnx6IAvVGZFMMIOmTGXibSuFV6C/8W5c7Dsc0
         OYWsa/Al4SbYJdVObqjNWWDBzNaKA34Yf4XOqex0FsZWZhBk/q1S2GJl+Kr9vxG/7+58
         ply61g3PE8EdGT2e+VY4gNmQWBH/uRVsysweld3oF+rwyhFWdepfVytosRUjDYIVqaO1
         iXU7gd6k5E2xna/vqA6D4TUhM/9RJdgrlV6McEMmPfYx1mK+g5g5vvjjVgG4p7Gqgi7p
         QwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903939; x=1795508739;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=RBFt1/TEuHI9EUPZ+ieonE0e2c5XZjyOFNs6ke1yzJzodD0+dxsWxCqOVMadZC/7Y9
         DWAFJ402q5D5XWbpZyaxPxm8rNCZt9S9GU2x87TzRZm5lO8KxB3Rpp1PkItG5Qu8xUvd
         +/eUl9GLx2+QxzqLvQOd3elhQkCdaNDMoEnellEDUkbC1okmFyRboLzMGVZIgmH+aK/z
         HFuCw7Q1a+r0oMZBKwKENUlN91NmWMYAtbMczXcBACSIYesdMVKnheHlbEB2VBjZy8M1
         YAdDhjSG8co85JgM1sguy+5t1raf94VenermDt54lH9sT6If64CxHVWgPhZkZ/OXBP6n
         vMag==
X-Forwarded-Encrypted: i=1; AL+hErHme8t1vJlVunPKXkXJYdzeTQPJgOKLGFIlkJVs4BrfKLMdPbsHzWEW1u98+3+jU/A6hEvexunBhk1o@lists.infradead.org
X-Gm-Message-State: APuU4Z+Lf7i/jVJu7c4R2j7qpv4ExnJK0XXBivXSAo8YtiR8tKMPw8jT
	gfFYvnKBnnYbtJTfi7JZj4EJscgabfmYaW7hF6eOeA3nURdO2v1t5NPxEOdnu2edwQfD
X-Gm-Gg: AZFdTZfeOJHxM6yyU9Kpuby/cu3EulOH4TwmWIria+dGpMENVhsAOw5HPWMiVsWCrnK
	NIuqBacOC5a9t9MozbCMjWxIV+/FuQMNeSEgHDlhtjj4AmMGLprfBb/DPF9FA+Zyqa9Y8GA8bPf
	JtUbDfVo87sACfjL6U22J0d3JrFlGqvktP6GYo0DQNw/CvaRmQwq0aCM3L7NMEEKljj0jECFp+x
	fHLq+liol94Qo6D29xoSlN79CEU5nZ3WrXhiKOwtFgBBftDGm5LEJxqdA3ZsSQDs8L9/4+rWlNC
	gyIgWN9OViGpEwlmpGeNSwts4cWx6rFrGY/z9L9yBFYAzqoTTXhQC/z9GUtZPjZoxvKmXTBPzf6
	RkCwAhyW9mjhAVTIOcpWwVQD1cHxmTLE0rXkCsnjGDTZ8piESG2qY11g7tVRRkjbdZunch7zbkU
	Z6HjgmPaE/lA19HAwqb3A4ROo6je3zFHXkA/+XGh2h/KYRnSkYGVkydh0JPm8AF9cILmXBimOaF
	D7UULDEhPre3zIq6cJgLB3z/z+CK+eLPk/NjlQPS37xDp73QoK4pkLKDgZPs0MIWQTPitXn040a
	TPXNpptAfouXN+V0+xZVItCJvLcikj9rrga+a7ChGTbFyJReBr+G7nKzSRA27oGd0gz7GxD8hOT
	r6E5dPGLzmvMRWhL0/5t1VCWlilZejogW46WPPje60tQqKJ2AU60xHA1vTFi8nlvWXYQ4UOvbND
	HqSA==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr25238543f8f.13.1794903938925;
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm26907832f8f.28.2026.11.17.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Message-ID: <a9124bf1c858cef3e8ac06b1b2396dcb0e19e2a5.camel@amutable.com>
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
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
Date: Tue, 17 Nov 2026 09:25:36 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_002541_849233_025AB262 
X-CRM114-Status: GOOD (  18.32  )
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
> The file backend calls ->read_iter() and ->write_iter() of the
> backing
> file directly but never checks that they exist. Everything that isn't
> a
> block device ends up in the file backend. So a namespace pointing to
> a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such
> files.
>=20
> Refuse them when the namespace is enabled the same way zloop does
> since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/nvme/target/io-cmd-file.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/target/io-cmd-file.c
> b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932ee..dfa8aa46188c8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (!ns->file->f_op->read_iter || !ns->file->f_op-
> >write_iter) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> =C2=A0	nvmet_file_ns_revalidate(ns);
> =C2=A0
> =C2=A0	/*

