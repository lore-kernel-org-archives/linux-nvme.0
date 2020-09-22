Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8301C4727D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:45:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A36822262
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xZLAxytC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FB4JX+Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A36822262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:References:Message-ID:
	From:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0iJZjVWhQuwluAcP0bSmUmyTt9Ah87XzJQKagcK7Sb0=; b=xZLAxytCJ97lbeR7oNUKI0hd7
	c1yLYiwMwT3RLTVaREnf0Mwe2wOR8NIvpop5196hsTFBURYgEWHOyvekE9jOt9Rk1r9ltyycjl1D4
	Z++HzbBlaxb8IrbqQS0QTqFKMLxmmxXd/kxtPoN0+IYABCNxTHhB6NiXKkcAjzdO6D+ox8BesnXd/
	KJfqayxW4IW75KB9dRoEzfFKwQ/OndK73q2/VWsnA4mIKRNgqvG8TfOqlnNjvUiwjuaFP1x+qRXh3
	7lsxEtwO2NVrg5kL1DdxU0ZPHwOJdDlctJayxd+32f6oOjpjKl1wblmaSE+Yk43VWaBKBi2lnFaCm
	r1ZZ+Lnmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKq67-0004r6-Lg; Tue, 22 Sep 2020 21:45:15 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKq65-0004qQ-2g
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 21:45:14 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MLPS0u120824;
 Tue, 22 Sep 2020 21:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=OnHR2z+pTSxWGA0yzbpjKzfdiJyDBQzjB79y2MMZH/c=;
 b=FB4JX+WfNSSbtGh1TxsdqRv7IrboBDiEuVBNmgbSj63ZTmextKoFY3UiSwWzOTor4Y6A
 E3XlS3VhITTV53QI4mZByjgLbnlj6fqLEq2zkfr+RLy1VwvFNquxybUsy1Lh/1rcknez
 bBzCqZbkMRQm82KczT+c6SKdtBqQLJcVRjHRqvsrTuZQhbfl+H48yItLg6hJxSwKxM8a
 HBfP2vgm7P0KOwOhNF2d4t2r1QiFiBrhJ1waJuxK5j+Vb9/s54TmYVlipw2ciyLb2uuZ
 V/AtRM3IgRxJ9XJMNlBt6xoSspSe37b1nk2S39aeWXUD1Z4q3yWwtkT05742O9+tbEQH XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 33qcptv876-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Sep 2020 21:45:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MLQW52156536;
 Tue, 22 Sep 2020 21:45:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 33nurtm50u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2020 21:45:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08MLj4NG013468;
 Tue, 22 Sep 2020 21:45:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 22 Sep 2020 14:45:04 -0700
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 4/4] scsi: handle zone resources errors
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15z85pjuv.fsf@ca-mkp.ca.oracle.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
 <20200917231841.4029747-5-kbusch@kernel.org>
Date: Tue, 22 Sep 2020 17:45:01 -0400
In-Reply-To: <20200917231841.4029747-5-kbusch@kernel.org> (Keith Busch's
 message of "Thu, 17 Sep 2020 16:18:41 -0700")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 mlxlogscore=812 bulkscore=0 mlxscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 mlxlogscore=795
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220167
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_174513_231334_85B78D0A 
X-CRM114-Status: GOOD (  17.37  )
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
Cc: axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 martin.petersen@oracle.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Keith,

> ZBC or ZAC disks that have a limit on the number of open zones may
> fail a zone open command or a write to a zone that is not already
> implicitly or explicitly open if the total number of open zones is
> already at the maximum allowed.
>
> For these operations, instead of returning the generic BLK_STS_IOERR,
> return BLK_STS_ZONE_OPEN_RESOURCE which is returned as -ETOOMANYREFS
> to the I/O issuer, allowing the device user to act appropriately on
> these relatively benign zone resource errors.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks fine but needs your SoB as Damien pointed out.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
