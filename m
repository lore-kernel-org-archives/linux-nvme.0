Return-Path: <SRS0=rLKq=CO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254BEC433E2
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 07:20:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2F720760
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 07:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ePm1JYtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2F720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/tCiNATcwJYZ8LsXd1CmT+p3w2+aFnEGt/q8y4xT3Fk=; b=ePm1JYtxEAuUPNKsy1vMa9Kjy
	AUI7VsBuAovqKVzh7TcNniWY7jVxgfz3eh0PeUwtRW9Q0OJKdwirr/myZ1fcPB0x0+Q5ZKe4xwx8N
	/EjUcgI8OiTdcpE8d3YiFWMVHkcBrB5DnvWBLMTpVmTCxFmvhUvIXdChxMb5PaX0lu421xnhxEUgq
	y/9irXDukWS0286nlHwD8TXEfIfpiXCK1Jx1n2G0Mt108QhZMif4NN773nzm3cuM7iDSYqMZzR/Yj
	GWeblW3rYYrkTQQ2HSp0d7/rjHJlvwZSxSY1jWPImSGRrtmCv2a1Wmc2tohufiW/2RZhWLsWkIgwL
	pvDEU3tWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kESV9-0003TN-SM; Sat, 05 Sep 2020 07:20:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kESUp-0003Rm-30
 for linux-nvme@lists.infradead.org; Sat, 05 Sep 2020 07:20:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D88D468BEB; Sat,  5 Sep 2020 09:20:18 +0200 (CEST)
Date: Sat, 5 Sep 2020 09:20:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/3] nvme: decouple nvme_ctrl_get_by_path()
Message-ID: <20200905072018.GA13403@lst.de>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-2-chaitanya.kulkarni@wdc.com>
 <16dc2193-9830-6184-e7f6-ceaca5f0aaf0@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16dc2193-9830-6184-e7f6-ceaca5f0aaf0@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200905_032023_247702_7358E07A 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 04, 2020 at 09:54:48AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-03 8:39 p.m., Chaitanya Kulkarni wrote:
> > Right now nvme_ctrl_get_by_path() accepts ctrl path, based on that it
> > opens a file and calls nvme_get_ctrl(). In order to take module
> > refcount it is important to distinguish the error between file_open()
> > and module file ops check so that we can unwind the code in the caller
> > nvmet_passthru_ctrl_enable() in the error path.
> > 
> > Rename nvme_ctrl_get_by_path() -> nvme_ctrl_get_by_file() and lift
> > the file opening and error handling in the caller so that we can unwind
> > appropriately in the error path.
> 
> I still don't really like this idea. No need to keep a reference to a
> whole other file.

We could still lift the filp_open into the caller, but drop the file
reference right after we got the controller reference.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
