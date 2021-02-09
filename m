Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F67C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 15:35:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E5964EB8
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 15:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E5964EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IpcnokamIDCSEmrZjfGuRjJSq7AA3ejdpZ4mbgJ3+mo=; b=CCS6rGd4/rW3Z5qDR19ZPCQla
	GqfVKlbqlTtcw3RXlGoN91Ygjl6rHX17j9u+Rrk98R0v8P35GvX7ZHR2mWbLsXJr++MrMJK7Cp36V
	ksT/IQyaO2BUJZ8aD3xm1xwpNKhb+3BiM9DjODI0RZZ2bDbpN1lBwYeHYAVSg4QSCCBrN9tOreXUG
	IDPkADYR6PuTok5sxQby3SbJjNOJCHjtvbp9OASGaR2H8KICATwdvnOYAbqISUXmYfNeyafyMUtjy
	GL9Kn/dsO4ReSWOhBFHFG7X9vRcAwfK1kPoxcJW76QTTL1PO7mhuG7G8HWweyW/q10+xIt1Mov539
	+Xoa2IMwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9V2o-00015f-AI; Tue, 09 Feb 2021 15:35:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9V2m-00014n-E0
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 15:35:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AE07D67373; Tue,  9 Feb 2021 16:35:03 +0100 (CET)
Date: Tue, 9 Feb 2021 16:35:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
Message-ID: <20210209153503.GA8607@lst.de>
References: <20210121090948.8027-1-mgurtovoy@nvidia.com>
 <20210121090948.8027-4-mgurtovoy@nvidia.com> <20210127174717.GF28180@lst.de>
 <BYAPR12MB349445BDAFCBD9C9FBC32701DE8E9@BYAPR12MB3494.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB349445BDAFCBD9C9FBC32701DE8E9@BYAPR12MB3494.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_103512_600400_C0843757 
X-CRM114-Status: UNSURE (   7.48  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 09, 2021 at 03:07:05PM +0000, Max Gurtovoy wrote:
> is this respin still needed ?

Yes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
