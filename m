Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC768C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxRSULSnQ9AB4xZze/zzmA4j0sE1oXfkxcYBXxS9T8c=; b=AeLaF24d7Rfd7+p8/qEis78de9
	+fF4hXYkMjLEfBgllvB/uAuKoH8tEd2fXB0lC9K5o3wCbo9xjg3AlGFtrcDnMWO0RkuUk6hCvCZrh
	YozwgxmFn7622uTBKGa41S65dLJS9Y74ghqJ4nJKZaQw2u4OMBgHqmuUwY+MlakRvi82yfyyG2YoR
	EMuKagGvl/PVt9/8a8H5MPi6krt5S86dXn0AOAmTHV+RBwU/4PuklaFGnYDEiqymZo46SMoSq7S2T
	WTrEFktE08CYU/01Z9nvU7qE0OBWYd+erqSjK/c8u1ZQqtxBQOrx5nH3HR5Gi/E9phFTzH/Ugewze
	MYWU5v4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oON5k-004Wpv-PC; Wed, 17 Aug 2022 17:44:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oON5h-004Wml-Uk
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 17:44:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D571E61329;
	Wed, 17 Aug 2022 17:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9D2C433D6;
	Wed, 17 Aug 2022 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660758264;
	bh=RUGwvuAQRArCjX8ifHZubqA3C7OTKG3kXa4gkAdYYas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FaAsS1i2+0FDOsoI5r001GJsjskp84fnvr18WAj/ayy2ejW6ey0HCpfTWmU0OwzJ3
	 T2MFHduv1IihnTQhcnIAJsnGBsw4GBpQEnJGcQUk42V3Z1MxsIChB14ZmcXb76Avng
	 HtIxCuQeFmNI94yfoU5enj+DJKS+cI0C9H5i+hR1I60xyImpwWhelumNno+JJe38KM
	 0fw91lFhKrjYki+AezrQbc3g/cFbzFJmDxMF2aDRLFGMfA6DFuCmREPpgPD4hQWh/m
	 Zk7GP594ZQ9YMq6bIDQUOfY7ryARPwGwEQhHdAjUSL0/hOU05/gDmbB0aGZCholtrJ
	 S6MDGtZp4w5NA==
Date: Wed, 17 Aug 2022 11:44:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Message-ID: <Yv0o9MlqCjXUcDKc@kbusch-mbp.dhcp.thefacebook.com>
References: <20220817170427.15682-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817170427.15682-1-fmdefrancesco@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_104430_075786_9BDF07A1 
X-CRM114-Status: GOOD (  13.84  )
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

On Wed, Aug 17, 2022 at 07:04:27PM +0200, Fabio M. De Francesco wrote:
> @@ -329,7 +312,6 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  	u32 length, offset, sg_offset;
>  
>  	length = cmd->pdu_len;
> -	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
>  	offset = cmd->rbytes_done;
>  	cmd->sg_idx = offset / PAGE_SIZE;
>  	sg_offset = offset % PAGE_SIZE;
> @@ -338,7 +320,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  	while (length) {
>  		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
>  
> -		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
> +		iov->iov_base = page_address(sg_page(sg)) + sg->offset + sg_offset;
>  		iov->iov_len = iov_len;
>  
>  		length -= iov_len;
> @@ -347,8 +329,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  		sg_offset = 0;
>  	}
>  
> -	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
> -		cmd->nr_mapped, cmd->pdu_len);
> +	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, 0, cmd->pdu_len);
>  }

I earlier meant just use a local variable for 'nr_mapped' rather than replace
it with '0'. I don't think that 0 segments would result in usable kvec.

I'm not even sure the existing code is correct, though. The sg->length can be
higher order than a PAGE_SIZE, so it may be over-reporting nr_segs. It's just
supposed to be the number of initialized iov's.

Anway, the rest looks good.

