Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C73E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzEdvdaNe/NaMS8/dlTwh4LN3q7PPGH2drrrm0YbKwM=; b=mdbCfZX0+oF6s3MhL/3bEmTn4s
	wo4z9KGKbA5VCOVFQtCMqFdt9Oc8KyhyWqQByFASVUiJ+4nnAl6Aw5CFWb6clCZgR0QqPSFS3DHm+
	hoUhb2BVU7ILut7SIkA/7uLLhHUAMKALdkN0sxGM84taUEepUSm1thkxBKH9iFxMyLfYGkNx85fUp
	qfgcUItiizJl3ugDnkk5JqeaWSu7ayEel9OO36jKeA4z6P6rDE5hmFRYE1h57K4OxKfRM+2KIhDYF
	Y6wuKd2hY/TuaDxUeHSvJGvXIbJOWvBZOIvtNT6f6mY6cIQupjct8En4XHZlj7XsFme30ERKBNW/g
	bsV36tww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTsd-000000088Nl-2Cfx;
	Wed, 08 Jan 2025 11:05:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTlB-00000008608-1MsR
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:58:02 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5087eDN9007055;
	Wed, 8 Jan 2025 10:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qzEdvd
	aNe/NaMS8/dlTwh4LN3q7PPGH2drrrm0YbKwM=; b=BzlkOVGx94f52UyfeKtmX/
	35Ov2RxMjukEeuNABzY/pbTXpCVjmmxeAUfbAbMh9OekLXvdhR5/FoauHQiwVJSP
	J0QrLi5EyIkJN3JQX5MzILj/ssMjo01EsffPyJ3qw+Ri0BrAHN2It9hBQZS13b49
	wexCNt4JCbc+Qs82ObOyHldF3ikU0vky+LrNkkNw92rYKB//ab6ejC+LRPL29CDE
	jHfmVdrUN/LlLrQaL6SH0TSIOOg1WuI6vbMeypEP1EGhlw59GN3BQhoaqn0sdcZs
	o/oDVG+OErpyHn7L6Jo9gjnDqgAms+9qhG8YdFn32UX5rLeejrKtP2wnQGS4nvAA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4415r54wfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:57:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5088YQAe008870;
	Wed, 8 Jan 2025 10:57:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyyfaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:57:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508AvuXO32375394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 10:57:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A7425805D;
	Wed,  8 Jan 2025 10:57:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7A758059;
	Wed,  8 Jan 2025 10:57:53 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 10:57:52 +0000 (GMT)
Message-ID: <7a867d10-923e-4c9b-ab34-9d084474d499@linux.ibm.com>
Date: Wed, 8 Jan 2025 16:27:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] loop: fix queue freeze vs limits lock order
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        nbd@other.debian.org, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-11-hch@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250108092520.1325324-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s-XVh3kn9Vi8c2_S9D4wxUMbkILVJPtf
X-Proofpoint-GUID: s-XVh3kn9Vi8c2_S9D4wxUMbkILVJPtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=620
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501080082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_025801_481341_EEDDCBDE 
X-CRM114-Status: GOOD (  12.44  )
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



On 1/8/25 2:55 PM, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock using the
> queue_limits_commit_update_frozen helper and document the callers that
> do not freeze the queue at all.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

