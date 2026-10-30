Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD009606B7B9
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AHg4HOIv;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=DqNBr0Nm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6PnPZflWZGQkBJLvcdzUi8qDR8iMloTcXmEwdQBRUDQ=; b=AHg4HOIvFItJSb
	yl41Y5iy4+T11ni0XHxsSXsY/lTZM4AKGvgwffcPes9Rp+aY3fdAvULAZ+reN63+hnZdXhwjOPA3i
	hQXUP0QMx9RoGhT3JgzAxfnmhzOfd+PQJjedAUvJp+AwU54bwcTsXxd0FmTrvlXUygqd+AvG/4nav
	HafJ8OK67Xn7rR0Zs506OMZr0ZlYr/+68zaHuM/0scPxUZqDu8mblqnU+Uo4v2E/+d+mRt4sjlqMm
	nYnhqWi6AL/QNXh6S0R0zavoZg5jOuAiw4smz47BbY4XM9bMP0ysbZTL5EVEHbzsgofGI0Vr7B10F
	qO5+YhQtP/Tk2y6dvapA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMu6u-0000000CbhU-3GoB;
	Fri, 30 Oct 2026 21:26:04 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMu6r-0000000Cbgw-3e48
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 21:26:03 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5365d26ccbdso15536931cf.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 14:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793395559; cv=none;
        d=google.com; s=arc-20260327;
        b=I5RynuhdBUfKnS8ZINHw1aP9kS0mnL3x/Eknce2fPUCtwh6qD8owa63hAsBj6ay0sl
         CTArGepGnTW90QbZ1Xhy13cSf9Y0Q4GYkqUn6sl7e4dgXg9ZBBjCXrIHA1pDEumDM0S1
         eymSQHx52WhAg9W1Nig2dA3kR4er/pVQ0tAOkhUMqhYR0yaai6lr1TxfHQLb9Y852ZbN
         9WR54QmdD0XQbI3uQ4oDC4Y5DVS10aXU1J2kcroZCmDY2iAh7ainmIOxbu3Bjrb1BHky
         5r41C8Znyjl5BXQ7qPQJjaUnT+vr1FkkVLUtfVKiZ8MO9/VREKKEEJbAW5niwf8NN7Ck
         MPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6PnPZflWZGQkBJLvcdzUi8qDR8iMloTcXmEwdQBRUDQ=;
        fh=dpYg5ZyPGssdK2QX8KES7/SA95S/yONaDE5PB2RwqyM=;
        b=jxft5L47E3owVPUVkbU0pYdxvTubWgKjNOcq1B8Y4zOVuxdNGy+27ji7AeWkUiY8fw
         LTEb4ynT88vrAwKUAtLq4OnDO3oZKj4KH0Vfa40mkcz+39nPTHD/yuL4WXIInpaz0K3s
         3D6pucgx2ppCqen8yBCENmUIE3lWgqWfPZtuvZ4kRXJckEr8JxSJB76fmp26lcd8MIaA
         fRH6jbYpXc6gejFkwkT2JEJ17L67m9c7pLglu38aXyUEU0bjrg7JBoCQhYsQcNstFzbU
         imKceDh7MVmIWoMzgdq/3SkRi9LRtA+hiW0cPEDO1LMvdASZL8x11hdkIRwCox2NeiNn
         Ax2Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793395559; x=1794000359; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6PnPZflWZGQkBJLvcdzUi8qDR8iMloTcXmEwdQBRUDQ=;
        b=DqNBr0NmRem50ImtSKatIA5vy9mvWkvxv+OnijF0w3MFeDeb6lH99KzGSGshfTSgD8
         XgQuH+Tzhn1ycpjthq+fWX2ppZJC9XRoGZjw7iMoadxjSSRmNw1Mdtav1qgNOdE+C8hb
         pgFCaUxjucqX5HFsYkXtSX76cpjziMqWDewq6dWU/QTMdgxBwDJHIkaiWuL8x2q6rfWR
         JGJgd7zhkSHB5ScbO8ADHkrtNlZlq38VbB5rKF8pbStIpTQGcdYwFbS07g0cyOnlVTkt
         F+CM6F1uD339tjvg4nZksDIoev7hn+ZPLgc3zzq0zc6FRWcXZByc2gOecvsguAQNZMBG
         DCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395559; x=1794000359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6PnPZflWZGQkBJLvcdzUi8qDR8iMloTcXmEwdQBRUDQ=;
        b=pOB0onSKQBpWxsf3OhUF18jw7VbeJiLuJfn0Zv/W/155dsgCLe2XpcdOrvA3PizxG2
         V8MxPCsADV03T1Klc3HGgRkutzAdnyr4U0rKmQSGcTvU4Xzd1vEfdXnvP2WVFNRAQZre
         VGiKAwjFskeKhikOqA1tFScEkyTflXCjBSUpGav46E/QesvGyAypEervCmJVvDG22Hwc
         zBwmDeHgSox94hGmfQ7WMyYEKMMo5oKad+I4vHmDH0rZ2sF4bouKK8lSLR8BEriLrU2a
         9nkw4E4skEvn1FzLo0O/vF+nrCVPDFf8H62OYviAMUKVhOaWLDNPqyEnGgXC+S07amPI
         Q/WQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRmWEz3XP2wNXEdANPndrg01HAsy89hv/eszuK9vF+hHGk+QaotfRhWwEcG9/prm5r6vrizG5mh+O1@lists.infradead.org
