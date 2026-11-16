Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98A606A329
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FPbaP+Jb;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=AuEiQMJ0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LyUzJZvYwUSiIXUd0aX2M/LtsBwgiCS4YLA14UCXzmU=; b=FPbaP+Jbm2TnJ7
	SKj1uS2H3qCMjAxsH1DBkKvCQPswwgSL9lRdOnTIDDmN8lF8SWbL1mmFPrQzfPuU4JXVkyw1XmBRU
	YAiKldfPw8949yfwstoSQepkciQ4u5UoCxIWQbyxSZe31FbNrzv5N/V4IH03n95/LVF3Jdg4pxLEG
	mFIdBXMI8+6CKACTk6ln000YBn3zHpsc8aYX3XIYHg4xcpvRnO0dDzTwFtvR2Mf23vjLM3A5/h0qS
	0C3brcxSeD/M4AvM40g5SVi+AcFgvgBzdXvL2P/y4+rhRHiYJyJH+tykkBj1p3spL1mJC9AM4PQj1
	hZbB1R5NtXaRGT9veTKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT03l-00000003Li7-2S25;
	Mon, 16 Nov 2026 17:00:01 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT03f-00000003Lg2-1cpv
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:59:59 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-55d360ca878so12334231cf.2
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794848393; cv=none;
        d=google.com; s=arc-20260327;
        b=rpmnJEKfnRwwZKbWq2J+8oXEnmnWnzB1BoRCBsk6Uqlz11nUhdCKIcsQU5fgxiEdEt
         6oTA3LlLlYVRXyZ+wKb7Xh6lq7sbEvCh6oZ/eQjJSypVYW75kxR7Gorjw8VNhLdw7VyQ
         STzaX3B9bTdiml6wPuqJn1nFR68HX2GKYQP0+W8XTySLyhUVEwGVMskrLVFOUz5gs1s3
         cBEmkEBpZZ/pqcxyFIciHmvV/e6MWiB99RJP7qncfTYRRaALQSraLcG/tsr7PLqGe79K
         /3yZTc8Nsx6S+yiEcSKSii/F2SFOYPRw8EFLQbgqir1iWCTIYPRezLnGbRWhvBwS4FW2
         9rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LyUzJZvYwUSiIXUd0aX2M/LtsBwgiCS4YLA14UCXzmU=;
        fh=mFh8qc2HlqkTtAOKS/rpuwiogeoePfY+bRcKEvZsgH8=;
        b=XcsWxTbbhsefMeB2/+XD0MOnlVr5+cY41MwEpGJksfH46/s51qBvyG1TrRCwO/rHe9
         jbG4wmKdNUZofzy/8LDpzWKHTkrWvGvp30Hffnm2g2WDiRMB9jze0zdK1o5X+tvF0rrT
         c0nPtsanIrL3J9UbqUdNjw2d2MSdvTkaF3rE5NuB2Ja6ghk6wtjRC3Kz+bRiWjD92es1
         2AHNSSZjF69EDuKUfMqrqPAVQqc6C/I9CnGWM59TSBF9zpIq6e7IUdR+rMulyOMGajRk
         cmaoeJRS+/Qv/V/6VBkxbwrK+cSLbec4JiYPyTCZe/4sLpQe7xd1S489FsukoC20hyyJ
         SSlQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794848393; x=1795453193; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LyUzJZvYwUSiIXUd0aX2M/LtsBwgiCS4YLA14UCXzmU=;
        b=AuEiQMJ08s3JtqKGjArG9mzJwo9/2A3KBGuLVn7t1snHItODDzPK6jLXmZO9EYxm3m
         KJxHgoTJ4dmxIDFXl6F6jKPj3Z+WAT9lvIFf7kSrY/1t+y6piFxUUtbIMKtpP5GcQpUW
         tPE8ma5EXFa1a+Qr0mLD93AyXqI1pA09fvMC6v3nkGVyrQgz4yLpkDYgu3bIT3HJGFAm
         QITSQtpMbigKi4eysGzrMmH96au1J3dmnmY+rDKc4MqKHiqKGrRZblGxLvP92nfQlaMM
         pJJX6C6C0HRclYqMk4JoOuT8FeqIAUEV7BQl/XAOfVtIPqu9XI0F9tlIWknRIN1pmKUC
         TrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794848393; x=1795453193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LyUzJZvYwUSiIXUd0aX2M/LtsBwgiCS4YLA14UCXzmU=;
        b=JLxsqz02yxLbXchuqXdGI7p2m6Oh+0n25uvp4rrlQAks3+NJl0EaQld6vt3ccmsPVX
         TIhsHLHfkysN0VGDW+4uuZyktfCkJBXChcQyqvF4y3BLL+61Z4/z1DynuM69v5PGnx+M
         WwZAJwNuKZvYBbkMKi0Rg9ASNchnsXRU6WqOsvzZ769DSizgMtPY04NamlhWkCQZrMaD
         yi0Z076hiWloq+JIB/SSpq2w1p+rfKsg4sEyi+JkU74mfLpqGYByGRhVsoO6trBQQZVX
         sK/NjbreVQVApRlxRa2XhF1wdtuealuQDw3YaMipJSI+x2d9J/STPdVgeEL7wuObDrbD
         y9Xg==
