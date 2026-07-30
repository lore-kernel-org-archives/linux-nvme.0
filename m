Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655CBC55167
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 05:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=; b=01XrebHVNWrc+eRSUb06UYcLxO
	V68XSpz+gNABd3HiYf5t9SjuTfUSmXwc3djj5nKCMcImDaYMDd/OzMaIgBcSNdgOIwjRzuocZs5Za
	G+qXyp3KKkZG3/+qjQpuADlB0xRbS1LcjsSWsq4j+VvEYbwlMRYXNM/0Hug8goy0UGVYIbz8FtImZ
	85K+vRAJyX/JI4enc2mWkMSQP+NfOpkX9ZeKNIzkUEt/yCjgY54XDJwqe0YPjVVT2s4j+FAj9UjFt
	YRGJw3Rb4mZYVkHOe+pNSiH4jcCL+rgtsbsC9FN8omklTbvHJbWtMxTWkvWvKQpxAov70OCMcJANu
	Et58rLrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpfSf-0000000Blpx-40YH;
	Fri, 31 Jul 2026 05:07:09 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTS5-0000000AyUi-0LF5
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 16:17:48 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-451ef88519aso7739fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 09:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785428264; cv=none;
        d=google.com; s=arc-20260327;
        b=d7cPHaAKkBsIKYskXX6ova8NRPPRT/ezZ2vRqxr/8gZhyxnYK9fK/j2gXYn7yyYlGy
         NbdGIctFyFXqxRG3yR6ZapEOZH20+RI2tXdEkR5JI3aONkzbpR0rbWtfIpyBIt6dyoYr
         dFUcMDUE5tGX2++1Umi25ZM5uEYiGyelHOgQTJJEJboQ3ucTYieM+IBdti/sIxk3vEIe
         ybce66RHS2qEhX8eC6XrO0fPhIwhMKUOwWzKEojNcyiR1+Q46uEycFfQO9kX3PWGawMu
         +0V59RyLbw1E0yrJ0S5LzleZx+9DYcZ113xmrUVi9MxFMmISfLszfH2OahFvLJtZLLo3
         QAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        fh=JQWHEqiDanxUF9brciE1EVVQEixivCpzkJ4OrCmBpds=;
        b=Pr+SicrQam1cYQcoTMxhKQyADVXcaOmEJA3kunNpeVHtvlRs+PxdvyEYbY9n6d0mXF
         wUZ/HKayMs1nVWwpjkRD4XSs8C7S/ZH7EjwRihsghfmnLXejDx/5K/vIoK4PmoF3c3Ed
         NjvTNsIq9Jn+c/pqNhh2ncmQR10M1DAjyLLrC0h9dbF6+kwA2ubZj1+PoaU/y6XSzMZb
         K8ZtwuoPJo2D2DrucEmYRxmcRb40ZGJzSbvNOR0w7vglslR0M1UhoG8SQfDvhsEyFwK9
         jByT7KOJuXVvcfijx5HMZkcfmAuvXfbT6HQd7NLv2uDbLkwGNCCwRiuM3qaaa6CGyy5C
         yBeg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785428264; x=1786033064; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        b=IP3tKo7IqY4/YaA3m2GrPayhe6QaG3itJk7SdNT0NkvMKPL9+DO+bZ+U+IlS9+RyoC
         Uz0cHRzMnE3EKjeeKvj+gYZhh3jh5J/keier4JH4I/zExPF7GQzEpjhAkTPIlNCrpEb8
         By498eb8ZINTTaavxNwyP0EMLkmDtIlXlWdhK0Lx/DxDUx26zW9qxczeKQEITjiHKkje
         rowkcc93ov0WT4Q0ym5RL0iRHAlpGm4On7+R2LMSfihvQDH8uEkzYzX0db9e75NSfRn/
         io+iFttMLebaGvqrs+tpTvtlwKreBqyv//Iy9mfGpTCPd3+BCWojZZfuJA3pmG1k190n
         ihpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428264; x=1786033064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y9uL8axv/bSBp1hJEk9/5EREqK5uThhZ6LCPv7JfjT8=;
        b=L/M/q203ZicRmiggfwrLD75EPp4kBtNgxD5vHKvfZge7KJYsATRTfU7rXfd+TLY9TR
         Gzq2C7Ivf+iM1HBZ4lqSwDNOc9KgCTL8+w71EWnMfJ1f+9v5IupC0McE2ILALfKpfzse
         h//NZ9Txual4JHbTazqhP9KiKoMJ3wUG7jIKQpjh4l28hNnki314+bWxDi6D83BUst0W
         QClyVhCzq0jhEuNnmgc8jtEuDWvXfk5fwSG8KIGf421N6m2xgByLG5or5cpiINluEwaJ
         uhvVboyZr11W6Te2Sg0ivAKLP5FS/titMvbaz6u4jJPJdsVhHP55+sN8Gcps1A8zDEt6
         upJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0d5ro9WEf/oR3l4wwSoA4Z9NMP/VWULfAk9YEGzrmSttdyr3Cx+LTqlFfNuoOl/uyYEfjC/GprqFs@lists.infradead.org
