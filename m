Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA6C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 03:43:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA16820721
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 03:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ulz9VNrW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTNbrma4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA16820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DFnd4BeBXwW0heNEjiF3CxCupzDNI2UsaxehMrBqykY=; b=ulz9VNrWiiz3dl
	GSMdynsqAFJrJFoEsoupySxTxpOiRIaxWPcM33wVw4UgEhAPLJo6+9jdukdcrGqo8vbjyaG0NMHob
	2ec+beS1IUdfavxfNn48D7ngV+e12unA9cNkcfC/VHRcC4RbTWxyJp3aKOwQZbYbV8hsyvJP9MT0j
	O8t35m0IVnIwSp6zsTUFBqcPvlyWcD+YIrfM9qRY0xYe58UReX6IbwqMsH3Qc2ryqjcX/wR30qGzy
	VZpGm/SLh0Yv+PB1dpNSsXV6Qo6KwfaYn0/Rgpc20DPCUTFGlktax4+fRIsVyZlZeAMs/W57mwukL
	eQUGc0pl4zMhnA732+Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeVvR-0001vF-Uj; Fri, 29 May 2020 03:43:17 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeVvO-0001uU-Mh
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 03:43:15 +0000
Received: by mail-wm1-x344.google.com with SMTP id u13so1610329wml.1
 for <linux-nvme@lists.infradead.org>; Thu, 28 May 2020 20:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zVd4Mrs1U/5A2IfnCC8X5EEtHjPOE7HxiGZ1sl3wvYI=;
 b=NTNbrma41jWb9ZxdhkCC2cNhYh29W7WYsx5CnIfy0X82s6PEJc8ev12p2Ui0F74tM+
 QSrhatHaEmpCZJ8uosoqWhazybAtGUSJeecjXouuf3HMo51gyCz4R0EmHGOxTkw6mJLu
 InFoAWgn+5/tj+jtgBOLJFSC6coaxNgy9FpcoHHf3LIUYPj0mxwUx54V4MoBk68p08bb
 U+PIMfIJZ9Z2xA7OUzD+wVcGXWKaPjb0p9hle6wZ9CtK7VNi3eGbw3iBgPOoyS/tYRZ7
 iXtlRaZMYiw0TK4aOcWSC1alWil8zbK/CjgBrQO9cwl6CRCFop/w4+YgO6Zv9hJ+w4Hr
 /41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zVd4Mrs1U/5A2IfnCC8X5EEtHjPOE7HxiGZ1sl3wvYI=;
 b=hm2c0pExx4QrJ711wvI8QenkRX5VESqlOC1QH68zQiFBGrBnLmQm0s6RXcwVIAlxQw
 ueQF0su/KPDHMxm0eXzlfOOTqKC0uNrb4gnAT9Xv7QfyGvSEFk9M23HTuc3sIM5kUsu0
 hHetPRmjzwZryz27CGjx9QjNse/hfrO9d5ekDLKh/dLR2pc186kP2ZVXlCIvwG3bZwT/
 bDQyI3q3qb7eIVRJZO9787/cIGDyAZwfY/g22RPuZpmqZuoW2FYe8ZAUzyboy2yOUkSh
 /6++nF7ZtAsp5Q2ynjOHVF41Uf5/zocTvwN+lcBQFlq9qr/q74XKS6frCYyoJlvJtIEq
 UsQA==
X-Gm-Message-State: AOAM5307w9SoXHJDvDRH3CUErxRBaqau5/pMsHNYrJRRZWkMCDKj/nKz
 klCe0opZ29WtxPq9334ugZaytlq/DOtuGo11SIM=
X-Google-Smtp-Source: ABdhPJxHB+sKYUh9DfAl0ytD3Fg6TyhqqVHefR8XB+OU7FR6SA4N5F73MJUDnCyS4z2o6nxZSW/e3697tJHqe40OWrg=
X-Received: by 2002:a1c:6243:: with SMTP id w64mr6251862wmb.162.1590723792990; 
 Thu, 28 May 2020 20:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
In-Reply-To: <20200528153441.3501777-2-kbusch@kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 29 May 2020 11:43:02 +0800
Message-ID: <CACVXFVNTMeyM7RrBuirSUXPZvDT3QvdoxDJBc4RYBuUdX2kJYQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_204314_741322_9E4B033F 
X-CRM114-Status: GOOD (  14.09  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 28, 2020 at 11:35 PM Keith Busch <kbusch@kernel.org> wrote:
>
> Once the driver decides to cancel requests, the concept of those
> requests timing out ceases to exist. Use __blk_mq_complete_request() to
> bypass fake timeout error injection so that request reclaim may
> proceed.
>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba860efd250d..f65a0b6cd988 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>                 return true;
>
>         nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> -       blk_mq_complete_request(req);
> +       __blk_mq_complete_request(req);
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(nvme_cancel_request);

Looks reaonable,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
