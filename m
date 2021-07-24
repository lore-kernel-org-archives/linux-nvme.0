Return-Path: <SRS0=i1kA=MQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C6C4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Jul 2021 02:47:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913F060EB6
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Jul 2021 02:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 913F060EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3n5DpEPVjjJjgn8rpeVrOCaCx9Kmv4l/HUSsvawvvNU=; b=oblWWz/fxXKYvC
	+J0BypcAQkS+Meq57hfLaf7XuXhnvt9t+afY9aQMWYyHUiMMZQhQU79AG6owivXcDlxGwsyoIkegq
	NQq71S4r/366BFfIhPjjYAYwekE5EBP9g+IHXbCxPrYyPA8uuhXKHGpPhvXnY0dIchMM2EMv8SJWY
	tmMrFV38pzh3ZeZZvEhVvc7+7mLxYpzikY8aZWyiSZM0WyD1tmhzFI7lk3EOzhLrizm0YIjPVGfUD
	0/WQn8dDgY5NbYcAc3rGYnDKOcPN1UoqqCXZH8jVF89rFUbGIp7JhuWi0dvUdd/dFSuVFu2ofw3OL
	Vx1JDVcjf2dj3ktj3a5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m77h9-006a03-S7; Sat, 24 Jul 2021 02:47:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m77h6-006ZzO-AN
 for linux-nvme@lists.infradead.org; Sat, 24 Jul 2021 02:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627094829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYZOwF/MtLnhxjwL0S3tKAdZ80TWAAftcA6hP4vffEs=;
 b=cejeOIaicMWMs7SBMqxyEqODFIgKIGf8SQa/Ra8NzE7ZhIK80u14YwpQc1Sz8OmsUjOcUz
 RBdY0WkhE3HYj2MRqEE2TrCgyvtUOhok78yyW5uqE8TsCB09e5lCepAIVO/YXjOuTKs7Ft
 8LinBF0gd8PRBJAlcrWWunSkws0kcXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-jCMhV56HOV-gmTDEtaXL3g-1; Fri, 23 Jul 2021 22:47:05 -0400
X-MC-Unique: jCMhV56HOV-gmTDEtaXL3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49ED51007C81;
 Sat, 24 Jul 2021 02:47:04 +0000 (UTC)
Received: from T590 (ovpn-12-70.pek2.redhat.com [10.72.12.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0A3669CBC;
 Sat, 24 Jul 2021 02:46:58 +0000 (UTC)
Date: Sat, 24 Jul 2021 10:46:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andy Smith <andy@strugglers.net>
Cc: Linux-nvme@lists.infradead.org
Subject: Re: 5.10.40-1 - Invalid SGL for payload:131072 nents:13
Message-ID: <YPt/HXOuzZzg3QXf@T590>
References: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
MIME-Version: 1.0
In-Reply-To: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ming.lei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210723_194716_636874_2BB010A3 
X-CRM114-Status: GOOD (  16.03  )
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

On Tue, Jul 20, 2021 at 10:07:33PM +0000, Andy Smith wrote:
> Hi,
> 
> I have a Debian stable machine with a Samsung PM983 NVMe and a
> Samsung SM883 in an MD RAID-1. It's been running the 4.19.x Debian
> packaged kernel for almost 2 years now.
> 
> About 24 hours ago I upgraded its kernel to the buster-backports
> kernel which is version 5.10.40-1~bpo10+1 and around four hours
> after that I got this:
> 
> Jul 20 02:17:54 lamb kernel: [21061.388607] sg[0] phys_addr:0x00000015eb803000 offset:0 length:4096 dma_address:0x000000209e7b7000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.389775] sg[1] phys_addr:0x00000015eb7bc000 offset:0 length:4096 dma_address:0x000000209e7b8000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.390874] sg[2] phys_addr:0x00000015eb809000 offset:0 length:4096 dma_address:0x000000209e7b9000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.391974] sg[3] phys_addr:0x00000015eb766000 offset:0 length:4096 dma_address:0x000000209e7ba000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.393042] sg[4] phys_addr:0x00000015eb7a3000 offset:0 length:4096 dma_address:0x000000209e7bb000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.394086] sg[5] phys_addr:0x00000015eb7c6000 offset:0 length:4096 dma_address:0x000000209e7bc000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.395078] sg[6] phys_addr:0x00000015eb7c2000 offset:0 length:4096 dma_address:0x000000209e7bd000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.396042] sg[7] phys_addr:0x00000015eb7a9000 offset:0 length:4096 dma_address:0x000000209e7be000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.397004] sg[8] phys_addr:0x00000015eb775000 offset:0 length:4096 dma_address:0x000000209e7bf000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.397971] sg[9] phys_addr:0x00000015eb7c7000 offset:0 length:4096 dma_address:0x00000020ff520000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.398889] sg[10] phys_addr:0x00000015eb7cb000 offset:0 length:4096 dma_address:0x00000020ff521000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.399814] sg[11] phys_addr:0x00000015eb7e3000 offset:0 length:61952 dma_address:0x00000020ff522000 dma_length:61952
> Jul 20 02:17:54 lamb kernel: [21061.400754] sg[12] phys_addr:0x00000015eb7f2200 offset:512 length:24064 dma_address:0x00000020ff531200 dma_length:24064

The last two segments are physically continuous, which should have been
in same segment, otherwise virt boundary limit may be violated.

But __blk_bvec_map_sg() doesn't make the two into one segment, can you
collect the queue limit log?

(cd /sys/block/$NVME/queue && find . -type f -exec grep -aH . {} \;)

Meantime can you try the following patch and see if it can make a
difference?

commit c9c9762d4d44dcb1b2ba90cfb4122dc11ceebf31
Author: Long Li <longli@microsoft.com>
Date:   Mon Jun 7 12:34:05 2021 -0700

    block: return the correct bvec when checking for gaps



Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