X-Gm-Message-State: AOJu0Yye1wp1xhLEypL/T/L1KvX1Y+eeZ/uTsi9inDSgOB2emWRFbiQE
	hIJf8np7LgsgCN2Xb9RFOKAUelGG+OsbflCuxV1dp/qVDjnQnMEiACMUSIFlnebh7333oDWZHHa
	Vr/PrvkigCKqpnXyZQN64n9NoP0S0mevr2rqFm+5OrA==
X-Gm-Gg: AR+sD10lftoHeMMARe0ik+ZEtfbseRhMX4V90JJOeBMg+3V/uaX3EannIf8gPb8IeMS
	pErsqVeLj2lTfX6+xEpIt+VRS0jDjv0+S8AKMjCVp+znoBjaT/F692Y/nXlQDRRHCCDdQnRj+O1
	W2xYEaN5A0Km0EYafTxzlUoJiz8glMbRskX3S3NnvrbnXuuIXONfc2YF1yEWdg4tdU/NeZzUkvx
	SygcliFm3GNGsTMlDg8X+s4zhXQND1Xpk8Ux+uXFew2G1N/C2CTyQ09nVxM7O05v8kEDkUlq6Kf
	5dmcddliaKjo611owbaYfetTa6X5LkHGc7AGv6Mmgh5/
X-Received: by 2002:a05:6870:610c:b0:448:8595:1e8b with SMTP id
 586e51a60fabf-458dd203cc6mr828125fac.4.1785428263717; Thu, 30 Jul 2026
 09:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com> <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
 <CGME20260730104131epcas5p4b52720519486f7ac774c317923a79c81@epcas5p4.samsung.com>
 <de4ec386-42ba-41c3-bcbe-1fe8b2f71ba9@gmail.com> <09134617-6d9e-4963-9319-1855e88a4df9@samsung.com>
In-Reply-To: <09134617-6d9e-4963-9319-1855e88a4df9@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 30 Jul 2026 09:17:31 -0700
X-Gm-Features: AUfX_mzVuCLkHKoQjKU1BgpL-X0Ty4OF1wEt1trnCKGouEKw-m3DZTMxHTHiuQw
Message-ID: <CADUfDZoVUHMWK0KBnznB73o6Vg+iQBBzJE2NmF1Tf22Zvh4=Yw@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_091745_315715_EBAA3DE7 
X-CRM114-Status: GOOD (  19.47  )
X-Mailman-Approved-At: Thu, 30 Jul 2026 22:07:00 -0700
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

On Thu, Jul 30, 2026 at 4:36=E2=80=AFAM Anuj Gupta/Anuj Gupta
<anuj20.g@samsung.com> wrote:
>
> On 7/30/2026 4:11 PM, Pavel Begunkov wrote:
> >>
> >> I wonder if it's possible to perform the PRP list page allocations and
> >> initialization in nvme_dma_buf_io_map() instead of the I/O path. The
> >> NVMe dma_pools are per-NUMA-node linked lists protected by spinlocks,
> >> making them significant CPU hotspots. If the dmabuf registration set
> >> up a contiguous DMA-coherent list of PRP entries for the pages of the
> >> registered buffer, any command using the dmabuf and requiring at most
> >> 1 PRP list page (i.e. length <=3D 2 MB) could just set its PRP list
> >> pointer to an offset into the dmabuf's PRP list.
> >
> > Possible to an extent, predecessor patches tried that, I left it for
> > later to keep the series simpler. I guess chaining won't work in
> > general case.
> > I mentioned this to Kanchan, Anuj and Nitesh before, they were up to
> > playing with nvme optimisations in general, and since sgl from Anuj
> > is ready, maybe they already have a prototype somewhere for that.
> >
>
> Right, I have prototyped the PRP list optimisation before. I will send
> it once the initial version of this series lands, to avoid adding new
> review churn while the rest of the series is pretty settled.

Sure, landing it subsequently makes sense. Glad to hear it's already
in the works.

Thanks,
Caleb

