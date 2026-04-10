Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62958F45A12
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 22:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jLwMpFotmNz9qSI+dw+StTfkgSeaXjf1JHydsM6F8ys=; b=zRRTj9sLud+CH4llIANQS89GT8
	N9tqkX5hUQI9jjDoc34RKZey8nVYDYEnAN7cq+23JOnfSzZb/yAO44+0VE72rboDTg2JvU3f8Me6Y
	9aj4t6rOR1VHslpwKEko1LCpqfnjfY+nbEhS79/KvRDwV8hMciQVTGAjYquk2QLPenKigT0mc2fu4
	e+FqZMGbkcLBv2mOUe7TW2vMptXrZDYhXJ9dVV19tmEgFMUnHlUZ8JQPnP0FSkWyzFqXoSP4mDYRv
	KLqeEIffsjcBPnQTY9Dq9Tv3VftWDxvQgcvNocNlWqNzUKWV+a1AV2WhPjWI0eDWLsJLCCiSFb/8t
	kRxCetAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBKVm-0000000CtMG-355N;
	Fri, 10 Apr 2026 22:39:38 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBKVk-0000000CtLo-0FVp
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 22:39:37 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-79a60975dc5so29376647b3.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Apr 2026 15:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775860774; cv=none;
        d=google.com; s=arc-20240605;
        b=I+jybzmxeBoRoI/yaWlHkM79W5Sjmqb1e6TaBgMwz0g/cuMONtE6H3qQAAe0ONuzJq
         PMntZc94ToOkcYiX6jU9ExvaEk42BBpygnQImgyzpGME+lpgc+13fEqgiq7pL9eVlqzk
         ZBt1D77Il2V7wrAhoH+l3YOqzXWy7HZcr5N4Bkg5FEofKsDpFWoX2O9YlSEfi8KQF0O9
         W7YVpI8NmNDHcd03JhOy0js0cW+LMveWvJfiqiZzoVKXb5hTZuHR9gqXQf1jXll2qzW5
         TDWIbpp0Dq+CyqNonHJ8rObitfXI8ddOOWZFevE2x+RwcNzmfoLJmTIKP1NrJ+BpB0UQ
         8DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLwMpFotmNz9qSI+dw+StTfkgSeaXjf1JHydsM6F8ys=;
        fh=8pgtm7/YrQoilv7dmsi4rBrFdcN+aD3TWfnBF5ccpec=;
        b=FjZmkylAHE1NMr5i5XJlzWEl88sCqhAqCxe0Hr7hUESUgVW1tLpZQLffO1dX17wle/
         eEgziAUfTAwQpaiN3MgsV8rHi/Pc4jPzgPUY1NQP6JKfbBM4Yzl5QZjrNVNjLWvS6eFe
         BVJKcavJhc16sMeYh3miMsdf5ngybPfYyYejeae8VMeoCZPYI7OdAuau/rlixyqQe9GT
         sRpTpaeG6Ugqr4WEfULD9tITQRwPG4cbCNrG3LLQPmydAn0t5a2T3TLS2PnxMRDAERTF
         58D9JV8GfB0UiRLq8i25uKFUBh7ijOWdR+GYtMotBdtnEdsDi+Ny16uJkY3zn4gkg9an
         JMlA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1775860774; x=1776465574; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLwMpFotmNz9qSI+dw+StTfkgSeaXjf1JHydsM6F8ys=;
        b=4KxuWtmELLUAS1eKeGJkZc/V6xLNGHx7dljhtPQ7FjElcW30biHTRWtCO4Zn29VU1W
         mtK6GiMm45VY8uF0MCFhyOwA2uRDwj88axQKDCixtpFCw9djzY7PDYThmJV86Fe4EMzV
         1oH54Sh6J1RMYvI64NHJuDINeWhD5bGT+59vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860774; x=1776465574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLwMpFotmNz9qSI+dw+StTfkgSeaXjf1JHydsM6F8ys=;
        b=BnY0vMAsB61nF768G3limTJOPFRbb4kHtbQOu7MWZzzg+6bSmJTBVdlLO8CmVVO5m1
         xoiOz/rMpIB6GRxDbnYAQJOi5UPi1G0F7SSxsHSpEQxKD4CXOgXEYnsSkUe0iRMglKh6
         zVs+JDG2ls+go18AdE8QMXIfWlqd4qYt/aTZ4271S1izQnBIdLSd945R83yzXbszj6Iw
         HO4yumlfyqRgAoKs2P4NbYZj4HkjSbh97+BH2aDBzx6UwOOBrBEKMIpNvsbA9BNvonFu
         IjoKE+Id7SCPfXq/Ndl+LklxIk1DBBdzIdj2BpQOcWkjjsQmkQDJcJskUnG0UkNCoM3q
         xdcg==
X-Gm-Message-State: AOJu0YxpobLtteWyHW2AHTIQfofwwUHePSqr48K02gURGdyOlJ/5FRRC
	zJEKbboVg2d+75qD1WtzZ2ACwMIl/uueo9yZV2vjgMdFVehEXrlHqNUDM+fFYcTidXcZpQKCzQy
	YVWvOhkpPjrxtce49gQOzCmKCvCHx3niHW4pAXlpee7yZ0SOv92FbPkBm8+vb
