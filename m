Return-Path: <SRS0=fF/j=BZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D4C433E1
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 06:54:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587E121744
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 06:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o5QjLBt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587E121744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RQSbCnZDoHifWvfQ2UADYzHeKenzNhQCUAqnRV9vTH4=; b=o5QjLBt4UtCBYAVPa8LqUu1w5
	7qOrlO6c72PjEBs2bShU0leUJKEkZdYkGYtQaMaoDypZOeqM17+LiUYCE/PB7GJ1Qyw1MTuxanjzj
	VQUwGiS9Uwlj6WTT8bcPDKQ7F7TFKXmpQW9RpYMrfBr8Kg9rRJzkNop0yDYNg6r1C6hDxHtYBDUBc
	bWdd/cCYaAUV8nwZ1snio4q0Z6a/lBm/ljV2rGvMY9rAFPQ/A0IaasP2uHlKo99ABxOGXqgYapEmU
	kZz16z/KN5+f18jc2MhRP0/wAF3BvH8VjN38ng7FppFkXdekcN8cRhK2R48JgYUU3bVQSITK6fPBt
	ZtPFHmZLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6q5L-0005EL-SO; Sat, 15 Aug 2020 06:54:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6q5H-0005Dw-Oz
 for linux-nvme@lists.infradead.org; Sat, 15 Aug 2020 06:54:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0DED168CF0; Sat, 15 Aug 2020 08:54:25 +0200 (CEST)
Date: Sat, 15 Aug 2020 08:54:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] nvme: refactor command completion
Message-ID: <20200815065424.GA15518@lst.de>
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-3-hch@lst.de>
 <6e751fee-9e89-96c7-8246-c8af3ecfcdad@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e751fee-9e89-96c7-8246-c8af3ecfcdad@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200815_025431_986104_276FDBAF 
X-CRM114-Status: GOOD (  12.19  )
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

On Fri, Aug 14, 2020 at 11:37:14AM -0700, Sagi Grimberg wrote:

[fullquote deleted, sigh..]

> Would be better to reuse nvme_is_ana_error I think so we
> don't need to maintain ana status codes in both places:
>
> static inline bool nvme_is_path_error(u16 status)
> {
> 	if (nvme_is_ana_error(status))
> 		return true;
> 	switch (status & 0x7ff) {
> 	case NVME_SC_HOST_PATH_ERROR:
> 	case NVME_SC_HOST_ABORTED_CMD:
> 		return true;
> 	default:
> 		return false;
> 	}
> }

I initially had:

static inline bool nvme_is_path_error(u16 status)
{
	switch (status & 0x7ff) {
	case NVME_SC_HOST_PATH_ERROR:
	case NVME_SC_HOST_ABORTED_CMD:
		return true;
	default:
		return nvme_is_ana_error(status);
	}
}

but found that a little weird, but I can go back to it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
