Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC408C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 12:21:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A72064DCC
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 12:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A72064DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K0g51VTh5trEyTI+nKvm1KvL1fXVOiebG60jyCZXIgY=; b=dfhx0HJC5KxHHnqFNTnEOSuoA
	ov4ie2Nsi38QIjmttWJsxplRKRnJgczMqVPjJMolNb1+LpQ7+fnzWeoJgAUIh6MU33kjtk7Z6MSrv
	gW3eJeiTPRGuyZa0MNxFdIwIIXimbzOzbsWZ4Fju1/vJhpEqrm+jN0Kr0HmfdtDOjBmX+2t7urqlP
	L/m3Ld6/h9fT4z9p3dh0U5Vdgs/JRF608iJkuzsX/yGsCuKWboBTnZgtAz2+qih2XnNaYTcGY6nr6
	wnrpfVatAUDV+2RNeZwK9ZW9HevSPn8rRH/ejgRMlv0Cdw/NgV9jCbK7fIbX+ixGANKDABbiKnevC
	+ovkU3REw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l56IX-00013C-LH; Thu, 28 Jan 2021 12:21:17 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l56IU-0000uQ-OK
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 12:21:15 +0000
IronPort-SDR: ucpWMUEWhsmfc466RjYKYkG1Pf5kPY6oJuWBKk4vMZ9X2RfTLPq4G1kj4DCYK0ZSlqACFQZdmA
 I3mAL9sC33mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="177660219"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; d="scan'208";a="177660219"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2021 04:19:12 -0800
IronPort-SDR: eRNUCStF3+ysdD36ol17BBFuyFq0XadSElC5SF2zqj/DnJRUCJCwsvqwX616ZKrMf3xPkPAmOp
 Da/0IwKqhasw==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; d="scan'208";a="363709169"
Received: from michal-desk.igk.intel.com (HELO michal-desk) ([10.102.102.231])
 by fmsmga008-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 04:19:10 -0800
Date: Thu, 28 Jan 2021 13:25:01 +0100
From: Michal Krakowiak <michal.krakowiak@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210128122501.GA2579222@michal-desk>
References: <20210104155343.GA26034@michal-desk>
 <20210127174606.GA28180@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210127174606.GA28180@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_072114_934933_A76F4DC9 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

I'd like to ask about future nvme tracing development: Will preparing 
similar patches (for more commands) be welcome? I'd like to do it, but I 
got some concerns after the discussion raised due to this patch.


On Wed, Jan 27, 2021 at 06:46:06PM +0100, Christoph Hellwig wrote:
>Thanks,
>
>applied to nvme-5.12.
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
