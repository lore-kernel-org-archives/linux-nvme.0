Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D2ECCF9F0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mD5r71BVS21ewOiZf8dMXggpxJLFWlk/aN2Oc8hga9w=; b=KqUZJA0Wq4ea7YVuBFIZ7zP7eM
	7dZgbPGck43520/ONAFDg48qXoHOf+z2GoGC450i14v95dGaaZcqcOtHbKvN5hIWFzxdbgfQ5yZuJ
	lRN8cF8OD7KfdReTaB+k3wPUcPLW+aLUmsBxbxTGe2BN+Rvk8jLjiDs8BxHaKYPR9lbayDKDD1geI
	BYsNy3fR2ElCwbv+wD2DFSj/iEM3rWtaR+/2r8tkOnnRGP3P6O9w/dwqLA+bdEnHkmYwUFGDGiA2f
	5GUdqfAEhJyZtw+w5ZRtzXjAuW90k6l8A9QkezE1R0RN+YexCAnELcGQsICCqhd2yfUw9iFRq7tAD
	ymp84hsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE9EK-00000002472-255I;
	Wed, 29 Oct 2025 16:41:00 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE9EI-0000000246K-0VKa
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 16:40:59 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TC6kQe025645;
	Wed, 29 Oct 2025 16:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mD5r71
	BVS21ewOiZf8dMXggpxJLFWlk/aN2Oc8hga9w=; b=lGVUi2Kw1P652HmQOueqrW
	ydG4apCVKCBmox4MhzU33HNXI6brNUixO40N/2mrggqk2tZGEaTsMRahp1+sulgC
	obPtlvpDB9v/4plwAM986y+jcUAPaVAC8CCalxX+XY8dAVXmFqsgmJwYr8CfpjG9
	D4duMDDQzwB2XeyBBedagdaG20FVPqeXb1peh8HH2Q/wrTt7kEJw5UdGGp02QrR/
	fjYqZTFUYlZUcA/FVgZN5yLVbe0LaGytcdZyK5c0bAEoRGTZjeCqJRiDaZCyA/y6
	RGwMUENnCObj5ixwgQ0Y+t3fh5ZnQMCuuk4bOWMsCJyoX1dcT9uFUYkj5lk1rV8w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acmfb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 16:40:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TDhOCV027516;
	Wed, 29 Oct 2025 16:40:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33w2mck9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 16:40:48 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TGelw420775568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:40:48 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA03458052;
	Wed, 29 Oct 2025 16:40:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AB8C58045;
	Wed, 29 Oct 2025 16:40:45 +0000 (GMT)
Received: from [9.61.54.89] (unknown [9.61.54.89])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 16:40:44 +0000 (GMT)
Message-ID: <fccc74b2-98af-41b3-a819-8f3f295937fe@linux.ibm.com>
Date: Wed, 29 Oct 2025 22:10:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 1/6] block: expose
 blk_stat_{enable,disable}_accounting() to drivers
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
        sagi@grimberg.me, dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20251027092949.961287-1-nilay@linux.ibm.com>
 <20251027092949.961287-2-nilay@linux.ibm.com> <20251029093934.GB1066@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251029093934.GB1066@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=69024391 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=odWxVjlxeg2ErseHIvcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DSuAxsQUrER0bSwievV--KHW01rpFQgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX0unFDy/4LocC
 1FkdjlahObfz1gJ9AVZHoFW4duAuEek/hk+2U06X600F7BLj54OLMOjcmlP+l4dDB59WO+yQ9kN
 zmGYF6qw34FKZ+VzQX63M1zik2H613g6s1lHFmT52rhJhBwMVjTCdWRiBGz3XScJq+RGS1gWLLc
 +6IQ5Gh/P4xFeajav1KkSNJzRdnDMa6h7RmYUUU4psN9u90mJJhPWg9+YGMWr9uDinX5MKyoTlT
 O5aDMOTjYVrcPDVJz8OFusih7y6qNCeeiEw7cVFAQNNDf2tCVMMEBPcXI+B2UoNJ5FCe/B08t68
 IFMOoXm5KrYBvoP3wocMOIS5uT217hHJaqkI/bcpoWMbNTqv4b1HaJ7OzdyrR8sCl54TmugmUX7
 qBFVitNkkdhZsWI3AvARE9osWYnB5g==
X-Proofpoint-GUID: DSuAxsQUrER0bSwievV--KHW01rpFQgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_094058_166497_74004757 
X-CRM114-Status: GOOD (  14.93  )
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



On 10/29/25 3:09 PM, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 02:59:35PM +0530, Nilay Shroff wrote:
>> The functions blk_stat_enable_accounting() and
>> blk_stat_disable_accounting() are currently exported, but their
>> prototypes are only defined in a private header. Move these prototypes
>> into a common header so that block drivers can directly use these APIs.
> 
> That's because they are only used by I/O scheduler, which are the only
> valid users.  I don't think drivers should touch this, but I'll stay
> tuned..
> 

Well, these stat APIs are already exported by the block layer, so I assumed
the intention was to allow drivers to make use of them. If that’s not the case,
then perhaps they were exported unintentionally.

On a related note, I also looked into using nvme_req(rq)->start_time, which is
initialized using jiffies when the request is submitted to the device. However,
for my use case, I need timestamp data with nanosecond precision, which is why
I opted to use the blk-stat APIs instead.

Thanks,
--Nilay 


