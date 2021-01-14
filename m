Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53071C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 17:43:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65F223B40
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 17:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65F223B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K6C3987La1t4lP0tNsdsgrxvMlJBfRL5YFWv42W1ijM=; b=kDlWUbeJbjMIHLdw/7oEWetXV
	c0N9hiYDT3Xd2MS2Rm2o89CJg5HI9lHKmrEftLUpmD5qZ3VS3vsBCHlCDcpWUBjmYmvkrzzpnjEHj
	TZFgAihMZiv9sAe2pI0RaNs122uUrYZGv1977XtLl9A/885TlwQ3ULi3bpC4kzYIPyDghLevkZmBT
	prGbpEppPb++m0P5WlfVRp6EiDy+G9alVaOb3KHbcvSuWwH42J+idHPMpnovbU7KHuHHsCLUPN49H
	8ieKEuLJEuVkOjWjH9O77zsUpnMpxZ5D98G93W2xrXRSTypr9VaqZCi0FPbIcEHAv4zsKtiqRLIRF
	bONXDyskQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l06eT-0004KX-JU; Thu, 14 Jan 2021 17:43:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l06eR-0004Jk-6c
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 17:43:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A3DC568B02; Thu, 14 Jan 2021 18:43:12 +0100 (CET)
Date: Thu, 14 Jan 2021 18:43:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller
 than a sector
Message-ID: <20210114174311.GB31188@lst.de>
References: <20210113160621.98615-1-fengli@smartx.com>
 <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_124315_366525_360498C2 
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
Cc: "lifeng1519@gmail.com" <lifeng1519@gmail.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Li Feng <fengli@smartx.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 13, 2021 at 02:12:59PM -0800, Sagi Grimberg wrote:
>> But this only catches a physical block size < 512 for NVMe, not any other block device.
>>
>> Please fix it for the general case in blk_queue_physical_block_size().
>
> We actually call that later and would probably be better to check here..

We had a series for that a short while ago that got lost.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
