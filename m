Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99607C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 18:41:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E326161C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 18:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E326161C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hLKNOWr5zKuzhEvzwxVvDJMoi8LLXTDRgtu1cmG4poc=; b=jSBE8gCSp/zjIf
	X4KTvNNcjHlO5xZ3GfS0+1nYSK7IQOx749VNrk6YjYLpC4RMBDN8aGHwEiMLQI0lEdTYGVgDbaml0
	pMJLGBqiC4mDgGAQiJfIZn2nNgrUhSsgh4GUqCTdvob6Ewua4/JABn2r8BIRYlUcJL/1m5OlGUekk
	CLNnZfVhxKNIPYCLWsnPP1yXopwriCmiboBNFbVIXBUNMpZDgWQjB9aTtg4I6R6QSfmZhX6pA/4PX
	cWdVNj6My4kBqLtTvShX+DdcyLNMy9snSz2oA/cy8YjZPWsVUwhHroGkeK7CYqPmn5XjxRh4xgt3j
	gXulrGzLA3dLKCxwVYFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqgfU-00A3QS-Nu; Tue, 08 Jun 2021 18:41:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqgfS-00A3PN-6A
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 18:41:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E6E36140B;
 Tue,  8 Jun 2021 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623177697;
 bh=vBZtNDAV6Pb1mGKiFeM02JZvOiGN62Dyrgtle+9RadY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mnJcNNz3CtTgB4+VJCviUBirK7XtojBKjAZ/FMDOh4h/y34q8fK2PcoAwAYyKBnHU
 zsLcwNplDQx0tC/FeKRCq72d/v2Cy4u2+CE4dU9GxvF163fLxhR+r+w9MapfIkwXzY
 5fU+QiLTxjrVBdLD7AprFtfn7c8obE+ZYfgmtYHXoX2zKV+JBMFHkEY7gNeGL2PTCp
 uD14VHgjDHnN2cOebAn2UUM9afOmOjcUtP304PBSLEUqqAW9A928gQID9P41eKb/IG
 V6VQQTnU1fPZjENAdU0l+T7QpS/r/AGiQdxupiYxz1iWz2Otq0mEFwTFcyxpW7tHvT
 d8YYi0OotqM+Q==
Date: Tue, 8 Jun 2021 11:41:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Michal Kalderon <mkalderon@marvell.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shai Malin <smalin@marvell.com>, Ariel Elior <aelior@marvell.com>
Subject: Re: BUG: scheduling while atomic when nvmet_rdma_queue_response
 fails in posting a request
Message-ID: <20210608184134.GA339600@dhcp-10-100-145-180.wdc.com>
References: <CH0PR18MB4129247C2B9AE092E3C59740A1209@CH0PR18MB4129.namprd18.prod.outlook.com>
 <e059fc90-81e7-dbe8-86f4-87b4bdbd5bb0@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e059fc90-81e7-dbe8-86f4-87b4bdbd5bb0@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_114138_270548_84F64ABE 
X-CRM114-Status: GOOD (  15.79  )
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

On Tue, Jun 08, 2021 at 10:43:45AM -0700, Sagi Grimberg wrote:
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 7d607f435e36..6d2eea322779 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -16,6 +16,7 @@
>  #include <linux/wait.h>
>  #include <linux/inet.h>
>  #include <asm/unaligned.h>
> +#include <linux/async.h>
> 
>  #include <rdma/ib_verbs.h>
>  #include <rdma/rdma_cm.h>
> @@ -712,6 +713,12 @@ static void nvmet_rdma_send_done(struct ib_cq *cq,
> struct ib_wc *wc)
>         }
>  }
> 
> +static void nvmet_rdma_async_release_rsp(void *data, async_cookie_t cookie)
> +{
> +       struct nvmet_rdma_rsp *rsp = data;
> +       nvmet_rdma_release_rsp(rsp);
> +}
> +
>  static void nvmet_rdma_queue_response(struct nvmet_req *req)
>  {
>         struct nvmet_rdma_rsp *rsp =
> @@ -745,7 +752,12 @@ static void nvmet_rdma_queue_response(struct nvmet_req
> *req)
> 
>         if (unlikely(ib_post_send(cm_id->qp, first_wr, NULL))) {
>                 pr_err("sending cmd response failed\n");
> -               nvmet_rdma_release_rsp(rsp);
> +               /*
> +                * We might be in atomic context, hence release
> +                * the rsp in async context in case we need to
> +                * process the wr_wait_list.
> +                */
> +               async_schedule(nvmet_rdma_async_release_rsp, rsp);
>         }
>  }

Just FYI, async_schedule() has conditions where it may execute your
callback synchronously. Your suggestion is probably fine for testing,
but it sounds like you require something that can guarantee a non-atomic
context for nvmet_rdma_release_rsp().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
