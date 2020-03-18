Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33498C5ACD7
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 15:33:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0992620724
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 15:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IoNgXA7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0992620724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uHWf7doH9pvBNqud7G3hLw6G+S7GIEXJqntLRvnD9R8=; b=IoNgXA7p1Ik553
	HJ8nhtFGYqLsuewYIsy0dSDKhgxp59ZzfGC/wD8zqH0R4Se6EhuBDdeLKfQvP0eQhN1pcrBb5DRta
	014X7o0zAXKXjKtabWe97RpJQ/BYiJF825RQkinuioLix948yts8sMu7KHj3UUDAJmDi2R5ItqpvV
	7FAbPZL/DsuogvfAxywIKm0yXMtIJGZDtlwaZFas8YeXuK6zgpa+G7gM0OsdeBRINN8S2qiieLrKt
	k1pqS4KE9vFrxMcutFApdF/bVpVbrUSckuC6dCGcfihV97Mh7KHVsKTEr/2PATc+Hh3S2hs3Tec6X
	PQxySGP4YtVBTyS6JMLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEahZ-0006f8-Lw; Wed, 18 Mar 2020 15:33:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEahW-0006ej-DO
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 15:33:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DB64D68C65; Wed, 18 Mar 2020 16:33:41 +0100 (CET)
Date: Wed, 18 Mar 2020 16:33:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/1] nvme: release ida resources
Message-ID: <20200318153341.GA14201@lst.de>
References: <20200318152759.199450-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200318152759.199450-1-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_083346_603041_C13FD394 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: kbusch@kernel.org, shlomin@mellanox.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 18, 2020 at 05:27:59PM +0200, Max Gurtovoy wrote:
> ida instances allocate some internal memory in addition to the base
> 'struct ida'. Use ida_destroy() to release that memory at module_exit().
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/nvme/host/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a4d8c90..31bbf40 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4299,6 +4299,7 @@ static void __exit nvme_core_exit(void)
>  	destroy_workqueue(nvme_delete_wq);
>  	destroy_workqueue(nvme_reset_wq);
>  	destroy_workqueue(nvme_wq);
> +	ida_destroy(&nvme_instance_ida);

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
