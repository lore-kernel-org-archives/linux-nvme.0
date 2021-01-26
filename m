Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33218C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 18:17:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72FA20780
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 18:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72FA20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CEciRsWTQgREFTW7TyrKEaaKkLiYT8Pa+7XgbdR61zE=; b=RkuZrGepZhkZ681LxtOsXHJLq
	xew5hVpEK5INoxoK3xyjic8KlF7jl5qmwW8A2MCnaGI23Y5c8/p4fCUbVSiHuet73tTIcwhQXxc5U
	wzBNWn1VAZ467UZ+iY6UMK0zYnOFx5UQzMJ/+DZc4bscdSisK9Q/efVk8iDODdrrVndZItsmyOVRV
	ibcGRiXGT+RUfPtMU2sk77vTTKptLofB7UKHkhU0NkCJ97yamaDVATmpO8ExDj5c6VcU+GvJW9S9F
	IEfpM6pzBd5XauVlGnW34WCOnUie4FCctKF81PnpBR7AgtVHz8+TLeEO5syrdcxZBcvzXTbSLXYnu
	9uOOVI0wA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4Stv-0006nZ-Lc; Tue, 26 Jan 2021 18:17:15 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4Stq-0006mY-2E
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 18:17:13 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 26 Jan 2021 10:17:06 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::98fb:6d15:be65:b22d]) by
 SJSMAIL01.us.kioxia.com ([fe80::98fb:6d15:be65:b22d%3]) with mapi id
 15.01.1779.007; Tue, 26 Jan 2021 10:17:06 -0800
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
Thread-Index: AQHW81Uk6e6cbZGyEU2+tznAk87Vf6o6HfbQ
Date: Tue, 26 Jan 2021 18:17:06 +0000
Message-ID: <b5c179e3eb904800931712d6b92cfbeb@kioxia.com>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210125195844.1390581-1-clay.mayers@kioxia.com>
 <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.57.231]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_131710_142023_4F396FB0 
X-CRM114-Status: GOOD (  10.46  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Sent: Monday, January 25, 2021 5:43 PM
> To: Clay Mayers <Clay.Mayers@kioxia.com>; linux-nvme@lists.infradead.org
> Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>;
> Christoph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>
> Subject: Re: [PATCH V2 0/2] nvme: Support for fused
> NVME_IOCTL_SUBMIT_IO
> 
> On 1/25/21 12:03, clay.mayers@kioxia.com wrote:
> > Local pci device fused support is also necessary for NVMeOF targets to
> > support fused operation.
> Please explain the use case and the application of the NVMeOF fuse
> command feature.

NVMeOF devices are used to create disaggregated storage systems
where compute and storage are connected over a fabric.  Fused
compare/write can be used to arbitrate shared access to NVMeOF devices
w/o a central authority.

A specific example of how fused compare/write is used is the clustered
file system VMFS.  It uses the SCSI version of compare/write to manage
meta data on shared SAN systems.  File system meta data is updated
using locks stored on the storage media.  Those locks are grabbed using
fused compare/write operations as an atomic test & set.  VMFS originally
used device reserve, which is a courser gained locking mechanism but it
doesn't scale as well as an atomic test & set.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
