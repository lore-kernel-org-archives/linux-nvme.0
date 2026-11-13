Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13DB606A898
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kxf/OBWb;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=DY7teW/t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gQ+bi0PEcth1C8j6KYtMHOcnQffx/MZtkZ+1kTRjkfs=; b=kxf/OBWbPxCHQu
	YIzSuTw9GeDYCgDuUMTMApRg/UF1v2N7y0oHg7Yz4HqdP41l0XII5t4eFqxBj/7whTmg+LBcP07nP
	mxvNL7BhkAHWP2TylYt3xeLeXXx/l9XH0vt46d/eq/C8efPRbbrOZC/9Zyf47AOy9ebD3mxd+n+Sq
	PKVo6buGJ1BIwpG3/RSrc6Z/s/FTnbkLYEc+Sg1CfyhvVINPhrgIKLb6o8HoJOeJDzzeJ7a+Sd5rR
	fYCJMRYGFRWuVbP02POTsQ8tsYncIl1KbDVGQmXXUq1If/AAzrM2ouMzPBSD06ZdhX9FD4IwhCKA9
	jik3pMSbA0nRPscxoMiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvc1-0000000Dozb-3jzK;
	Fri, 13 Nov 2026 18:02:57 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvbw-0000000Doyl-0ndP
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 18:02:54 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-91c6ce60697so34817806d6.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 10:02:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592971; cv=none;
        d=google.com; s=arc-20260327;
        b=XKBL4+/BbSRFq+MiNj7YmVTnOFAiUIHWFsCs2BszUUxQ8QjYgULC9/XZfmfyGi2DFL
         Fu8dTfrEsygWXI7MulSwNkkPGGLFifMEHfs4o+zwcdkKNAXsYfDejWDa2XQC+c1EE3HX
         NYrBJvFpqEu+zKvhPu8cL2r2NPYPwdVk8HscKhd1uvfV+BR2K8bgWGKZeGtjEHQFQirT
         3/N6EQmU+kv23LsRBLM7B3r4eb1RZeOkxPzidTO0HulUz2IZR+NG7uUBskFUxaq6TY41
         7o/EzQAgBv1PGYvHgJLd0004F3IEwquQLVCDnojc6OjKi+10fe+j9jbsI/IuXCRa6nQV
         yV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gQ+bi0PEcth1C8j6KYtMHOcnQffx/MZtkZ+1kTRjkfs=;
        fh=XqnVCCD6U8uDkMtMxvYN5LeAOOtX88Zqm8Di49gn7VQ=;
        b=HjYS8qwVLjjD+z1e5DIrnX5E2PzQckodm2ja7OGv9lXbxbynzM5no94lxCOLxmqUPb
         dhSffHh939I80UfhBJ4FmPU8Si0Sr98gYZJOTfaeYpZp3eYI+isauPtof/8mLLDun0Rq
         UoufkcOHRVwcRcHQ9Yuw+WQ2oQLvYTMgmSQ5EyYKGqTtz5sF0S9ykJa55ZrNBt1CULp4
         HYHBK01z/Jbmxnjsa1lRwkiLu/qCKkxRpfA7PI23BD4vLkZHIX8bqLdY85ogWQyWyqZq
         HpqWXvT1JIvhFo3lR8mNuLLOGFaRxQAnAuibo86aszxUvnhETm8tFq/Txvclqq/R/mFr
         E0aQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794592971; x=1795197771; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQ+bi0PEcth1C8j6KYtMHOcnQffx/MZtkZ+1kTRjkfs=;
        b=DY7teW/tMABuBxS65Hd3Gq7RkAkZ7eESowvnyJ53s8KG0WA6BOdIUGQQjenm5/dWoa
         3mmHSqugfDhXgb1M5s8w8Phs92UFZxdEa0cZKQTpYjGrEcLYBOsG91kw9zFfz2OXpoiV
         LVgrJOpqGVuC1pju12nInwz/0XYqMDPdzW1TakLyQHR26E8iGup+o10D2/ahAufumZ3v
         CdUAwhDseh6UkRqxCNWFWYdiAPcE7clfImUr557sxIB++xq4DLajbep65GjizUR1823I
         9GclbpL6BlFLzmPZ8RH5nJ/fzJXXk/OzyqWWKwfKuCS+Q2RDMUo0pq+K89QwpOrxRAAv
         jrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592971; x=1795197771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQ+bi0PEcth1C8j6KYtMHOcnQffx/MZtkZ+1kTRjkfs=;
        b=asXLeArDSpVH3Q8en7P9RnB2qrvofj1ON2C074fxtUez3dKEJ7Kr4Yg5oLYjpwYNFM
         hwPrK4yhZjnEvdqWfSEqA1oYKgFR7iTxEUzx9tcVyCbvGkYD5iF11ehr8EVN9EmPET4s
         3U+5zj//2rnxeFIO491nCfarDxAZpmUsVRAeqb1t6YKHvbir9KNaUdlF4RaiRoTolnqt
         wSkbTN1VjjghYsMs3fVHNROkieIx+wZVCEcjysq1fbUHMC91T/aPaSMCuCA3j4T3iuwT
         xTw5oXHO7dMTP3VFIGWzle1iCqasZzZBIJAvReUjJifIXEMLQKIwq+4HCP8xb31ZWvIC
         b55w==
