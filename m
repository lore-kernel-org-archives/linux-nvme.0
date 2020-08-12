Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D10C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 15:10:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365F720781
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 15:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wt6KNT5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365F720781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AwT/NiOd9IcnxeMw0ljR04+R1BzI7fbSYw0CC0mVBJU=; b=wt6KNT5ApwnxdymZ6lfjivUW0
	+BiDfXPYp763EDrobtIrDwYLeUKe1hwXYK/u1+AS1Tgi1cqVtcwweB8eYG2epmsP3rJTD8CSmaJUX
	KHPxQKK2RjvdKw1El4bog70FjuSmOkb36gt+HHx7sEokX9w3y8NRjtLq9T5sgfl5z+JVGND6pDqv3
	banKQNI03nW58CUhXE9eesgDznAxzAts5kndtKOVm4WB2r+GhRsJtM+fkM5fiiAmuSKhcP355thSa
	OfeKUU0DZOoCqZyw7X07gMLZKKsdhVqQvr5gfmch6RSK94x2GABx76OvTOdfeOV7OGmRs99KSqZAJ
	4M7tQL+sw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5sOl-0008U1-Mp; Wed, 12 Aug 2020 15:10:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5sOj-0008Tf-NS
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 15:10:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 25B216736F; Wed, 12 Aug 2020 17:10:36 +0200 (CEST)
Date: Wed, 12 Aug 2020 17:10:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 2/3] nvme-core: delete the dependency on blk status
Message-ID: <20200812151035.GB29544@lst.de>
References: <20200812081844.22224-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812081844.22224-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_111038_108507_5026734F 
X-CRM114-Status: UNSURE (   9.88  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 12, 2020 at 04:18:44PM +0800, Chao Leng wrote:
> nvme should not depend on blk status, just need check nvme status.
> Just need do translating nvme status to blk status for returning error.

While this doesn't look wrong it also doesn't save us a single
instruction and actually adds more lines of code.  Do you have a good
reason for this change?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
