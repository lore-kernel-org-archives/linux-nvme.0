Return-Path: <SRS0=CVBY=5U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15264C2BA16
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2020 07:14:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3BF206E9
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2020 07:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V5phX/tD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3BF206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P8qdpfuTqkMrNcGf0qtj8e1DqgehvOlgIfmerxoP35E=; b=V5phX/tDHwAFPo
	VsQ0DEx2B/RYpREh3smiqakk8/mj25NZZ1Y2Yxy/8H1UGrN+rVjYvLHieus5sUCU9nmBg5MPr2ciF
	oB1i3PqIO2bfZIHopv3C+2teSdWwvOiq7u6LmIhsZumasVRqnScYYeqZSBIJ7bubT0kB2BdvSIB+9
	z5LnVgEeq62dRyRvc4GDas9D5VDM94AFVFoix2Mr4+QGOKnO7hhyLsN9L+VZ0TVK5F9Po0WeWAXA/
	im8oYVwkzzfuMR+SI7WZDXLmYJxA2XxjBwYgFr1TZrTy8y8zOPIyyQLdPgh7EcfFhk4zcyZe00vWI
	r14cBpeSACLAwctH6JCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKd0f-0001zt-LB; Sat, 04 Apr 2020 07:14:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKd0b-0001xx-Lf
 for linux-nvme@lists.infradead.org; Sat, 04 Apr 2020 07:14:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D060B68C4E; Sat,  4 Apr 2020 09:14:23 +0200 (CEST)
Date: Sat, 4 Apr 2020 09:14:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: remove unused parameter
Message-ID: <20200404071423.GB14645@lst.de>
References: <20200403162409.1324031-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200403162409.1324031-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200404_001425_874045_369B1407 
X-CRM114-Status: UNSURE (   6.62  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 03, 2020 at 09:24:09AM -0700, Keith Busch wrote:
> nvme_alloc_ns_head() doesn't use the 'struct nvme_id_ns' parameter.
> Remove it, and update caller accordingly.

applied to nvme-5.8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
