Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EB8C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 02:39:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8739E20818
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 02:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="onsVj/UL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKwEb6SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8739E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Qg+M7D1yhmtBxtIBrENVD/Q4MVGnfXoE8wjepRq7T0=; b=onsVj/ULMCA8GA
	32cxL/kdpUW0AXxHuBJJ3jMPgZiVmg50AQHHLDrsDX43DmVQafn15B9rGeTXRCfhX0kWRdvZ0KgUJ
	mtVzSCY+AjF6+2XIbJH7qK9rNfwlCfFaIPKy5bqrw0VGXH2LJIgyzGONe/4icbpJlhYg5lTc1lw+z
	tB4inNcL9xCeU4LORLrl/Ay2J0e6WivEdvOOVocCN3QCW4uO3VvOVc89mof9Aq5LHY9rvpguNftuo
	jB5LjhxE021m4loNn3v9r6HtVtvoTEd2cUsYFuMK023lYCgbM9pmt8lhJoVLpIkRNWNp8zmPioAKQ
	8FbzdKjLk+oxt1zYDNDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUM5j-0003DL-Kz; Tue, 12 Nov 2019 02:39:39 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUM5g-0003Ct-Ts
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 02:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573526375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXo7aA4mmEzBPCt6vOYLhDZGwqL49rU1CkXRwDtjk+Q=;
 b=fKwEb6SJNk2Ft3FCuCubdzn9hNWAp/PI7fAvYcfeWiTEf+3KZtxCezpFHLDSDQYxq41yMI
 3TciPuRAud9oVMndAXADju/15iluBGcTZmYbz9TrHuf+BXIOEadKjX+dhTdC+9A0X8hbU+
 dgYDVQgEvqaLYxh6w0GMvV6ZG8f7rAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-A6NNody2Pd6ldBcN_Fh1EQ-1; Mon, 11 Nov 2019 21:39:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 080171005500;
 Tue, 12 Nov 2019 02:39:31 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6FF75C1B5;
 Tue, 12 Nov 2019 02:39:24 +0000 (UTC)
Date: Tue, 12 Nov 2019 10:39:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Long Li <longli@microsoft.com>
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Message-ID: <20191112023920.GD15079@ming.t460p>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <20191111204446.GA26028@lst.de>
 <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: A6NNody2Pd6ldBcN_Fh1EQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_183937_079563_D644F08A 
X-CRM114-Status: GOOD (  14.88  )
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
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 12, 2019 at 12:33:50AM +0000, Long Li wrote:
> >From: Christoph Hellwig <hch@lst.de>
> >Sent: Monday, November 11, 2019 12:45 PM
> >To: Ming Lei <ming.lei@redhat.com>
> >Cc: linux-nvme@lists.infradead.org; Keith Busch <kbusch@kernel.org>; Jens
> >Axboe <axboe@fb.com>; Christoph Hellwig <hch@lst.de>; Sagi Grimberg
> ><sagi@grimberg.me>; Long Li <longli@microsoft.com>
> >Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for multi-
> >mapping queue
> >
> >On Fri, Nov 08, 2019 at 11:55:08AM +0800, Ming Lei wrote:
> >> f9dde187fa92("nvme-pci: remove cq check after submission") removes cq
> >> check after submission, this change actually causes performance
> >> regression on some NVMe drive in which single nvmeq handles requests
> >> originated from more than one blk-mq sw queues(call it multi-mapping
> >> queue).
> >
> >> Follows test result done on Azure L80sv2 guest with NVMe drive(
> >> Microsoft Corporation Device b111). This guest has 80 CPUs and 10 numa
> >> nodes, and each NVMe drive supports 8 hw queues.
> >
> >Have you actually seen this on a real nvme drive as well?
> >
> >Note that it is kinda silly to limit queues like that in VMs, so I really don't think
> >we should optimize the driver for this particular case.
> 
> I tested on an Azure L80s_v2 VM with newer Samsung P983 NVMe SSD (with 32 hardware queues). Tests also showed soft lockup when 32 queues are shared by 80 CPUs. 
> 

BTW, do you see if this simple change makes a difference?

> The issue will likely show up if the number of NVMe hardware queues is less than the number of CPUs. I think this may be a likely configuration on a very large system. (e.g. the largest VM on Azure has 416 cores)
> 

'the number of NVMe hardware queues' above should be the number of single NVMe drive.
I believe 32 hw queues is common, also poll queues may take several from the total 32.
When interrupt handling on single CPU core can't catch up with NVMe's IO handling,
soft lockup could be triggered. Of course, there are lot kinds of supported processors
by Linux.

Also when (nr_nvme_drives * nr_nvme_hw_queues) > nr_cpu_cores, one same CPU
can be assigned to handle more than 1 nvme IO queue interrupt from different
NVMe drive, the situation becomes worse.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
