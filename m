Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8CFC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:28:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C407B61580
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C407B61580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qfDpsAXNX/kxsMsEW0RkDWpe51LnozMcsOJsQuyYszk=; b=nMUShhsOpWt9nlrhGnlZLNZzx
	xb6bKUhwG36dbU96FORKWS/IwyTM5970o6v7pxiYqgljaAFxVkBtYAbwrb9ClEkL90fhJKFEyl/JO
	kBbVOfRsKuYR2+xtfkUsht/nfKUx1SLkDIYyahuot6vYCSuSA5jVvcoBYo+GEi/d4BYl7+GRiMtFt
	PDq9VmRk3vA6QcSM5DdoWtElu4NmdYNVaJ37k9DiA/CGqwoLuDYnn9ijdsRMyCpCTUZgMaZ4mBVQL
	MK1MF6srQCEN13Gtejng1lBlZf1sSMR9UPBjAlgQzYkyRbhJu/LHOCRwjLX0cAdLuAgq5iSUr2sgT
	jJ5WhHTgg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlCf-004WdM-AS; Thu, 18 Mar 2021 05:28:13 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlCY-004WcW-T2
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 05:28:10 +0000
Received: by mail-wr1-x434.google.com with SMTP id k8so4130027wrc.3
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rfx+TchQAmKI6FsJkuxScKmEX+0zqfYSOjwSIEbxyH0=;
 b=mkluLKXAAsBCsl0mWPxxtIYUbFTNQK2ody1+IiBTEqRJwE8yI6s3G7xLe2/9KtnRzj
 s+S0IumTC3VYHEvuOroigQhUG4w3BHUxapXGhVhONx54WinXdkNYjvJUz9OWCXG/NZ9s
 Fxpn4W60J6MWKOddru69M3vo/jyA7mDvUONTCqkMOkhC3DdOwU6//2pC76nlI7gZCO61
 W+rUGRg9nsxWiOnZelYKmE+N4wnCX5pCTtpLeqR0ac7dS2jgzNdAVqWTLYViu6FZhvJV
 IcavfBZOKhbq87DBYwzUiTw/y1TJgLt+z7Nr78p59lFWb7PmnBvqJqEOW7xdJckA2flo
 OIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rfx+TchQAmKI6FsJkuxScKmEX+0zqfYSOjwSIEbxyH0=;
 b=UVK+G7U/f78K/JAXVReHwuhkILf+j6gtg4d730dsdznKM72ic5XBC2SGlGrV5g1SMZ
 XAnUWjSQX+WQga3qFDv00BoUxUIJRkNGWoUq2+z8tEil1tmj2VyCZ+hU+bV2ohztVe6u
 X6VRfzHkiM2rRFG0wBLQ2595wJmCXNhTVTX/Y5012sRBRUlogXZBgYCTRmkf+MjgCnck
 ZhwPIW7MDvEU5vVQG1nAgeRoyP+9Q0YGvvAms4+YXboT6VO+D/4VP6jMtNI156RYG9zy
 QuzREm/DRAOSGtXWTNY7l5UdZvNxXWzEi/D9/eQYnfL1V+kNj+QTRKHJHJxGRAP+F2cu
 mUcA==
X-Gm-Message-State: AOAM531o3QiV+4qQ05jTu5d2eZBGg3BXh7GwPc8TvKfOA8W3OGoKi9y/
 836C41BMWHND3nWdMZHXXGa9iDw7qEWTjv1WOlebT5Q4iqs=
X-Google-Smtp-Source: ABdhPJxWIGF1N2Sd/4pWO866zVddFJ+Hqceiki+UEQbGp6ua8pcbLwAvKncozCoPDa/getqV1n3tDqRf8rflh/e47vs=
X-Received: by 2002:a05:6000:2c8:: with SMTP id
 o8mr7690771wry.407.1616045283436; 
 Wed, 17 Mar 2021 22:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210317203703.17391-1-kbusch@kernel.org>
 <20210317203703.17391-2-kbusch@kernel.org>
In-Reply-To: <20210317203703.17391-2-kbusch@kernel.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 18 Mar 2021 10:57:36 +0530
Message-ID: <CA+1E3rLNEUhUy1FkcPedo_DohjhGKZ=U+4M4J8W3pY1m7nwb6w@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] nvme-pci: allocate nvme_command within driver pdu
To: Keith Busch <kbusch@kernel.org>
Cc: KANCHAN JOSHI <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_052808_993543_6AA986C2 
X-CRM114-Status: GOOD (  21.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 18, 2021 at 2:32 AM Keith Busch <kbusch@kernel.org> wrote:
>
> Except for pci, all the nvme transport drivers allocate a command within
> the driver's pdu. Align pci with everyone else by allocating the nvme
> command within pci's pdu and replace the .queue_rq() stack variable with
> this.
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ecd11b1febf8..1a0912146c74 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -224,6 +224,7 @@ struct nvme_queue {
>   */
>  struct nvme_iod {
>         struct nvme_request req;
> +       struct nvme_command cmd;
>         struct nvme_queue *nvmeq;
>         bool use_sgl;
>         int aborted;
> @@ -917,7 +918,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>         struct nvme_dev *dev = nvmeq->dev;
>         struct request *req = bd->rq;
>         struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -       struct nvme_command cmnd;
> +       struct nvme_command *cmnd = &iod->cmd;
>         blk_status_t ret;
>
>         iod->aborted = 0;
> @@ -931,24 +932,24 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>         if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
>                 return BLK_STS_IOERR;
>
> -       ret = nvme_setup_cmd(ns, req, &cmnd);
> +       ret = nvme_setup_cmd(ns, req, cmnd);
>         if (ret)
>                 return ret;
>
>         if (blk_rq_nr_phys_segments(req)) {
> -               ret = nvme_map_data(dev, req, &cmnd);
> +               ret = nvme_map_data(dev, req, cmnd);
>                 if (ret)
>                         goto out_free_cmd;
>         }
>
>         if (blk_integrity_rq(req)) {
> -               ret = nvme_map_metadata(dev, req, &cmnd);
> +               ret = nvme_map_metadata(dev, req, cmnd);
>                 if (ret)
>                         goto out_unmap_data;
>         }
>
>         blk_mq_start_request(req);
> -       nvme_submit_cmd(nvmeq, &cmnd, bd->last);
> +       nvme_submit_cmd(nvmeq, cmnd, bd->last);
>         return BLK_STS_OK;
>  out_unmap_data:
>         nvme_unmap_data(dev, req);
> --
> 2.25.4
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

LGTM.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


--
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
