Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936B7C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 07:55:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610FD2072D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 07:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lVgqgAba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610FD2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=npyTVUuzGjzCq9UzJmlEQQRuQ+OFScc0j6ye8DcZ8Qw=; b=lVgqgAba0RtWjThbt4LjXSQC3
	u5IqL1exbBgRHt10NVhCjXWMnKpLdBr10vJYvAMCUrF08OZmUC/8+FVcb9cTpVqd6kk3i4G8mE7HK
	+n6TWgLn5VGXupJ8ykGC/WDitIFE793XJRORuB0nOzEd5ZGuWd8Jqtn2ydbFz392SCL5gQZNGyrrL
	3igB7t2psjL79XvzpfKxylInX15oKLg86io9j9hWLqI0ahGBTQeZU726xV2ogqmeG4Hbc8jBh62SU
	pvuYaGCHC7W5nP2XAZ3P1e1aUkww7Ni1jtMM//+8gumYrmYMmHO5aFIsYGEusBDB0xixqJn+e3TqF
	CpEcFPS+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7Zyx-0007IE-KH; Mon, 17 Aug 2020 07:55:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7Zyv-0007HE-M6
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 07:55:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A867868AFE; Mon, 17 Aug 2020 09:54:56 +0200 (CEST)
Date: Mon, 17 Aug 2020 09:54:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] nvme: refactor command completion
Message-ID: <20200817075456.GA15510@lst.de>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-3-hch@lst.de>
 <6e751fee-9e89-96c7-8246-c8af3ecfcdad@grimberg.me>
 <20200815065424.GA15518@lst.de>
 <eeab0487-0fcd-92b4-775f-8a08827431b3@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eeab0487-0fcd-92b4-775f-8a08827431b3@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_035501_846943_F1E2C7B2 
X-CRM114-Status: GOOD (  11.07  )
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

On Mon, Aug 17, 2020 at 12:45:10AM -0700, Sagi Grimberg wrote:
>> but found that a little weird, but I can go back to it.
>
> Seems better to me.

I think I'll just keep this patch as-is and add an extra one implementing
the suggestion to just switch for a the path error status code type.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
