Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EC1CD4851
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 00:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2NAd8eEiw1oaBIeLwLtP4Ugx4Vpn9O59alKNAV8DYKk=; b=f5BLSlKDYoBYMqzXZzw3y5oFDQ
	LPKBZ7t5+qa31mRF6gWm4elctbypecUpkWFZVa9wJfkBeqSX15RSYYGDKjkpRydlxnz12Xjm0N3qy
	4nppVFQF0MRQ2JHAMmL8g0ncA+HHY+AXuSbQG0R2t1acGKb+IRUL5K/YFKja4gNZTKzoPwfP6TVi6
	X//eBLU6FZmwS+KQUw99hr+go/dQbFMVjD6ZaJmyf+PTomcysd3eXhd5qAlhPMrdsZz6s/nvD4x4A
	gdE2T2Sx3r6xdJfYAx7RfPoEKdObNj7KEORUUh9NKIjxB47XDohWfFogJoXtEpOC6HR5qajgDKhPn
	Tmcojw0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO2m5-00000009mwi-3iwF;
	Sat, 16 May 2026 00:21:01 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO2m3-00000009mwF-1QVi
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 00:21:00 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-6314d2e31d6so127141137.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 17:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778890857; cv=none;
        d=google.com; s=arc-20240605;
        b=XNIY8a0kBBn78DOciXVIuLEtdK+5/ezkaXG1tY5B6SF9yFE9B9WfwJEen/Y/5QuKLf
         TvPPzpI/uIRIF5SVGvyjQAFEF+b5OD2uOKKm3GP4vA0ebUp4wY86r2FG2CoI8coBTczJ
         /eXVJUY9QtpD1um0RqsdA3BmvwQjNxAqpsICOiYdPTrRV2W9w1dQTXSaxD2MyPVRwLxK
         wlcPiqpvi2rz7M2HGMRFINnzuaxYqJAkaPjBZCKB0+nJ5z1nvOishH6+Sx/hCWrz2bKw
         Uk+qrSnhhyjV/HyKSGLsV8CDIdi13GZWX7pNju687DuVfBbgO19M1VLufweQpvJ925im
         DL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NAd8eEiw1oaBIeLwLtP4Ugx4Vpn9O59alKNAV8DYKk=;
        fh=p59UqIUPyN1uBHHsdsrStHu8oT8hClmZnm5f+KRGoYM=;
        b=J+AJ9NQWzHu/x983p4z8lZWbQuaGg+WAgjVItEGJwfG7QWT25Q9ifUyL7Hq1gY8Ky+
         WK3Qb82VelAo18sGX6VUYfEcTeGNDm1kevcjOkwyU54vxl+rwkuVzAy+jo/agaLmD4pH
         tFRUkkZhn3sb44AXAGKt2yAhspbYCx9qNuE7wV67+ee+JlS8DXS2CeEhsdOeNEUz+QId
         xndbHzfA/p9P6dCrTDcBE6bEIEPBwGeRAad+WdW2ABt+0+y48/WUcvcQgj9QY+6e5GG5
         KYmuksVRxLq0v3i1T4sUhJXpI1rOp5Dd+CBO4F21T0aANdKvU2wY/VTgogxx6bCvk+YC
         ubwQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778890857; x=1779495657; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NAd8eEiw1oaBIeLwLtP4Ugx4Vpn9O59alKNAV8DYKk=;
        b=a7jnigSisapiB09zv6M7oPHJsyJZ/jWx6VIYagXn37XYFDZMlkxNRmyfSIJTvIFbtl
         Btq9vDcszjHtUCXuO7iii5i1wDIKYh1Wd/rB+ZpROPdayxzitE/2sviqvHnKp0bSBSlD
         hs7co1VyXHNx+0zCcILqfLHIoEDKHNDPAbrs4AMLBBfAQni5723SXqYaNmJnAG8YjYV9
         d3nBKvyDR5p1wQgkJe7Z2jUlyn6+K+17UyYF8IzaTc1wTeeZ/kkc/pgOskkObc3I7r/J
         hl78g7vBpKkk1S9xBVKheuELxBmPDdMqmPO9Pq399dvZSWzqhiZbIlDtLdNeh+0TNK+y
         7ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778890857; x=1779495657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NAd8eEiw1oaBIeLwLtP4Ugx4Vpn9O59alKNAV8DYKk=;
        b=ZRt4rYaYR+w9Zt5/1dathkyRfmkHgrpZjAKAflxtnkYSLBFBVRcHtl0z+bJfWiE/iz
         XrLUsuTQJLMFfab8ijBBHLYXQxyTKUVvebsr8rjjgB6N2dk51M3mdd8c3xpKRiVcI39H
         7qgv4V9brKYa6kja8/Hp4PI7tk6xCAD1Ua6oLwTE/KGRZ8cQ9YCstSC5k9Z4JjzYIdCK
         g2wq+fx7AZ/+bpwDvVzG6BbfMtvlZ005ZVp/OeY+l3mhZbY2GU83zCZsHmKeROfGPIjE
         bHvLfNy4DBhb77l2g5E7Xw3kzQJJyfOhg8JhfPIgeYcpWaUtyKIlDTEK8seMuReAX7DJ
         PXqA==
