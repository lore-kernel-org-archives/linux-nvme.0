Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF63CA9EAF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 00:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8183021929
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 00:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cclh4P+S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR+2whxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8183021929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=utFlqptdaCh67tcVvMZV2hyWnX/FW93AFDZ7HHZLFBk=; b=Cclh4P+SJrE+cZ
	GX5pZUlXLKMyevne8ysw9NphjYIMnxyKttxqFuWYLLX7izgXKb8dNaZw96gOoJkIQJ+pvCBWpiPUi
	YXkJfmhUXbI4cn3miKgr4gUYo0GJXUtIHu0NFOGVa1gW/ornRXe1zJTNFvgv3DwhhHUsXsrtZhOwL
	6ubkAsH6mEijC5Ck0bOWaosHFNPPQsHiQ3ihcbdVYokFMaExDQ4Huo5xgnknqkOLdUwe2dl/JqfTf
	czVk89yPocqCWEkQvcKUGFNsws+tBZApvhVd2gv5zIYjZth548zgs9kSy8MxU2yhOgLjbLBk9Rizs
	M+IMw61OnIGOEpc3BUJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNnLd-0008Ij-15; Fri, 25 Oct 2019 00:20:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNnLa-0008IE-Ex
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 00:20:55 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3030D21929;
 Fri, 25 Oct 2019 00:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571962854;
 bh=bC985rj/uGr5kpM3lV8+Lzv14SErAUJ30tXkNbNlDNU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mR+2whxhjFQ/HKwosMbLS1XgQA4+o7WRtuXfJ0BJvvnTDWvKzt0nhxZQiC8dw7pau
 glmXpqG25L32OylS3HzItJywufNSTaMwJee2IrXk10hx11/LO28Z7NZwBvXcz27Obs
 dHBNDDXi7+ICUbJE0HefWpLvzKHrBcQpQCHfvIl0=
Date: Fri, 25 Oct 2019 09:20:50 +0900
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 0/7] Remove data_len field from the nvmet_req struct
Message-ID: <20191025002050.GC28602@redsun51.ssa.fujisawa.hgst.com>
References: <20191023163545.4193-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191023163545.4193-1-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191024_172054_520362_1342D380 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 23, 2019 at 10:35:38AM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset is a cleanup in preparation for the passthru patchset.
> The aim is to remove the data_len field in the nvmet_req struct and
> instead just check the length is appropriate inside the execute
> handlers. This is more appropriate for passthru which may have
> commands with unknown lengths (like Vendor Specific Commands).
> It's also in improvement seeing it can often be confusing when
> it's best to use the data_len field over the transfer_len field.
> The first two patches in this series remove some questionable uses
> of the data_len field in nvmt-tcp
> 
> Most of this patchset was extracted from a draft patch from
> Christoph[1].
> 
> The series is based on v5.4-rc4 and a git branch is available here:
> 
> https://github.com/sbates130272/linux-p2pmem/branches nvmet_data_len
> 
> Logan

Thanks, applied to nvme-5.5 with the requested author attribution.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
