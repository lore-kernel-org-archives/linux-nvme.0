Return-Path: <SRS0=rA+l=65=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F941C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 08:14:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57FA20657
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2020 08:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fN11o/J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57FA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GRrc9wyx2ZmYh2GvIDKVlbErSi9O5TQbIboUbBr4GxM=; b=fN11o/J5JLMSgG
	LtdHOs4HBWTISKLtk4VV8LmeRiqjmD6eelJHkihScTcgMAWidXDFIl1PR19mRl1oBjqS2ngOq+wDJ
	6zmBcHaJnXvJDpERw/dZBE+Qq53GX07A5iC5JrM3S9JHHPYXYu/KLfX8Ql6YWU9/xTLxCHotryzcA
	NrW+ExveGl2ORLsAarXX1acu5vTkGHMm5vJf2sqnV2CPWehpJ3cububI3Nz21NTtT+jSJj8bzzpj6
	fpC5WMwRLx+Nw5/8ktM+vNJ5HAAXqFf1ugzcJ18finODWS464VMIgB65XBJSorwp0LzgzsaJ0Ak5C
	5uuBPxA5kWhJJj7N5a+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZVU6-00036X-1e; Fri, 15 May 2020 08:14:22 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZVU3-000349-10
 for linux-nvme@lists.infradead.org; Fri, 15 May 2020 08:14:20 +0000
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-135-kgvmV9-GP7CT7oWXwAS8yw-1; Fri, 15 May 2020 09:14:08 +0100
X-MC-Unique: kgvmV9-GP7CT7oWXwAS8yw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 15 May 2020 09:14:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Fri, 15 May 2020 09:14:07 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Miller' <davem@davemloft.net>
Subject: RE: remove kernel_setsockopt and kernel_getsockopt
Thread-Topic: remove kernel_setsockopt and kernel_getsockopt
Thread-Index: AQHWKU15LJmP4mOGDE2/GHhLszFt9KinP7aQgAAO/ACAABIowIAAkWGAgADbQOA=
Date: Fri, 15 May 2020 08:14:07 +0000
Message-ID: <29428bc7a5344412be9f632bced8888d@AcuMS.aculab.com>
References: <756758e8f0e34e2e97db470609f5fbba@AcuMS.aculab.com>
 <20200514101838.GA12548@lst.de>
 <a76440f7305c4653877ff2abff499f4e@AcuMS.aculab.com>
 <20200514.130357.1683454520750761365.davem@davemloft.net>
In-Reply-To: <20200514.130357.1683454520750761365.davem@davemloft.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200515_011419_375687_031CDD74 
X-CRM114-Status: UNSURE (   8.15  )
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
Cc: "marcelo.leitner@gmail.com" <marcelo.leitner@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "joe@perches.com" <joe@perches.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
 "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "vyasevich@gmail.com" <vyasevich@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
 "ying.xue@windriver.com" <ying.xue@windriver.com>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looking at __sys_setsockopt() I noticed that the BPF intercept
can also cause set_fs(KERNEL_DS) be set in order to pass a
modified buffer into the actual setsockopt() code.

If that functionality is to be kept then the underlying
protocol specific code needs changing to accept a kernel buffer.

The 32bit compat code would also be a lot simpler if it could
pass an kernel buffer through.
At the moment it copies the modified buffer back out onto the
user stack.

I'm sure there have been suggestions to remove that complete hack.
Fixing the compat code would leave a kernel_[sg]et_sockopt() that
still worked.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