X-Forwarded-Encrypted: i=1; AL+hErF29MlDRShaQCXgvjbVWOZ6uItpp3u840zncGfV43q2VV89cRL1GaCpbGYnYd3BbIGL72lj/BHyoxfZ@lists.infradead.org
X-Gm-Message-State: APuU4Z/087q+2IZU7xJZf8AG99iwn97B+zoFaUEb9K7K/ie0Q8F6mYOR
	Zp8a7p8qIq0XGweiDQpvviy/x0Vv24vClcGOLvK0so2xRO5/iGkXYC4NL/EE60cvdiEDXDMmUtv
	y34fM9KbP3L95sZZIHPhPcqNsfSDCIzjTCnKK7yoGsQ==
X-Gm-Gg: AYBFou0Vf7zxp7pf9lPbJPjqVPXHvmAkHZknlhvDc+uhLgfhysYS0GN08sytg44iq39
	PgLgA2IhiHIFh7DTISM0IpylqP2fYqwygPnDK1eSuh5D26MNvcjjniAQxaVK8afg2jMZ7hXpogu
	QZ8uS6r1FbjzAGZKlzqEoxE1Y7mx5+TmXGxySA0qeZMtzclCBz0ct7N36LSb1167greRm2oDY36
	zcOOCBqeWeq85pgR2J1L9TRsrkgEQ3GfzaWCM3FHNaNRoBUNZhRlWsCe86CqxCLZpE5ZXnYfN0t
	CfR8E/eVG6mCQQ6MnBoWNAU2CrBeUFSXxHnMxjX/ttn30Ps8Mhx3+ZUHbn90klvyF7/fxis6tiQ
	rzyXRwB3+V4qknbFvsIMateiq/TiYWwx+Bq5rag==
X-Received: by 2002:a05:622a:a883:b0:536:6c4e:13ff with SMTP id
 d75a77b69052e-55aca35e080mr51491481cf.56.1794592970332; Fri, 13 Nov 2026
 10:02:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com> <705f4452-3d07-4d91-9dcd-ea53b2cd75a5@gmail.com>
 <CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2BmN20Bh3btpLum7THg@mail.gmail.com> <20efc96b-c57d-4bbf-8d3d-602b8c9e5828@suse.de>
In-Reply-To: <20efc96b-c57d-4bbf-8d3d-602b8c9e5828@suse.de>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Fri, 13 Nov 2026 10:02:14 -0800
X-Gm-Features: AclHuK-jixVC_zcNYsWh2RHUZVwc70pygNrgi5VX-_W7wvY40TMb8OgTwKzr8N4
Message-ID: <CAMof9cUGg437j6qZ_T+AQYxYRSvh9WBtx6582sMPjk2p-e68ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and startup
To: Hannes Reinecke <hare@suse.de>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com, 
	Hannes Reinecke <hare@kernel.org>, wagi@kernel.org, shinichiro.kawasaki@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_100252_431402_926DFCE7 