X-Gm-Message-State: AFq9FYJeWwxGHlJrt0X6mwlW93Q66wXH0uHDLeQdfHBj/Qx4lGmoktB7
	Y+873OHT6U1y/cBVpZigvleVUlHeCekJ5DNlsgNbCEJL8v0hdrF8U9ALz7+A2c+cdrHDZp4BSKb
	uYFNXt+LFICtTuh7dGp7Pn6ZluonrN5PlcOq0UH7mjA==
X-Gm-Gg: AYBFou0lW3TIJ1AsfcwUC3ZKal9u2Ofl1iQgFjB9aihrbCGv1BvaCNflAoc1MDw7n6M
	AOK34yMR1ifsPEIplB4d7qVCOtOp3C0rme7PU5Bu/HlNYqBHLs/niNreA2MvRI6LE3z39YWxFoV
	HnVZErwOGE+5jD1sLyd5bRL5KVjDSOSDqse6gptIetdgEHe2sbBj1mNUq9zGSLrKC53ULNVLWbb
	toeNwgBW6PbueuHRXOy6O7GNwSQKCI9zCkpTBlWygRYDxJIWYy3KLQS4tjsKe2bdbSX1aU8cTma
	KGVQtvWaiCQ18LPrpDv4Q7Y4y09DCC3XW+MX5sBeVDHBG7xyLREMYndXwOqWrtUF+S3GNAbelpv
	TBSxW5/nWKF85pLjqD6doG4/MUS7O+DQHjfV3
X-Received: by 2002:ac8:5a04:0:b0:535:25db:17b1 with SMTP id
 d75a77b69052e-542b62a459emr59994351cf.17.1793395559191; Fri, 30 Oct 2026
 14:25:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com> <705f4452-3d07-4d91-9dcd-ea53b2cd75a5@gmail.com>
In-Reply-To: <705f4452-3d07-4d91-9dcd-ea53b2cd75a5@gmail.com>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Fri, 30 Oct 2026 14:25:22 -0700
X-Gm-Features: AclHuK-E-tAbQfFFoffttX8JpmWen3SDKN4NyGsv3Y_ggaQL4RVBOp4lMFsPazQ
Message-ID: <CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2BmN20Bh3btpLum7THg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and startup
To: Martin Belanger <martin.nvme.dev@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com, 
	randyj@purestorage.com, adailey@purestorage.com, 
	Hannes Reinecke <hare@kernel.org>, wagi@kernel.org, shinichiro.kawasaki@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_142601_919957_20337210 
X-CRM114-Status: GOOD (  22.57  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 3:57=E2=80=AFAM Martin Belanger
<martin.nvme.dev@gmail.com> wrote:
>
> On 9/22/26 16:07, Surabhi Gogte wrote:
>  > Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
>  > allocation and startup"), refactor nvme tcp I/O queue setup to use asy=
nc
>  > API, combining allocation and startup into a single parallel operation
>  > per queue. This reduces connection and reconnection setup time when
>  > there are delays in establishing connections, which is especially
>  > important for high-core-count hosts.
> [...]
>
> Hi Surabhi,
>
> This patch breaks NVMe/TCP connects with TLS. This is a different bug
> from the pf_cache_lock one that Shin'ichiro reported.
>
> Test: one VM with 4 CPUs, nvmet-tcp on 127.0.0.1 with tsas tls1.3, a
> connect with --tls and 4 I/O queues, and tlshd at upstream commit
> a0bd51d.
>
> - Linus master 6b4b543fa187: 14 of 20 connects fail.
> - Same tree with this patch reverted: 20 of 20 connects pass.
> - Same tree with Daniel's pf_cache_lock fix [1]: 22 of 40 and 17 of 40
>    connects fail.
>
> On each failed connect, one I/O queue logs:
>
>    nvme nvme0: queue 4: TLS handshake complete, error -110
>
> The tlshd that runs for the target logs:
>
>    failed to search 'psk' key 'NVMe0R01 <hostnqn> <subnqn>'
>    gnutls: Error in password/key file. (-31)
>
> and closes the connection. The tlshd that runs for the host then gets
> GNUTLS_E_PREMATURE_TERMINATION, which it reports to the kernel as
> ETIMEDOUT. The other queues use the same PSK, and their handshakes
> succeed. blktests nvme/062 and nvme/063 fail the same way.
>
> I can share the reproducer script.

Hey Martin, can you try the tests once with tlshd using commit 3a6658e
("tlshd: Link the NFS keyrings per handshake instead of at startup")
or ktls-utils 1.5. blktests nvme/062 and nvme/063 passed with this
commit. I believe that change fixed the keyring race in tlshd
independently. If the issue persists, let me know the reproducer
script so I can also take a look. I saw the same errors while running
blktests with an older tlshd version from ktls-utils 1.3.1 and
updating tlshd worked.

Best,
Surabhi

