Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BCCC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 11:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aaR+m7SvBmFhn3PEThDwPoyMGY38LDHh7hCgc2hVRsw=; b=j4Yu7NYmx2Mhl5vmStjcqw4nYT
	71hevAUex/d8UEcspO20geV3yuynO2VnrlXQFJxiJddtNAt8qxL6pMnYPeN9um45/2yM3HdJp0H1E
	dbqDvVkrQTAGT/Hk/80jUEl3zBy7oa+GTP/oJVu50/zqgSnY5wTxHq7zmE2b/7Mucq0AdtldqDVWa
	84nDVEWjjrFqAvHMxnoh7mgnjo3GqChUYoB1C178nph1ZNxGhwNmOnczj1hrw3Jz4QxXKAXizOXg5
	wI8KGUU7O4gyS6iNhOIbVf7UAeTsQawMSTZVLSQPqq7pFodJ43998pWW+2eGpNxLZzEBRXbvlZIjT
	3LaY7FCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3y6K-00A3EI-85; Wed, 22 Jun 2022 11:00:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3y6H-00A3DR-CG
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 11:00:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1C6468AA6; Wed, 22 Jun 2022 13:00:38 +0200 (CEST)
Date: Wed, 22 Jun 2022 13:00:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Alan Adamson <alan.adamson@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220622110037.GA27411@lst.de>
References: <20220608075252.GB13027@lst.de> <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com> <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com> <20220609035323.GA31248@lst.de> <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com> <YqNRPEpZgT8Xn9Nr@kbusch-mbp.dhcp.thefacebook.com> <B396ED69-5559-40F0-92F3-8B319D90584C@oracle.com> <20220617090100.GA7767@lst.de> <572E6BCA-2B80-46BB-9FBE-F6AA3D7C8FAC@oracle.com> <YrIX5Q5xODHMC5AT@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrIX5Q5xODHMC5AT@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_040045_598319_096795AF 
X-CRM114-Status: GOOD (  12.00  )
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

On Tue, Jun 21, 2022 at 01:11:33PM -0600, Keith Busch wrote:
> This is clearing the other descriptors only if the controller also reports a
> CSI field. I think just do something like the following on top of your patch,
> and should be good to go.

Agreed.

