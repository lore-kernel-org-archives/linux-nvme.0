Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D0C49ED7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 01:17:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C7B21928
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 01:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aqe7wQrP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2d4RXQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C7B21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dG1JdIW2OfO39lD7o1R2/qzxGK7sCwDyKFXY9+YV2Vo=; b=Aqe7wQrP8Rr889
	/mMWqkUYk31BiREHmyUksWA/IMXF0oULEo9ibFfrGIIPfD7IV4GPFuS+k1khKzfLZcGMoSsPzBRhn
	IUTm3y0CFKghOtzOrU64S1exMKC4Y2aGBnE9yodNnnii9NeDC9cCIIBN42nJLp8A7Z/xk1yn6WFsb
	ZQ1Oeam4P5fMCm1x7Uq3f7sVnFYrDSZT8WYYlT8QXzO9EIV4XJHmvfyt5chW40tF+w7OInCU86kqH
	tu9BC9jXHOA6SzFAGPIGabszSxasCzaXYXuOVc52nmL1O3gC2fSvHiYRdLaQ7fSs+yBzhmN4uQcD5
	r/XQAGX98jwSQNIg3+XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7rFm-00024A-OJ; Wed, 11 Sep 2019 01:17:02 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7rFk-00023p-0U
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 01:17:01 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B1E3gx081074;
 Wed, 11 Sep 2019 01:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=VW6NQiLrb7n2pHcWqpWBPIO16ZVy6fIAW1nnemdhT+g=;
 b=W2d4RXQI704f78e3bazF325gUq5nSExcM8L/MYUTAKI74XCFvNKEYCx5wCWvHzHvYofz
 u3A81ju3LxDcJyx6dAkeAP781PciE2tYDlOx2FODMuFpaARbY+vta6wqL1s7ZOsQBWTu
 wTEyVOMhWKZ98s4CeS8ELQuPTBbjwGuYWAcr7uWVvTAPOjzD+eJHHXFa9QkwvkaMSZIB
 R8eP1Gf+Zp4GX9GKR7f4PXysnvGTGG1EiANP2u3WxKVdV9+G2mBrFkJEIlKB7SjPVDtb
 n4JfHlIHN8yOwKa5PnuVCr60TtAvNgt8WQYsJYitGtAVMmuztUH4GbYRpM5kxdDi2ngR DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2uw1jy6rpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2019 01:16:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B1E5kV060189;
 Wed, 11 Sep 2019 01:16:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2uxk0snpkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2019 01:16:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8B1GZeF028961;
 Wed, 11 Sep 2019 01:16:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Sep 2019 18:16:34 -0700
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the block
 layer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <yq1mufei4zk.fsf@oracle.com>
 <d6cfe6e5-508a-f01c-267d-c8009fafc571@mellanox.com>
 <yq1d0g8hoj5.fsf@oracle.com>
 <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com>
Date: Tue, 10 Sep 2019 21:16:32 -0400
In-Reply-To: <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com> (Max
 Gurtovoy's message of "Wed, 11 Sep 2019 01:27:29 +0300")
Message-ID: <yq1k1affx8v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=658
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=724 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110004
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190910_181700_145182_604A3B94 
X-CRM114-Status: GOOD (  13.82  )
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
Cc: axboe@kernel.dk, keith.busch@intel.com, sagi@grimberg.me,
 "Martin K. Petersen" <martin.petersen@oracle.com>, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> I guess Type 1 and Type 3 mirrors can work because Type 3 doesn't have
> a ref tag, right ?

It will work but you'll lose ref tag checking on the Type 3 side of the
mirror. So not exactly desirable. And in our experience, the ref tag is
hugely important.

Also, there are probably some headaches lurking in the slightly
different app/ref tag escape handling if you mix the two
formats. Whereas Type 1 and 2 are 100% identical in behavior if you use
the LBA as the ref tag.

>> Anyway. So my take on all this is that the T10-DIF-TYPE1-CRC profile is
>> "it" and everything else is legacy.
>
> do you see any reason to support the broken type 3 ?

Only to support existing installations. We can't really remove it
without the risk of breaking something for somebody out there.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
