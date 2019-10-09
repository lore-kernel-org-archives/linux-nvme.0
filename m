Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D58C47404
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 21:55:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE83218AC
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 21:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fg0tp9Tv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+kYOiHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE83218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PZ2ezsP1/fsRtW5DpSRzxO6MXq9xv+DlhpX+tW9QriM=; b=fg0tp9Tvo+0EksJih1ymakyBd
	wcP1fhcf0ExrAztoWFCSZfaIgTAYhtMPGz3vc5TsihNoHxGmdTdkECQYc6hOu4/qz3Ue0xhK7HuEn
	UHWQrFL1PHQSyNbR4Xisz5FLSOg6g+4F1x1YrPDssnQ547Ug/ReEBxpNRawTWQqEELYZ8SWxbZEnY
	KmSuJpZgnSkkCsS+IZ5QI7Nrf71C4+ckCQeWFHTIu0CEpa+yd86JAUlZHHVqoyu/9BdfyNJjjC7bn
	9jtZnAl+yC0Qy9+/wrF68G+Kj3fhwaSyUU69SlPtsz35wq/dsQ3rIfScRF273cEisyGCeRcIO2NVp
	o2Arvi86g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIJvJ-00072u-5p; Wed, 09 Oct 2019 21:55:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIJvF-0006Tc-DX
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 21:55:06 +0000
Received: from localhost (unknown [167.220.2.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB069206B6;
 Wed,  9 Oct 2019 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570658104;
 bh=oAoT7tDis+MgcqEHt2aEIBpYj48lAWF2BJLncuZbCME=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t+kYOiHIY1/XXGJ+YqbwsSVQJ4OGnXid5HkIT2iUNKD9ctwrzYs4E2iKQy7R5KWXu
 tcdKHV+br7WPjf+1hcaDrczQ2tJcAprxluUJvU7R0LAoi/wm74Uj2XTrW9zqi9N0A8
 aetHYm68XjNHJ2bBxRxP/IpdP0qPXDh86dnem/aI=
Date: Wed, 9 Oct 2019 17:55:04 -0400
From: Sasha Levin <sashal@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4.19] nvme: Assign subsys instance from first ctrl
Message-ID: <20191009215504.GW1396@sasha-vm>
References: <20191009162910.1801-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191009162910.1801-1-kbusch@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_145505_495870_28773B7E 
X-CRM114-Status: UNSURE (   7.40  )
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
Cc: Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
 Minwoo Im <minwoo.im@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 01:29:10AM +0900, Keith Busch wrote:
>commit 733e4b69d508d03c20adfdcf4bd27abc60fae9cc upstream
>
>The namespace disk names must be unique for the lifetime of the
>subsystem. This was accomplished by using their parent subsystems'
>instances which were allocated independently from the controllers
>connected to that subsystem. This allowed name prefixes assigned to
>namespaces to match a controller from an unrelated subsystem, and has
>created confusion among users examining device nodes.
>
>Ensure a namespace's subsystem instance never clashes with a controller
>instance of another subsystem by transferring the instance ownership
>to the parent subsystem from the first controller discovered in that
>subsystem.
>
>Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>Reviewed-by: Christoph Hellwig <hch@lst.de>
>Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
>Reviewed-by: Hannes Reinecke <hare@suse.com>
>Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

What are your thoughts about taking the following for 4.19 instead?

733e4b69d508d nvme: Assign subsys instance from first ctrl
e654dfd38c1ec nvme: fix memory leak caused by incorrect subsystem free
32fd90c407680 nvme: change locking for the per-subsystem controller list
092ff0520070f nvme: fix kernel paging oops
cb5b7262b011c nvme: provide fallback for discard alloc failure

--
Thanks,
Sasha

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
