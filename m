Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B90C55ABD
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 16:25:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04648207DE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U6AZBzoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04648207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vjwtjeOXecKNeRV6AAiC8BDAwPPQoMl7cJYTRHCA854=; b=U6AZBzoZmehPMXbbP7yIkZ9qC
	vteAVM57Yqd0Bh/Db1yu2puMtS3ar7KGLITl0L2jVql5goobKyKNVloelq3RpOUZwVcusxX868iys
	kcpIqDJegnzf4/U2V4z84BnhT5LPUvtOPryISNdMVFePnzQIFxlx1dSGHaYTPQ7L+7hCSC44xrYJ3
	GVAgo5O03DMTfpgzd5VmD04WzBtUF6i0o767wcor30LErdrOc1jg0V8PTXYbPlcr7kVRqh0za3Cw6
	veYzI3dCWZ9CnLT+B73oY0zo9P/JsIxUBjgpRiUgcvkK0N7S/Sa1gFbgUbkeXB6ZVfb+A5z2lIGeb
	nIWi2r5VQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdbsw-0004bc-DE; Fri, 13 Nov 2020 16:25:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdbst-0004ai-Ph
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 16:25:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7C1706736F; Fri, 13 Nov 2020 17:25:03 +0100 (CET)
Date: Fri, 13 Nov 2020 17:25:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
Message-ID: <20201113162502.GA16940@lst.de>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
 <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
 <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
 <c753af20-878a-91ad-c5c2-692016fe2014@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c753af20-878a-91ad-c5c2-692016fe2014@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_112512_019018_4D3B0390 
X-CRM114-Status: GOOD (  14.35  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 13, 2020 at 02:15:59PM +0100, Niklas Schnelle wrote:
> 
> 
> On 11/12/20 6:36 PM, Keith Busch wrote:
> > On Thu, Nov 12, 2020 at 04:45:35PM +0100, Niklas Schnelle wrote:
> >> You got to get something wrong, I hope in this case it's just the subject
> >> of the cover letter :D
> > 
> > I suppose the change logs could be worded a little better :)
> 
> Do you think I should send a v2 with an improved message?
> I just realized I'm pretty alone (and wrong) in starting
> the commit message body lower case too.

I'll pull in soon, no need to resend.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
