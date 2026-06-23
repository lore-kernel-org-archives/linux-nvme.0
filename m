Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A3CDB470
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 20:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9MUGSR+G8w0e9t/Us+u+afYAQZW56UL9oik51hoBoiU=; b=DB9HCbW9qB1U4VQS+Nm1z4NFjl
	P8cM39mXIw8YfL2hcb0uA4F6I2mCmZDTQYe1sS06u2WTxJKabvULvSrWxFH/A+hUnfObtt2nyQPCg
	HDRLnZY/O4A38plguhrKKEWv8jjBnzXDgbsaI3Uml/IG4QcFuAQLunoLHvmDw16d2/PHhmCD0Agfn
	isGfKwVMZfdt0hy2eplGnoh9f7a9/JWT1W4nR1Tsqzr+o7B2PRpJzwAgMqzrKulCPaiJY6aArzvJs
	7aajg3WWmSWqo5AZvD88M/1hF7zVe2RwqlhTWj2UI+v3v0zfx14QMIS6FKwAcLSW9VjqobiSvxfnv
	jJia/Rqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc7sj-00000006rEN-3JLk;
	Tue, 23 Jun 2026 20:38:05 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc7sg-00000006rDz-0o7o
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 20:38:03 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-697de335c18so450216a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2026 13:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782247079; cv=none;
        d=google.com; s=arc-20240605;
        b=FD/U4MnKkQdVpsOEiXBK8Xz971fY3oRs2QgO4ntgZKg0akHH1Gxx9a7wkS7qCDbLy0
         JV5FJlRyCHD764ZNXUYhQbiuT1heGU6xGj78p8HPWHyrqKyqI1qDo9K2sLQ7/GgmioIJ
         2J0DUIuGnmFrBqzfUeP0BHZVVdrRlUPfl1+NeiXwMaDyjkgP7qEMC8rSC/XdnuVHLKgi
         6yRTKp/4Hi0mHx6qOVEXDWqdeDjFitUbSMAxZeG+70m1QCruJ2KMYR6SxhZkesFyMWXd
         aB3TEXBEGAHhq6Y/IfOl79HrMMphgAjbJwX1egfn5vz/PC85u7rdqcK3TdKSMADc9SZu
         vBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MUGSR+G8w0e9t/Us+u+afYAQZW56UL9oik51hoBoiU=;
        fh=AWinbm2SbSQFXtcrkR9LsvKi+jB6/HNwSsADz6JIemY=;
        b=A5W7s/EG7htknTCCEd5Vv2xdSKSGnIC8Of6c4g4XbL60BEj6lfQT+ZAXL8PXnma7L4
         SRD7i4liXCu5cdpaXL4h8lSS7tViz1QMLT/cB47WWkeOIk+PsA5fqeV+caXNIs20azWS
         E7jmnvjwIzXCf6xmwCGLwlhd28fD+6cbqtfH/XkhxE57YHQTTJseCPETPYa01+i1KiPQ
         3PHbmIaX0GOcKGwbhyyMyY75IrkevcRFm92UjsDxrVQaEQED2ec+mtyp1kiXfHe/Y8kH
         t+9xnAyFIUKROpD1PlTErhWD4w+eqVpGo5dLTT7qHsfxDrlC63pvtVTIRxwjK5dC3PGA
         nuHg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247079; x=1782851879; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MUGSR+G8w0e9t/Us+u+afYAQZW56UL9oik51hoBoiU=;
        b=O1/wHwGw28ip/iAwNzeJxGEo00DN+jI88fkNR6C/vy60a2U+YcTG9kISXSIeUxk/Tn
         fE8MTMKqD50nWE7pJY/fexDA69qvBTyiFOsMCydEfEbpTEKyHGC+1ZsADHgsm+cpMilH
         9AzyqWnqfhh/Cp5KzG52X9SuTf5nWT/fJ3/cNymACc64lE3wns55WlL93FRoY1c+65gy
         P5UXJcjSPqvFOn8rRDSzAjt743UQ7IHcK7F3wZiyA2zfS4YFRyj4my1rKrKUXsNBeKTG
         t1vhKse2953qMw0d5QXPMkGoibQM279GBd032v6ydfBSFgFehhaoJ+T/rIPpjS7yPusF
         sMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247079; x=1782851879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MUGSR+G8w0e9t/Us+u+afYAQZW56UL9oik51hoBoiU=;
        b=eqYdy8y582pTHIm5GaWuJyM7i2HES32febNokxJZBvZ9xFAx3rIuxSdYphJ4Aetu6i
         c7U+59zinKNwuNFm9UjXxnJzYwPtNTvEkZcSzWcrrhuxHjTurv5oDPafxIJjAwCuxXN/
         0EkK1F4NSQmOGKvh9TvIjexK5LUP2soeA3bWjcUdi3HiC5qavITv5ce3eupAdgvKy6AZ
         E7UybAIB0JGkC764gxQE+T8ShvHa35mwrjJJowZhPTtRtQWe4GGdxcIl5+Fv6ih/J3JC
         nXWYlAkUCeqsBKmrKnO3RZLS16h0tri7RurH/9mXdnElpsbHn1J6oBZ0seT9QOU4y+BH
         kQZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xs/neYwCvaGMkU/sN4aetJpKstbvbxrzMV+8Y4jidFPvWWniwSQcVjsV5FMSNcJ82+cjLJIXlODje@lists.infradead.org
