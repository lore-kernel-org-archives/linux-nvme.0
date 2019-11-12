Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B0CC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 02:10:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AA6206BB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 02:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uNzeKNM6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARcfukQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AA6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NXFN28QaiSSmkosgqeEXT+k+dlgY/dP5UQ0GO0EggfE=; b=uNzeKNM6WG87Ci
	yH8rtLMCS68eY2YYECEN4F5PDpe6Fk8JH3BF4ofy26qdF9o0PFkdmXPvClP0grxmijuVh129okQ13
	pIjy2UYqKHCHiHAxa0fQ2E5ALAL3b8fO61gWvgPhr72yGrkv2zxFFZrps2Ug+2GzW0jS4UlwmDleu
	dcPSDqLuoO9z8IltYM9wPuKYmp+4YDWR35H67N4QhjNdVkQOKlGKPR9W712tLN2/NMzrE7vHvfhkm
	sGiPFfLqOGkGS6L0gVtHwL8GyPp4KlKhY1joGME+DWTQmV66mFBBV6869ac2lleBq0B2yr0O+8m2A
	UDguvQhGG/Bt47BkpLaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iULdA-0002lm-LL; Tue, 12 Nov 2019 02:10:08 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iULd7-0001rR-5l
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 02:10:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573524602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwIej8L0DUgEEuem6IJGdBEU//aFA2ZHcy7O9ct3ggw=;
 b=ARcfukQzCTcGFuHHpCNCKCYl6J73LCRw8pwSJlvEyicUJ83M8ieRN768+5H1VISKKtai8C
 hzzes/2NLXPCdQ3KAQUSUtBl7EllUbcZR1vNTviDCCIrVFb8Zff5fTJlv7C275kL4rBAC5
 258P6+PDF+0k7sdCzTFRR0+sVODo3ro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-IOf5XYo2N0ya7JHV2WeeBA-1; Mon, 11 Nov 2019 21:07:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0D22107ACC4;
 Tue, 12 Nov 2019 02:07:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E55E61076;
 Tue, 12 Nov 2019 02:07:42 +0000 (UTC)
Date: Tue, 12 Nov 2019 10:07:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Message-ID: <20191112020738.GC15079@ming.t460p>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <20191111204446.GA26028@lst.de>
MIME-Version: 1.0
In-Reply-To: <20191111204446.GA26028@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IOf5XYo2N0ya7JHV2WeeBA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_181005_308829_F7872820 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Long Li <longli@microsoft.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 11, 2019 at 09:44:46PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 08, 2019 at 11:55:08AM +0800, Ming Lei wrote:
> > f9dde187fa92("nvme-pci: remove cq check after submission") removes
> > cq check after submission, this change actually causes performance
> > regression on some NVMe drive in which single nvmeq handles requests
> > originated from more than one blk-mq sw queues(call it multi-mapping
> > queue).
> 
> > Follows test result done on Azure L80sv2 guest with NVMe drive(
> > Microsoft Corporation Device b111). This guest has 80 CPUs and 10
> > numa nodes, and each NVMe drive supports 8 hw queues.
> 
> Have you actually seen this on a real nvme drive as well?
> 
> Note that it is kinda silly to limit queues like that in VMs, so I
> really don't think we should optimize the driver for this particular
> case.
> 

When I saw the report at first glance, I had same idea with you,
however recently I got 3 such report, in which two of them only have 8
hw queues, one is Azure, another is on real server. Both are deployed
massively in production environment.

Azure's NVMe drive should be real, and I guess it is PCI pass-through,
given its IOPS can reach >400K in single fio job, which is actually good
enough compared with real nvme drive.

Wrt. limit queues, actually it is a bit common, since I saw at least two
Intel NVMes(P3700, and Optane) limits queue count as 32. When these
NVMe are used in big machines, the soft lockup issue could be triggered,
especially more nvmes are installed and the system uses a bit slow
processor, or memory.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
