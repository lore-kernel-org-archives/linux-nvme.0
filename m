Return-Path: <SRS0=OKIn=7E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3479C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 13:29:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C080F20679
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2020 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OuObJO/7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TqrTc+G8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C080F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:
	References:Message-ID:From:Subject:To:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XWAih21igEAZA2WuqfQFrJ8NMw7ndN2cwVvP4AD89so=; b=OuObJO/7bxw7zX
	KhSq8kYIM6mmB4MOqHkf5KWuFSpDW8yVx5W38oi9eNGry25APOmlX3JQ4deQK7vlxATSaSQLSiUPO
	3jvHfOnp7vNYmW19kPDNwyVffMXly91NGIp/Zfz4cfDjEI+y0+9F0w7SF9paKmye4Uoiu0R0Vwt2u
	K8U2vIiLyMSG+AQwlTzEiP2Qh50tDY59YKvnbSSinrhF4+yY78CDe/+ZfGdghcIup3ckvTl+Fw3GA
	zkYrfhzDRmGHVl1dfydVXf2URtzukvAs/lPWV6os4bdwLXZLtv3g0zLsIiFuFGs2kcFZK171lfvfL
	Bw1ulGDxqY3b8CBpvshA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jc7jN-0005Zr-8W; Fri, 22 May 2020 13:28:57 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jc7jK-0005ZI-14
 for linux-nvme@lists.infradead.org; Fri, 22 May 2020 13:28:55 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDRWFn100636;
 Fri, 22 May 2020 13:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=wJj/TOJ6M1t5cfmt+N94dEWcPKX/nTIvr6VL+0kO4SI=;
 b=TqrTc+G8JBybFizewgrreitt3mw0VvHVgSL9ltZcik1FLZn9T5MJy4h82rd9/Jj+Kwv6
 AEAzctPEEfiaRNNNzfYPdb8sKRxtqf9GWeVMnXWKm7dAYx7mChUM48jAOJd1h+yc3Mqp
 pA+ON8loBffZsTNDmsqZ0OQ43HGComdRj8/nX1ogSNAuYiOJUKx0JFiLPyejPU8sjfH6
 Y/NfmYtrWlrwumjV4cfg53ULXj46YCMdjLIibOUp9jU+eB5W+xXQZ0kJwV+NG+UJd4gL
 C0jTfwib/4JucFQtPd8TH0BA0TuzGoUXqpV4VRDWtAig6H9ZmUUOcuysjW0Yg0fSDNsc fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 31501rm95f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 May 2020 13:28:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDSjh4174114;
 Fri, 22 May 2020 13:28:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 313gj7g554-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 13:28:46 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04MDSdHN010303;
 Fri, 22 May 2020 13:28:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 22 May 2020 06:28:38 -0700
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] block: Improve io_opt limit stacking
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lflkp0b9.fsf@ca-mkp.ca.oracle.com>
References: <20200514065819.1113949-1-damien.lemoal@wdc.com>
 <BY5PR04MB6900144BD2729172EBF5DF2EE7B40@BY5PR04MB6900.namprd04.prod.outlook.com>
Date: Fri, 22 May 2020 09:28:36 -0400
In-Reply-To: <BY5PR04MB6900144BD2729172EBF5DF2EE7B40@BY5PR04MB6900.namprd04.prod.outlook.com>
 (Damien Le Moal's message of "Fri, 22 May 2020 07:27:11 +0000")
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxlogscore=862
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0
 mlxlogscore=895 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200522_062854_152517_39D159AD 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Damien,

>> +	if (t->io_opt & (t->physical_block_size - 1))
>> +		t->io_opt = lcm(t->io_opt, t->physical_block_size);

> Any comment on this patch ?  Note: the patch the patch "nvme: Fix
> io_opt limit setting" is already queued for 5.8.

Setting io_opt to the physical block size is not correct.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
