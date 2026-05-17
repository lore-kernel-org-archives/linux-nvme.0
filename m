Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416E1CD4F3C
	for <linux-nvme@archiver.kernel.org>; Sun, 17 May 2026 03:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xbrf0vLOxShJff8wjdlTZGIuqanEforPTuzsfc2p+uU=; b=hukSmS3WtM4Yo5Udl1PqddW+S1
	g0TL7Vxy7qW76actzoDGw0GLhB064Pq9QgmsdTJLVs7Z9UVAGAJs8795F3ZoQ1V2OppYFncAwfl34
	N7unMX1/DkQQ98B6FTmkK2HX3O1VrnaaMEUD9hMeKRiRmjGNQGlSKtQ5PUaz4owuDWGDqdPkL7obq
	0l442ktzzuGxuNfWtaDjoJU7aJn56YyhWAp5fDLTlzoeTXHYBK+EKDzR0andev/DlrFzw//XEHvoF
	OxsBKa2PkYCDLcTnHahS/DYxFFIcgxg/Is0/rYoZtXskwqaQV+lR3BPDi4q5IbRBUns9bsSKvLiFd
	jdkQClXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOSam-0000000C22b-2sEa;
	Sun, 17 May 2026 03:55:04 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOSak-0000000C21p-45WU
	for linux-nvme@lists.infradead.org;
	Sun, 17 May 2026 03:55:04 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso3217978a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 16 May 2026 20:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778990101; cv=none;
        d=google.com; s=arc-20240605;
        b=VGq2yAatorfncDpAt5O5hkh2VaXlXrSb3JQ8aOaiRlRfzkv9sVYGxNi7X0kq5yvt1H
         0OaXthv6zkaln0lNuPBNmTtIZBY4kFtkYBwDicGqOZApd2FmX4RYSc5k9iNjhVe/zkut
         wM/ws6kYFKg7Jqh22cX/6rfkKfa/3yEJCHrSatgdLU343jDfWrt4n546U/5/ZSoCEjfn
         Z/q5zLtYtV5P9DvGcZ3/pazVgAnSWY6K04eVIkcoMRJ1JuSyQObyzH3Ymb1lmgc4cuIH
         /M3YzKp1qhUhbEPAokUNIJ8cHOqd4F81tDBvN1FBg6AtfswlV4QEcE/b5QXVFeksR+fs
         ZU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xbrf0vLOxShJff8wjdlTZGIuqanEforPTuzsfc2p+uU=;
        fh=KrubpOBPi4dy8FoD2xv8Mwievlx4qkKCq9FWLCBMXoQ=;
        b=APGR/c4UmmQzGA62ndRJVxFIf0K5A8Z5KoQ+AD3jPT1YUGarLRJJx5cSLeeuLTDSbc
         L0dNS6cQWTx0Lkii3O0slr+D3MM0ZZ08rUQ1E+03szKCERSNV9TxGjwFaOnxOsvdSpUB
         qD3kNCzCjMJoravaXBGx5wAJH9YXY3O3ahUMqkePA4htziWDLSq+HeSz8t9MDly3b+qw
         bWVPYDSbbbfhZM2EwyAUs4iOtldOmtlGS8SUdlzqp7VcF+geZbvdDTDrUYeRWp4KnQ43
         1ndMYELkXdbO/B9asSDGhIl6+0Nb3myJ8ujpuRMprjs/H8q/dRgpEPD3ZcukN4rq7+ye
         HB0g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778990101; x=1779594901; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbrf0vLOxShJff8wjdlTZGIuqanEforPTuzsfc2p+uU=;
        b=CcaAx3znEIzP5hxYdMD4JV0QSQZDLCeVFCin4chEww3S95kXcxh1y90xB444t/WxFm
         kDg9Mb398y5WjTEHNaL5IaLyzJ9aJUraXe0ZUiBOEnEftgeTS6WsUiVTvzV7AwVDQnIU
         6NQ4TkJ8TU1bOM1ypstWPg+yCIwPB5EpB2sfP/+OWcYyfIUC0ZPPKhMV9gx2ozt5NobR
         siwggfEY1qtwCU9zjJqDUmg7En4wstV5l5JWzkYsWaYWeCs5DkcNhMgxYCpDB13atHl5
         pM+KmUbezvOtxvGLVEAW1Ju6hZtwXsPnvmf2hUfGurMCpO8ikfvKB/xN7qe8Bv0qwPDg
         LWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778990101; x=1779594901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbrf0vLOxShJff8wjdlTZGIuqanEforPTuzsfc2p+uU=;
        b=RCNI1UuCvFr2zwVrtrKkYfpNNUXAcdRLgiKfPZ62uS1/CrGov6D/InXCWk80NnlmzL
         OTE/WtKXAUzctcZzmeDBakq7TBEU42UJHEROX4UmHmtd7wJX1Wq2f7Dnp7MraqLO05Tz
         AbMaY6mJYaOsVVBC2Q1IPCPkF8kEtS/Mcba7qK6hCCr60GOnImGk6T3B9jelYiWqN43n
         Z2s22CMapQCtIKRxlWYWaIOQQNdC/dQTU6sXhxMse0YfOcgD6sZ12gYi5NhXCQoRV8Im
         4vvFueerKyAKMY+oVd0Ar719FVh5Aok/1AhlsLiFyyfGvN2re4cN58znsPaAZKNfXd3I
         fNsQ==
