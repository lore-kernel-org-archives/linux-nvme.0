Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF534C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:41:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8822E2082E
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b5euWIRQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QjaptZIe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmABzUh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8822E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tBOOPeeBOJm/2BHtzIBUgTQRvr9J5y20Niyy3u9MsFs=; b=b5euWIRQ6iv9+l5OPswD5c2HG
	z373vqvAqGHwGCAtElGyLi6p06yQGJDjnYtu932cO56H97x7lL3F7QuDzjJwsc3KTmVOR4HQ6jZYJ
	WCsQY9MgU8rZBjMac9C7r8JRv4FHpkbo2kcU3fqzydZm3EL7/3BO/7FU7SxcDTOClvqckCtNv++Qh
	oL2AkhJ1DypZF9sNIqCpqB4xpJQZo7iS4t+vth+GX22mBLUYtk02kb29YAnvgmrkZtKrKSqqvZ/4V
	z3VXjDn1UpYNVULkEsIVadfKdVPuas+jXBYYFa8HUxLSBrI6p2GSCX4mKLYMFbDRp04FOl03TXoE7
	ciDwsAPuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomj0-0000g8-Jq; Fri, 26 Jun 2020 11:40:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolL6-0001wR-S8
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:12:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=c4cTSsUezX96Rwg9PngmOXJn/n5tbOZb7vuxiLpOkvA=; b=QjaptZIe171TW+44Clzth9P+qH
 RQo4q1LHwFeGz/G9xe2LfKFvwn3YblNhIVTIIGNNKM9VXUgDFxIzDwNNAffXQVoODUQfRqnP3pfd1
 yaaV77XQF00+YYGbXoPrYk9q8ujkIF9UCf7hYOxf4tfGNBD/QhGW3RHUZYMn+guPMdvLAXAOsRzq3
 RXY1edMy2KB6oBmPGtamBXa9Po/7j75ak6fohjJaxWvvMy0gn0zMauySM/btjR9lDJrXVoifuksgM
 nDxTGQmQ96gowTgfUf/xOXARohNwtLERQbAE8EWmRIMMckE84r3r/eWkFbMh7DOmXoRGT61CrX9Zh
 d/2x0REQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joYRL-0004Eo-S7
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 20:25:46 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D4E12072E;
 Thu, 25 Jun 2020 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593116741;
 bh=c4cTSsUezX96Rwg9PngmOXJn/n5tbOZb7vuxiLpOkvA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CmABzUh66EQBbjd3WO+57e6gCUL4bnXKtE/Mf5vjeYYErq7P5vhHPhE8pmzMinGFE
 yWjP/1btseQbBCi7kjzHtzHM9ah6bdBbG8+LNPm+vYQQ8ZkNXoA1eeMyfmbXloPudm
 hpvLxpkduVmph0dQZ0Oz9DJgtXTneH852QcSZzlM=
Date: Fri, 26 Jun 2020 05:25:34 +0900
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Message-ID: <20200625202534.GA28784@redsun51.ssa.fujisawa.hgst.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
 <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200625_212544_315540_62544EF0 
X-CRM114-Status: UNSURE (   8.92  )
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 25, 2020 at 09:42:48PM +0200, Javier Gonz=E1lez wrote:
> We can use nvme passthru, but this bypasses the zoned block abstraction.
> Why not representing ZNS features in the standard zoned block API?

This looks too nvme zns specific to want the block layer in the middle.
Just use the driver's passthrough interface.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
