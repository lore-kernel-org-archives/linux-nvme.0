Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83507C432C3
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 17:40:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500382075C
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 17:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sNIB+YPb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYMz2kk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500382075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2KS0okrsltzl2ltM0MDfqZKtFe1IDb35o4fby5DNpik=; b=sNIB+YPb3/zHXH
	D3yq7yQi4FN3eweGV5aJdCeU+qgA9/qCn4xsVFVbSmUnTmb8yS5dlhC2E1xiOd86kxR3g9NQnBkt5
	UT+s3dwUzO6t/ZKGSi3G9lTiufMk0EuiV9piuCQh4N8ns8+dKAAILkC9R9tSJWKeJMJ56ALlFt7FU
	If7K4kTrPF59DxHzisujZPN+ciqwOBMs5+N4pcGjSmlQLwnrPpWXpNGjZheUYH+pXIGaF/7xLp5qY
	YT5msFI3SK5Fo8s1LR9kkN7GGrrnBXFzWuL4JB84NsMasTdOLd8HPXkpPIRSLKtSwuCmFhl3uKyqR
	3Vtb4IywS+TcO6b7Gorg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZepb-0000Wu-F4; Tue, 26 Nov 2019 17:40:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZepZ-0000WU-4F
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 17:40:54 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C7E342073F;
 Tue, 26 Nov 2019 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574790052;
 bh=DnNCAJBHkaxQHcPPpJafXsK255vrL4rheTpa754mmWI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DYMz2kk/bKgrz8ydDXmUxC7L1xJciAar2T2Xe7DzFz3aMYCOwWcIFEH135a7ZsvJu
 o+8hL1N7RAjrj9SQtw+RDhwsVfAzll1qY/8tIUkCjREx5p2cSetLNmZyZEhMxDD0Hv
 yrYX8aDlQrukZuModzBa6x8Dp6nFHeovqZDYABWk=
Date: Wed, 27 Nov 2019 02:40:49 +0900
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH 3/3] nvmet-loop: Avoid preallocating big SGL for data
Message-ID: <20191126174049.GF2906@redsun51.ssa.fujisawa.hgst.com>
References: <1574613512-5943-1-git-send-email-israelr@mellanox.com>
 <1574613512-5943-4-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1574613512-5943-4-git-send-email-israelr@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_094053_189060_795C9ADE 
X-CRM114-Status: UNSURE (   8.90  )
X-CRM114-Notice: Please train this message.
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
Cc: Max Gurtovoy <maxg@mellanox.com>, James Smart <jsmart2021@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Nov 24, 2019 at 06:38:32PM +0200, Israel Rukshin wrote:
> @@ -156,7 +156,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		iod->sg_table.sgl = iod->first_sgl;
>  		if (sg_alloc_table_chained(&iod->sg_table,
>  				blk_rq_nr_phys_segments(req),
> -				iod->sg_table.sgl, SG_CHUNK_SIZE))
> +				iod->sg_table.sgl, NVME_INLINE_SG_CNT))
>  			return BLK_STS_RESOURCE;

Minor merge conflict here from a resource leak fix from Max, but I fixed
it up.

Series applied to nvme/for-5.5

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
