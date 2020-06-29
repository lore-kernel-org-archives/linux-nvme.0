Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B33C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 12:50:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4007823B23
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 12:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UIe9sURl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4007823B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7LwwPQB1oO02U+3XSMUy+e/4v7J5b/d5fuDlf6sd28=; b=UIe9sURlnGJP28rzMoJLUTksG3
	5jN/fL9pbOvv8VD2ovBFIZMqblzmBEzqXaKA/LZtdiUSmaykEs4vW/E+jzErnxQGKebFZdJMZjX0X
	loHMLZK5mfrtPXhRP9LIEp64MhoZPgNYCAYW7mXdyd/vt45Vm8X56+4lFEg9bJBbBPITV7DVTcLGw
	FSXumYiQ1UzbbrcMVv0w4NT134Rqb6ihZVu4/+CWXrEIuvJtEurPxddbdIcfgfO4o/0aFj9Ohe9Y7
	Kj+igyNlqAncRMRRlY8tDXD22/uOTzvXFO39pIsMtIawrur5FwO8XItruB2VasG8JusWKjs78DrHh
	LhYaEu2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jptEY-0002fI-Op; Mon, 29 Jun 2020 12:50:02 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jptEV-0002bi-Ax
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 12:50:00 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R301e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U126K8P_1593434992; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U126K8P_1593434992) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 29 Jun 2020 20:49:52 +0800
Date: Mon, 29 Jun 2020 20:49:52 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [RFC PATCH] nvme-pci: Move the sg table allocation/free into
 init/exit_request
Message-ID: <20200629124952.GB31739@VM20190228-100.tbsite.net>
References: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
 <BYAPR04MB4965FD429BA4203694CB37DA86910@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965FD429BA4203694CB37DA86910@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jun 28, 2020 at 09:55:12PM +0000, Chaitanya Kulkarni wrote:
> On 6/28/20 3:44 AM, Baolin Wang wrote:
> > Move the sg table allocation and free into the init_request() and
> > exit_request(), instead of allocating sg table when queuing requests,
> > which can benefit the IO performance.
> > 
> > Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>
> 
> The call to sg_init_table() uses blk_rq_nr_phys_segments in 
> nvme_map_data() with this patch we are blindly allocating SG table with
> NVME_MAX_SEGS, without any performance numbers it is hard to measure the 
> impact.

Not true, the original code also will allocate sg table with NVME_MAX_SEGS
if the request contains multiple segments, I just move the sg table allocation
to pre-allocate for each request, instead of allocating sg table when queuing
requests. Obviously it will save some memory allocation time when the request
contains seveval segments.

> 
> Can you share performance numbers ?
> 
> I'm particularly interested in for IOPS/BW/CPU/USAGE/Submission latency 
> and completion latency and perf numbers for the respective function in 
> to determine the overall impact.

From my previous tests, I did not see obvious improvements, I think my
test case always create one segment for each request though I set bs >
4K. I can try to create special case to test multiple segments.
But as Keith commented, he did not like this patch, so...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
