Return-Path: <SRS0=D3NM=F2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C497C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 13:51:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453B423105
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Dec 2020 13:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453B423105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=47hxzSJJuOu7+5+c9T2NnR8s8RYR9EpFW6PSZJ5iwgk=; b=B5VzLUs5CK3GN78+SvpRl4c9R
	WJEsFUH2IH7UZfjujBTkfsWDHG36llAcPeiaqVKYQu2PYH4z/LtYAoEvGw0IY5N3/L+uQWtpYRCLX
	Rb+I9fAvdiwfe1mFHcuman57FvtUyg/YBYT4/kmTMg89/9EP1VnnbGgr7cmP3kjUWmEY0sbs3X/c2
	gGQvXVwiyH0BIwhVKBn90fGUW+8wIh/0ZO1FmjpbCD3MQxHk1oBAdUOLLveUIbQ6coRChjQVNmLTt
	e+djPoiDysetiNcKjEBS3/wJ5Uwi3Wfk2tdQHga2wUZ24jjWMIZ6g56os3wNo95bOLjLn32hNiywE
	ux4ydV5Kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kri48-0002kl-1a; Tue, 22 Dec 2020 13:51:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kri46-0002k1-A4
 for linux-nvme@lists.infradead.org; Tue, 22 Dec 2020 13:51:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 07C7967373; Tue, 22 Dec 2020 14:51:00 +0100 (CET)
Date: Tue, 22 Dec 2020 14:50:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v2] nvmet: fix mismatched serial
Message-ID: <20201222135059.GA32569@lst.de>
References: <20201212075801.1393924-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201212075801.1393924-1-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201222_085102_483673_358D8865 
X-CRM114-Status: GOOD (  10.31  )
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
Cc: kernel test robot <lkp@intel.com>, chaitanya.kulkarni@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Dec 12, 2020 at 03:58:01PM +0800, zhenwei pi wrote:
> Target side uses 'bin2hex' to convert u64 serial number to a hex
> string, saving serial number as be64 to keep the right byte order.
> Also use format '%016llx' to show the full serial string to avoid
> to drop prefixed zero.
> 
> Test on x86 server, config '0123456789abcdef' to 'attr_serial' on
> target side, and run 'nvme id-ctrl /dev/nvme0' on initiator side,
> then we can get the same SN string.

We can't change this interface any more, as it can break tons of user
space.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
