Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4286C432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 21:50:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAA82071B
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M5NX0p/D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxqTCnP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAA82071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E7diFuBWVArK9n5+zdW6T+KLsdFyxqvS80g9ljZTLV4=; b=M5NX0p/DoxzTb0
	gpFN5NOPsPJAUtzuzShyyySsOqMk6Hy6pWmmHnrdb5tbav8yyWI/LCm/Sw866YjfpNBHOC5DyxxiJ
	IdkY8KGE2ZVDIuMLFEYg+TJDJ1+7KMhvK1iiCWkU+rSvl4J1862mE5nUXfnBXKUCrXLXciUfmAfuH
	eOIHfCg6KBQcsT1CI2KM7Oj6Zl3bOREcrZLL/rcUXhiIsLgNnxxnoCHDDQEK3ddUq00a97sZ1RgBs
	8lo0aqfOomLFJJjgzV7Y9AF9jSoagYSSVpOhZEJNQAHN+3RrLz9p6zSl9LzUd/X6XbJkWvaf/WVsM
	5DMtEM6fJ2LuJ0OWrNvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYGoi-0008FU-D3; Fri, 22 Nov 2019 21:50:16 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYGof-0008F5-Le
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 21:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574459412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kh7qDWTTZhI/fz8UjxHMIGRX717fbHfRx0Y/tMRe4DQ=;
 b=QxqTCnP4QE0wStb6i1WZPzmDzKbd8V70L7NjgFQP3fk0FA+XmF8WlBjXEMk78YnPIGphrq
 V7aTnbvD+XCmzfrqBu5fNjHgBHqQ7UMQJMWJbxQmvcPK/Wxxdh5WXgo2KNiT+H5qsc83Dr
 ZWRwjqpAVedk1ldab8DCn80EZ7QdQvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Imd7MJw0PymO5ima_QPJww-1; Fri, 22 Nov 2019 16:50:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BA3E18557C0;
 Fri, 22 Nov 2019 21:50:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F2AB5C1B5;
 Fri, 22 Nov 2019 21:49:59 +0000 (UTC)
Date: Sat, 23 Nov 2019 05:49:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191122214954.GB8700@ming.t460p>
References: <20191114025917.24634-1-ming.lei@redhat.com>
 <20191121031154.GJ24548@ming.t460p> <20191121061431.GA22886@lst.de>
 <20191121074643.GB4755@ming.t460p>
 <20191121154531.GB17852@redsun51.ssa.fujisawa.hgst.com>
 <20191122094457.GA23632@ming.t460p> <20191122095743.GA21087@lst.de>
 <20191122102517.GA30001@ming.t460p>
 <b5148303-f05d-71c8-787a-597958c1909c@fb.com>
MIME-Version: 1.0
In-Reply-To: <b5148303-f05d-71c8-787a-597958c1909c@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Imd7MJw0PymO5ima_QPJww-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191122_135013_778652_43E1A3E0 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nadolski Edmund <edmund.nadolski@intel.com>, Keith Busch <kbusch@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 22, 2019 at 02:04:52PM +0000, Jens Axboe wrote:
> On 11/22/19 3:25 AM, Ming Lei wrote:
> >> as that will still overload the one cpu that the interrupt handler was
> >> assigned to.  A dumb fix would be a cpu mask for the threaded interrupt
> > 
> > Actually one CPU is fast enough to handle several drive's interrupt handling.
> > Also there is per-queue depth limit, and the interrupt flood issue in network
> > can't be serious on storage.
> 
> This is true today, but it won't be true in the future. Lets aim for a
> solution that's a little more future proof than just "enough today", if
> we're going to make changes in this area.

That should be a new feature for future hardware, and we don't know any
performance details, and it can be hard to prepare for it now. Maybe
such hardware or case never comes:

- storage device has queue depth, which limits the max in-flight requests
to be handled in each queue's interrupt handler.

- Suppose such fast hardware comes, it isn't reasonable for them
to support N:1 mapping(N is big).

- Also IRQ matrix has balanced interrupt handling loading already, that
said most of times, one CPU is just responsible for handing one hw queue's
interrupt. Even in Azure's case, 8 CPUs are mapped to one hw queue, but
there is just several CPUs which is for responsible for at most 2 hw queues.

So could we focus on now and fix the regression first?

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
