Return-Path: <SRS0=obgt=36=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B32AC352A3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2020 17:07:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D7E2080C
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2020 17:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DejZKmIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D7E2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bQMpcNnqpCFI3Opxcmndzpk/bOBqrGjc0ucbcG/uLFE=; b=DejZKmIz5QfxbU
	Hn9nyqIJt6NTbwYNAdWiUl11cxphj8Ke6e6yqEc8xKccgdT9udxsa/19K0n0jWUswNLTI50z/42yp
	BDbjwnCBiJ92NiaXEkRUStgytHFTxT0kHjd0inU/GKBZWcuHJJ/V9XgOLSRxml98Dg7f7/g6Y9l+E
	yv+g393zf1klv98jgp0Wp310g9k0h1wCPZ6uL9Y5qG6cT+Az7SSBLuTX9XjRmDe6YY3xprQoLjt9s
	NAEOAdxriKOTjXioRv6U8IlBnk8bGTmMbC1UcjUdevTzZ6xpL2mq5QVxKiF7xC8Ka0jHq6QiQk0a6
	FJ3VjwNsFi73p/JFgHXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1CWZ-0000rH-6P; Mon, 10 Feb 2020 17:07:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1CWO-0007c3-R8
 for linux-nvme@lists.infradead.org; Mon, 10 Feb 2020 17:06:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E6E9F68BFE; Mon, 10 Feb 2020 18:04:42 +0100 (CET)
Date: Mon, 10 Feb 2020 18:04:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH 2/2] nvme-rdma/nvme-tcp: Move err_work to nvme_reset_wq
Message-ID: <20200210170442.GB19584@lst.de>
References: <20200206191342.10190-1-jsmart2021@gmail.com>
 <20200206191342.10190-3-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200206191342.10190-3-jsmart2021@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200210_090657_042789_73B88AF1 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Nigel Kirkland <nigel.kirkland@broadcom.com>, maxg@mellanox.com,
 mark.wunderlich@intel.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 06, 2020 at 11:13:42AM -0800, James Smart wrote:
> With keep alive processing being moved to nvme_wq, it potentially creates
> a conflicting position with err_work also processing on nvme_wq and needing
> to flush/stop keep alives.
> 
> To avoid issues, schedule err_work on nvme_reset_wq. It looks like this is
> not only a good thing for keep alives, but also brings the transports in
> line with the RESETTING state and processing work relative to RESETTING
> on nvme_reset_wq.
> 
> This change is made to both nvme-rdma and nvme-tcp which have like code.

Shouldn't we move both in one patch to create a regression in one
cycle while fixing the other one?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
