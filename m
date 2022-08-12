Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9406C00140
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 05:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HweWSmvmD2c1NosW6lpOZ2fFYRG12L+8YElxJFHn39o=; b=1uewhuzyAt6bdmc9ouorcALUBc
	AoBPnrDLk61vEJ8cIbx/Px/WMaighisacxLguUJHIZYsrB2nVId62ddHb3MSDMh3x2RQjSPUXpri+
	E9wz4KV6EInWguA9Ox+PhH41ZRqBFDcaOrJ9zqedtNi3fgz3mS7TzFWs7guukUs6BGROdpf/ZCQR4
	uXzjFYI0r2rx0HbJ0ym5BvIQWTahbODa6kp78Eaq/G58uNO33DZpWCwHPiiFsmt4TEXEyr9zTDca6
	/fjL+F85CVJ+e2m5ewSWOJKwGQLZKauD48c8PQXDVfI3KS2BPhoXsv+3LNUtlE0n6C9ig1mFOdu5g
	DD3gpNWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMNIn-00Fmt1-AH; Fri, 12 Aug 2022 05:33:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMNIk-00Fmmo-Ib
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 05:33:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34F1268AA6; Fri, 12 Aug 2022 07:33:30 +0200 (CEST)
Date: Fri, 12 Aug 2022 07:33:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme: do not update kato from a dsm io command
Message-ID: <20220812053329.GA24588@lst.de>
References: <20220811192608.3387239-1-kbusch@fb.com> <YvVgIzRXRv6EKk98@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvVgIzRXRv6EKk98@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_223342_808258_F80F3703 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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

On Thu, Aug 11, 2022 at 02:01:39PM -0600, Keith Busch wrote:
> Actually please disregard this. We don't reach the effects_end on io commands
> as it is already.

I thought we do, what prevents them from ending up there?

And we really should be more careful on admin vs I/O commands here
anyway.

