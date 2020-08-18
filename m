Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB1C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:33:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC052067C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 06:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WMN7kt8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC052067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vianh+m+GPqxtf/3KHPee/2QHr32WdwWNMCDVdEBEG8=; b=WMN7kt8tF7hqTRLcEZwMs1fn0
	LpgwirWGTdxjGapFcDT3l/+vbezR6406zUwV0/Ew8CKmJ767/KmXt1iDZuCTExbctULoQ/E6AXO0I
	KQUkbKca1MsDrHDxKU4K+WoiW3tRKbD5Tvnsh8c1NGlPZOff6X7ubJTfN2S0eDWahTe3omdsuhvIl
	BNsEQhrGcF3FcZHi7q5BbYhvlSNHDO07w9RPA39bAdGmoS81f4OqTGlVnGne4jH5v7WF11jlfzsOL
	WsBP0PU6VksmmDCdQwf6B0BkaZOyHmmDWqmRg81NiDUH6A6ZTmqK+dmO5V6CLJ655sqzvzGmzDaIY
	O2yYmuq4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vBb-0003v0-8r; Tue, 18 Aug 2020 06:33:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vBX-0003tT-P4
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 06:33:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3289768AFE; Tue, 18 Aug 2020 08:33:26 +0200 (CEST)
Date: Tue, 18 Aug 2020 08:33:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme completion handling refactor and fix v2
Message-ID: <20200818063325.GD1754@lst.de>
References: <20200817081544.837699-1-hch@lst.de>
 <5f98bdfe-0e9f-60a5-85e3-88910ef0a8a4@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5f98bdfe-0e9f-60a5-85e3-88910ef0a8a4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_023327_938779_6A89842C 
X-CRM114-Status: GOOD (  16.13  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17, 2020 at 11:10:33AM -0700, Sagi Grimberg wrote:
>
>> Hi all,
>>
>> the first two patches refactor the common nvme completion code
>> to be a little less obsfucated, and the third one is the fix
>> from Chao to redirect to a different path ported on top of these
>> changes, which now make the fix very simple.
>>
>> Changes since v1:
>>   - add a new patch to handle the path related errors using the
>>     SCT class
>
> This looks good to me,
>
> Do you think this is 5.9-rc material? I'm thinking this should go
> to 5.10...

I think 5.9 should be fine.  We're early in the cycle, we've go a fix,
and more important the building blocks for the persistent reservation
fix, and also a similar one in ->report_zones that I found now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
