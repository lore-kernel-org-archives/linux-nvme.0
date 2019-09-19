Return-Path: <SRS0=DlcY=XO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA6C4CEC9
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 00:40:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A63721907
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 00:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V1OKTgLZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XFNu2t5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A63721907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G8RKAfKgBoCvrUYcy/LhT5NooiFUha7m/EsJl840VBA=; b=V1OKTgLZOHLEMu
	SvgmDBEn0PSjJ8rFKc8PiVUSo6WoSDw3HbuYUCTmhrKGPB2z2ZeeawoKU9YvU75RZ7RzjcWQ4X/IE
	xj3OHFul9otRhpMnN4O165YUPBQ2u8UyNmZwGDB5Rx905vFrEDUxXb+RJ7NE7Z05siq/ht1A0XX+e
	GO/SjsmopsTIRcs6AgcvbIa/D1V/q/0EYcXRXZqLbLV0QzxyZpYH15wsdaPACPo+ix+7bGG5b5ZUa
	e/tQA/+58oDye0UKLfLmgZzM98CTUeIkyZCJgW4apO+zKTiO5OmeOwYZ0J/jxNn5Lt7e15vJEUgGt
	xN0kw7UU3434YR+9HOgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAkUs-0000SE-6Y; Thu, 19 Sep 2019 00:40:34 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAkUp-0000RO-H8
 for linux-nvme@lists.infradead.org; Thu, 19 Sep 2019 00:40:32 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J0dX9T024573;
 Thu, 19 Sep 2019 00:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=IiS8L7N9j19Ktt7jiprEMiAHt8Lso8e0fWbUgEUG5V8=;
 b=XFNu2t5BvRu7qGRCCJQS1sWozs+CA4hh3L0XGMClLM2Cm3YnguEM8kkMdZ/FeoJTBnPR
 fjqurUlG/LDbpdST7E+qHopb8FFOZaYmlfDwkIDM8NZBWAMqDJTyIfh0nZuPlBk2WW83
 /tnT5kacddQ8RpYRr2XsY/gkGZs0j4nTPYqyiaE5/C1hd+24H4Rg/Ue7NREL9OvhxUr3
 csEkHfR5rt8rWtXOVYxuiByruFiOSDyMp8m6FMWLoNSOFpebRy5QhlE2xspTRU6bZbp2
 SXI6b5cGophHGNpOZtJU6ZfoqMRUKV9Hnj7+GxpIBk0iijootjmPzXcD859YbGSSRpB1 hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2v3vb50jge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2019 00:40:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J0cKii096214;
 Thu, 19 Sep 2019 00:40:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2v3vb926j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2019 00:40:11 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8J0e80I029874;
 Thu, 19 Sep 2019 00:40:08 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 18 Sep 2019 17:40:07 -0700
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
 <20190916073455.GA25515@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
 <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
 <20190918132611.GA16232@lst.de> <20190918170807.GA50966@C02WT3WMHTD6>
 <20190918170956.GA19639@lst.de>
Date: Wed, 18 Sep 2019 20:40:05 -0400
In-Reply-To: <20190918170956.GA19639@lst.de> (Christoph Hellwig's message of
 "Wed, 18 Sep 2019 19:09:56 +0200")
Message-ID: <yq1h85986fu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=721
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=797 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190003
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_174031_659656_A1822EE3 
X-CRM114-Status: GOOD (  17.02  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "Baldyga, Robert" <robert.baldyga@intel.com>,
 Keith Busch <kbusch@kernel.org>, "Rakowski,
 Michal" <michal.rakowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Christoph,

> On Wed, Sep 18, 2019 at 11:08:07AM -0600, Keith Busch wrote:
>> And yes, that bouncing is really nasty, but it's really only needed for
>> PRP, so maybe let's just not ignore that transfer mode and support
>> extended metadata iff the controller supports SGLs. We just need a
>> special SGL setup routine to weave the data and metadata.
>
> Well, what is the point?  If people really want to use metadata they
> should just buy a drive supporting the separate metadata pointer.  In
> fact I haven't had to deal with a drive that only supports interleaved
> metadata so far given how awkward that is to deal with.

Yep. There's a reason we did DIX...

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
