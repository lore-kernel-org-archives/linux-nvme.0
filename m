Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED41C47085
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 00:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A585F61057
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 00:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A585F61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jtcDreTtDbPC/cEPHkJF8JYxYtpd9WejrbUKkNnrReA=; b=qmZME6oUh/Zz5S
	nHwkgk9OFFhylHrCN+ad+QqzfqbkYmyyTPMa1Ee/liqSs+vAL/4vg5M+j7IZluTTboVSWSRPz60wn
	UgR1ZnwyoDb7BrfJUCRymPwBgHlk9JpeWMcf+GZHXLLEJfgEV2KR907z1DqW2nSZm0jdi7lUS5TCN
	bv20vUKqx4TwjX1bB09xV4yfDtcfNK9oC2NxzbNaw8PmxoL0AiH3swTVwB0eo1Vnpj/Xe7bqm9FJV
	+koi8ZvxL5YWxby6DarUsZABXEuW5jymzL080WDMxh6VLR/Cz+HTdFwTtv14u3LqIe8WCAErFAqwg
	8MFBQlNh+wiuQs+BEWvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llKX0-002SEq-Cj; Tue, 25 May 2021 00:02:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ll599-000kQS-Aq
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 07:37:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5756668AFE; Mon, 24 May 2021 09:37:05 +0200 (CEST)
Date: Mon, 24 May 2021 09:37:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210524073703.GA24372@lst.de>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
 <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
 <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_003707_542433_A93507A7 
X-CRM114-Status: GOOD (  15.92  )
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

On Fri, May 21, 2021 at 01:19:26PM -0700, Sagi Grimberg wrote:
>
>>> Forgot to mention: During testing dynamically adding namespaces it was
>>> possible to trigger the WARNINGs in the nvme_parse_ana_log(). Initially
>>> the subsystem started with 8 namespaces and during runtime another 8
>>> namespaces was added.
>>
>> The controller is required to have a non-zero MNAN value if it supports
>> ANA:
>>
>>    If the controller supports Asymmetric Namespace Access Reporting, then
>>    this field shall be set to a non-zero value that is less than or equal
>>    to the NN value.
>
> That was my thought exactly

I think we should add a sanity check for that and reject the broken
controller if that is not the case rather than working around it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
