Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6590C9830D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 07:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S1fXxaoehIopV1PeW/nrL+gXG87cQGpcsm5CRZuB4kM=; b=B8JUWde+Z3XrtbLEXIQBQ3a5vz
	RKVdqgPrXATRRcaXqlwQD0mauON4c8uzaGHdk3RVMgg+xqxHeRN2okt43KiHxCJ9qJ4915RecBdY0
	537wIbL+7rDOdDAwCC9f3o2sH3vbDHJW2MW3CXMqF87/dOLlHO7oXakHZGnXkhMl2awHOHrwM5sVH
	/fuuZklvRfrtzZS0kBpLVZ0ojQxitet1VDSfKmqMvWEpkZiRokoJNBeUailCKLMQXtD4Few0coxR6
	QfrNkuzcKQB3tHqNDUMd14IdHt1XP8aVkCvRWfO9xxF1j8uC3cq9+A/yzf72JQ8xm0j/ug04GCwGH
	bfssviHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9zvW-0000000Cms2-1Ij5;
	Fri, 25 Sep 2026 07:00:58 +0000
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9zvU-0000000Cmrh-0QPm
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 07:00:57 +0000
Received: by mail-oi2-x11.google.com with SMTP id 5614622812f47-4b37a3ed714so433447b6e.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Sep 2026 00:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790319654; cv=none;
        d=google.com; s=arc-20260327;
        b=nWHgoqylUXUUNEn4jZhAKjGUPaY2eBtfc8dVDce1PacFtTuSkCKNsL5cYAcHQ2l/l5
         h5Vj14UfxVRlWelpWk5hBbr+AAlEBUq2aMXzrOCzW37bzie3J3PGfz+GFkrUirsdV1z+
         vMLBTPXr2bsm8gXNjbUb7hBrSiicW5zrSwKDFxkfQ/JRx6aIT7D9uB1+VelpG7L6tGKI
         UmlwBKANj1gSDSD1WKH62PGaobViFwnTTqLs2cZFOMPR3O1anjwMvvKe+3SAMYMmCNyG
         eHaViIfxvyTSr1gq1jJNPVjF5rO/uxj3LYQRKq5LK7K8Fj+SfFBmfoMmfzZHu6r/OzeG
         w1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S1fXxaoehIopV1PeW/nrL+gXG87cQGpcsm5CRZuB4kM=;
        fh=AxpGKhXfsLfaPXuKi1L2EFtLzBANDHPCr3+Bn+oiP0o=;
        b=Gz94HWMKYPZ9gNzOrKiB4SIO329wIilgTLnYGYhzwm7+7X4sJtxbNN+k5K6UDUHCCZ
         nX183hLPfFvYDW3/5+XduX5nwkD4JuTvUe8Eimm8mB3e2mbM+QjDgu09OCiLi7s3d4xu
         4/H0esJqHFmHWnv2xtX6xiHhsmoNsGoCKMfm9e5u9OxwWYhdBOm23xNvgFQDNaCVI+oh
         RHrXUnhREMe0fWPKK7mw0jrCcSBSwTmH3KXgjiDCLgdiE7nLgmKnDc8Wbb5LKHv+ayLZ
         KDWxmWAD89uWcN7V4r/2usrsoG8FlVKkGhZXVnZk/Dv8jx3CPtmQw3XaGKuvWYm53L8a
         jGGw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790319654; x=1790924454; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1fXxaoehIopV1PeW/nrL+gXG87cQGpcsm5CRZuB4kM=;
        b=TciEduaVrXaCw1xAcAq2YgHIkDU1Hnsmi8GdhfbG3ZwVDLficNLMxyVdjYOIEmJX3I
         VVz6ZPTZH8w9RF3XyCYQGqWTywmLH2aqq/QDPyWajY7bERofgT2sgpEx2H3ozect6QSz
         s2SUSQOfeZ4hsVZ8sQW18kbnVM+rMDV23w+Cqe0BewxjUu1k0b58awhAaQ7a/B14XFe7
         dL9mikUFlxlheOONYsiU0BiKmU8CaP4TMyA+IscJ8oly6NYGfPKyp/EdePTDaDeU4hUV
         x450yrHwxDaEmGWNXzLDdLVaEqHsQ9arRLcTzLQOB8Q5vACRBmEb1XqIp+nAizNSdYmU
         B+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790319654; x=1790924454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1fXxaoehIopV1PeW/nrL+gXG87cQGpcsm5CRZuB4kM=;
        b=gqC+0B3kxLw4meSxRrt/IYrH5OugBBMEVJ6v+6O5MB4aIwth9PeYwUajtpmQGxdvGf
         /1TnH2eK6QuIlJEmaDBbuQ7Dtv3ArzEBG8Id0S9U9UzP2vZwqTc7CAvSUTJjRsfTdngw
         y+UeJ9zcPl1LbDqHl/cluloDPbwX8QLaVIPcVVJTxLLeSxkZn66epuGzrbKjj15Zcjgf
         4BXWSK68at1dv5BQMYpP5T95FzL2Jhzi437QNIpu+x5oDAxmSq9X78O6PIRNRbh7u/n3
         OLHiI/e9FwRPHuwYRsxgycX5x2RBIQddSdRHN15w37lSq3jcEAlOxQwpPzIRrqziusC5
         8WGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwps38/wQYRv5OK8Qp/RdHYH/jKsqncMa4lNmqSCxmKcF1W84g+xUc+zqBoCqLqV54L5UJuojDInjv8@lists.infradead.org
