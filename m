Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EBCC624D6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gEe1d8sG+0EgjCoTSlQmflPrgCIUiZwfZ4LCrvMwTsg=; b=HegsdIeLmYROEIinGekivNhOhJ
	puytxjw/zEpuXVj7/lQ8FHaQDvN8qxXnVmfJwIz4QngcrSjw4q6qO8fYF8gZnFIH1mqIah2LEts07
	ZhYWLmvniAszq3bX2Fws8hLqSOS3iGNAQHimxFB9XQb6iukPx924TIbGB2pMGvkCiDlG4fbkYAo15
	VuhSr8684Xp27F5nOJLOIDAvzQgggEpBf+Mb20Bc0/zxgRi+/um8qxPdFAZ/6JmoYMUnVChcCRqZV
	K1QXMCNWLuw/d+QYtuetCiybD7z4bBV+BMI16BdYHMtz1nAyLOFvVi+3S2QAjbwFSYDhT5KOWRn+u
	x9/cOFeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lit-0000000EuZ2-3Ckq;
	Wed, 02 Sep 2026 14:13:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lis-0000000EuY9-1msO
	for linux-nvme@bombadil.infradead.org;
	Wed, 02 Sep 2026 14:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gEe1d8sG+0EgjCoTSlQmflPrgCIUiZwfZ4LCrvMwTsg=; b=qaY1wJ2MRXY/yqjZR9M0tJbwpM
	FBZM4yb/uhQpLXv+SC35nFlmyqXLZCqjLpgcmUv2vpaPXxa+GltY7/kMcHUI8XAZGwAYDVqBlW8DZ
	NZf7bIUCGb3XLCk+9Pwj9Jr7pkkiuZ3pkmAarAAbJ6fezwsGJpDq04jM73WyhCZEBJIIzTE3OJXl3
	bsDTy8EtcOwQzrn1H2vXKTehyKQ6Tfwwm06LMpJ05kVnok64nKRgEbG5T1lvSu+ROo3lTKrk7FXfp
	qaeujcY+v4yBmmN5TsHWW1srxk7M18XVJ1tqJrNEBWqtHSAzprprs+ZzBaef5D2vpTbDDoG0tPqU+
	wDpXze5Q==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x1lip-0000000C4i3-3UYt
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 14:13:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B324B6732A; Wed,  2 Sep 2026 16:13:47 +0200 (CEST)
Date: Wed, 2 Sep 2026 16:13:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	john.g.garry@oracle.com, wenxiong@linux.ibm.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
Message-ID: <20260902141347.GA24385@lst.de>
References: <20260831152006.819471-1-nilay@linux.ibm.com> <20260831152006.819471-2-nilay@linux.ibm.com> <20260902133104.GA20945@lst.de> <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_151351_983847_7582770A 
X-CRM114-Status: GOOD (  13.70  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 02, 2026 at 07:39:32PM +0530, Nilay Shroff wrote:
> So the practical problem is that an open multipath head can continue to
> be used after its underlying transport module has been unloaded. The
> proposed change keeps the transport module referenced while the head
> node is open, preventing the module from being unloaded in this
> scenario.

But why do you unload it in the first place?


