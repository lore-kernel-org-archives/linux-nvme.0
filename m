Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5065DCA5FAB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 04:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXHc2ocVl/GXq6eBcofJvFTp9Fkopv1F3F+Vt9UcgN8=; b=zzgwSAtOBQB9WPPHIChStvV5U7
	xEHPo9Nhgs++DKMWQ5OE0vM/pygWt3ykHuLlnJn/YrPZ0lbRqEaX5szTbDzp79V4Rv4BkmHGq6v/y
	X0Vh/sp/dLtSKsmAYlwknms3D8Yc0a8vgVQeMEYxgrCYF+8E2mpPghMYwpB0jBffPI/EztKWmuYtp
	RF7wp95Eht5P1k3GrRWJytRCmZEoy6XDbxB1kyGAvafoLyB6Ou1gOWyrPj+UPNi9bmNMgZfMZRVOI
	MiVe4vq/nwmZR6no2D3zZFbwYW5lhRMpN9RwuWutzmxwEsmS8RSEaYMBk4R10oJiWByPjzoQLR9yL
	iXrvHrqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBlkn-00000004zX2-1H3D;
	Wed, 30 Sep 2026 04:17:13 +0000
Received: from mail-ej2-x0f.google.com ([2a00:1450:4864:34::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBlkk-00000004zWg-3mae
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 04:17:12 +0000
Received: by mail-ej2-x0f.google.com with SMTP id a640c23a62f3a-c2a8b9acbc6so746616066b.0
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 21:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790741829; cv=none;
        d=google.com; s=arc-20260327;
        b=pb/8o++7dAINfqlyn3nkHnhqHIgKpdzSlOHZQfWw8JHSFcR9OUNCx9vYlycejWWPB0
         3arlBRDzYPFzhZdAHrGR6BJmtI+MDJewM0MF4VhBE+zVL9o06BFcDodMK/q2U+342ZoM
         mqFsKR/WwsEUXZI1bD+/rMdb4yOycW5n7rx2UkTTfmIt81SRSAMIu/fz1XJROmtCfeLY
         TZSKKQhG23o3Rk8MjkCh54AUsC/SvOA948YjpGCrG+jsJsB6n5yZc12+1zyGQxpPqLAa
         Y9zMMnStINd6XlUng8VE8g2jb0ENqhgxTFX7xXqB3oPnFQC5ZxxmaKJnA87qPMaBhG0o
         U/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXHc2ocVl/GXq6eBcofJvFTp9Fkopv1F3F+Vt9UcgN8=;
        fh=mFl+mXvd5nPZSZBanH6xuDKVgFCyrf/Sioil1zHvdsk=;
        b=q0jZCh35QyFs7oKRZNygyCHi1ibhpB4qLA2uupEwE5PGtJ5m2bxFcrI6V5RwwJBneK
         voZzWTQu3l+WY5nWOy0G4epmhvMBtlhxUuam599RjUuLI/ckDuogH619B1+ljJgQrCC2
         TWqOFBLFfR4q8eauvFIGxuUZSPYNVu3JsaYCfzprAtULQRCsbgbqx6FWVkfAWGUX+7JP
         azqy3mb30JTSsQMYEZNpkgzE14I4ZjGnA13Mwy/cTDwijpXH5KoaArMxNGGQwtzwRFGf
         uGsFKdBYi17gkFGSHgRER9eZhA6npYIekYQZtb25Hw+dQ1rbU9fwCIdGgFr36H0+GqH5
         MjjA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1790741829; x=1791346629; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BXHc2ocVl/GXq6eBcofJvFTp9Fkopv1F3F+Vt9UcgN8=;
        b=ijVb6KIt3OsRv+wLZ2XBx2H0hjxBi3ahoWSsjT38KonzsCWEQo766qMF2RCQwJkpE3
         sAisxlmsxONpiwivmwM7ZiS7GdyVv6KxaRfo521EzBc0wnEyj9WOd4ukpEPw99G1o/Kq
         jv+/BXJs6tLpRa5KukUKJGe2B3BRFw6vEC80bCU7fY8SB1nQWTE19F/e6H4fLRXhsT24
         okaJe5MAyxjf3HSHdmzVCGuzmAMjRD+v2ZY7VpT487Wpt0bUIpDH2e6S2W80rIKhTaP1
         hmCe3h2xEQUlbB1PdnYgRu+DTTo3DZDyg9ZplqUO8sOSim8G8CW9lBPBUw+AaTzaSrT6
         zxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790741829; x=1791346629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXHc2ocVl/GXq6eBcofJvFTp9Fkopv1F3F+Vt9UcgN8=;
        b=dmAiM4lHOPXQGidrUm+u+jvsDvMt2DksdrgQeNTa6wTqqV2DAaVSRnH+VoYrdJrxwD
         1Yh64stM/Xk7smiV+4vE9wRUZeJC5ydKduypBV5SS348sXFKasVY3WmUjz7A8r2V3hhL
         p5bNcMiTUzrLzjozbeQucMmn5pN72hhVcj489InBkd47SAV4Unmfhma0/knVeFJa+lqc
         4uQBJSFanr+2h9OHKbnMGpJl+IeGw5Vn+MuHaQOdVknHmYu6wIib2jLO764PTzCa6rg9
         ZRDuOo0ml1Ckj+OoZ+3mGqB/I6ajB39Wvh5HD36daarejuI7fhJ+oRoGJQHPnOKN2OI5
         JhlQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+iZFLSDBnr5NRb/NfoEjTTy3A6/pRv9wMC6e/LaEdjK5Pxg6ehjqaxWlhNTFHOywNZCjShowqA8c2@lists.infradead.org
X-Gm-Message-State: AFq9FYIFAFXJRHTGMUUYgGoWREJvdORYxsaL94IAGGDff7QzFIkwUbAt
	1ZAmYsmv925pcXHTcGSPVi7uGPeeigfcBkDTWriEL5zDyqzH5cJ3f/uWTug8aEglYsTB3/L9o1C
	WKDwegsVXRkdZQvtdnoT8A60XzxSfd4l4lcUwGSCQMQ==
X-Gm-Gg: AYBFou2MxYZM1aeke0BmXY7A4ANDNTR6CDYINp0pjPZXW/bcWPe5+PJVWHowyWt7pl2
	ZLyD0cgtgztf8420SqGAeXXnvxdMiZQz0mpI8zzCBTpYMJwGfoY3+LJdkLT23HKKg/NX0QVCIiM
	XwKkv7qkFO9PcUD2FozH/nnpnHSS+r8ZwxcDf2Ssvim8FGU41pT28otP6DCAKS8cAQvPk2vCe0m
	tkcQCIKWD1KRjFr9pY/EqfrJ2E8HypsvriQBL6V/ftxHdyv/IS/+WjgKBf+xPouvkvsKPuMuT5x
	YSA+1wheQXpqonAtRvZq3VWFZhjMdm6XmX6DbK5f0uz6xO9Y0jfdPBCJ
X-Received: by 2002:a17:907:7215:b0:c2e:c8c:e123 with SMTP id
 a640c23a62f3a-c2e23cac5d3mr5647366b.10.1790741828953; Tue, 29 Sep 2026
 21:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260930024233.96200-1-artem@trailofbits.com>
In-Reply-To: <20260930024233.96200-1-artem@trailofbits.com>
From: Xu Chunguang <chunguang.xu@shopee.com>
Date: Wed, 30 Sep 2026 12:16:57 +0800
X-Gm-Features: AclHuK9PXTY6APTmi-Sas-3gAiomOj0JKzSbbMMC4c-EJPtWckhIK29Ek9W5PlQ
Message-ID: <CAAO4dAVKgZT5rkv1YQzgch5xcA=DH0EmHM=oOY6e-c-sArTprw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] nvme-fabrics: use reserved tag for reg read/write command
To: Artem Dinaburg <artem@trailofbits.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_211710_992632_1F738B10 
X-CRM114-Status: GOOD (  30.94  )
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

OK, I will apply it for 6.6 later, Thanks


On Wed, Sep 30, 2026 at 10:42=E2=80=AFAM Artem Dinaburg <artem@trailofbits.=
com> wrote:
>
> From: Chunguang Xu <chunguang.xu@shopee.com>
>
> [ Upstream commit 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa ]
>
> In some scenarios, if too many commands are issued by nvme command in
> the same time by user tasks, this may exhaust all tags of admin_q. If
> a reset (nvme reset or IO timeout) occurs before these commands finish,
> reconnect routine may fail to update nvme regs due to insufficient tags,
> which will cause kernel hang forever. In order to workaround this issue,
> maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
> tags. This maybe safe for nvmf:
>
> 1. For the disable ctrl path,  we will not issue connect command
> 2. For the enable ctrl / fw activate path, since connect and reg_xx()
>    are called serially.
>
> So the reserved tags may still be enough while reg_xx() use reserved tags=
.
>
> [ Backport to 6.6.y: used the older BLK_MQ_REQ_RESERVED request flag. ]
>
> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
> ---
> Hi Greg, Sasha, and nvme maintainers,
>
> I am working through the small CVE backports still missing from 6.6.y.
> This one addresses CVE-2024-41082. It reserves a request tag for
> controller-register I/O during reconnect and reset.
>
> The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y=
.
> This fix also affects 6.1.y, which will need a separate backport; this
> submission contains only the 6.6.y patch.
> The target-specific adjustment is recorded in the bracketed note above.
>
> Could you please queue it for 6.6.y?
>
> CVE: CVE-2024-41082
> Upstream: 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa
>
> AI assistance: An LLM helped identify, adapt, and validate this backport;=
 I
> reviewed the resulting code and validation evidence.
>
> Thanks,
> Artem Dinaburg
>
>  drivers/nvme/host/fabrics.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index fd01b86f10a4b0..8adcc8c97c42cf 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -179,7 +179,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, =
u32 *val)
>         cmd.prop_get.offset =3D cpu_to_le32(off);
>
>         ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL,=
 0,
> -                       NVME_QID_ANY, 0, 0);
> +                       NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
>
>         if (ret >=3D 0)
>                 *val =3D le64_to_cpu(res.u64);
> @@ -225,7 +225,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, =
u64 *val)
>         cmd.prop_get.offset =3D cpu_to_le32(off);
>
>         ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL,=
 0,
> -                       NVME_QID_ANY, 0, 0);
> +                       NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
>
>         if (ret >=3D 0)
>                 *val =3D le64_to_cpu(res.u64);
> @@ -270,7 +270,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off,=
 u32 val)
>         cmd.prop_set.value =3D cpu_to_le64(val);
>
>         ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL,=
 0,
> -                       NVME_QID_ANY, 0, 0);
> +                       NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
>         if (unlikely(ret))
>                 dev_err(ctrl->device,
>                         "Property Set error: %d, offset %#x\n",
> --
> 2.39.5
>

