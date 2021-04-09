Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC073C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:52:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E3C61181
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E3C61181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ro38Zmqy2aclAt8d0d/9/dxd/t9/9zjK/rGENKoyadg=; b=pjyJ0FD4nF35/woEtdpDKTHQq
	vB1iHc/NhcITHDDY22xujNE+jv8S/+sRuzPNd25QtmKHTeFBxf5H6o9MJ8auciPMlZG3GEnEjn4sd
	qmLAjrhUnON2lPzJvEZtaLiV7rEKB1VIPnds/ixUJBofW9arux4hB7dHwuIL5i4l21Wg4Pk1ejjnb
	wufv+ndvh44WNW2+wiw7sy5W80vISyg6Qz6sKREmmiCsTLHjtCWUewzPvmaye2UpNGiJj8PkmBcDm
	1Byq/g7GDad+j5qbqFWNpZ+MkMZnvjoD4W2l9Ji4ZaCwak44cCDs90C/tMJZgolgRIQJJL3CqXnu5
	hUUQKs3jQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUnoB-000Jz2-FH; Fri, 09 Apr 2021 09:52:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUno7-000Jy0-M0
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 09:52:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EFDE868B02; Fri,  9 Apr 2021 11:52:05 +0200 (CEST)
Date: Fri, 9 Apr 2021 11:52:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210409095205.GA15931@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de> <20210409072901.GA2085@localhost>
 <20210409075415.GA6991@lst.de> <20210409080214.GB2085@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210409080214.GB2085@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_105208_116669_B6B57209 
X-CRM114-Status: GOOD (  19.50  )
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

On Fri, Apr 09, 2021 at 05:02:14PM +0900, Minwoo Im wrote:
> On 21-04-09 09:54:15, Christoph Hellwig wrote:
> > On Fri, Apr 09, 2021 at 04:29:01PM +0900, Minwoo Im wrote:
> > > Tested with namespace-specific admin commmand (Identify Namespace).  And
> > > it fails with invalid IOCTl because we don't have a route to the
> > > controller IOCTL for the generic chrdev.
> > 
> > Yes, that is intentional, as supporting the per-controller ioctls
> > on the per-namespace devices is a mess.
> 
> In multipath case, head blkdev is also per-namespace node which is now
> supporting the controller ioctl by nvme_find_get_live_ctrl().  Is there
> any different policy between the existing blkdev and generic device in
> the current series ? Or should be just deprecate the controller ioctl
> from the head blkdev ioctl in multipath case ?

Well, the multipath block device is supposed to be a full drop in
for the block device, including having the same name.  So I don't think
we can just deprecate it, even if that would really improve things.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
