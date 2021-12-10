Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E17C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MPOjOUfa8fvSDb0z4W4iRNFcmDQDHhlkp7C0GIwanU=; b=E/XhWO4/xErFhA+39qyXN8ZG/W
	0ytVdBSxE7/Ver5rxropYNHRMD5zh+z04c1+95h7RtLIZrGv4rxKVd/vxKCujxtLJV0FCvVxNRR+z
	aZ+aeUkgShmf8axGx1hBhCDVql8+ObSRFbuhZ4nXm1DFUNptkADlUrhi/8dFD45j1l45gIp1LboPe
	dt7DT0gAsFAu1T9A/i1EPl2W+Z/MjrQ6F7Ot6aIpTUuhKAgDKGF8a/t+N1+XbIcOhICYB9Aenx6ra
	cCv4BniBbDBJnWo6jswNMZtr2CHM9tTOSDZ7xnJ2ugyYylwhZ3kTrvkCaKevD2Ic07iwLeL2eMHPf
	FLjHt03A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvi3Y-002U7O-Sc; Fri, 10 Dec 2021 15:43:32 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvi3W-002U6V-8n
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 15:43:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5FBABB82867;
 Fri, 10 Dec 2021 15:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B528DC00446;
 Fri, 10 Dec 2021 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639151007;
 bh=pi/RiwUuzXnDEpL4zTwcTZYm07EP6T/oa75U+iKae18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L/i5JFMxtkzGaHRdx4oy1DF3f+oYZgYaFFLxet8ujmLqv2FdL4CmYr3a8q5vAexSI
 oiidU3KmpuMuBEmvvOra7UIqrhAESGE0YZJVOyMVD9v1+CkMx0oUvZpOP2zcruhIq8
 T6X5fJ+bKx5OtewOM9xjBk8vZOQXfdzQB1e6ilPnBzEkoxTdjcP4hMtTXQh1vsBiry
 EfqijmSitCDRAn66ATCv+WJzAse7THWQHQsAvuTBN1qXF94XUJcj2aiPQtQ77CEgkS
 Y76ZJi89oIQbEgNSbHhMBL8uWn7bB09B/u7M0br1asppRV71R0/FcITJMbzpRiG36r
 zxbDK26ddOGkA==
Date: Fri, 10 Dec 2021 07:43:24 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/3] nvme-core: move gencounter check into nvme_cid()
Message-ID: <20211210154324.GA3856533@dhcp-10-100-145-180.wdc.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-3-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210112116.9299-3-chaitanyak@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_074330_497473_7608C9D2 
X-CRM114-Status: GOOD (  12.67  )
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

On Fri, Dec 10, 2021 at 03:21:15AM -0800, Chaitanya Kulkarni wrote:
> -	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
> -		nvme_req(req)->genctr++;
>  	cmd->common.command_id = nvme_cid(req);
>  	trace_nvme_setup_cmd(req, cmd);
>  	return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 98d7627cfdce..2be0191e1a1f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -511,6 +511,8 @@ struct nvme_ctrl_ops {
>  
>  static inline u16 nvme_cid(struct request *rq)
>  {
> +	if (!(nvme_req(rq)->ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
> +		nvme_req(rq)->genctr++;
>  	return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
>  }

No, this will incrememnt the counter every time someone queries the
command id for this request, which happens in multiple places. The
counter can't be modified for the lifetime of the request.