X-Gm-Message-State: AFuF++kQQIAGtsWwgIfpxAChrxtjw/58/0d9YA0Yc3UNrErB97D3fZeL
	kEyZ+iUL6Vm/3O6jTdhg9z4z/2TKKALk5ct9xBL3D6g2/7LcOOw48t1wGQFHI7UjcM68rhweutW
	I5TF6e/M2jxJlyFTHdE6tVq3abpRgNKE=
X-Gm-Gg: AYBFou2kBibcBDAq6bynhKNt0cM/ADJG//0fTUs/0PnwPhmgV5We8mpmp8x5JjL/7VZ
	R8jvgKLm5aG5xnxzv0GzwuzoF7a1kxoewVByG41dKNSwyuZToaDP5U5+CBHg44YWa+ZHTDFV3nE
	GypEhhgj60GJd86iuNmEvXoND18lUFbiFtyZYPB3X+zUpmLLDPyRMXKkB5Ds89rs6NijvvMlqTz
	lhL3zq2zo7JLXd+oGll/I+8vcCpjE2kGAJrVqL51bzN8lQ2Ni7QNzd/H+fVbQT+ZlEZCgZYutYC
	mDu4KKcXGMMuS17e7gXObK1Jdyf9Wi2PNlwMFoFKFh6kopTCD6/lzcf9D3OycEh+g4GwWtRRFLj
	zduUrI2gtx0gCulKXjMUv1w==
X-Received: by 2002:a05:6808:159b:b0:4b9:a829:f01c with SMTP id
 5614622812f47-4d72e16431dmr5142881b6e.40.1790319654501; Fri, 25 Sep 2026
 00:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260924053121.17703-1-yupeng0921@gmail.com> <arS-38fE5r638g4Z@slm.duckdns.org>
In-Reply-To: <arS-38fE5r638g4Z@slm.duckdns.org>
From: peng yu <yupeng0921@gmail.com>
Date: Fri, 25 Sep 2026 00:00:43 -0700
X-Gm-Features: AclHuK80rKmiL3-JKRQwzW_6XT8TAtbFUe0xI3YnKDyMTZWe3I0aCFGT4xVZq5g
Message-ID: <CAG3TDc0DZs5+E1tEBCn7uQyWJwZOY-brXBKTx8fBCy3HJqaqiQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvmet: add cgroup_path to charge namespace I/O to a cgroup
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_000056_171281_E6F3EEE9 
X-CRM114-Status: GOOD (  23.79  )
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

On Wed, Sep 23, 2026 at 11:10=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Sep 23, 2026 at 10:31:21PM -0700, Peng Yu wrote:
> ...
> > +#ifdef CONFIG_BLK_CGROUP
> > +static int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
> > +{
> ...
> > +     cgrp =3D cgroup_get_from_id(ns->cgroup_id);
> > +     if (IS_ERR(cgrp)) {
> > +             pr_err("failed to resolve cgroup id %llu: %ld\n",
> > +                    ns->cgroup_id, PTR_ERR(cgrp));
> > +             return PTR_ERR(cgrp);
> > +     }
> > +
> > +     css =3D cgroup_get_e_css(cgrp, &io_cgrp_subsys);
> > +     if (!css || css->cgroup !=3D cgrp) {
> > +             pr_err("the io controller is not enabled in cgroup %llu\n=
",
> > +                    ns->cgroup_id);
> > +             if (css)
> > +                     css_put(css);
> > +             cgroup_put(cgrp);
> > +             return -EINVAL;
> > +     }
> > +     ns->blkcg_css =3D css;
>
> This is really odd from interface POV. The user specified "associate IOs =
to
> this cgroup" and that can fail if blkcg is not enabled on the cgroup. Eve=
n
> if it succeeds, if blkcg gets disabled and re-enabled on the cgroup, the
> device is still going to be issuing IOs as the old draining blkcg.
>
> What the user can express is the target cgroup and the IOs should follow
> whatever IO control that specified cgroup is under at the time of each IO
> issue. Currently, cgroup_e_css() has to walk up the tree to find the
> effective css for a given subsystem but updating cgroup code to add e_css=
[]
> array on each cgroup to avoid the overhead shouldn't be too difficult.
>
> Thanks.
>
> --
> tejun

How about this:
1. Add a one line change in the cgroup code: export the cgroup_e_css
2. The nvmet invokes the cgroup_e_css for each bio and under
    the rcu protection.

I think we don't need to add an e_css[] array on each cgroup. At least in
my case I don't expect to have a very deep cgroup hierarchy, so we won't
spend too much time on the cgroup_e_css.

