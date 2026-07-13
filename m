Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3251C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e/4L/szZu38b4G+YBCDLvQaRnOkQwRq1nKzcGbKzOls=; b=RkH0IcFby4YOXBwef8uXeENCs3
	ROpZyC5CIciokxdi1CHyKEP5vgYAZGKN8lknkXrbvQVHBItSrNMpkHDQI21NCVkXRC4b+EyuTHMKS
	L8yorr/6AMSR9JUGTYhO26CCJ9ip1M0wGS4X62QuPftkYVuTh8Gdgc8Fg/nsR9Ie0kTTFzVaFWfSW
	jb/Ia3rdm1znTEQyxbPfLrfhoc2tc87KvqawSQf/aOERlnCsxDB7qkOyI6SivMeqhKRH1mqKkkVx9
	qfkYKSQpxnG+l9dQf+aDmqeL8bazNb5iPuy0b0u78ApmkzYgxmJNIB4+Iucav6ArPZOxE6lS2lAt/
	dwlXVU7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjJzE-0000000A2EG-14xr;
	Mon, 13 Jul 2026 16:58:32 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjJzB-0000000A2Dp-3P1F
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 16:58:31 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-698562f10e7so4745067a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jul 2026 09:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783961907; cv=none;
        d=google.com; s=arc-20260327;
        b=Xsf3YLustYOtDvesXOgDa/qw6qrI1E1RLH3F0QOrDo0umokbuHS5fHIBvcLUbMhhqK
         mGVLGB+YddtKFRYWBHNHCMINLCxB6LkjPFuCfqHQWMMc73CuJbORlZ34CGgXxb2iKCjg
         Q87DSU2ATpqCD4urYHpI2LelmZq7b+5f+wNP55dLexribH/1zwwpj/wCF1nQFD2qoF2i
         ZpqmM7ooUk13uEw3iOhjwU07NzyzBYqaDvuss4LP5Ycq/xieP1p4SQOlcH8PvZah8UY0
         /qCTW+KMgsg06ihG6D4F6WgIiIcVxs1eYRilipLrlmJyhBwicmIALxARja7Jgb9zBddO
         u5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e/4L/szZu38b4G+YBCDLvQaRnOkQwRq1nKzcGbKzOls=;
        fh=6QAmwhPHu8CEpBfKgnfk87FjchphfLH/wW0wuwQic9A=;
        b=PzYPhG21kqy7W1Xn3VrNUYiYE91zYirOFO4uRLzB3hnh2+amOEt/mXHdO9lQnefR3A
         NKp2dZ+uPil5XghPtCNP4re3hJnlLJ0pATsKNj/81TtDWkoqc4ppXa1O5MLr6/7wGQ/u
         QbSH8W/u8MjVGx05WJG90uhfdyFgY2fI56CXCr78jtwRaLVMf/ZJOnmytfM+u+nEPuMG
         eBq5nuFCPpy1YQ10S7cyedB/X/aH90sh32TrqO2uqZEjCJC4pyOs7hGRTrkzCvQQLIbI
         ahq+DeknFJlhk7CWg4yeKBI9BrZc4rlIM07lG+g65LPyOmoloEatgoyUUcwObte3PLQD
         Zlog==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961907; x=1784566707; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e/4L/szZu38b4G+YBCDLvQaRnOkQwRq1nKzcGbKzOls=;
        b=T5IPyCIonQU3qIaolFmxEePmrlGFOD0xuiJNmr54htXH76lsHEL26u/2fplJgJoLYo
         gMav43ySN2r3WXp/C6BKzBGEJaB1GH1+V9nCGcmR5KWc0xkXj316w7ZTgda758+NP1+n
         eF3U6AzW+mVPMJ+6H6iclEJZmna9VS7XG4eRJgiSrECmnQCmizpowlbEm64JCTULQbkp
         jRzmjWmNB5eGgUpbPLdtb4C1C2B/idiPw52DnsXnnfhhBStc8YprwT5Hdt4o/eFqGxb9
         ODhS6td9r3pFkiDtvk54O0n19vEerRN0w99OGemXlCS/sRBJW66O6urHBp2hR67Pvfr8
         q67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961907; x=1784566707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/4L/szZu38b4G+YBCDLvQaRnOkQwRq1nKzcGbKzOls=;
        b=EE60WfW97gdnLuJ0CiBtwZtMdtOXWpFcbpmqB1TLoSeBqilyeEDqnpEbfT1rGJhj0h
         Am3Dggc9YsJqadUvaMAd3m6w0pgRkcaGr1S8hwcHSx8FowyyWU1+QL6a3GnA2rpzIyfX
         MO/a05sazcb2nnvdc7c+HkUIEpZfeS3CpDo7qDF4OZOy8SqlXX1eqQrGFrCNcgBY4P6A
         ACBZCvBdWhHkq9/HBgftxJQU50potLg7cLPhiZaqooM8sx4cUP5LOZ56nerd+8ysSghj
         ObWomX+IWP4ExV8Ja/oGnrVC5tAENISWUkI00HSBJN3CkCUAlV1qFNCVG0dGUfvseDeV
         GoZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpEpiGFV1CH3KpftEs7YPL5gm8BiXV1VN/Tddjnq4nH/l6bQEkl0xpRdKVZrZbotizQ79SNh21KpVxQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2VRQp7MD/QoEEK5+eMBPGFcJJ9VaYZ46qNxdW1IMc1SMX1lpP
	RV1V0pcBP414Vu8tjYp29eNz2rvXiCi46LmLxRPUBfSK+0BwW4E+yzl4HWdEdTODvzKE1wc0A4K
	kv7sGawPJKr/lGUMi97Cu3GRGZgm8enQ=
