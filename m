Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8875C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:06:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74927611BD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 07:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74927611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WovdXS6QI0Pm6F6AIp1vbP6UWFa7ppLAL3MIeMw5IVk=; b=pmsgfFxaP4YAFj/9LFNMU+Idr
	qGEf08bF+lvCjLwFxDrjlsp2LE9Nc14X9hfaFDxW9e3dirMCgToGb5LdcYIqCOXb3KBVgeYD0PLCo
	9BUvA1W1w8M/ztHBeo0KSDcKfeOCcR5f8MjXISjfO9EbPkqGtSikQb5DK+Gdv6W2w4mJLTfOsOlNT
	AsYG8EBHmNmYeBqDWtr325swwrnbaekzrZz9h1b2wVWtmmeJTNf492ULS2MtXXAbKE/8T4l2VS31k
	mYCpiMDtQOacCBrduQFZvjEfrjy2gRKa4Egjbw1eVK+c/6kNHlv5ZZ+x4UuGoRmA2T6Jmewu7YzFN
	aUk9O2dmA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1litnc-00HFRK-Md; Tue, 18 May 2021 07:05:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litnZ-00HFQu-P4
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 07:05:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ry76OrNMe4lAs1Tht+t8+cwBWSsBvCH8liJ4DFV+y0I=; b=PDcuCMPm7c4O61MoqLk0I3BgGk
 tQIW7+QD5MDqUlDUUAAGHiLVZdCg/vydErKBHKS312GUeP90KPfVvZxTW83mWEj7M6VCFHIo6BYL0
 voxz6G5BJzv9vF6ukdMDwfSU5VYmxpLQcRbnLcHsd1/ebi2qsZsdPZrPmPsZ3jcrppbarQ9mRUVLt
 UYRP0lLPY4XYhH0v1A9kwbS1doGpz6I/22bbguOcErvZ8y0Cg2hgxYBLmbu11MJnCPEjS5e+Ec+0d
 ofDRPdkpEAySaJ+c2MSzJ5K+rUxEC0XYFWrTlNa23yahe+LiYnGFPFtLbmpxyWf7nCYomPDKfAt9T
 UX5zS8nw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litnX-00EOI2-5V
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 07:05:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CDAAE67373; Tue, 18 May 2021 09:05:44 +0200 (CEST)
Date: Tue, 18 May 2021 09:05:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
Message-ID: <20210518070544.GA8521@lst.de>
References: <20210517083215.105604-1-hare@suse.de>
 <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
 <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_000547_372673_05692CA6 
X-CRM114-Status: GOOD (  17.00  )
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

On Tue, May 18, 2021 at 08:59:09AM +0200, Hannes Reinecke wrote:
>> I asked this on v1, is this only needed for mpath devices?
>
> Yes; we need to send the KOBJ_CHANGE event on the mpath device as it's not 
> backed by hardware. The only non-multipathed devices I've seen so far are 
> PCI devices where events are generated by the PCI device itself.

Which really goes back to my repeared request to add a comment to the
code to document why we need this uevent.  It surely looks out of place
and it seems Hannes can tell a story of why it is required.  I'd really
like to see that story next to the call.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
