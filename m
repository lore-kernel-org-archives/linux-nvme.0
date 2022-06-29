Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48E2C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+89HG/51719ITVv8uxUa5aJs3xSVjJqyUb5ifdm38aY=; b=eAaMbMzD7IgHzX5TfAzxbvA2Ci
	0bYzN4pYVSNWWs1wnTLqHLX51zSXcRock9g6SPmBydt68NKucqi0DlazWozIDaIB+ra2pbbPMcsWo
	LG6BG+mmWBwA76dH+tqtZzvn9bpWSm3Bomy7UpGq+9XikxEMxWpCj1rpp8Any2dvGm8a9pmd4+N59
	T1a1u+h7C6kjDf07uwqY5RmUp5S/FDaP8GkuLE5Tq5zDCycblFKKZTPzkmDmoGZsckfA0Ba9vZd8t
	BeV0lki49eKFeJaPs3qjZ2duYVcuoM7r4xff2O95Yb6hmfmqoGQoPgpXFcZNknTKHNa9mLmpO7hlT
	Gjj+XAEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6cJy-00DT7i-3p; Wed, 29 Jun 2022 18:21:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6c7L-00DOED-He
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 18:08:49 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TI8Kq7001514;
	Wed, 29 Jun 2022 18:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+89HG/51719ITVv8uxUa5aJs3xSVjJqyUb5ifdm38aY=;
 b=Xr7PmnFTFfLyLX0jfIUZ4t3hUWqf/VTHd9pdMnxYRESxNDkh2XdN76I1ePChQJ3M21BO
 0QJhkMZmVLP+7VJm0NgsZ6IFhiKZTjnXTFQIQCi/v6FrO2So1WSXM4hwaE2uYh6vxwfS
 JTanPFUdKLJSTK3LpMeltIOa9VTtfH8eaddEgICkEk67ubKJIBpRWGP5mfZTp0SJZv4N
 mBDAU51KOm7cQ3irHo7ptZxwW7T2CMHh7erF212B/MeB6Ih7a5kq5vK/Z5rUe6aWPEb4
 C/o7HYzoqw952bA+OzLYROwQRtR/uUUDDR1sTcG/RkeY+yeq2mOaqPtVHGn4J+5eVLu5 Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0uf9rey0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jun 2022 18:08:37 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25THpHlg004236;
	Wed, 29 Jun 2022 18:08:36 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0uf9rd05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jun 2022 18:08:34 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25THZ5gg016303;
	Wed, 29 Jun 2022 18:04:50 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma01wdc.us.ibm.com with ESMTP id 3gwt09huv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jun 2022 18:04:50 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25TI4nBr16253312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jun 2022 18:04:49 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C74C6E054;
	Wed, 29 Jun 2022 18:04:49 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23C066E050;
	Wed, 29 Jun 2022 18:04:48 +0000 (GMT)
Received: from farman-thinkpad-t470p (unknown [9.163.2.135])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jun 2022 18:04:48 +0000 (GMT)
Message-ID: <f723b1c013d78cae2f3236eba0d14129837dc7b0.camel@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
From: Eric Farman <farman@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>, axboe@kernel.dk,
        Kernel Team
 <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
        pankydev8@gmail.com
Date: Wed, 29 Jun 2022 14:04:47 -0400
In-Reply-To: <YrvMY7oPnhIka4IF@kbusch-mbp.dhcp.thefacebook.com>
References: <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
	 <YrS2HLsYOe7vnbPG@kbusch-mbp> <YrS6/chZXbHsrAS8@kbusch-mbp>
	 <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
	 <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
	 <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
	 <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
	 <20220628110024.01fcf84f.pasic@linux.ibm.com>
	 <83e65083890a7ac9c581c5aee0361d1b49e6abd9.camel@linux.ibm.com>
	 <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
	 <YrvMY7oPnhIka4IF@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3_RM63mUoipqzU4ybxJTtJlefiGjveYm
X-Proofpoint-ORIG-GUID: D6JYdDjCbQ6N12KCKXWfy-nX_bLi1ZV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_19,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_110847_747320_BA555C2F 
X-CRM114-Status: GOOD (  23.40  )
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

On Tue, 2022-06-28 at 21:52 -0600, Keith Busch wrote:
> On Tue, Jun 28, 2022 at 11:18:34PM -0400, Eric Farman wrote:
> > Sort of. In the working case, I see a set of iovecs come through
> > with
> > different counts:
> > 
> > base	count
> > 0000	0001
> > 0000	0200
> > 0000	0400
> > 0000	0800
> > 0000	1000
> > 0001	1000
> > 0200	1000 << Change occurs here
> > 0400	1000
> > 0800	1000
> > 1000	1000
> > 
> > EINVAL was being returned for any of these iovecs except the page-
> > aligned ones. Once the x200 request returns 0, the remainder of the
> > above list was skipped and the requests continue elsewhere on the
> > file.
> > 
> > Still not sure how our request is getting us into this process.
> > We're
> > simply asking to read a single block, but that's somewhere within
> > an
> > image file.
> 
> I thought this was sounding like some kind of corruption. I tested
> ext4 on
> various qemu devices with 4k logical block sizes, and it all looks
> okay there.
> 
> What block driver are you observing this with?

s390 dasd

This made me think to change my rootfs, and of course the problem goes
away once on something like a SCSI volume.

So crawling through the dasd (instead of virtio) driver and I finally
find the point where a change to dma_alignment (which you mentioned
earlier) would actually fit.

Such a change fixes this for me, so I'll run it by our DASD guys.
Thanks for your help and patience.

Eric


