Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22581CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vM81ijpVRIfOQpuUNIseAyAOboBzuQON04OLSxcWG7Q=; b=rLb7YE/w59JullCdwNF24K6Gx7
	4FZm6oxfbro4uWa1l/vhyK8BZsJVpkp1LRE6qCFy01NctJqOXYr4IeVaitowop6uaSt/4IKTFWHxU
	ILeQPQu42XRLVyspChX2digs02S+Oq/83t+HIH1R5NGgLsOANNcOunbJcjqGpsIiI2kCIQfp5lW9C
	TkFaanvHrNu5lZPRw7qlLNvXIj65fy+cb4evpADUCyXCWv7eNxWcxQEE1nmcO5TsyzPi67KrwQIqy
	n/WniiukkjTjJDGBklGB4YJUOGL/djrqg83Lf5ghlJKcjJewfY2d07NF3kSOrLzaR0s7bDtRNyIwU
	Mwj8rjxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7Y6-00000003O1v-0ybw;
	Wed, 27 May 2026 06:15:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7Y3-00000003O1F-0nfB
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 06:15:24 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4UWH735258;
	Wed, 27 May 2026 06:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vM81ij
	pVRIfOQpuUNIseAyAOboBzuQON04OLSxcWG7Q=; b=jG8oi7hoYLlFgW9QTX9GI2
	jx1O+DUH1LVUrbBdtDrVSMA+yhLH/WxDgNIZ5J+Q1O1NAY0afBSXi/N4kLzmj7ie
	cZ3ZU7KYl1dJ29XQhMixipQ6ha4BEo2+rZaX5XxOEOSaW1ex55HUS/IvlTXE//Ku
	WgilKyZ6a/rhuHY1BRI4bS9OzsPt1TtGVN6ijHcNJFhsj6+10FjICRJ1ZLn4ng9K
	hmlBhUDQsvYRmYgP5fieeDHFjCw4bhqpRc+o+5pZ4YDOfqSyexG4mPGTyswpqXA5
	nwsm/N5LmeYAo50T3XB/KFrfmJVVAMFnuWS9lRNQXV1j8sgfrQ22U5ahD3NNT0rg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc6nu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:15:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R697VE009592;
	Wed, 27 May 2026 06:15:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbsnfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:15:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R6FA8S30278196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 06:15:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8994258060;
	Wed, 27 May 2026 06:15:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6566D5804E;
	Wed, 27 May 2026 06:15:08 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 06:15:08 +0000 (GMT)
Message-ID: <39d29c16-8159-4765-b1e6-09a4354e33ea@linux.ibm.com>
Date: Wed, 27 May 2026 11:45:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20260526153921.2402015-1-kbusch@meta.com>
 <20260526153921.2402015-2-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260526153921.2402015-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a168bf0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UFKti7nZLArcjxYJBigA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JW01OkM9uoDNUAqp0-nrJXgUbPVx6NL0
X-Proofpoint-GUID: JW01OkM9uoDNUAqp0-nrJXgUbPVx6NL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA1NyBTYWx0ZWRfXxYO+jZRZHjSv
 rbEtE1UqHem20UooKryyFFrMFGn62Xixz3Jn4uQQyO+fs4fnF/Uw3hVDj68GjnwaQAIlzyd9tfJ
 xgN12ESZ5ySV62e2LJdGCUsun8BW7x6BjdpX7/+kTuXcvSdyoKdxiWgS8I9M6h2E1So5x0tvZSW
 GN2woNlj7LmB6nlUrO6Rvguk0L6GyvHqEwDy7pCP9BFPT9NbhW2ZrNZHKOeg5x8U2V3hCRbrZG3
 EYUOVdPw9iq2CfK3OXmuRav7RT7DcNUqQweOtLKa9KvVU6J413O5vjOD1Y5Vng7zMBV6haEt7sz
 NsnHo8PiFNgD8RNWe6TqgjleBSG0yyQ/xAjKmUCQdQDGoZnkKzg4vCf5BxM7bDwhQb791S5H7K1
 vDrvA1w5/HQ8t79Z0Rrz6iVmmJQeD+qmLIU1K8nZRL0Aa6PiTfo3LB5N5VSKzGUCiJ2NY7wrX7q
 3S8Ys7Z5quiab6RWzgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_231523_378392_C73D336F 
X-CRM114-Status: GOOD (  11.05  )
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

On 5/26/26 9:09 PM, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
> 
> A user can enable io accounting for passthrough requests, so export the
> helper that checks if the request should be tracked. This will enable
> stacking drivers to to report iostats for passthrough workloads.
> 
> Signed-off-by: Keith Busch<kbusch@kernel.org>
> ---
>   block/blk-mq.c         | 32 +-------------------------------
>   include/linux/blk-mq.h | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+), 31 deletions(-)

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

