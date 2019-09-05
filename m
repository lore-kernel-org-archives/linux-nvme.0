Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B0BC00306
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:10:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB0F20692
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JjcAYni+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB0F20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kaHwbONK3Cnlc4vqyY6deICnuaSCI8uBBWgkYL8N08A=; b=JjcAYni+NI49Fy
	nz/8hxgoNQR4/fjrYVjK8AnvPXpYQw7uqPKwsFNmmgOwXLkk9T1oa/U5F4XbNZfbQOqCCmHb5LB4m
	fV5wrMAWXHgBqFBqkDCYATPf3bg1sNiZVAlbvBCTqm6QFykxSZLPd3AxLRYIebhjtPJqQT+ioAcw3
	uc38BtI6mHbPZN2DFgPnir3SrYgnEjELXivXOM5F7WMmHo5wRId2G2pRstcqly9j2s8kkBQ7xjn35
	I7rjMbqAdg7zoro3KgFNadksJGZhz0KRLhKdoRITFVFmUlub88KQgr6NIJ3MJ7/OnnFIeo6OMFhSD
	Gbp8/OiAbPCbfn1Yc36g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5y5J-00054j-CA; Thu, 05 Sep 2019 20:10:25 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5y5G-00054L-Mn
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 20:10:23 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 13:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; d="scan'208";a="184339753"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga007.fm.intel.com with ESMTP; 05 Sep 2019 13:10:20 -0700
Date: Thu, 5 Sep 2019 14:08:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2] nvme: Remove redundant assignment of cq vector
Message-ID: <20190905200851.GA25446@localhost.localdomain>
References: <1567698066-29168-1-git-send-email-israelr@mellanox.com>
 <17a246f8-8c9d-d37a-4e6b-6eff8d4f3962@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17a246f8-8c9d-d37a-4e6b-6eff8d4f3962@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_131022_786828_DA5B3977 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: Israel Rukshin <israelr@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 05, 2019 at 01:08:18PM -0700, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> I want a formal review from Keith to apply to nvme-5.4.

Sure thing. Patch looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
