Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEAAC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:56:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30966206BB
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KEi82Zgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30966206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uypu5kfgU4uaEZAyS6H9OdnIue0vEtBEaRK0lCuoymE=; b=KEi82ZgdKQA353
	SnkN2IugXHcAYOKZQIuLC0/n6AbVnmVnR5x0QoI30tud8yO3mf4QxwBKef2ZNXzrTBbZe6pCjcXLK
	hr4s7PxeEcQ1wW1fNNSZBn5zeBjbefMPaFyUjycfAd3UY442gBBgzcr2RkDl9oh2xh41sB22FxujS
	y/HwBAB9IMok+uxsAjHYwd52bkLGH9rObSOebnagefSQo6SHDqCyhK0b89QrVB1PiePDe+vhBR/Wo
	n5ATtIHQcOXmSrj9vwncKUMb1Fy3E+QM3FX//KO0HFmz5AlT+jVi8zsp1MYZyB6rcTvtodbrtXFtd
	CiHOUOYxjC11DMCzYaig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5ynx-0006KN-7X; Thu, 05 Sep 2019 20:56:33 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5ynv-0006K2-BW
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 20:56:32 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 13:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; d="scan'208";a="195221739"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by orsmga002.jf.intel.com with ESMTP; 05 Sep 2019 13:56:29 -0700
Date: Thu, 5 Sep 2019 14:55:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] nvme: Wait for reset state when required
Message-ID: <20190905205501.GD25467@localhost.localdomain>
References: <20190905142607.24897-1-kbusch@kernel.org>
 <20190905142607.24897-5-kbusch@kernel.org>
 <a1895103-5906-7a46-9222-478bc76a2dbd@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1895103-5906-7a46-9222-478bc76a2dbd@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_135631_408968_E75D570A 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 05, 2019 at 01:47:26PM -0700, Sagi Grimberg wrote:
> 
> > Disabling a controller in a path that resets it in a different
> > context needs to fence off other resets from occuring between these
> > actions. Provide a method to block until we've successfully entered a
> > reset state prior to disabling so that we can perform the controller
> > disabling without racing with another reset. Otherwise, that other reset
> > may either undo our teardown, or our teardown may undo the in-progress
> > reset's bringup.
> 
> Why not simply flushing the reset work like nvme_reset_ctrl_sync?
> 
> I might be out of context here...

It's not enough to know a current reset completes. We have to know that
another won't schedule, which the RESETTING state guarantees.

More context:

This is for when we can't re-enable the controller in the same context
as when we have to disable it.

For example, PCIe FLR occurs in two stages. Suspend/resume is another
example. An IO timeout occuring concurrently with either gets the
wrong end result because the timeout tries to incorrectly re-enable the
device. This patch appropriatly synchronizes everyone through the state
machine to prevent these things from running concurrently.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
