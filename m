Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F1C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 05:26:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E290060EB2
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 05:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E290060EB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p9wS9XZENPT79xhJ1OLcd8TreWgET8CN5pcfHFaDnM4=; b=SNvFEf7dnvLPq+
	+2xQvXVjsnHKEuok2xP5+QU9E+aLpRD3msGcOQqPCbCKh1pL4TgJ+gG53LvtKuIvOP0T2xFS02ZA1
	E7CBzwEWI/kTan0Go8whOwOY3NJawcn5MZfuvTqPnApfYqBDV76UD6pp5c2TwiLTgAkBMoFaLP2JG
	WYeTRPcm++CMBl5PT1zIBuumkKs+6utCgxyfuaauEE4X3fScoyXhvGIJzwkE03dCIriAC+lAItSWs
	uHNbhl9Ksg960XheLXKsIGK/AEW39hjZBDN1JEhYlafwKFu6CAdYM/wEccZJqayU+yA0sFM8P3CLv
	rBAesdM1YBDqmvAMyeZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6nhL-003R2J-PC; Fri, 23 Jul 2021 05:26:11 +0000
Received: from zeniv-ca.linux.org.uk ([142.44.231.140])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6nhI-003R1c-0W
 for linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 05:26:09 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m6ncc-0034np-I3; Fri, 23 Jul 2021 05:21:18 +0000
Date: Fri, 23 Jul 2021 05:21:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@nvidia.com>, dsahern@gmail.com,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 edumazet@google.com, smalin@marvell.com, boris.pismenny@gmail.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 benishay@nvidia.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 Boris Pismenny <borisp@mellanox.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>
Subject: Re: [PATCH v5 net-next 02/36] iov_iter: DDP copy to iter/pages
Message-ID: <YPpRziMHmeatfAw2@zeniv-ca.linux.org.uk>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-3-borisp@nvidia.com>
 <YPlzHTnoxDinpOsP@infradead.org>
 <6f7f96dc-f1e6-99d9-6ab4-920126615302@gmail.com>
 <20210723050302.GA30841@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210723050302.GA30841@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_222608_098037_37C3E8A1 
X-CRM114-Status: GOOD (  12.40  )
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

On Fri, Jul 23, 2021 at 07:03:02AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 22, 2021 at 11:23:38PM +0300, Boris Pismenny wrote:
> > This routine, like other changes in this file, replicates the logic in
> > memcpy_to_page. The only difference is that "ddp" avoids copies when the
> > copy source and destinations buffers are one and the same.
> 
> Now why can't we just make that change to the generic routine?

Doable... replace memcpy(base, addr + off, len) with
	base != addr + off && memcpy(base, addr + off, len)
in _copy_to_iter() and be done with that...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
