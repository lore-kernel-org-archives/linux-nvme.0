Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC85C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:24:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47C520675
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OcQpscC0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O1vX9xqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47C520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p7nrOTA/+Emr9OjopyNw94MTCGP4sAQDF/WYIK5phNQ=; b=OcQpscC02VL38G
	P33bCchcF3tceo65eZPMzg60dT/aDotA8ROVC1wRzof7iPcH1hvGC9R0VPI4kWPvgqERGPIVld3LK
	nKqK/mlSXDusvpKKA93UqouvSEc71361RbsQb5NLPGYU0OmQpz6QPcD5Ad4PKJWwPwF315Wk8oO8M
	iRUBGAaNRXP6gsy2d1KBbxJNynF2o6Wbc3PNnK/QacA12vAaXyFV2DPTLxgMaYsgec1v/JbQC/YqC
	9pWRBkqIahTQqNz4AOPbV2hwGe77qGRYOFuA2NhVQ6ui4ZTXOtDPDd7AgV16Rg/CIi88YOa/iYTL0
	JzVXXMIrCerwUbskhyag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ9AD-00068y-UA; Thu, 14 May 2020 08:24:21 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ9AC-00068U-OH
 for linux-nvme@bombadil.infradead.org; Thu, 14 May 2020 08:24:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=GNSl57J+LxonPLzG8vkL/ar7GDiVodtVdzEZg1S8fvM=; b=O1vX9xqG6anzFAK8EDJjI1hgdg
 TJmt5p6CopyNJBP8G6mry37xhPyHq9PaUHpA3qfemt/awhOQHsJSl+6GxI/i4FpzgeqL7X2IpdfNC
 FqxMVvsRHCvAekX3YZG8hs1EI6gJie0Z9SWW2bvA/s9SNaXBXHoFx2vu9vChLvrcipqvHohvRMB2K
 vKfcr/Oaqbr4TTJC4fGCDaj7k7trMx7Qdms1OqK+Qh8fCbtZXUWeav33LUwm97VurcJ1RevPb8C2C
 h2rrszygxiKpMXUlAro2LvZsZqusqWXI3fZw+/Ao2Zbk02iZIuNErl3q+19/R5BJuA14i69+eK6Di
 vfHJ0hUA==;
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ9A9-0004JF-SX
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 08:24:19 +0000
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-NR0jAm9dMXGz0XSWuD-CMg-1; Thu, 14 May 2020 09:23:44 +0100
X-MC-Unique: NR0jAm9dMXGz0XSWuD-CMg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 14 May 2020 09:23:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Thu, 14 May 2020 09:23:43 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>, Christoph Hellwig
 <hch@lst.de>
Subject: RE: [PATCH 27/33] sctp: export sctp_setsockopt_bindx
Thread-Topic: [PATCH 27/33] sctp: export sctp_setsockopt_bindx
Thread-Index: AQHWKVB6yiOODFVfBEqdWGEpseVc56inPsjA
Date: Thu, 14 May 2020 08:23:43 +0000
Message-ID: <f22a26559aa9430ab8549c0624729082@AcuMS.aculab.com>
References: <20200513062649.2100053-1-hch@lst.de>
 <20200513062649.2100053-28-hch@lst.de>
 <20200513180058.GB2491@localhost.localdomain>
In-Reply-To: <20200513180058.GB2491@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
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
Cc: Eric Dumazet <edumazet@google.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Vlad Yasevich <vyasevich@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 "David S. Miller" <davem@davemloft.net>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Marcelo Ricardo Leitner
> Sent: 13 May 2020 19:01
> On Wed, May 13, 2020 at 08:26:42AM +0200, Christoph Hellwig wrote:
> > And call it directly from dlm instead of going through kernel_setsockopt.
> 
> The advantage on using kernel_setsockopt here is that sctp module will
> only be loaded if dlm actually creates a SCTP socket.  With this
> change, sctp will be loaded on setups that may not be actually using
> it. It's a quite big module and might expose the system.
> 
> I'm okay with the SCTP changes, but I'll defer to DLM folks to whether
> that's too bad or what for DLM.

I didn't see these sneak through.

There is a big long list of SCTP socket options that are
needed to make anything work.

They all need exporting.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
