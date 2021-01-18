Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B337AC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 17:59:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A67F22CA0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 17:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A67F22CA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=oxkkDzr/K1zKh3dtKcjr0ook3
	cLC+jGLtzPB6XhJvs0BcCUpJRA053qb7kgJVs+EMo+bJCJMf/JbWmQQK6N9fOMP2XbeoDOkqBRSrJ
	gouako9kg5aWiRWggaEbuKm4Xd7ih4Vf9KRRAJzElRxU4zdV9kzM6AnJpbCHTXGe2i2UZBon6lck2
	1fHCfhzMfwP20k3g3egSJR/erBmuvwdc2v4gb9AzuohMXPSHEbReHmtarNTP2Xy31Q2rQ0J591lZe
	LHMeit1nz7GWZFZmYPzc5dcof8h6xipQWQHcM/VveNiC5TlhhM4rcPnQ5OXcQPMSGDiSVrcEtIPaU
	RqrKwTxZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1YoN-0004s8-1E; Mon, 18 Jan 2021 17:59:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1YoK-0004ra-Bv
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 17:59:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CDCA16736F; Mon, 18 Jan 2021 18:59:26 +0100 (CET)
Date: Mon, 18 Jan 2021 18:59:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: Re: [PATCH v3] nvme: Check the PRINFO bit and the Metadata size
 before deciding the host buffer length
Message-ID: <20210118175926.GC9901@lst.de>
References: <20210115015507.45615-1-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115015507.45615-1-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_125928_506118_C866AA4E 
X-CRM114-Status: UNSURE (   6.46  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Jonathan Derrick <jonathan.derrick@intel.com>, hch@lst.de,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
