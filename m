Return-Path: <SRS0=aJh0=5X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22000C2BA1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E140520768
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cNR0o8+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E140520768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oTEq6mhvJOiXFOOMVE781dC9Q3zmie7EcBY0P7C6RcY=; b=cNR0o8+GjEQYEm
	9IbGIXBJ/+fLp5CcqwiVQS/j8qXbSubWRpiVEVN8dorzUoVGUDHcZNUoXD+9p/9ntE9nE51pKgesH
	RNG5Ye4FO3UUxb42zhQAr18Y4PSiL5Co8yO3oseKK+wTBSlCA0vKwOpH2wm2Sb7XLWBVNtUdohi8l
	gCquaQhSzm1oIC0JZ7ujX64OCk5BKcgsavhp4KuIHIs15ZksLH92Knx6EFOY0vmgAHmiRdYC/8B4F
	0iQ8dhYIYOC+P2wS3FzD/jw27cn8n23vhDdEsL7s4tR78NPV5n0djJDzh07Nwc/AJP75qDX4Ng4Xm
	5+8QUSGjTilNmRLiAJwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLrBb-0001cE-MM; Tue, 07 Apr 2020 16:34:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLrBZ-0001Zo-6H
 for linux-nvme@lists.infradead.org; Tue, 07 Apr 2020 16:34:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 57F1F68C4E; Tue,  7 Apr 2020 18:34:47 +0200 (CEST)
Date: Tue, 7 Apr 2020 18:34:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: slight cleanup for kbuild test warnings
Message-ID: <20200407163447.GB2929@lst.de>
References: <20200406235534.59650-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200406235534.59650-1-jsmart2021@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_093449_374153_FA132195 
X-CRM114-Status: UNSURE (   5.47  )
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
Cc: kbuild test robot <lkp@intel.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-5.8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
