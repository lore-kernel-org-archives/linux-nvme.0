Return-Path: <SRS0=77Bv=24=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B892CC282DD
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 21:40:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AA520692
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 21:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FunbvfVs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEXViJ+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AA520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lkPsxkAm0SpJKAGDb2yVw0kSxITZI0alzj0OByn22aw=; b=FunbvfVs5NwDW0
	hR57joGnrtZtnLpNSxMM3fC44VWWIJkuIVHxI28rgRXYWOuewLWst+RD7Tjl2U8waMeiXxYbfq9jv
	JOBTx/SAZH3etzbOQDfkd6GQGWRyMGcK3NvN5IX4OGlhwBWvncXjKVc1U+fhpFbLA/nuFQtaWu/lG
	3p8jykZMlJWLvaM6I99PnulCPdosUXbHyY6KSU8+G7W1of+llCS8KZPmWTulLtFWy9PGY+aSMQ4QN
	3WvwzHIBPzhIzFhO87Kp7te3iYeRjLwSUsBBj6utVTUhS7EarVaUwUTXM4AdM4V4xfkCwuutF8Wup
	qtAb8cN3XtTQeFn6KUmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iowa8-0003No-1h; Tue, 07 Jan 2020 21:40:08 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iowa5-0002RJ-0s
 for linux-nvme@lists.infradead.org; Tue, 07 Jan 2020 21:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578433201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSFxCL3k8Q6kQpuVjvodBV8GghU6vTCrTI5PKdnHV9s=;
 b=MEXViJ+hxfp+Mu2nF8oPCwjUt+fwhu6mo6zHduvqA2pBTLSb8PcCXTff5fe3F+pNH4JEnH
 UR8dyYJeN6wBAhAh6QWBT2vkhX5AyVMyJEsU6aq4AofOJS8OWdqL7GGWNHwjqHRBB87soF
 M0iVQGklBHfTUozAQdx0ImkY9bvF66w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-fmmXZbPlOemJuWh2TJdqVw-1; Tue, 07 Jan 2020 16:37:49 -0500
X-MC-Unique: fmmXZbPlOemJuWh2TJdqVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3463107ACC7;
 Tue,  7 Jan 2020 21:37:47 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 455638208E;
 Tue,  7 Jan 2020 21:37:44 +0000 (UTC)
Message-ID: <1eb9d796f81fffbb0bfe90bff8460bcda34cb04d.camel@redhat.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
From: "Ewan D. Milne" <emilne@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley
 <jejb@linux.ibm.com>
Date: Tue, 07 Jan 2020 16:37:43 -0500
In-Reply-To: <yq1y2uj283m.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
 <1578369479.3251.31.camel@linux.ibm.com> <yq1y2uj283m.fsf@oracle.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200107_134005_234842_589B2D7D 
X-CRM114-Status: UNSURE (   9.90  )
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, ssomesh@amazon.com,
 Balbir Singh <sblbir@amazon.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2020-01-06 at 23:39 -0500, Martin K. Petersen wrote:
> James,
> 
> > > We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
> > > capacity changes. However, this event does not automatically cause
> > > revalidation.
> > 
> > Which I seem to remember was a deliberate choice: some change
> > capacities occur because the path goes passive and default values get
> > installed.
> 
> Yep, it's very tricky territory.
> 

Yes, there are some storage arrays that refuse a READ CAPACITY
command in certain ALUA states so you can't get the new capacity anyway.

It might be nice to improve this, though, there are some cases now where
we set the capacity to zero when we revalidate and can't get the value.

-Ewan




_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
