Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED7CA9EAE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 02:21:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B060120663
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 02:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VMfilSLM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyB5qy3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B060120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gyyHza3TDLxrt+fdw9NEQ+eAuzwp+IGqqIQv8HRPBTE=; b=VMfilSLMhxqusj
	1W94l92BdtpENOoCDFO4xNOMIqg8df1SKdcN1jMXwCApVynrphpoPvqqsz0MMaWqUCgpj868G8uvH
	WIX7nBT8kMGuauuc9M/w9MSyr5P7IRoAkm1NSs9eUhV6Ytlj+AZwpNxynA8PMm7l6AYIylIp1GDOF
	Zt3PLiWq9EbG2wsQwAWAyyHX16idDgOK5+fhcs9xL+I9TM3/nMfYlbcWLDJOzW8CHBUK3Gw4yGism
	Mx3+FhflXKm3qL2nlrY6x45DuweoAklaPEDcoH0pTpxOkH6UJ0TLGvu+lhWqIcVtXLM9OuLEYJxQD
	vP//r9EevO/bZ3bP6Qlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPdbf-0004tk-AG; Wed, 30 Oct 2019 02:21:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPdbc-0004tI-N0
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 02:21:05 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1CAD920663;
 Wed, 30 Oct 2019 02:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572402064;
 bh=w0/3kaUB7oCF0vshvYPuesKYeBvfIjAAwdfE2oWpGdM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oyB5qy3jMoEteMB3Tr8NkiRbCV052Cx2As2GHK2mlZErKt6AjASTUoTurviAl/o17
 qxWFXtPVueRIGIey8YNKfGmv8GhL42kNTYXdU/7lelIpdXi/Aj/R+bABLRZjHxsRTH
 5PBEcoWm6Njnr7Gv3sgGvHUR+M2MvM/jzSnbzKCw=
Date: Wed, 30 Oct 2019 11:20:57 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvme-rdma: fix a segmentation fault during module
 unload
Message-ID: <20191030022057.GD15332@redsun51.ssa.fujisawa.hgst.com>
References: <20191029144227.108450-1-maxg@mellanox.com>
 <badcd22c-54ef-a4ab-2080-55f697b184e8@grimberg.me>
 <20191030004643.GB15332@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030004643.GB15332@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_192104_772244_C5F95FFB 
X-CRM114-Status: UNSURE (   8.80  )
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
Cc: shlomin@mellanox.com, Max Gurtovoy <maxg@mellanox.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, israelr@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 30, 2019 at 09:46:43AM +0900, Keith Busch wrote:
> Thanks, applied to nvme-5.5.

Oops, this one is a fixes, so I've put this patch in 5.4, and the other
in 5.5.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
