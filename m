Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20648C282DD
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 13:12:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C8C2072A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 13:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i6Lz7qDV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2mECv0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C8C2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DNMpvV0xObjOQrhoRHwHf9HZSkMmptlFL+X2xOt5+0g=; b=i6Lz7qDVa1e9Ds
	ZnJfRD4ajelvdC97rtqjx0hCyJYMJoKyI4TxLGFAx0iE30i0j1YXm+66DHXo+i8drSIesseU3mtjs
	Afz3bzp92z1W/3t4WvAvPG4tO9fR8TImaaYtbJ9FYIGoiz6vp2S2IMS88AEgoCHeSmAyBNyRnOBcD
	mW5oKFZnEjJA1le6qX71JoW/8POFz8gZWmNV/Ah1U/8VZ3z+C7qu8G/zcDJSTVAHhkA39vBRI7hvZ
	oQ30TBq32ei4rPFX8N6Fw1BZhKHv7u990VRAjG6RJ7lF8P9rGZyWiN7uvQAiAH79u9h+iZna9EDsg
	exhCgIxE5Fa5Aqm4f10g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipXcC-0001p1-01; Thu, 09 Jan 2020 13:12:44 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipXc9-0001O2-54
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 13:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578575556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=to2tC83cIN6vDKqhn+LssLPUECktszP/zdsC8v7PRMA=;
 b=Z2mECv0SnpxSKesECoVEIAXiW8xxHE/xu2WlxqAFTemsFxUsEy2vGkQIBDY9pEfuAFP2AI
 wNbl+KFVnPlsA1MzX3KuwKzwA8/WrgYrRtLrWKhazCfcnKGAANRwho0Wp/mFbyoO8wOJFL
 /8GSoluzlP3f8GuOt1LNJPaVi7q8enY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-XZIIqOGfNbKz-WjSOQcfLQ-1; Thu, 09 Jan 2020 08:12:33 -0500
X-MC-Unique: XZIIqOGfNbKz-WjSOQcfLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DECC801E72;
 Thu,  9 Jan 2020 13:12:31 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C10365C541;
 Thu,  9 Jan 2020 13:12:27 +0000 (UTC)
Message-ID: <cc8dddbcad70453efad665dc19787803ec48fdd6.camel@redhat.com>
Subject: Re: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
From: "Ewan D. Milne" <emilne@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, "hch@lst.de"
 <hch@lst.de>
Date: Thu, 09 Jan 2020 08:12:27 -0500
In-Reply-To: <yq1k161xq1f.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-5-sblbir@amazon.com>
 <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com>
 <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
 <20200108150447.GC10975@lst.de> <yq1k161xq1f.fsf@oracle.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200109_051241_275060_4790A6CF 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "mst@redhat.com" <mst@redhat.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Sangaraju,
 Someswarudu" <ssomesh@amazon.com>, "Singh, Balbir" <sblbir@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-01-08 at 22:33 -0500, Martin K. Petersen wrote:
> Christoph,
> 
> > > The expected behaviour is not clear, but the functionality is not
> > > broken, user space should be able to deal with a resize event where
> > > the previous capacity == new capacity IMHO.
> > 
> > I think it makes sense to not bother with a notification unless there
> > is an actual change.
> 
> I agree.
> 

Yes, absolutely.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
