Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C8DC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 20:42:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604896023E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 20:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 604896023E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qC4+qXZc5vUkwonbwRRpVZ3KrOAmO5QkgaTKA+jlx8A=; b=k7ynWVZO5v7Uxj
	Tq+tEQNsc5LxCAh66Ef73YnUxjCjXr61bIvnU8XTY+VnfyrunEsOgUPtSTWxexL2egCsZnlzoumcw
	HDiygdKDupKylqT5iJKSgXK+/VBeu2UEE6D9L7xcL5VDRXsVS7EtcqGfeabdV+LIFHddYV4J3lFYd
	3PNs4m+xqvoGAL2gKVWFb9uY1NHXzO7V5uQ+Bfii0kMpBNH/87PAB8yZx+SNbn9ubD0Bx0TjLV529
	B+3JszESSUOSuFtjGns+fOaPyZYUdZG7+ILzp2IJO/mm/K7b1RxYN+UpRncNNCjoHRVn+uDcBasXJ
	IyEDrED8a8zue+nNyD1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG5uD-003TpK-6Q; Tue, 17 Aug 2021 20:41:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG5u9-003ToV-4F
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 20:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629232908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wcl4Dsri643WTYT2ZVvqT65s7dgjheTTZlEE7QZJGi0=;
 b=YfGVCHHU/0+LXtetI8CmscSUPK6Czh/5Rrl2MxhFNJMM708lXkzQzas3Uc00kS9MVToSU/
 70Nh+VlV+y9H0YwVODjDs/7zGWPeVSzR/5ylEUymGTauXKpuiRARMtdXkiBV9EoV29DrHo
 53nW0lnxrAZmmROWLJcpJ5Qa/9fCZIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-OibFsp8zNtK8OL7wOrtR7Q-1; Tue, 17 Aug 2021 16:41:46 -0400
X-MC-Unique: OibFsp8zNtK8OL7wOrtR7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08F51082925;
 Tue, 17 Aug 2021 20:41:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3995E60BF4;
 Tue, 17 Aug 2021 20:41:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 17HKfZQS031822; Tue, 17 Aug 2021 16:41:35 -0400
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 17HKfZrZ031818; Tue, 17 Aug 2021 16:41:35 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Tue, 17 Aug 2021 16:41:35 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Bart Van Assche <bvanassche@acm.org>
cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, kbusch@kernel.org, axboe@kernel.dk,
 damien.lemoal@wdc.com, asml.silence@gmail.com,
 johannes.thumshirn@wdc.com, hch@lst.de, willy@infradead.org,
 kch@kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 djwong@kernel.org, Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
 selvajove@gmail.com, joshiiitr@gmail.com, nj.shetty@samsung.com,
 nitheshshetty@gmail.com, joshi.k@samsung.com, javier.gonz@samsung.com,
 Mike Snitzer <snitzer@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
In-Reply-To: <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
Message-ID: <alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_134149_309372_1C9DF84E 
X-CRM114-Status: GOOD (  20.75  )
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



On Tue, 17 Aug 2021, Bart Van Assche wrote:

> On 8/17/21 3:14 AM, SelvaKumar S wrote:
> > Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> > bio with control information as payload and submit to the device.
> > Larger copy operation may be divided if necessary by looking at device
> > limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
> > submitted to zoned device.
> > Native copy offload is not supported for stacked devices.
> 
> Using a single operation for copy-offloading instead of separate operations
> for reading and writing is fundamentally incompatible with the device mapper.
> I think we need a copy-offloading implementation that is compatible with the
> device mapper.

I once wrote a copy offload implementation that is compatible with device 
mapper. The copy operation creates two bios (one for reading and one for 
writing), passes them independently through device mapper and pairs them 
at the physical device driver.

It's here: http://people.redhat.com/~mpatocka/patches/kernel/xcopy/current

I verified that it works with iSCSI. Would you be interested in continuing 
this work?

Mikulas

> Storing the parameters of the copy operation in the bio payload is
> incompatible with the current implementation of bio_split().
> 
> In other words, I think there are fundamental problems with this patch series.
> 
> Bart.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
