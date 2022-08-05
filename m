Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CFFC00140
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ga2cCTSN3yZBMW5yvU/lttjepAbBJTyR4B1NePmyphw=; b=gpmHgH73vW5BrPWk2GPnMWsl9J
	KYtME4h466cq0Oeq7NGYMa0inQjvx531DAqYqrWvSFNYGCQFiUNwGDivIGilxBsl4V7Qm8huS0xJl
	KCTR+zKOLmwFGNpPnEQHZC8bazz7vAIhz+B7bVu5R+YGR9l1yWSnkD9xZv5Pqa8vr1SDXwE48YjT4
	jXRqflk0hXCcfUfrUx7eot1SCvXBNQTZTz9O726MpsyhaEmsjtfop455p2Qu8KW7iXt7Ghy/HCMK9
	W9Jde2e7zMZlXF8XqGCh2crK5l58odn7iMkQVktUlIC2jxIdEI4l6NZNxH5n100ZFNlm1xg+Rngaz
	wmczeXEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJwXe-00EySM-UY; Fri, 05 Aug 2022 12:35:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJwXW-00EyNL-06
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 12:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659702891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ga2cCTSN3yZBMW5yvU/lttjepAbBJTyR4B1NePmyphw=;
	b=DLSsolO3P3ELATl9IpDaI+gAA/94BzzVaj9RXuthDrRtn2hTE4NrAYl+s6PTrpJM124EiI
	/z6dCIcbTCogudI0JyrEY/ew1ERJq18KkuxVBtR2q5jAY4nNtkOHeCZ7BHugubOoBmHCzr
	XL898koKv/DxQgIUkgl20/yI0Ibbr+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-c9A5ZMmuPy-4tTP_B7ntPQ-1; Fri, 05 Aug 2022 08:34:48 -0400
X-MC-Unique: c9A5ZMmuPy-4tTP_B7ntPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDD0A803520;
	Fri,  5 Aug 2022 12:34:47 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 05ED3C28125;
	Fri,  5 Aug 2022 12:34:43 +0000 (UTC)
Date: Fri, 5 Aug 2022 20:34:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	ming.lei@redhat.com
Subject: Re: [PATCH] nvme-pci: fix race between pci reset and nvme probe
Message-ID: <Yu0OXgQo/HdusMEu@T590>
References: <20220801125753.1434024-1-ming.lei@redhat.com>
 <YuxAQmHrwLGL4Wap@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <YuxAQmHrwLGL4Wap@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_053454_158206_9BE7DBD2 
X-CRM114-Status: GOOD (  22.91  )
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

On Thu, Aug 04, 2022 at 03:55:14PM -0600, Keith Busch wrote:
> On Mon, Aug 01, 2022 at 08:57:53PM +0800, Ming Lei wrote:
> > After nvme_probe() returns, device lock is released, and PCI reset
> > handler may come, meantime reset work is just scheduled and should
> > be in-progress.
> > 
> > When nvme_reset_prepare() is run, all NSs may not be allocated yet
> > and each NS's request queue won't be frozen by nvme_dev_disable().
> > 
> > But when nvme_reset_done() is called for resetting controller, all
> > NSs may have been scanned successfully, and nvme_wait_freeze() is
> > called on un-frozen request queues, then wait forever.
> > 
> > Fix the issue by holding device lock for resetting from nvme probe.
> 
> Beyond the issues with locking the pci device, I think the problem you're
> describing is generic to any rescan that alters the namespace inventory, so we
> can't resolve it only on probe.

Yeah, just it is easier to trigger during the 1st scan when no any NS
exits.

> 
> Is it enough to track the frozen status within the namespace flags? Something
> like the following:

I guess the patch could avoid the issue.

Another way might be to remove nvme_wait_freeze() from nvme_reset_work(). No
see it is necessary:

- nvme_dev_add():

if (!dev->ctrl.tagset) {
	...
} else {
	blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
	...
} 

If there isn't tagset, there can't be IO; and if nr_hw_queues is to be
changed really, blk_mq_update_nr_hw_queues() will freeze queue, otherwise
it isn't necessary to nvme_wait_freeze() before calling
blk_mq_update_nr_hw_queues.



Thanks,
Ming


