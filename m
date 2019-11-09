Return-Path: <SRS0=282r=ZB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD205C17441
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Nov 2019 02:10:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB23521019
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Nov 2019 02:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XQz9XIs1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kLGK7S8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB23521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=txlgbUIMZWlwNoXQxFVXN/mot1OeufNndF/F4tMIXyc=; b=XQz9XIs14P3hDm
	7GzHzFg1S0ftTPjTMdCVE5FDaStuhsMn7FR2oa5CW2p2dpfA88ZR1gACsgRxTY8L3kiX7/cZSQx+f
	cP0R6uc8NShgU+27q5lSrCKMTmzvC71Fr3eKpFb18aUIdHe1iZWEuBVjMM2Edy/XD5kbHWfG3Gdxc
	ANW65IYi590bq7z//jgie2rKMHx02BjCjBzc3vRljmrOwGJevxxIzZHHKmvAziwQuDAw0mEnasFtt
	eZixnEbpTLHbjD9c8MwlK7g/Uco6ghfuoBGnQzaxHpbvh5mp9EMZpldi39NpBY2Gt+7Zns22oFxJR
	81TZMmGDG/PjJGoInC1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iTGD8-0004fe-JD; Sat, 09 Nov 2019 02:10:46 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTGD6-0004f3-HC
 for linux-nvme@lists.infradead.org; Sat, 09 Nov 2019 02:10:45 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA92ASai192333;
 Sat, 9 Nov 2019 02:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=V5CJcNApYxpDczQ4ADL3cRGstDfWH1koab60CADqsC0=;
 b=kLGK7S8D5K3324H1bkKsMmH/M00Sf1roNH7ZwT/YZcGG9xTpke5qmsjZ9mniojDMzlh0
 K8CQhspe808baXkg+pWxcIrHFXuh4vw3i6T1ZD8V/xuh7YfxRwyGxBPtYJrpAW8Gcdo6
 x5bjw/hGihprWD+dNyeAnAADG6+adYpMFshFoym+ngeVs29CZ7gyY3zqUSTjj36vkiET
 Dcq3UpQmDj/ZGBzzQH0arxXq33BkzArzGx7k+g/moabKipRBtfJE1s1UtYGJ4FQ6n1oF
 8JtZqpVwuaFlgkiL/m0bjGqEFhM6+O4CFawB58182mb0B9RO9k+EgHIWiVvNEZ9+HVVa rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2w5hgwrbeg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Nov 2019 02:10:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA927nIp129872;
 Sat, 9 Nov 2019 02:10:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2w5hh4kj1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Nov 2019 02:10:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA92AUaH011096;
 Sat, 9 Nov 2019 02:10:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 08 Nov 2019 18:10:29 -0800
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 06/15] block: Introduce BIP_NOMAP_INTEGRITY bip_flag
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-8-maxg@mellanox.com>
 <yq1y2wsxv7o.fsf@oracle.com>
 <578955b0-719e-0ab4-919f-b4ec84d1f77d@mellanox.com>
Date: Fri, 08 Nov 2019 21:10:26 -0500
In-Reply-To: <578955b0-719e-0ab4-919f-b4ec84d1f77d@mellanox.com> (Max
 Gurtovoy's message of "Thu, 7 Nov 2019 15:29:25 +0200")
Message-ID: <yq1zhh5vlyl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911090019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911090019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191108_181044_656063_BD545222 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> In the fabric solution the Initiator side is the SW controller of the
> namespace and the target is kinda HW controller.
>
> The SW controller is doing the reftag remapping during
> prepare/complete functions and it should be done only once.
>
> The HW controller should write/read the data from the media as is (and
> maybe verify/add it).
>
> When you're using an NVMe disk as the bdev for the target namespace,
> then prepare/complete will be called also in the "target" side and we
> don't want double remapping to happen.

In a typical SCSI setup you'll have remapping several times as the file
block offset visible to an application is different from the LBA on the
LUN. And the LUN LBA is different from the LBA of the drive physically
storing the data block inside the disk array.

To me it sounds like your 1:1 mapping between host LBA and target
back-end LBA is just a special case. What happens in your scenario if
the target bdev is a partition and not a full namespace?

> In the complete_fn there is no option to skip the remapping...

Only because there hasn't been a need. Feel free to add a
BIP_MAPPED_INTEGRITY check to complete_fn.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
