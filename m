Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84002C433E9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:20:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4E620775
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="de+mSHQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4E620775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yQF73Vk4Nlnxz2trgN70DKkfUwh/FucS147VHAM9HG4=; b=de+mSHQiPCVJSax1Hl303hdJ6
	8FFCiupgpaZxlrNXEwJfEOpUvubjj/rgeu+eCwo2zyYt/U24QqOMjexkGIYQAgL2zC1J7zFwT4AX1
	jxiPAFXPJiyJZDPPFqg5Ms3y0AD0xaWQtY2eYXiA8U6WwTPtfYHmfEP+hYlnYvflH42y2b4Pj7kog
	vZXGLHpx5t1jtNrIR4uR6/ew7SAsOKnags7zcl39oxnEMtsXxNZOsj/9I8zqde6H3ixqkZ1MpP9wL
	fRD24MN0e492pej8DINPdmNBjlHyiAOOjRuptVYEK+2AdBpBtREUo1E0HC9aiA/xSlfJaHms+j22y
	fJ8f9P38Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDryJ-0006PV-Dg; Thu, 03 Sep 2020 16:20:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDryG-0006OZ-6B
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 16:20:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A441B67357; Thu,  3 Sep 2020 18:20:17 +0200 (CEST)
Date: Thu, 3 Sep 2020 18:20:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 04/12] nvmet: use consistent type for op_flag
Message-ID: <20200903162017.GC25423@lst.de>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831222707.35611-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_122020_348888_B253689A 
X-CRM114-Status: GOOD (  11.55  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 31, 2020 at 03:26:59PM -0700, Chaitanya Kulkarni wrote:
> In function nvmet_passthru_map_sg() we set the bio->bi_opf ored with
> req_op and op_flags set based on the NVMe cmd. The variable bio->bi_opf
> is declared as unsigned int use same type for op_flag.
> 
> Also, adjust the order according to new length.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed By: Logan Gunthorpe <logang@deltatee.com>

Actually all the op_flags used here are bogus and have no meaning for
passthrough commands.  So the right fix is to remove op_flags entirely.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
