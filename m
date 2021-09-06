Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612E5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 08:09:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334416103C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 08:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 334416103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OX6dPHJ2CT4gm4V7A0it0o1x0UWTOmH1Jqp4t5SXbYQ=; b=2CXmSCaiKRxjdC
	wvH2QpUI4Hq/TwNqHqGgmwBhAFMvGIEZuh+RPdQoS4MXf4FolKJhYBaMCvu03I/niMFEgOh0uWV+9
	d3u9hH9Rx+oQJHhthlQOFP4QHIiWS+A7IYucbRK0MY8z2ALkIzB3nbFsi4aKAT1k8YmuARb3kJqzF
	iw2kZcy6U+lvYTp+OwUtLBGYDdx3e57WUwESOyYAA5xGnlNi+3+bjk9ShMnlA2RfMA5Zao1JMmhHo
	HZSOPTq3/VV6VFC/KYs+KIYJZmLFxqH73Md3qlQcxnI54hT0Wq/G2l2F86mLScTAJgB5t3/G4lIiF
	8zIIRkV9sETpyifzJdew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN9gp-000Ca1-Bg; Mon, 06 Sep 2021 08:09:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN9gm-000CZG-HK
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 08:09:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E18B767373; Mon,  6 Sep 2021 10:09:08 +0200 (CEST)
Date: Mon, 6 Sep 2021 10:09:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
 martin.petersen@oracle.com, jejb@linux.ibm.com, kbusch@kernel.org,
 sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
 ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
 agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com,
 hch@infradead.org, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/8] nvme: add error handling support for add_disk()
Message-ID: <20210906080908.GA25575@lst.de>
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <20210830212538.148729-4-mcgrof@kernel.org>
 <677ca876-b003-d3b5-9e2e-d50ebef82cce@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <677ca876-b003-d3b5-9e2e-d50ebef82cce@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210906_010912_760605_0BD98A14 
X-CRM114-Status: GOOD (  14.08  )
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

On Mon, Sep 06, 2021 at 08:16:35AM +0200, Hannes Reinecke wrote:
> I would rather turn this around, and call 'nvme_put_ctrl()' after removing 
> the namespace from the list. But it's probably more a style issue, come to 
> think of it.

The order in the patch is the inverse of the order before the failure,
which generally is the right thing to do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