X-Gm-Gg: AeBDietiqkGseaYKCWEMDyYX3S+U5OWrQCa3F4o0bNLtp2v6viX/xhBJkCtQFO0jf8I
	osZrBCr/Bf9sMQm1U1d61wo2uaA8jPahxZcA6doN/Oxa9P7C8zpHOUiuX++XEorbnzI9I4+wODS
	w9D6t6D+PDHwacIutAgPfcNUhaZa18iv3rgigzEgUXcglcUIPYo6YZ7k4r/rK4VvC6B8m/BkKhT
	0WuBKgIUiPf6g1hHwyq98XOpzILOeCfe0UFcNNg4rs2JAm5tvdbVU2cj0ldfi9mPpHzRr7vV3C8
	LrGVd2PA
X-Received: by 2002:a05:690c:6612:b0:79a:5164:bb2b with SMTP id
 00721157ae682-7af6f327722mr51252397b3.7.1775860774045; Fri, 10 Apr 2026
 15:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+w=M=SEUeGvXaK6OqdDVjYrbagnzDgAMgCRHbRqoYvS+OgW=w@mail.gmail.com>
 <c773c37c-b4ce-4f3f-927f-0be8a9b2d7a5@arm.com> <CA+w=M=SmUFUCfS6kGvRh3A4Vq++gSwhuPK7gn-ebWnM6BkpiZQ@mail.gmail.com>
 <CA+w=M=THPjp9JwDPe_XpLcEpLTLakCf8OiybSbLwOPxjmAHy0w@mail.gmail.com>
In-Reply-To: <CA+w=M=THPjp9JwDPe_XpLcEpLTLakCf8OiybSbLwOPxjmAHy0w@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 10 Apr 2026 15:39:17 -0700
X-Gm-Features: AQROBzAheFmuUjqq6dqy8RnxTIRftTFHZJAZ9Du3u4CTLlxXL3_Uubzg8grCZ_E
Message-ID: <CA+w=M=TKSo-vDuOfMEZv=SGfaOMZ91XPgG5rJadWbzXtReyM3w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix swapped arguments in SGL DMA unmap path
To: linux-nvme@lists.infradead.org
Cc: linux-iommu@vger.kernel.org, iommu@lists.linux.dev, jroedel@suse.de, 
	Robin Murphy <robin.murphy@arm.com>, will@kernel.org, Nagi Parimi <nparimi@uber.com>, 
	Kshitij Doshi <kshitijd@uber.com>, Jeff Bean <bean@uber.com>, Vikrant Soman <vsoman@uber.com>, kbusch@kernel.org, 
	xboe@kernel.dk, hch@lst.de, sagi@grimberg.me, leon@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_153936_103567_A681878D 
X-CRM114-Status: GOOD (  22.20  )
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

On Fri, Apr 10, 2026 at 3:29=E2=80=AFPM Alireza Haghdoost <haghdoost@uber.c=
om> wrote:
>
> The arguments to nvme_free_sgls() in nvme_unmap_data() are swapped for
> the multi-entry SGL case. The first argument (sge) should be the
> segment descriptor from the NVMe command's data pointer (type
> NVME_SGL_FMT_LAST_SEG_DESC), and the second argument (sg_list) should
> be the pool-allocated array of data descriptors.
>
> With the arguments swapped, sge points to the first data descriptor
> (type NVME_SGL_FMT_DATA_DESC). nvme_free_sgls() sees a data descriptor,
> unmaps only that single entry, and returns -- leaking the DMA mappings
> for all subsequent segments.
>
> This manifests as unbounded iommu_iova slab growth on ARM64 systems
> with 64K pages and IOMMU DMA translation, where IOVA coalescing is
> disabled due to the NVMe 4K page / IOMMU 64K page granularity
> mismatch. On x86 and ARM64 with 4K pages, IOVA coalescing handles
> the unmap via dma_iova_destroy() and the buggy path is never reached.
>
> Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_ma=
p")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 28f638413e122..728999e4247d8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -761,8 +761,8 @@ static void nvme_unmap_data(struct request *req)
>
>         if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_l=
en)) {
>                 if (nvme_pci_cmd_use_sgl(&iod->cmd))
> -                       nvme_free_sgls(req, iod->descriptors[0],
> -                                      &iod->cmd.common.dptr.sgl);
> +                       nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
> +                                      iod->descriptors[0]);
>                 else
>                         nvme_free_prps(req);
>         }
> --
> 2.39.5

Apologies, I wasn't aware Roger Pau Monne already submitted this fix
(commit a54afbc8a2138 "nvme-pci: DMA unmap the correct regions in
nvme_free_sgls"), which is already in 6.19.y. Please disregard this
patch.

For the record, we independently confirmed the bug on production ARM64
hosts (64K pages, IOMMU DMA-FQ) where it caused ~490 GiB of leaked
iommu_iova slab over 42 days. Setting sgl_threshold=3D0 stopped the leak
immediately.

Alireza