X-Forwarded-Encrypted: i=1; AFNElJ/16JEjM/8Di4twCNb/JaddxVKle0LE0VtiARDslnQSSUcTxzX3GQ21lNiNQGhFEy8pE42kg5BmCxWC@lists.infradead.org
X-Gm-Message-State: AOJu0YycP72rOYSHmIdNhH+ZDn9uNmYv+SgFz1k2Be0B2KhVRGlTDJrO
	hPStvrmBW0jwF5YSla3r96+Iy80f/9nEN1SauQuOie2ocO1ly33DXKLgoodgqxSm4q1nWNguhgo
	jQOMvjGglTMyq1lf0zfntGC7blHRkCjWG4R5JP2W5fX4FupoEitzy+pZF7LTGEko=
X-Gm-Gg: Acq92OFT9drgWCvCN0GA6GF4zcefmLh/rXa0ypcnH+xpia3eGobQoakyZTeuUrwjuUZ
	1eVs5hCPu8fLjwHK2gsJyM28y4SNceTixkpbwmdHeyoT4Z4lqJMahU3xz8Fk+hF6NP59omUluyq
	ovtbyixO5bvABRVAVvq0DaEIr79Dv/+yqX38EnGCJqnQpJT0VOR2h3TXLXPrAePT3AdFOlCDrTV
	oIIJ0HDuoflZney/Wk2VOmkS908o1Ui1evuyF3ggBcHwAgJ/tW0yMQyvdkbOWVWCB4Fpg3lBf8s
	chsCXU8abVLv8dct3w7pg0oJ39HOfXY7okNU5OP5Y/nfE+G/ggauVeErFaN+9RPTU1z0
X-Received: by 2002:a05:6102:6051:b0:639:6533:65a0 with SMTP id
 ada2fe7eead31-63a3ee7eb93mr3533522137.18.1778890857262; Fri, 15 May 2026
 17:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-14-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-14-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 15 May 2026 17:20:45 -0700
X-Gm-Features: AVHnY4JJ6zo0lPLtpNyvPjwnTtCR8e3N4IGNOVfs910rSWLBV5zKe1A-p0hNKdY
Message-ID: <CAPpK+O0pDchbem3eJuH1ZnDyuXVXY9WxfQ7OpFmq8wg_n+8+KA@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] nvme-fc: Use CCR to recover controller that hits
 an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_172059_424567_8BD439D6 
X-CRM114-Status: GOOD (  10.55  )
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

On Fri, Mar 27, 2026 at 5:46=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

> +static void nvme_fc_fencing_work(struct work_struct *work)
> +{
> +       struct nvme_fc_ctrl *fc_ctrl =3D
> +                       container_of(work, struct nvme_fc_ctrl, fencing_w=
ork);
> +       struct nvme_ctrl *ctrl =3D &fc_ctrl->ctrl;
> +       int ret;
> +
> +       ret =3D nvme_fence_ctrl(ctrl);
> +       if (ret)
> +               dev_info(ctrl->device, "CCR failed with error %d\n", ret)=
;
> +
> +       nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +       if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +               queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
As with the other transports, I think we should also have:
                dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting
error recovery %s\n",
                         ctrl->cnum, errmsg);
before queueing the ioerr_work.

Sincerely,
Randy Jennings

