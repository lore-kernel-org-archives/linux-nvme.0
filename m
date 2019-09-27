Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF8C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:36:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B8A2075D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hWWnBwjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B8A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IWN5r5mq9EJBGZ5SmBJ5O/44qqTKuryOqYSDzaZSRGw=; b=hWWnBwjN42XQUb
	05vKNYr86Z0KKGDfm9fFSobwyv8HSy0xacEdclIRvGtwhAGhPd6lkHSJ7KJqLVy8meL2NBJIQo33y
	t0HNeJmFyc2j3dHJa+Whr2vOhF+JF2EFtQ1j7ca6j2FC5KPRzQp64zRBKClPWJCdrlM9Rb0Sjc74y
	a7NKqetksKH5VjPE7BCEOq0dv5AcEMDRmNX7mv/uxPMF8+fgnuL66dm9uWG48Q8YLzcLjCL/NSoEF
	av520ykDlQsF/sOuE9jXY1hd1UzMHqSYystdtdN2wwD+tslBHAPjHWGz6S0AoSWjCEUlDNX0U/HVu
	ENvrXNGi66wrT2MxoHnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDxuO-0002l4-Sn; Fri, 27 Sep 2019 21:36:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDxuM-0002k8-4S
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:36:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6CAE768B05; Fri, 27 Sep 2019 23:36:07 +0200 (CEST)
Date: Fri, 27 Sep 2019 23:36:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org
Subject: Re: [PATCHv2 3/6] nvme: Restart request timers in resetting state
Message-ID: <20190927213607.GI16819@lst.de>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190919213431.7864-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_143610_317839_1FC25419 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: James Smart <james.smart@broadcom.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 20, 2019 at 06:34:28AM +0900, kbusch@kernel.org wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A controller in the resetting state has not yet completed its recovery
> actions. The pci and fc transports were already doing this, so update
> the remaining transports to not attempt additional recovery in this
> state. Instead, just restart the request timer.

Looks sane.  You don't happen to have any good idea how we could lift
this kind of logic to common code?

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