X-Gm-Message-State: AOJu0YwuLQg/Gr/ruksqtmqA5LdHHy/y8dNodwllCeaH56me95bH5YYZ
	Ck41yzbEROctjv4xcfgoRM4GoLQEuCWSWmoask9cZFk8U8ERYO63/LDZphzeBJbTjnXlv16bR2Q
	3fQqFtb7hAJ+h4gNdH+kjYGabceGC2og=
X-Gm-Gg: Acq92OGtL/LRzaX01EmtG/WXlkdboNLnkxRcD2m2c/KLkMCCBpuo5RKY8UHUMEKJrGQ
	D0JKom2pZsbazHVReGNHbtUn19CZpqeOK8RYwcczG4Jol/fKmkZ7yQQtLHRQKH8OYgkHjEC2JU+
	TaHLk59wnNIny4cMf2gorbnZgimI6x/YfxJmeVD3aXgIc7ChDJWZqB+GF90WvG8WvT0AvhH5Szr
	vdSQLH2xfZuvxu5GxriAMInm4DDmRyzSnk7ibLP52a+jncNIU9OEyKhhwarP+4zvOK2ThqIF+vi
	nKNriFb7
X-Received: by 2002:a17:907:c291:b0:bd3:7b11:7870 with SMTP id
 a640c23a62f3a-bd51777ca61mr544791966b.5.1778990100962; Sat, 16 May 2026
 20:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260427003457.1264511-1-coshi036@gmail.com> <20260507054809.GA19796@lst.de>
In-Reply-To: <20260507054809.GA19796@lst.de>
From: Chao S <coshi036@gmail.com>
Date: Sat, 16 May 2026 23:54:49 -0400
X-Gm-Features: AVHnY4KNTLVuSXINN0lA9vSO1jrGqK4vd0JcUP-N_FlwT8kc6OamExo64gDnw3s
Message-ID: <CACd_6n3s+Y+xdsuQVja=t1RUEdro2yQRyJyjpqFcd9_pF98OzA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_205503_028227_CC730C90 
X-CRM114-Status: GOOD (  19.54  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 07, 2026 at 07:48:09AM +0200, Christoph Hellwig wrote:
> What is "semantic mutation of Identify Namespace responses" [...]

The emulated controller returns a mutated Identify Namespace on
rescan (flbas META_EXT, lbaf.ms !=3D 0, dps =3D=3D 0) -- the host-unaware
geometry change Keith described (out-of-band format on a shared
namespace, or a non-compliant device), learned via rescan/AEN, not
the host's own Format NVM.

> [...] rather theoretical case [...]

Agreed v1 was wrong (1/2 hid the signal, 2/2 unrelated; 2/2 dropped).
Not fuzzer-only though: the out-of-band-format path Keith acknowledged
is real, and the branch is reachable from device data, so under
panic_on_warn this is a device-triggerable panic.  The deeper fencing
fix is the bigger TP-level work; v2 does not attempt it -- it only
adds the missing nvme_setup_rw() case for an unusable (metadata, no
PI, no profile) namespace whose I/O is already rejected, replacing the
assertion with one dev_warn_once().  Worth the bigger fix, or leave it
documented?

Thanks,
Chao

On Thu, May 7, 2026 at 1:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Sun, Apr 26, 2026 at 08:34:56PM -0400, Chao Shi wrote:
> > When an NVMe namespace is configured with embedded metadata (flbas bit =
4
> > set, NVME_NS_FLBAS_META_EXT) but no Protection Information (dps=3D0) an=
d
> > no NVME_NS_METADATA_SUPPORTED, nvme_setup_rw() fires WARN_ON_ONCE on
> > any request that reaches it with REQ_INTEGRITY unset.  The WARN was
> > observed repeatedly during NVMe fuzz testing with a FEMU-based fuzzer
> > that performs semantic mutation of Identify Namespace responses.
>
> What is "semantic mutation of Identify Namespace responses" supposed to
> mean?
>
> > In both cases the bio was submitted without REQ_INTEGRITY (because
> > blk_get_integrity() returned NULL at dispatch time, so
> > bio_integrity_action() returned 0 and bio_integrity_prep() was not
> > called), and it reaches nvme_setup_rw() for a namespace where
> > head->ms !=3D 0.  The existing BLK_STS_NOTSUPP return correctly handles
> > this dispatch; the WARN_ON_ONCE is a false positive.
>
> That means we fail to properaly freeze and quiesce the queue over
> update=D1=95m which has much worse results than just a WARN_ON.  So if we
> care about this rather theoretical case we'll need to fix that.
>

