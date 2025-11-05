Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12551CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JdgAdIBfH+t1F2d3BmqV5ZhWYbo65SQ21rj4JxS5vao=; b=BKPsSMojYryuUS+JKCzXtrUyM7
	3hsVDBaGv2i6jh59eBO6zJrnnsq9LXXqffoTGPoXXSQgbXhcv9f175xCCw1+sXgUFyEGSFrMYrAmm
	dMaO8ZG6UWpw5d3VV0SjcGPj/56pE5PeuRkIwXzInnYXmhxzcSkODjhXpMQXwRmHkZ2mkK0LJKFaL
	LgNcwxgyp/HguqdOMSRr5ngj3dr0O3NfHliwb84kIYp73Iy3wuj2IP4ZF8Xo0vZop/ze8Ztn/GJFE
	XdG/QfrJxP1QU7gzemVbRnOw9Wqpyp/O7qBSo2xgftRbiqQll/mmytnLNx9waOGXgSr2Hg1J0trZ9
	9a8e/byg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXSz-0000000D6W8-3UVp;
	Wed, 05 Nov 2025 06:58:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXSu-0000000D6UH-3Anc
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 06:57:58 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A54xQ95017849;
	Wed, 5 Nov 2025 06:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JdgAdI
	BfH+t1F2d3BmqV5ZhWYbo65SQ21rj4JxS5vao=; b=KJ5+hRdQZ1OxRzKPMAwWWa
	vaFZsfAxC8OaWK3p8/lRrnk5hvFZjoeH0MK+Zh9Q4vXTHj/TC5ym9Guox+TKh0vf
	O093pkeuHzBGOh8K9/1T7vnbOr/qKIvhhEbmkHy6HfK4Xj6G8Mm42wol43yL02OS
	dbDK4iPjnJOBYMTxo/dOwH5y6lnmnjahXXszXw/J0zJxGjRMU7p6WWs+FlaHBXVn
	bvl8jbXGiPxBnviPlmE1j6s65aQ3AJ6dY1D21fekrcflSUR6CPEZhIAl8cQTBO/k
	NIvZtcSa907y/iuRcPEBg3ykrXzpm9pW7/kAJ2LcYCH9LxnARWdqrXrC+YyUwMhg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuftsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 06:57:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A56vhSk022812;
	Wed, 5 Nov 2025 06:57:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuftss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 06:57:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A54ULBX012845;
	Wed, 5 Nov 2025 06:57:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y81xjm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 06:57:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A56vfFj21168654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 06:57:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDDBF58062;
	Wed,  5 Nov 2025 06:57:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC2DA5805D;
	Wed,  5 Nov 2025 06:57:38 +0000 (GMT)
Received: from [9.109.198.245] (unknown [9.109.198.245])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 06:57:38 +0000 (GMT)
Message-ID: <154a5fc6-c56f-4a41-b5a6-009334367f88@linux.ibm.com>
Date: Wed, 5 Nov 2025 12:27:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv4 0/6] nvme-multipath: introduce adaptive I/O policy
To: Guixin Liu <kanie@linux.alibaba.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20251104104533.138481-1-nilay@linux.ibm.com>
 <96f9d51d-7cde-404b-a2a4-0c1b97d07be6@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <96f9d51d-7cde-404b-a2a4-0c1b97d07be6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eNLKikPj1FB2ohgEOTdtWaVxZBM6TGBC
X-Proofpoint-GUID: nWYL-qmIRUwMUGfUm1fO0RHf9IWdGK_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX/0l8En9nyd9L
 4Na03WBw7r1Nqeup4MFD+rhdEGELBtKU+rercl7Ox8yd1R8OMtXIdOU/Fu5ZGBPlJW61Tt4dDow
 uaqOme7Tr8+m5GrVGSx9orwMuu1/HcOUbdmwJUEU3SoqLpPmKbPMPKS6DIaQCgpH5wV74AJUe4W
 5R9yR4LY6nDl7RGdxNO0w3nbUxDGZLOfYavJ+kaCPsAqgQRSEji/s4hBQbCTrZ/wf4tAmgPcdmH
 iHUCW88FKQ39mbKIyPiDwsEEV02bD+R/RJqLEo7j8N8qlZQT+Xl7mFN4Ng4BW1ITSx4IB3SgaSA
 Zq7pPu6OTWMlx7XuslNRtHKiN/bvAwPU4k3JpUfeHUiAk2oPJ02GOD01EFiRHy8WBOx5/MN31ON
 tOHF45TgGWkp995cJcNvOsfg6LvYJA==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690af567 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e4SXsZwL7cjpE_FuZ-IA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_225756_808109_38D02353 
X-CRM114-Status: GOOD (  10.33  )
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



On 11/4/25 10:27 PM, Guixin Liu wrote:
> Hi Nilay:
> 
> Could you plz update Documentation/admin-guide/nvme-multipath.rst too?
> 

Thanks for the pointer! I'll update the documentation and add one more
patch in the existing patchset.

--Nilay