X-Gm-Message-State: AOJu0YxAuY/KZAu9sng7768hjpTx+tpnUSD0PvPpHa2QrKIOoAg9nGaK
	+5mcFq3zPrSquqRRRPljPKN6JBhQSTocR5XTNbxSzz8ntBgWFUVI1GOYS2t//iayrg+VSG9D04b
	My/8hmPa1oUAfL+EPm5TNaq41YU475S8=
X-Gm-Gg: AfdE7clUkBzyWM43Z4Gj6+zhTrRJr7T7RW/N2TrOE9/dkF+B+8FjjRnSVrviaRnQAB/
	5gdRTM0j6OuczMl0Rr2N4lnG5IbCJ8vyx0h6A4qZzzqTlCepfljCNYpL3U4T2NgafGF/jcAGjzH
	ILzuKKpB120PVmvO04M6KOWfsJ9FoV3YRcWdI9zUdfvhs8jxrVRLih7ryIO+43g35W0qiATiBNE
	DlpVFbEkd9DWrUvLivZNRFQgH8fHpzg06SDM2l1QnVXoTR1gMJrpb36GQ+UO4ELNxiOfL0G
X-Received: by 2002:a05:6402:350d:b0:697:e93d:6da6 with SMTP id
 4fb4d7f45d1cf-697f376fca1mr87760a12.1.1782247078289; Tue, 23 Jun 2026
 13:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260515185853.2761456-1-coshi036@gmail.com> <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
 <ah7znSpPM-H-ACaV@kbusch-mbp> <ah752_DIQdr_LHaB@kbusch-mbp>
 <c6046eb2-9594-4355-9f4c-21a6f3bd8131@oracle.com> <539bb4aa-30a3-457c-8c77-c0d660376c3a@oracle.com>
In-Reply-To: <539bb4aa-30a3-457c-8c77-c0d660376c3a@oracle.com>
From: Chao S <coshi036@gmail.com>
Date: Tue, 23 Jun 2026 16:37:46 -0400
X-Gm-Features: AVVi8Cf0Ls-PhmtmYZDcGBNpWXae8oiqTX3KHoBFoPHS_gI1lQYxm3lX8MRa_j4
Message-ID: <CACd_6n1h6NW3DS1MDKkcr=r-uxGQ=HspMLN6TWtLc26Vct8sYQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from Identify Namespace
To: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_133802_364492_0FDE5B0C 
X-CRM114-Status: GOOD (  20.48  )
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

Hi John, Keith,

Thanks for catching the sparse warning, and sorry for the delayed response.

> BTW, I have thought that check_shl_overflow would catch
> id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra check).

Confirmed -- check_shl_overflow() returns true for the negative shift
that ds < SECTOR_SHIFT produces (_to_shift collapses to 0 and the
_to_shift !=3D _s test fires). I checked ds=3D0 and ds=3D8: both are still
rejected with the explicit lower-bound test removed, so it is redundant.

For the C=3D1 warning, the minimal fix is to drop that redundant check and
feed nsze through a plain u64 local -- as Keith found, laundering the
le64_to_cpu() result through a non-__le64 type makes the warning go away:

u64 nsze;
...
nsze =3D le64_to_cpu(id->nsze);
if (check_shl_overflow(nsze, id->lbaf[lbaf].ds - SECTOR_SHIFT,
      &capacity)) {
dev_warn_once(...);
ret =3D -ENODEV;
goto out;
}

This keeps check_shl_overflow() in one tested helper and avoids a
wrapper. John's nvme_valid_ds() works too; if we prefer that, I'd name it
for its actual sense (it returns true on overflow, i.e. invalid), e.g.
nvme_ds_overflows().

One note: I'd lean toward keeping check_shl_overflow() rather than
open-coding the bound. It folds the lower-bound (negative shift) and the
overflow case into one tested helper, so we don't have to re-derive the
boundary by hand -- e.g. the lower bound is on ds itself, not on the
post-subtract (ds - SECTOR_SHIFT) shift, which I found easy to get
subtly wrong.

Keith, since v3 is already in your tree: do you want an incremental fixup
on top, or a v4 to replace the applied commit? I have both ready.

Thanks,
Chao

On Wed, Jun 3, 2026 at 6:08=E2=80=AFAM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 02/06/2026 17:18, John Garry wrote:
> >
> >> I say we can ignore the sparse warning, or we
> >> can rewrite this to avoid the check_shl_overflow entirely.
> >
>
> FWIW, adding a separate function keeps sparse happy for me:
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ea837b94d3e5..3ec98038668e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2364,6 +2364,11 @@ static int nvme_query_fdp_info(struct nvme_ns
> *ns, struct nvme_ns_info *info)
>         return ret;
>   }
>
> +static bool nvme_valid_ds(u64 nsze, signed int shift, u64 *capacity)
> +{
> +       return check_shl_overflow(nsze, shift, capacity);
> +}
> +
>   static int nvme_update_ns_info_block(struct nvme_ns *ns,
>                 struct nvme_ns_info *info)
>   {
> @@ -2407,10 +2412,8 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
>                         goto out;
>         }
>
> -       if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> -           check_shl_overflow(le64_to_cpu(id->nsze),
> -                              id->lbaf[lbaf].ds - SECTOR_SHIFT,
> -                              &capacity)) {
> +       if (nvme_valid_ds(le64_to_cpu(id->nsze),
> +               id->lbaf[lbaf].ds - SECTOR_SHIFT, &capacity)) {
>                 dev_warn_once(ns->ctrl->device,
>                         "invalid LBA data size %u, skipping namespace\n",
>                         id->lbaf[lbaf].ds);
>

