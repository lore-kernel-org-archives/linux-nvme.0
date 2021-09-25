Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E516C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 08:33:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95886127A
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 08:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D95886127A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U/ryRzSoZnUAf5BaY5RkujAhLTYEHLne6uKugQuaT9M=; b=OgW1+trbBYA1d4
	7s7ymSxyI2nUVyzJ50aVkFP+K+hO1m3rON3xWALKRjYaZYRDnMlP0gwfTCf4tFmf3NzI7HTij9iaW
	hAanClxfc8weDmEWfFzYQ5yj+fUWMwf2d942SXJbF5b3jf5PEonnnPxWItqc2PdkxdTLOO+jf9zGN
	tbo5KyhjMG8BUmOqdkh+ILq99QWhbnvMDIcG2QPVr02dYthDFx707mkCVs0Q63GupRdPwONCLS8r+
	7Oyl7U4WSCI4s2uXzAQctUbrrTQ5Gvvt5pYqQ864lMjTxl0J38pv/I0zOBtPRjcFbI1I54V9dKbKp
	bLtpGxP9v5N6V9m4UkgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mU37O-00GIfe-NS; Sat, 25 Sep 2021 08:33:10 +0000
Received: from gate.crashing.org ([63.228.1.57])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mU37L-00GIfA-OW
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 08:33:09 +0000
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18P8VwJB021277;
 Sat, 25 Sep 2021 03:31:59 -0500
Message-ID: <de8f41b03ff2c82f7013ef3b9e7dc3b044c2b69f.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 0/3] nvme sq associations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Busch <kbusch@kernel.org>, Andrey Nikitin <nikitina@amazon.com>
Cc: linux-nvme@lists.infradead.org, davebuch@amazon.com
Date: Sat, 25 Sep 2021 18:31:58 +1000
In-Reply-To: <20210925030207.GA20848@redsun51.ssa.fujisawa.hgst.com>
References: <20210924210809.14536-1-nikitina@amazon.com>
 <20210925030207.GA20848@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_013308_074000_EB63BB5F 
X-CRM114-Status: GOOD (  11.41  )
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

On Sat, 2021-09-25 at 12:02 +0900, Keith Busch wrote:
> 
> Different submission queue groups per NVM Set sounds right for this
> feature, but I'm not sure it makes sense for these to have their own
> completion queues: completions from different sets would try to
> schedule on the same CPU. I think it should be more efficient to
> break the 1:1
> SQ:CQ pairing, and instead have all the SQs with the same CPU
> affinity share a single CQ so that completions from different
> namespaces could be handled in a single interrupt.

Can this be an incremental improvement ?

Cheers,
Ben.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
