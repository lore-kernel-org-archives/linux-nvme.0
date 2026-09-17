Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273FAC982C1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bNc9SxeMPkWE2pu814W9u/sSRhnubnpaFwSHoFKsqnI=; b=Rqgu01GGd8SAz/SZnaglux/VnI
	/GbrSfk0J2XOXLORaoKz5i/UdYJzk4j03B5HXwqSg4e2HYH1WkAcwL5EPgB4usJqK/ZLcAGY4CK6v
	tl3RKRqjfuIzZkZeE3F4hZC3XV09jZTz1EgUeVKrUSTaKRvXW0P1aOhAjOEZ9QqA8HiLpRGIdQMZw
	nrOkR7mRfjc3NQ6ke1UQHOtouLxfp3fbg1miivvYbjGwKaD6cd9m5cGNQ2uOx0iXGmOfU4hJiZXl/
	4MpGRsAp2ZmtXf1SuVR7yI9jpZYpvXYiBw0332803VBfMi+4lu+nTpGvfBnYJcPVs3oPGpZh1NH+Z
	fZg6uqHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x77KA-0000000AsYe-23VC;
	Thu, 17 Sep 2026 08:18:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x77K8-0000000AsY0-218U
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 08:18:29 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H62r3s543883;
	Thu, 17 Sep 2026 08:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bNc9Sx
	eMPkWE2pu814W9u/sSRhnubnpaFwSHoFKsqnI=; b=HYL0SNhi5itJS/QwpCdxbC
	eJ1n62g8/ksh6nhgRayjhaq3ZSStBges96lgkaYg91H4HIe6m651l954Btt92qbn
	PybBuNz2xqNWcy0prIj7HIMe+DoxEMic6F/PgAKH82/zjWTUK1q8XtHsSJ2yyufB
	751Te/D6yCcASJNnel5ck4KXe5wiHt8QoQnWfi1XGnAUaQEaukkQR12EDANbUozs
	/4CvSpjr8lACTnfTBW4X94DD0RfKbLJP4GlQ4vZYvPQQoDnBxmexjwgrvCnCLP8j
	N5X1nlJPw0oaV4FARnzrPtEFlAUiJvrZwYP3tCTAqhL11k+U+2kWb6atzMnX/Mtg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e8uy1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:18:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H654tT3619009;
	Thu, 17 Sep 2026 08:18:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7geh36a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:18:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H8IIgt66453768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 08:18:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 788D05805D;
	Thu, 17 Sep 2026 08:18:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEFB258061;
	Thu, 17 Sep 2026 08:18:13 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 08:18:13 +0000 (GMT)
Message-ID: <59ea761a-9063-4080-a653-006b10bf4d6c@linux.ibm.com>
Date: Thu, 17 Sep 2026 13:48:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: work around -Wformat-security warning
To: Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Maurizio Lombardi <mlombard@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        "Martin K. Petersen" <mkp@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260916114533.237863-1-arnd@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260916114533.237863-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwOCBTYWx0ZWRfX5OsBoHNZE+mE
 PIvlWZTx31Qc8Gsw0z7/66EN1P2GPoA89tV06MbyFq4ueKUKX71e0B7uom/5t6wcaDBAnKkh6p4
 Z9WOGk1QTm+jjiuSU3TydYyi85mzVZ71EmV9lG8G+ztsUzQNMzLwcnGi2D3uJ1In9gtXrIJTsMQ
 w4w+aX+3l/fV5exdzWF7LQj16i+2n7FcAyoPiKJfM0gKQks2Gleksw11O61wE5Pzski7IlhMfj0
 wgv/G/QAxOkjUKETC7M9VSH58ne/HBGsAKf7Snh+aV7qsVT4wTxoEYSn5G/y8H7yY+tcn0Zk7mu
 rr5MOKVVxiZkBqz5YxXlaGr5YabKU/OUcVzEXGvQA1FRliCh0exScSlLQcek+AR4avbxEAX0+++
 AoC54YCkq6cBGlguA7caaSBAfw6oK6kaAPpxGKpuxC82ei4QlQbeyhuNukHnr+53P+VAhyHkMEz
 Gy3krRHUZPAQSTz3oGA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaba24c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=TVXpOtnEInQrzbVAg1AA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: m49TgpsSjZ2XnFhABsmD8AIUXfMKA3q8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwOCBTYWx0ZWRfX14rt3zofN7cX
 9rg3ocJ4v5NoqzAlIPDT0dkVyTs1iY0fY7RTDL5IaAeKX3C0kt+/+P0dJtLLCdw3ZbWZlRhiBNY
 cqVP2Ji6/MX/MkPca1NMwDZuCciXgAA=
X-Proofpoint-GUID: m49TgpsSjZ2XnFhABsmD8AIUXfMKA3q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_011828_638451_51CC96AC 
X-CRM114-Status: GOOD (  12.43  )
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

On 9/16/26 5:14 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
> 
> Passing a string variable into dev_set_name() causes a warning
> when building with -Wformat-security enabled:
> 
> drivers/nvme/host/core.c: In function 'nvme_cdev_add':
> drivers/nvme/host/core.c:3911:9: error: format not a string literal and no format arguments [-Werror=format-security]
>   3911 |         ret = dev_set_name(cdev_device, name);
> 
> Remove the temporary strings and let dev_set_name() do the
> same thing internally.
> 
> Fixes: 26acdaa357cd ("nvme: fix crash and memory leak during invalid cdev teardown")
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

