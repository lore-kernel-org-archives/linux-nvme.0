Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B80C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 17:14:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE1061353
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 17:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AE1061353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1g1Vw9FtQKpKnY2LORsLdmO4xHwIYeOnqcv87rtlms=; b=2vKBx+Ea94Nkh+ig1TyOTdR4ec
	dpnGJ+mrpg2NdFGpzIoYsHVafFm3xBbmGEhK3zG4GtCgZvqMC5k8u9XyGwlZt9HzmmPTHUhPqjII/
	pe53A6jzYsiuD/gVoyZj6TbE5EFZ+bzqa+ecbmesoFbh8vNMz3PWAnsb+oJUOOrDIKkeqlkr9jJCp
	OgkOwFY9hj+eUFhds2dW7l90bpmncCSQCvbNgmmuTT5H1myT0o/IXb/vTD8jwslzM45t8hfOPwyUo
	E2hFH1C5qQO3c2S8UAmBBTUyrkR4I5s2zRqVNKXZG6Hk6Zb3DnNlSAmsIg1bogQgqgVXEb4Jzi0Rm
	2DtwCAjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mo7TO-00BAoG-01; Fri, 19 Nov 2021 17:14:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mo7TL-00BAnX-Bt
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 17:14:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2F18B68AFE; Fri, 19 Nov 2021 18:14:44 +0100 (CET)
Date: Fri, 19 Nov 2021 18:14:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Please rebase nvme-5.16
Message-ID: <20211119171443.GA15655@lst.de>
References: <0614137b-7ae3-48b1-d60b-57d1fcdae6ff@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0614137b-7ae3-48b1-d60b-57d1fcdae6ff@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_091447_568746_432DC470 
X-CRM114-Status: UNSURE (   8.31  )
X-CRM114-Notice: Please train this message.
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

Done.

