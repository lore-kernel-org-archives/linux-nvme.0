Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C144EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 15:51:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5FD61B1E
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 15:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E5FD61B1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whUiuJFDFuwD+wvushIve7sNdYVTgiq3Xcmxkte/4AU=; b=yoF7D/6YzNDF92l8FDTnpPuE9X
	42+p31/WtwcDxUAYvMjFofp/AmeKy6dUFncORBp3zL8Q48ZXrg4Ej9gDcy3f76KDETUSGjXuJKojB
	OLq1e5Le6eZ0fxD0l9U4SmWwTf6bb9X3QIvi/NDFI5CFTX5xhG6n/sPaAqRzJx5r3DQUXAUw9aC/i
	AoaHg7D+x+adtP9VgcR8HLF8oYwzfBEnWRQofkemObEO8CgSZcTtSwXExXsil4DQFLUqKisfRenhW
	O5P8PE75/uofgymjEmbvf0yZJ6aSPskqUb3m8DPtT/sQieUyVHej3gZI8gcPsN1+Pbsg+XvmkMSff
	4b40Iq8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mo6AY-00AudD-Ia; Fri, 19 Nov 2021 15:51:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mo6AR-00AucN-8Q
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 15:51:12 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A92861221;
 Fri, 19 Nov 2021 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637337070;
 bh=TlDTq9AOv8FgH+en11enMFFGBmpJzRegCF+fD5onZjM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bQeuXN4l1sz2ptHXt/d6W4TIuBCmMUS0qzRCLG2JD/OcSt3CWMjf4Kz9umEyD1Mnf
 sSoYa9EvfwrozqMXJmAWFC6ibMXKDdNcJ1i4SI49sZqWZBHEPRV0ZD7AozXVQE+IU0
 EzMQyJzLToEDD2KSF0UKITDIqDo4grbVTo9CDIcpWapmUvwbLfWN+O/dHAX6Sxf6nd
 UHHuN3UipIyG16hQ2b2UTuK8qG4j3heaexfNuzUAeZgikGs+VXBm0hhb2+G/TDwtM5
 sK4sguJxwE8PWRLdzTHlwVJ6JKtYTbavkglzBiWlscMyKruLREW97MhYaavX/CKMqF
 Te3gnmFDubS9w==
Date: Fri, 19 Nov 2021 07:51:05 -0800
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Vincent Fu <vincent.fu@samsung.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20211119155105.GA3298398@dhcp-10-100-145-180.wdc.com>
References: <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
 <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
 <2a65e231-11dd-d5cc-c330-90314f6a8eae@nvidia.com>
 <20211029081447.ativv64dofpqq22m@ArmHalley.local>
 <20211103192700.clqzvvillfnml2nu@mpHalley-2>
 <20211116134324.hbs3tp5proxootd7@ArmHalley.localdomain>
 <CA+1E3rJRT+89OCyqRtb5BFbez0BfkKvCGijd=nObMEB3_v6MyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJRT+89OCyqRtb5BFbez0BfkKvCGijd=nObMEB3_v6MyA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_075111_364017_251D3C13 
X-CRM114-Status: GOOD (  11.45  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 19, 2021 at 04:17:51PM +0530, Kanchan Joshi wrote:
> Given the multitude of things accumulated on this topic, Martin
> suggested to have a table/matrix.
> Some of those should go in the initial patchset, and the remaining are
> to be staged for subsequent work.
> Here is the attempt to split the stuff into two buckets. Please change
> if something needs to be changed below.
> 
> 1. Driver
> *********
> Initial: NVMe Copy command (single NS)

Does this point include implementing the copy command in the nvme target
driver or just the host side? Enabling the target should be pretty
straight forward, and would provide an in-kernel standard compliant
"device" that everyone could test future improvements against.

