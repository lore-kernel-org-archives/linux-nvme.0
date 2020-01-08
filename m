Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D851C282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 21:28:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1662206DA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 21:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="al/y4UFA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0tVVY1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1662206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hv/36zL9aOLMLkav0E7qJ3ip8OF4v7nC3EIPJkA/C74=; b=al/y4UFA+zOwiF
	8WIB9ir4wE/veHy1hH1nzfr1+/nO7jG1+BggIUCyIvLC6xARhVGCWQ9jOLoD2IXCwNQugd8PuHKOY
	IOCn64uLJZJ4OIjqYBIGoE4OJ+V1m/cYHwSqDraZX0JJ5pEyDvp0jenWuSmdrJCwj7yBeP7r4mY/E
	vf2uMKTbmyFgp1LARCmGPidKhPJewfOkfESMP35SyLBhcaT+5nXD19GVeik5rhpmZNSfOX3bDxaRM
	xvhhGazW+2ivZbqhYbW8Jn6Ft/47QvjsgA+JrUhzEsbkL8vhEsSeWnUCgvKaaGLSKuqCwlZsHsZBL
	tZEYVSENGGPtoXx9lhwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipIs7-0005Rg-Bw; Wed, 08 Jan 2020 21:28:11 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipIs5-0005Qi-62
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 21:28:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578518886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDndyIMuf+SGBEdpoWnLHWGwmjrUEAzXRO3SpvATPL0=;
 b=i0tVVY1fYNQXg0pFeyjN5zo83zoMihph3jEBS0fs6jAXnF8eoZDS3TJ8ZUx5NP7RTGRF3H
 Gr/PM9mgHE7XJbopzfOPVaYcObAp988dZcNB50LbmkPQW1L9Xaxjp7yOL9qkCtRkuNjWE4
 NMbHTAZsoxkoraSKIv11kYeS7cdvF9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-dStVFU0HPOeWpx54NiZpYw-1; Wed, 08 Jan 2020 16:28:02 -0500
X-MC-Unique: dStVFU0HPOeWpx54NiZpYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32852800D48;
 Wed,  8 Jan 2020 21:28:00 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3607C3AD;
 Wed,  8 Jan 2020 21:27:56 +0000 (UTC)
Message-ID: <a267a03595c613a4c44d379706d8f1a5d6e30035.camel@redhat.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
From: "Ewan D. Milne" <emilne@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Wed, 08 Jan 2020 16:27:55 -0500
In-Reply-To: <yq1ftgq1wlt.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
 <1578369479.3251.31.camel@linux.ibm.com> <yq1y2uj283m.fsf@oracle.com>
 <1eb9d796f81fffbb0bfe90bff8460bcda34cb04d.camel@redhat.com>
 <yq1ftgq1wlt.fsf@oracle.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_132809_301939_DBEB5D79 
X-CRM114-Status: GOOD (  11.54  )
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
 James Bottomley <jejb@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 ssomesh@amazon.com, Balbir Singh <sblbir@amazon.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2020-01-07 at 21:59 -0500, Martin K. Petersen wrote:
> Ewan,
> 
> > Yes, there are some storage arrays that refuse a READ CAPACITY
> > command in certain ALUA states so you can't get the new capacity
> > anyway.
> 
> Yep. And some devices will temporarily return a capacity of
> 0xFFFFFFFF... If we were to trigger a filesystem resize, the results
> would be disastrous.
> 
> > It might be nice to improve this, though, there are some cases now
> > where we set the capacity to zero when we revalidate and can't get the
> > value.
> 
> If you have a test case, let's fix it.
> 

This happens with NVMe fabric devices, I thought.  I'll check.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