X-CRM114-Status: GOOD (  35.46  )
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

On Sun, Nov 1, 2026 at 11:15=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/30/26 10:25 PM, Surabhi Gogte (she/her) wrote:
> > On Mon, Oct 26, 2026 at 3:57=E2=80=AFAM Martin Belanger
> > <martin.nvme.dev@gmail.com> wrote:
> >>
> >> On 9/22/26 16:07, Surabhi Gogte wrote:
> >>   > Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
> >>   > allocation and startup"), refactor nvme tcp I/O queue setup to use=
 async
> >>   > API, combining allocation and startup into a single parallel opera=
tion
> >>   > per queue. This reduces connection and reconnection setup time whe=
n
> >>   > there are delays in establishing connections, which is especially
> >>   > important for high-core-count hosts.
> >> [...]
> >>
> >> Hi Surabhi,
> >>
> >> This patch breaks NVMe/TCP connects with TLS. This is a different bug
> >> from the pf_cache_lock one that Shin'ichiro reported.
> >>
> >> Test: one VM with 4 CPUs, nvmet-tcp on 127.0.0.1 with tsas tls1.3, a
> >> connect with --tls and 4 I/O queues, and tlshd at upstream commit
> >> a0bd51d.
> >>
> >> - Linus master 6b4b543fa187: 14 of 20 connects fail.
> >> - Same tree with this patch reverted: 20 of 20 connects pass.
> >> - Same tree with Daniel's pf_cache_lock fix [1]: 22 of 40 and 17 of 40
> >>     connects fail.
> >>
> >> On each failed connect, one I/O queue logs:
> >>
> >>     nvme nvme0: queue 4: TLS handshake complete, error -110
> >>
> >> The tlshd that runs for the target logs:
> >>
> >>     failed to search 'psk' key 'NVMe0R01 <hostnqn> <subnqn>'
> >>     gnutls: Error in password/key file. (-31)
> >>
> >> and closes the connection. The tlshd that runs for the host then gets
> >> GNUTLS_E_PREMATURE_TERMINATION, which it reports to the kernel as
> >> ETIMEDOUT. The other queues use the same PSK, and their handshakes
> >> succeed. blktests nvme/062 and nvme/063 fail the same way.
> >>
> >> I can share the reproducer script.
> >
> > Hey Martin, can you try the tests once with tlshd using commit 3a6658e
> > ("tlshd: Link the NFS keyrings per handshake instead of at startup")
> > or ktls-utils 1.5. blktests nvme/062 and nvme/063 passed with this
> > commit. I believe that change fixed the keyring race in tlshd
> > independently. If the issue persists, let me know the reproducer
> > script so I can also take a look. I saw the same errors while running
> > blktests with an older tlshd version from ktls-utils 1.3.1 and
> > updating tlshd worked.
> >
> Ouch. That will be tricky for distros. If there is a specific commit
> which requires an update to ktlshd we need to have a way to identify
> that; otherwise we'll see lots of regressions where customers have
> updated only one side.
> Please modify the patch to work with older versions of ktlshd.
>

I'm not sure how to do this well and would like your advice.

The race is in the target's tlshd (keyring link/unlink per handshake,
fixed by ktls-utils commit 3a6658e in 1.5.0), not in the kernel.

Two things that I faced, getthing in the way on trying make the host
backwards compatible:
1. Nothing tells the host which tlshd the target runs.
2. Serializing only the handshake doesn't work: nvmet-tcp blocks in
   its accept work peeking the first bytes of each connection, so a
   socket that waits for a lock before its ClientHello stalls the
   accepts behind it. Serializing the whole queue setup works but
   gives up the parallelism for TLS entirely.

Can you suggest how to structure this to avoid the race while keeping the
parallel setup? Should we fallback to serial io queue setup in case of tls
timeout errors?

Thanks,
Surabhi

