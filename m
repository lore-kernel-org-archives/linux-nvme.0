Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E38EC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 09:21:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C6C61002
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 09:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2C6C61002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=adt2A/k4lk9cNjgeZBNO4v2J1VkGeDEC0HhZ2u56vfE=; b=dpgY6Dw+2lR6tb
	dsvQUqwNv049IcTRiLTW8zfCu1jSo8USupyJozRdRCY1gIZx9cROP6CsLZeCpzdi4Qt9tMM6IONJC
	cy2mCpXAoZGH0Btnm1L+QuT4mMm6vccTVouXKQiFp2ZNkWI7tEepPzInDZqatWJUDyoZ1CaR022S5
	YtWeFApU34mWpEKrzHAkgoJcMOUZQ7Gz6Nq9UP4YU05dkJdDEkAvYJaMhH/vgBP1AgxmepEi8hPs/
	MZO5pBg30gmzup3qzTkzgwMDgsTa1wjDQ99Zgg2MC4Cz5CJXzqk090DPB0wP2ZFGHfz9hdbpz1yMz
	RP65of0rM8N7sQ3WCMcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI68F-00G4rW-AH; Mon, 23 Aug 2021 09:20:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI68E-00G4q2-2W
 for linux-nvme@bombadil.infradead.org; Mon, 23 Aug 2021 09:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=m2UWnbGr+3dho2sklP4AJF5cECMOSLkmwWKYuXFM05Y=; b=i3gqpBFmQlc+SNiLRQuhZTW3HU
 TTDGsfYk+mRI+EMk0AGLfWR1AVp2id2eOX2kKUHCbOOqP6zovjtTBBVQV37xpeoAO4wMwMohcKpiX
 FWqPcyXFBfddEQ8WAvKt3SgFDRpLNUS1PGczKGPUiUq4bSPLvOhUuQ02byHMiyhVzjdgAksdBLB6X
 wKE/nXWyahNEvxNryXMRHmJv2LMkoGJpsUxbjrUkrzwRRFbq0eXfbaHBEw6Qkosm1MOi5us2Q4ITN
 4hEFgkXvXYc7uWs9JN4AEr32kgXk8Xr7X6McM+3CiIwp6ygvzSOorcBopPuRsPwbo6vRD4OQzI/Kl
 t1DUWEOw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mI673-009XDb-RH; Mon, 23 Aug 2021 09:19:36 +0000
Date: Mon, 23 Aug 2021 10:19:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <YSNoHVsQXKqmJ9nO@infradead.org>
References: <20210818120530.130501-1-dwagner@suse.de>
 <YSNV6vpaEnzc0Yv4@infradead.org>
 <20210823091405.pmmkubzgxodwgjij@carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823091405.pmmkubzgxodwgjij@carbon.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Mon, Aug 23, 2021 at 11:14:05AM +0200, Daniel Wagner wrote:
> Hi Christoph,
> 
> On Mon, Aug 23, 2021 at 09:01:46AM +0100, Christoph Hellwig wrote:
> > applied to nvme-5.15.
> 
> Could you drop these patches again? James just sent me a new version of
> the series which addresses the points we discussed in this thread. They
> look good to me but I'd like to give them a spin and will post them
> shortly. Also James is giving them a test run.

Ok.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