X-Gm-Gg: AfdE7cmPJ+NMB/VojLgUZAvgwZ+pdB2uGS7Hu+dcEImk9bAi3GVaV5fHJ7pp2Hv/VSA
	/6o4ccRID17zGUcpSE6kPPbIw/QE9eVzYTx9c4JWkJbbHWETsviqUqmXjj7eiLoi4K9cHpw5iL0
	C4853bI+liUFH95hhNnBVEUSWly0Jgxks/ijr7TCdrDHfxvV6lhLDm5DA8wuXJtiI7wVKpis0mZ
	rEgG78YVg9QioeHL2PqzTpxGS+hK7AnBruRRnmvlHOf3W3KuHBrKM4xH8xOWTowdSMikUYQ
X-Received: by 2002:a05:6402:11cf:b0:698:bf17:867d with SMTP id
 4fb4d7f45d1cf-69c5f103099mr4274097a12.21.1783961907066; Mon, 13 Jul 2026
 09:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260515185853.2761456-1-coshi036@gmail.com> <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
 <ah7znSpPM-H-ACaV@kbusch-mbp> <ah752_DIQdr_LHaB@kbusch-mbp>
 <c6046eb2-9594-4355-9f4c-21a6f3bd8131@oracle.com> <539bb4aa-30a3-457c-8c77-c0d660376c3a@oracle.com>
 <CACd_6n1h6NW3DS1MDKkcr=r-uxGQ=HspMLN6TWtLc26Vct8sYQ@mail.gmail.com> <e4650024-1706-46b5-91f8-57f2c358fcd3@oracle.com>
In-Reply-To: <e4650024-1706-46b5-91f8-57f2c358fcd3@oracle.com>
From: Chao S <coshi036@gmail.com>
Date: Mon, 13 Jul 2026 12:58:15 -0400
X-Gm-Features: AUfX_mz0O4zwXGa1uwwRv2fBTT8dmZZUcGxBXcDRQCyDbmXJ9TyEyZtEtXeg570
Message-ID: <CACd_6n2AZvgi1B8Vn8S6NwytDkqHmS=4z-1sxjmk+FPfWv_JMQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from Identify Namespace
To: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_095829_876653_101968E0 
X-CRM114-Status: GOOD (  26.55  )
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

