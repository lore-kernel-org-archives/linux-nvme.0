Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F4CC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 09:47:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDF164F41
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 09:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDF164F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pMjOLNW4gcj1zu+pt4p5PZsJXesfWUjQXD/NvL9AJ3A=; b=BijReh0QdgRutMJQlFdtIska+
	0UMfYoDjsdTJxh+LWGv/xBO4oUXnkxQwl3AdCU3x08YtfsEJ1xI4Rly43a91P6HOG26vY7Yk3zmrI
	RtikgrkvNzLn0DjtOosvKy2KgSFbQSWjmBFuUwTgXyKoh8YdPEtBzqNapUJaqb+WIjkj5NoPCLMvd
	acm5JEL24BRGnhcGaYr0U9XC3dfyLm4D6Uhv46zjzHkNuqwOSU8uL0t634Q1I7qQ4MhS/uZFOVedD
	J9Dru6bEffwDrKR427JovOGVWlxfqEv04/ZL/rxyQ3A7ovTp2GR6TMwYvyhTteC13wfDIOhIplfXe
	3R8aHa+NA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMSm6-002t7W-0e; Wed, 17 Mar 2021 09:47:34 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMSlx-002t6R-BJ
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 09:47:28 +0000
Received: by mail-wr1-x429.google.com with SMTP id v11so1107615wro.7
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ksPBtaRRLjtGMMsiM5m7t08iKHFXjLxcYU+9j3JrgUs=;
 b=LnWVoByLjSvZGWRtXMrLiZGBvGAUC4ztfWiKfCY2mi+NOQWiQM5XJfkPc/NS7x9xiq
 cltXtFYSXQNopZrEaskgOLCiGcP+O4YFnKRN7bRVQqArC2XT1pohFOopjKAtuuOFYqHE
 J3b0p4IDNZhlPAHhrsogX6VC1pWAZaZK2NL+zWTFiCpcfKDYhY699BDdFkFJffuVk5iy
 JkTNn9fI5T3HL23+jGOvU01dp9QaXHRAUVD3qEaERtqLKvZbHD54e0DkthqGd/o2i6h0
 jVwafaMFaONU90j+obSrodut8unP3K4VkX2b+ZCaDjeTrJSWnxUk6ajrVyIku2S7XfM/
 GHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ksPBtaRRLjtGMMsiM5m7t08iKHFXjLxcYU+9j3JrgUs=;
 b=A5sMwwCHFFz/CLlJ8whFEr346fFAHuw3JhKw8bCe5Fkq5zlbVGSMwHGjSBHqI9JxdB
 2lVhMD1I2X1mEWud7xUo1e4Yaz17Va22bE+zGgk/ZVetBKKyZoyW6FEz0Rgx4Jhfc0HX
 CPszZTdZLEiEKTIlyKRYvezhINbSQlYQdTjN0r3c+zeHM6RjOWqX09UWxdsPMzg68Fbu
 IGdEKKd2keV61J0gdoxKKUG67XnbbAOmQCZftCyjbHrPPXLxVGgHwp5e5QGwmPcJa8qw
 hCxuT8Sm28NP2mN0vZaDqHgqWecH2TCw5M7FryzTMApSLRMBtr9djYUKpNhEGuRfr3Wt
 7K+g==
X-Gm-Message-State: AOAM531MLkWCSX6T2fd75TGSASd4RQXvQXUFqAcQhLfV+hd0GFTFKbb4
 vWHFqlUDMqohLjwsD70EnvIltVTcxv/uf1Taj2U=
X-Google-Smtp-Source: ABdhPJwg78zWt6gtWBnR7FzknaqrMzAP5euPOxlIHmFamu4wNc4wXiOrYIGDq6LWgGrHZ0UQUPPOAWSQgpfk3R0B4DY=
X-Received: by 2002:a5d:5906:: with SMTP id v6mr3490848wrd.137.1615974443934; 
 Wed, 17 Mar 2021 02:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210316170632.4161183-1-kbusch@kernel.org>
 <20210316170632.4161183-2-kbusch@kernel.org>
In-Reply-To: <20210316170632.4161183-2-kbusch@kernel.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 17 Mar 2021 15:16:59 +0530
Message-ID: <CA+1E3rKQ-275KmsUNC1d9XP1rK6uVHWKmptj7Hkb2BVeqZJqag@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use driver pdu command for passthrough
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_094726_842852_C9B08CE4 
X-CRM114-Status: GOOD (  18.16  )
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

On Tue, Mar 16, 2021 at 10:48 PM Keith Busch <kbusch@kernel.org> wrote:
>
> All nvme transport drivers preallocate an nvme command for each request.
> Use that for passthrough commands instead of the stack allocated
> command. All transports must initialize the generic nvme_request's 'cmd'
> to point to the transport specific preallocated command, and modify
> nvme_setup_cmd() to initialize the driver pdu's nvme_command.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c   | 19 ++++++-------------
>  drivers/nvme/host/fc.c     |  5 ++---
>  drivers/nvme/host/nvme.h   |  3 +--
>  drivers/nvme/host/pci.c    |  3 ++-
>  drivers/nvme/host/rdma.c   |  5 +++--
>  drivers/nvme/host/tcp.c    |  5 ++++-
>  drivers/nvme/target/loop.c |  4 +++-
>  7 files changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 512e5578c6e4..eb71ef1648a0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -575,6 +575,9 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
>
>  static inline void nvme_clear_nvme_request(struct request *req)
>  {
> +       struct nvme_command *cmd = nvme_req(req)->cmd;
> +
> +       memset(cmd, 0, sizeof(*cmd));
>         nvme_req(req)->retries = 0;
>         nvme_req(req)->flags = 0;
>         req->rq_flags |= RQF_DONTPREP;
> @@ -595,7 +598,7 @@ static inline void nvme_init_request(struct request *req,
>
>         req->cmd_flags |= REQ_FAILFAST_DRIVER;
>         nvme_clear_nvme_request(req);
> -       nvme_req(req)->cmd = cmd;
> +       memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
>  }
I am wondering if this memcpy() is fine. The "nvme_req(req)->cmd" is a
pointer which may not have storage assigned to it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
