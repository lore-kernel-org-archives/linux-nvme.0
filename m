Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05973C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 03:04:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D9E2389E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 03:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D9E2389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:References:Message-ID:In-Reply-To:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hExmrBF6NEYMXSetis0Sa1+n/F16Qk3v39Mr45oTLn0=; b=rfyh4E5it1TZIUFQd/4gLzaw1
	yo9TRp60M2+wgDp0ZTCZTzhyYGG3dEpnt801uQITCxl1HK8lAkqQxih4bKmx7tglsCnZy2zIHLLD4
	7OqQRw35M8bOIlFSczOx5y9++IR4KS/KIZ18MFprO20d/F81H2MVFCdUpfuWw1r/61nZlYutQvaXh
	goLz3lOtoKwuWvTm8e0d+EcmVp2uqj2TIDgZp1Qubw7Ty2wOes3epNN5tOExdANO0teuUaCO+GFH+
	622KVdfubbUNRY06IFhgTXtpfQXc2BVQISExsAJ6hO5pkRKon8AxS7MHYc44boC3uGpZ4knzKuNtV
	sTdXrxlHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmpmR-0001DU-Pb; Wed, 09 Dec 2020 03:04:39 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmpmP-0001D4-Gb
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 03:04:38 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B933vWE013387;
 Wed, 9 Dec 2020 03:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : in-reply-to : message-id : references : date : mime-version :
 content-type; s=corp-2020-01-29;
 bh=im6KM1TeupZ7+OOqaL16g9WQ+py93dKnhY0FXeXUVrg=;
 b=CgT2u9G+DufvhAow7IPt573MPTsgelj/WTscwwx8qiipLPEte677SGvrA95oyHIIFtj1
 +3aR1DPmDfiFXTj8R7jfEEoEGfhshcE9Gx3L6Uo+9pfEEoMODoRGJZT0Lcj6RhSkp4Cb
 WIFVPvCeWshgSTiRQt7KK9u8u1zZCjvG0ImXHSnNpCGrIkXXRIuo+LM0uAL3AuMP+l3c
 gfAF4QZAXkme6Ee3vL2DjCy2x/3J9GHF7wL6u6tyPA+OqvqYgnAX0CbRpsEILyu//66a
 J/RvZqMLg7j+p1VGXFJgqMeh0BMS4ue9hQpCCkOzcvS02jsee+Wj38jGCf3JKgAapMr0 NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 3581mqwxu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 09 Dec 2020 03:04:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B92tiw1007609;
 Wed, 9 Dec 2020 03:04:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 358m4yujv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Dec 2020 03:04:26 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B934MK3021556;
 Wed, 9 Dec 2020 03:04:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 08 Dec 2020 19:04:20 -0800
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de> (Hannes Reinecke's
 message of "Mon, 7 Dec 2020 15:56:15 +0100")
Organization: Oracle Corporation
Message-ID: <yq1im9bsn0a.fsf@ca-mkp.ca.oracle.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
Date: Tue, 08 Dec 2020 22:02:35 -0500
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_220437_709596_DBDBF93C 
X-CRM114-Status: GOOD (  14.30  )
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
Cc: axboe@kernel.dk, damien.lemoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me, snitzer@redhat.com,
 selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Mikulas Patocka <mpatocka@redhat.com>, joshi.k@samsung.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>, kbusch@kernel.org,
 javier.gonz@samsung.com, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Hannes,

[Sorry I'm late to the discussion here, had a few fires going in
addition to the end of the kernel cycle]

> And we shouldn't forget that the main issue which killed all previous
> implementations was a missing QoS guarantee.

That and the fact that our arbitrary stacking situation was hard to
resolve.

The QoS guarantee was somewhat addressed by Fred in T10. But I agree we
need some sort of toggle.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