Hi John,

Here is the concrete change (drivers/nvme/host/core.c,
nvme_update_ns_info_block()):

  unsigned int memflags;
  sector_t capacity;
  unsigned lbaf;
+ u64 nsze;
  int ret;
...
- if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
-    check_shl_overflow(le64_to_cpu(id->nsze),
-       id->lbaf[lbaf].ds - SECTOR_SHIFT,
-       &capacity)) {
+ /*
+ * check_shl_overflow() also rejects a data size below SECTOR_SHIFT,
+ * as that makes the shift count negative, so no separate lower-bound
+ * test is needed.  Feed nsze through a plain u64 so sparse does not
+ * trip over the __le64 provenance of le64_to_cpu().
+ */
+ nsze =3D le64_to_cpu(id->nsze);
+ if (check_shl_overflow(nsze, id->lbaf[lbaf].ds - SECTOR_SHIFT,
+       &capacity)) {
  dev_warn_once(ns->ctrl->device,
  "invalid LBA data size %u, skipping namespace\n",
  id->lbaf[lbaf].ds);
  ret =3D -ENODEV;
  goto out;
  }

Two things:

1. Drops the explicit ds < SECTOR_SHIFT test as redundant --
   check_shl_overflow() already returns true for the resulting negative
   shift. I confirmed ds=3D0 and ds=3D8 are still rejected without it.

2. Routes le64_to_cpu(id->nsze) through a plain u64 local, which is what
   silences the C=3D1 warning (sparse loses the __le64 provenance when the
   value is passed straight into check_shl_overflow()).

Behavior is otherwise unchanged. Since the original is already in
v7.2-rc1, I'll send this as a standalone patch on top of mainline
(Reported-by: you) unless you'd prefer a different form.

Thanks,
Chao

On Wed, Jun 24, 2026 at 9:15=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 23/06/2026 21:37, Chao S wrote:
> >> BTW, I have thought that check_shl_overflow would catch
> >> id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra chec=
k).
> > Confirmed -- check_shl_overflow() returns true for the negative shift
> > that ds < SECTOR_SHIFT produces (_to_shift collapses to 0 and the
> > _to_shift !=3D _s test fires). I checked ds=3D0 and ds=3D8: both are st=
ill
> > rejected with the explicit lower-bound test removed, so it is redundant=
.
> >
> > For the C=3D1 warning, the minimal fix is to drop that redundant check =
and
> > feed nsze through a plain u64 local -- as Keith found, laundering the
> > le64_to_cpu() result through a non-__le64 type makes the warning go awa=
y:
> >
> > u64 nsze;
> > ...
> > nsze =3D le64_to_cpu(id->nsze);
> > if (check_shl_overflow(nsze, id->lbaf[lbaf].ds - SECTOR_SHIFT,
> >        &capacity)) {
> > dev_warn_once(...);
> > ret =3D -ENODEV;
> > goto out;
> > }
> >
> > This keeps check_shl_overflow() in one tested helper and avoids a
> > wrapper. John's nvme_valid_ds() works too; if we prefer that, I'd name =
it
> > for its actual sense (it returns true on overflow, i.e. invalid), e.g.
> > nvme_ds_overflows().
> >
> > One note: I'd lean toward keeping check_shl_overflow() rather than
> > open-coding the bound. It folds the lower-bound (negative shift) and th=
e
> > overflow case into one tested helper, so we don't have to re-derive the
> > boundary by hand -- e.g. the lower bound is on ds itself, not on the
> > post-subtract (ds - SECTOR_SHIFT) shift, which I found easy to get
> > subtly wrong.
>
> What exactly is your proposed change (to what is in the tree)?
>
> >
> > Keith, since v3 is already in your tree: do you want an incremental fix=
up
> > on top, or a v4 to replace the applied commit? I have both ready.
> >
>
>
>

