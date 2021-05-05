Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA71C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 04:58:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B05611EE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 04:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B05611EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UqchRQE6SQCpR59dMWqQn50aqvT9U1hnenS/IN16V7o=; b=Fn+DFCRL0a73dxkLMRneRvEgu
	ypnt4b1xZgBiUBRUNQrIshbWxSuw6ukaXyeM7fp1RJNMx6uAmQFoU/8c75cGQvdNje6uForCfe72w
	yQfB4GxHbAQGGeZIhq16n+xcOiAT3OkVfuZIPZRUtdd9MVkM01+HbpMIwt8IQq4bpefqT+yAKGUgS
	nSas2kUnc8hvxxFWmhsgOvgoJEJfrVmqQ55/8f2ZVvsL8uSBGbw7xVLvrONyVkH8Sbf8KW0OpFVN0
	HWuOgDXc882GmHX17a9fXzxJM3ehFzFRacQ+SGXF1clD4m2XsOfXCgWx99UwYJ4pM6/UmUZQoB7MK
	JvIPfvWIg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le9ba-000ECF-QV; Wed, 05 May 2021 04:57:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le9bY-000EC5-Jb
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 04:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JQ6IjV4QMpQIwrBJTQeE7iZ4evzpHn/exuTJrETemvA=; b=rs49XJr14jKJjZqU0FsJVaFRfY
 W74OhyQBG+0tgl/537PQvIfJXIKy0Uc8kXbRost+HDfQx3t3DRNph3g7sprbHEJZVPtl05cjXeEzx
 6tg1HydVwOHWNMdoGvJFF2QkzoxEteSFiZAEVhIzSGiZPrRSqJRu+uY6XABh9tSFxw6gZgHyaP2Kj
 csV1jZNybEqwQF+QCnz7LCnHO2o4+zmnHGspPhsaTQVRnRrsLaDM5l87tYCnQAEwdhh/nJ3TGNs18
 Ez1FDOOtaSlDvXnnftSM/K7YpqKUId8+Tv3zNqg+yDrJjOmoKhTUbCceuU0seEo3SRfI4YivYNAUA
 qX75YjUg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le9bV-004SxE-Pf
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 04:57:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ECA9668AFE; Wed,  5 May 2021 06:57:41 +0200 (CEST)
Date: Wed, 5 May 2021 06:57:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] nvmet: consider req->sg_cnt for inline bio
Message-ID: <20210505045741.GB11841@lst.de>
References: <20210504085613.GA21953@lst.de>
 <E4E6CC49-4F86-4504-8BCE-0A7CCF3B8797@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E4E6CC49-4F86-4504-8BCE-0A7CCF3B8797@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_215746_000604_0F89DD4D 
X-CRM114-Status: GOOD (  14.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 04, 2021 at 09:16:00PM +0000, Chaitanya Kulkarni wrote:
> 
> > On May 4, 2021, at 1:56 AM, Christoph Hellwig <hch@lst.de> wrote:
> > 
> > How do you get the fragmented scatterlist?  Oh I guess this is due to
> > nvme-loop not using our page allocator but pages that come the
> > block layer?
> 
> Yes, with nvme-loop and the test framework issuing I/Os using malloc allocated buffers with passthru I/O interface. 
> 
> With respect to Sagi's comment do you want me to send v2 with fixes tag ?

If you have a few spare cycles please do, and also document that this
affects nvme-loop only.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