X-Forwarded-Encrypted: i=1; AL+hErGMZuxT2qTWD2PXT45TmOCDrt0/aMdOjS+NVD4rT63qDDj3n4wx0MMvWlQJunFcsOGcIdM2FpgRg8kp@lists.infradead.org
X-Gm-Message-State: APuU4Z8FZbMdmO+XiOQEvsmOxf0VW3W7W55rSyk0YyvJuYM5Og3P2taa
	nWB7oX/hI5s2QGwH+spbut3oOJ78fwuVwN3BQp03R1MTPuoO0oRH4C03yhN4XuAcDewQ0zCOukE
	S9+1+fJ/4DXiB24MRgr8m0EvwFoln4fxQ7UahwCHYgw==
X-Gm-Gg: AYBFou3vLcV76WPVzq9spnH726heNLtSS8d2uGuDaqYoZIlOUa13N7Yg19XBSCQ5n65
	Of2O8Q8KaJ90Au3V/xcviK3eT8rk4Ou05lBwv2+37urydXo1vYdt7ZPiGXMa0uXqj1F5ezgqHIS
	xJs5dmlS4qFIGO7uMUdPTyRx6fR5P+cg7kKvCSNRqjcxkRIueZ4WrOGIujzE25TJmds2QBJ28Qx
	pDjn4EkCGzkBjUZ0H34652sKOk+1siL/kczIHIVmTANK2/CaExul5W/oROLq5VakxQx3Rg8U3ye
	v/a688qYfk4mNrPjAD/53IGuwnMyu7wN/HtKse0aeFri1NwtVkJ8SDyVylzJiDjZexQmgF4hqZ9
	Q3B2MYw+TpslJy+sHTtVWbYz/aYqEEp3xUrAA
X-Received: by 2002:a05:622a:2b43:b0:535:a20:8277 with SMTP id
 d75a77b69052e-55ac428750bmr192288761cf.10.1794848393240; Mon, 16 Nov 2026
 08:59:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com> <atSzF3URmcpP2_i2@shinmob>
 <CAMof9cVxoNxM70uJa=N+a88YBMmh+EKfXrrckXz=N45U0EKQcg@mail.gmail.com> <avmUgnb87CHqIDOL@shinmob>
In-Reply-To: <avmUgnb87CHqIDOL@shinmob>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Mon, 16 Nov 2026 08:59:17 -0800
X-Gm-Features: AclHuK8RTshQ1zzlMGqiOg2bjry7pMYM23qf5thgpZg6U8-MQSo8hd-mAE0evc4
Message-ID: <CAMof9cX9TNaXdL1ugdnCwxVG1Us8V-=c=Uk+YVKsMwFEYR7Vvg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and startup
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com, 
	randyj@purestorage.com, adailey@purestorage.com, 
	Hannes Reinecke <hare@kernel.org>, dwagner@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_085955_640035_778B882B 
