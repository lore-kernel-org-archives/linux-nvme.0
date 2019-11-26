Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788C1C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:15:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2B02071A
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 16:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dwpV0ilD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIuZXrxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2B02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IAc0HHa0j/EIFEg6HLK+LAwN63+kjCc/ln+5HIkuOs4=; b=dwpV0ilDk+7FNF
	Yl8+eglu0ZOhmUMi5cPLuKLBrqIZcHzTZulKjCDk3qD5Au3/h0CeZVsARRc4tI1Lr60QafLpSPrT2
	ZszRfZz6f/ERd3HoJLpu04OvvTBQMvdLxkqByqfVMCQLxsCWxc6PqjZ4wdw+CF2rpaXAeeqWqipV+
	tB6BZBjnhLNKWKoeuu9wT19ndpoP8FgP+66WEEjtTPU7S3dRuZD5jbn0EBEDebwtUvf2po4ifMAYI
	zjXozRO1ajjretCu7oIH75KO2DZAVMhyYVfVD4cAdLJS3yDHK2vn8FzIKtU08ybo16IXddeuDIqqe
	ZZDCnlo/cT2C9g3m/C8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZdV4-00074Y-4M; Tue, 26 Nov 2019 16:15:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZdV1-000748-Ih
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 16:15:36 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF9822071A;
 Tue, 26 Nov 2019 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574784935;
 bh=1Ll5ZrXDkVgc+LqbRTOlP1MUJTd8umuMwfs8oxInpCU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TIuZXrxxAcVLzzqmT6go4BfhkM4XYSIJaRGkLYaRB7YxiDijkt/sGfGP2H9uN77Uh
 gP5HsvY+8glML3AZEa4BLoJgynWlJh8UDnE1FHbrjgXS6pE+aQS5D8h8L7sVcZdrq6
 ivWEN7F56EwZdfrAJZ9r9FmeWJaQB9JCveWi5htI=
Date: Wed, 27 Nov 2019 01:15:32 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: always treat DNR status as no-retryable
Message-ID: <20191126161532.GB2906@redsun51.ssa.fujisawa.hgst.com>
References: <20191126133749.72267-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191126133749.72267-1-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_081535_643229_2EBB9788 
X-CRM114-Status: GOOD (  17.11  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 26, 2019 at 02:37:49PM +0100, Hannes Reinecke wrote:
> If the DNR bit is set in the command status we should not retry
> the command, irrespective of what the actual status is.
> So map it directly to BLK_STS_TARGET to inform upper layers to
> not retry the command, not even on another path.

Why can't a DNR error be path specific, like if I detach a namespace
from one of the controllers?
 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 752a40daf2b3..f015f6e91c85 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -198,6 +198,9 @@ static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
>  
>  static blk_status_t nvme_error_status(u16 status)
>  {
> +	if (status & NVME_SC_DNR)
> +		return BLK_STS_TARGET;
> +
>  	switch (status & 0x7ff) {
>  	case NVME_SC_SUCCESS:
>  		return BLK_STS_OK;
> -- 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
