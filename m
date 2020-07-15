Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A58C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 20:20:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D51720657
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 20:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YqWSZ6GD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u/O2MEJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D51720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=71HUToyixE2LPS1ZPdj7eHqvoYm3WjQIKnkRWNly8hI=; b=YqWSZ6GDwqQa9/kKVRkiLGiXq
	q5tpZAoWV4dqwGCE/aCmWgvikreVcCtJEDSucMwyIpXwgYiYHiGDNtIdufOH2tHV6PKdSeOx4/DWw
	yDkUYz2OlnuFmOyQA4ScN6xwgV89Y2wmpwdI2xsr3JG84vM+aL+udMv6T8IxpoR+CrDR6uvbgs922
	HqVOT8DjIqOCMq4FenZhQuVLPaPO67XiXBn1cj3Bb+plKnBKLw2n41hP4/oP5EbljRw12Qh8q++zd
	zUO5VWfxnz9IGJOeZZXNhQ7giwnKTM9Vj51l7C3repqNu05h3/4vG0T0Qz7Zv53Fiouc9Fwk/24Pn
	NGC8Q5HRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvnsx-0006HB-TW; Wed, 15 Jul 2020 20:20:12 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvnsu-0006Gg-Hi
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 20:20:09 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FKC9aj035619;
 Wed, 15 Jul 2020 20:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=peZ+vRId/ykXQLD5oamoNCCTsVfZ602Lx7lqj/8gGks=;
 b=u/O2MEJT5hTpPHg2Knqp+4T+7D7JXuVwi2Hs8num47piMyNm1pZRlhcJ+1oVV2SBvHZw
 T3SECeP+gkVSb8vWHAgM6Yt4p3yx8AP/26iFTHygrsmXr/itr73U/S0ioarUSRAdM4Ke
 yfcuPTBF0EZOkuQ/+kixeHDFUzZPNF1tpZX5SqlYfzn+QYmCTFuq9OKfNRmZHZQOMsmn
 xNKhFEFZ7G/nXN6vBuKNwNZO+vDiW4Y6+GgQOojFl8TOd90t4hrTOTxv9mB7vi63D58+
 /GNz10w2JShFFzjVLMb4LmrhWi2A6oRdfj+v4MrX55SEzA9csHdJ28g2Bvdcn8TSncgd Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 3274urdnvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Jul 2020 20:19:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FKHeuL107174;
 Wed, 15 Jul 2020 20:19:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 327q0rxbcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 20:19:55 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06FKJmxW006290;
 Wed, 15 Jul 2020 20:19:48 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 15 Jul 2020 13:19:47 -0700
To: Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v3 0/2] Export max open zones and max active zones to sysfs
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mu40o7jj.fsf@ca-mkp.ca.oracle.com>
References: <20200714211824.759224-1-niklas.cassel@wdc.com>
Date: Wed, 15 Jul 2020 16:19:42 -0400
In-Reply-To: <20200714211824.759224-1-niklas.cassel@wdc.com> (Niklas Cassel's
 message of "Tue, 14 Jul 2020 23:18:22 +0200")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150155
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200715_162008_738173_346BD380 
X-CRM114-Status: GOOD (  11.07  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Niklas,

> Export max open zones and max active zones to sysfs.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
