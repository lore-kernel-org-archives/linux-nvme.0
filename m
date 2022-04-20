Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA87C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLQcAuU652XCiTWv8/b9X5/6XaiAuzulFe1uQJW3bo4=; b=RJWuV1Hhxv+163BIrILIjKzCil
	Lz7BI/G+1IIpXCtQItVkbeLzDSBvClQgd3klf4Vj0GysovKIXSPlB8N8+W2BF3jDPRGcvCiwwKbkP
	z+C8xdqAyZZwGfPhMFiNHUHe1VT07EuoYiysr74yh3ZX3yoT0SeZOjTIG4JhisdIUWArbuKuV3oTH
	M9MSrG8wqEP3ssO5ZZGb+8YceT4GELXf2xATMg9LOyTGi/jy6nyj74Y3O8VDNYyS2QFs/u7pqwU+K
	HxxCzY3X7RoimVqA3GVl7r5sMoOSdxJ8PSusCgif5Nu5BFgNy1lWG12RJeVNLu/Vkm+4tuawqwBQI
	L3tBhKGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhDlV-009psI-Vy; Wed, 20 Apr 2022 17:05:18 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhDlT-009prd-Ng
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 17:05:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BBC15B81E61;
 Wed, 20 Apr 2022 17:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0593BC385A1;
 Wed, 20 Apr 2022 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650474312;
 bh=c+AKJvGX71aqNABEFZtpCfQ+5Lzs898ms9TaehXDrj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sl1YUjxSlaFoDPg4zEIxvaZPwalOUrSiutAphkHKiW2tXo+rbDfEMgT5gHUaJp1y9
 S+YGADSjgG6I7T5XNGi7j36BjOkAyPmqCj0f6cMGVtCJmqZq2wzFdQ4UVQ0A8nHUZb
 bOsQqqQNMAZzyZEro6NG5Woz4KrALoeqYB9F+TjE=
Date: Wed, 20 Apr 2022 19:05:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tanjore Suresh <tansuresh@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <YmA9RZIIypzWOWV8@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
 <Yl+kzdPG2EvAGCFG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl+kzdPG2EvAGCFG@kroah.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_100515_954330_76B3E225 
X-CRM114-Status: GOOD (  14.47  )
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

On Wed, Apr 20, 2022 at 08:14:37AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 19, 2022 at 03:35:47PM -0700, Tanjore Suresh wrote:
> > Hey,
> > 
> > I did not hear any comments on this v2 version. Please help me with your
> > comments and approval so that this can be prepared for checkin.
> 
> Wait, there was comments, that you seem to have ignored.  Why?
> 

Because of that, this patch series is dropped on my end.  Please fix up
and resubmit a new version if you still want this.

thanks,

greg k-h