X-CRM114-Status: GOOD (  41.63  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 3:36=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Oct 20, 2026 / 13:48, Surabhi Gogte (she/her) wrote:
> > On Sun, Oct 18, 2026 at 5:26=E2=80=AFAM Shin'ichiro Kawasaki
> > <shinichiro.kawasaki@wdc.com> wrote:
> > >
> > > On Sep 22, 2026 / 14:07, Surabhi Gogte wrote:
> > >
> > > Recently, blktests-CI runs for the kernel at block/for-next branch st=
arted
> > > reporting failures of the test case nvme/004 (with tcp transport) and=
 md/001.
> > > The kernel reported a WARN related to lock->magic, and it caused the =
failures.
> > > FYI, here I share the failure run log at md/001 [1] and dmesg at the =
failure.
> > >
> > >   The md/001 confirms a bug fix in md driver. The bug was triggered w=
hen a
> > >   nvme device with tcp transport is used as its backend. Then the tes=
t case
> > >   exercises the nvme-tcp driver, which this patch touches.
> > >
> > > I bisected and found that this commit is the trigger of the failures.=
 When I
> > > revert this commit from the block/for-next branch tip with git hash
> > > 34fbfb9d8d1f, the failure goes away.
> > >
> > > Surabhi, could you take a look in the failure?
> > >
> >
> > Yes, there is a bug in commit 61b0ed3be81b ("nvme-tcp: parallelize I/O
> > queue allocation and startup").  To know the queue range before the
> > queues are set up, it moved the I/O tag set allocation ahead of I/O
> > queue allocation.  blk_mq_alloc_tag_set() calls
> > nvme_tcp_init_request() for every request, which takes pf_cache_lock
> > of the request's queue, but nvme_tcp_alloc_queue() only initializes
> > that mutex later:
> >   nvme_tcp_configure_io_queues()
> >     nvme_alloc_io_tag_set()
> >       blk_mq_alloc_tag_set()
> >         blk_mq_alloc_rqs()
> >           nvme_tcp_init_request()  mutex_lock(pf_cache_lock) <- WARN
> >     nvme_tcp_setup_io_queues()
> >       nvme_tcp_alloc_queue()   mutex_init(pf_cache_lock)
> >
> > So with CONFIG_DEBUG_MUTEXES the first connect trips
> > DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock) in __mutex_lock().
> > That matches the call trace in your dmesg.
> >
> > Daniel Wagner posted a fix for this as patch 1 of [PATCH 0/5]
> > nvme-fabrics: fix connects with isolated CPUs and queue mapping bugs:
> > lore : https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-0-3=
55156be27b2@kernel.org
> >
> > It initializes pf_cache_lock for all queues in nvme_tcp_alloc_ctrl(),
> > right after the queues array is allocated, and drops the
> > mutex_destroy() calls so the lock stays valid for the lifetime of the
> > controller.
> >
> > I ran blktests with his fix on top of block/for-next (34fbfb9d8d1f, the
> > same tip you bisected on) and md/001 passes with no WARN related to
> > lock->magic.  Without the fix, the same tree and config fails md/001
> > with the WARN at kernel/locking/mutex.c:625.
> >
> > With the fix : nvme-tcp: initialize pf_cache_lock when allocating the c=
ontroller
> > lore : https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-1-3=
55156be27b2@kernel.org/
> >
> > ~/blktests$ sudo ./check md/001
> > md/001 (Raid with bitmap on tcp nvmet with opt-io-size over bitmap
> > size) [passed]
> >     runtime  1.779s  ...  1.814s
>
> Surabhi, thanks for the confirmation. It's great taht The md/001 failure =
is
> gone. Said that, now I face failrues of other test cases: nvme/062 and 06=
3.
>
> While I was running blktests on v7.4-rc1 and v7.4-rc2 kernel, I observed =
the two
> test cases nvme/062 and 063 fail for tcp transport [*]. I bisected and fo=
und
> that this patch as the commit 61b0ed3be81b is the trigger. I observed the
> failure with nvme-cli versions 3.0, 3.1 and 3.2. ktls-utils version is 1.=
4.0.
>
>   When I reported blktests failures for v7.4-rc1 kernel [#], the failure =
was
>   not observed by some reason. But now the failure is observed in stable =
manner.
>
>   [#] https://lore.kernel.org/linux-block/avBz7uOGYo2y426_@shinmob/
>
> It looks like nvme connect can fail for tls connection with multiple I/O
> queues. I created a blktests patch to limit number of I/O quees to 1 [**]=
,
> and observed the failure goes away. But I'm not sure if this is just hidi=
ng
> the failure.
>
> Are the failures observed in your environment?
>

Hi Shin'ichiro, I ran bltkests with ktls 1.5.0. It contains the tlshd
commit 3a6658e
("tlshd: Link the NFS keyrings per handshake instead of at startup")
which fixes the keyring race during the handshake. Both tests 62 and
63 pass with it.
Can you retest with that version to see if the issue persists? Can you
also share the kernel logs of the failure.

Ref: https://lore.kernel.org/linux-nvme/CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2Bm=
N20Bh3btpLum7THg@mail.gmail.com/

Regards,
Surabhi.

>
> [*] nvme/062 and nvme/063 failure
>
> nvme/062 (tr=3Dtcp) (Create TLS-encrypted connections)         [failed]
>     runtime  4.678s  ...  13.619s
>     --- tests/nvme/062.out      2026-11-09 20:12:01.056000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/062.out.ba=
d      2026-11-15 20:21:09.213000000 +0900
>     @@ -1,6 +1,10 @@
>      Running nvme/062
>      Test unencrypted connection w/ tls not required
>      Test encrypted connection w/ tls not required
>     +FAIL: nvme connect return error code
>     +WARNING: connection is not encrypted
>      Test unencrypted connection w/ tls required (should fail)
>      Test encrypted connection w/ tls required
>     ...
>     (Run 'diff -u tests/nvme/062.out /home/shin/Blktests/blktests/results=
/nodev_tr_tcp/nvme/062.out.bad' to see the entire diff)
> nvme/063 (tr=3Dtcp) (Create authenticated TCP connections with secure con=
catenation)
>     runtime  3.123s  ...
> WARNING: Test did not clean up port: 0
> nvme/063 (tr=3Dtcp) (Create authenticated TCP connections with secure con=
catenation) [failed]
>     runtime  3.123s  ...  7.313sost: nqn.2014-08.org.nvmexpress:uuid:0f01=
fb42-9f7f-4856-b0b3-51e60b8de349
>     --- tests/nvme/063.out      2026-11-09 20:12:01.060000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/063.out.ba=
d      2026-11-15 20:21:30.207000000 +0900
>     @@ -1,5 +1,4 @@
>      Running nvme/063
>      Test secure concatenation with SHA256
>     -Reset controller
>     -Test secure concatenation with SHA384
>     -Test complete
>     +FAIL: nvme connect return error code
>     +WARNING: connection failed
>
>
> [**] trial blktests patch
>
> diff --git a/tests/nvme/062 b/tests/nvme/062
> index eabe2d9..69a05b6 100755
> --- a/tests/nvme/062
> +++ b/tests/nvme/062
> @@ -55,7 +55,7 @@ test() {
>
>         # Test encrypted connection
>         echo "Test encrypted connection w/ tls not required"
> -       _nvme_connect_subsys --tls
> +       _nvme_connect_subsys --tls --nr-io-queues 1
>
>         ctrl=3D$(_find_nvme_dev "${def_subsysnqn}")
>         if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then
> @@ -77,7 +77,7 @@ test() {
>
>         # Test encrypted connection
>         echo "Test encrypted connection w/ tls required"
> -       _nvme_connect_subsys --tls
> +       _nvme_connect_subsys --tls --nr-io-queues 1
>
>         ctrl=3D$(_find_nvme_dev "${def_subsysnqn}")
>         if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null; then
> diff --git a/tests/nvme/063 b/tests/nvme/063
> index feb07bf..900bb9f 100755
> --- a/tests/nvme/063
> +++ b/tests/nvme/063
> @@ -46,7 +46,7 @@ test() {
>         _set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
>
>         echo "Test secure concatenation with SHA256"
> -       _nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
> +       _nvme_connect_subsys --dhchap-secret "${hostkey}" --concat --nr-i=
o-queues 1
>
>         ctrl=3D$(_find_nvme_dev "${def_subsysnqn}")
>         if [[ -z "$ctrl" ]]; then
> @@ -88,7 +88,7 @@ test() {
>         _set_nvmet_dhgroup "${def_hostnqn}" "ffdhe3072"
>
>         echo "Test secure concatenation with SHA384"
> -       _nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
> +       _nvme_connect_subsys --dhchap-secret "${hostkey}" --concat --nr-i=
o-queues 1
>
>         ctrl=3D$(_find_nvme_dev "${def_subsysnqn}")
>         if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then

