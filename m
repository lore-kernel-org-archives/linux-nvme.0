Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C3C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 04:26:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE8360C40
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 04:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE8360C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8wcvpQZbx8aSECrt8npEoy6YNbwhapPFc9zijDdskPI=; b=SJWGf17nJiJFOPvdKNjovEcVQ
	hXXJkngOBVeUEJ+X2wjY+ObONyb2DmPhzG3BSZZnRZCEdwhuoVD4VxgO2Zj4iFCjIce+vNteHNiwa
	zB1HLB6OQNHYt0wlYxt3LvOqrCK9mvoK286m41mpq2Xj/4mmcQNTha6GfER2WLV9d+bHToltESL44
	XC43dONfmPQvCCzgI97UNBWFwJtFgWBR/gs+j79A5LFJCVEcNeFvq0ip2Lx5rPT543tLH0Aqaulzh
	kgdDADI63quKP8IKOAk4D9pjP4c/2M4NWfZPLdEtPSJ5Bpn8mZG+DUfjK96ggCm6cQGl+i6tEKULr
	/NgdKAefQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lA3YL-0006Kr-29; Thu, 11 Feb 2021 04:26:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lA3YJ-0006KP-HF
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 04:26:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F34164DF0;
 Thu, 11 Feb 2021 04:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613017561;
 bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hmQ5lVyZAVxs3xUaUYrqRR2s5n3vYNPyI2bqKbHcCI9utzmeLQk0TIbryBvizqU20
 4B3gIakw0d8RCBFYP+6J5DNPri/2oQcqewrtwHhdX1YsKpXkECdQkMGScAodp+c4lR
 OkoDmYiKZUHAihb4aPVa6szdWqJvWFvEWQs9MQwXRzFLBTfYJ4xLNcsMg7Fo5LnP4X
 7Jxn2Z0I3fFIBINMqD+PPNqqKlerQh4F6DEDwlrbON+U6bfxPJE42+2ldhCMIwgPeP
 E5hMOAMqDcmSpPZts3n3stBEZ3D8S7noMtzRNwvWZLxVPGyJOigzWQfgrgNWUjQy43
 M4LBxj2Cjfcsg==
Date: Thu, 11 Feb 2021 13:25:59 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-tcp: fix crash triggered with a dataless request
 submission
Message-ID: <20210211042559.GB28207@redsun51.ssa.fujisawa.hgst.com>
References: <20210210220400.1730263-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210210220400.1730263-1-sagi@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_232603_660076_8F1CE63B 
X-CRM114-Status: UNSURE (   7.30  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
