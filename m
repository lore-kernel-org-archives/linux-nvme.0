Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D191C83F1A
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3Vnrym9B5BPe2U/a3iHJBpV8aO0k5uE39IfFSeBVBc=; b=Y9gPv53NIosJJdbNvTv6iH8De4
	LtjGNohy9tkivyEWOW4iwifbPhwpBr3rtqZaHL+1TegsijmBtFEvm3JZ0vBAMmwOENlvX2IPQA1l7
	tMkMhEvz8YN6io/bveOIUXnDZNE1Si/6UB6pW6QbQ+WVXHtuzk78XCihb3Cj9kyxFWOETHfcrR5js
	hfgVcvtK2Q5WtVhLYeN3gPR5m3nhtg2nMnWnG5XXqodwgndikAoA/9CAcIuGn5/7ENmo9vu3wvCDk
	dr2nV9JJ3VTUuhBBQiS5+onPa849ww7H/tveMLsoApC/SxrM7jycnWnkO7dWZz0yerujfBRxX9xBN
	KCXZjlkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueDtP-00000002gf5-3w7g;
	Tue, 22 Jul 2025 14:22:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueDNI-00000002axq-0psX
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 13:49:45 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MDdIPF013176;
	Tue, 22 Jul 2025 13:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P3Vnry
	m9B5BPe2U/a3iHJBpV8aO0k5uE39IfFSeBVBc=; b=MeSpfzlsO/mItJS2Z6biik
	uXQqLO4qnx0UZHXSUmpNPrFtM7bu89lutpwx/uwg5jNeOOcHgS4ANJ5kJ1nuooXR
	VxF0vsEOQZRx5626xoIrKhJ+/pB8LMEaWkTXc1WUEp6H+fHg0mEOcrSE8o9JTf+H
	mBccg6qmhgqYrxQ7Xg/4QYzo8VI98zUxTiDy6gRF52juMQM4cAbf0edw4jY0PC2U
	NcMj9wQ+lMUIxXqu0Zw8OYqOS35pUX21Nk4Tuv+N8egBe52csKEMaMaDr7HO7b3l
	/k0K6i0FTSGgxT+wC3NB6ouHM6ObRcEmWkL1rN2116xRWCOQhoKVXItTOaUvnO7Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482bqeg2e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 13:49:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56MB0Lui012415;
	Tue, 22 Jul 2025 13:49:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p3036qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 13:49:41 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56MDnfrT37814972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 13:49:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 626EB5805A;
	Tue, 22 Jul 2025 13:49:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79B8B58066;
	Tue, 22 Jul 2025 13:49:39 +0000 (GMT)
Received: from [9.43.55.21] (unknown [9.43.55.21])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Jul 2025 13:49:39 +0000 (GMT)
Message-ID: <21a71d8e-8b8e-4097-9156-a40e2bb69fa7@linux.ibm.com>
Date: Tue, 22 Jul 2025 19:19:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmetcli: add support for NVMe passthru target
To: "hch@lst.de" <hch@lst.de>
Cc: "gjoyce@ibm.com" <gjoyce@ibm.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250611103939.3056458-1-nilay@linux.ibm.com>
 <aa442891-0303-445a-b3ae-e1728b88a910@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aa442891-0303-445a-b3ae-e1728b88a910@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=c+2rQQ9l c=1 sm=1 tr=0 ts=687f96f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8
 a=gLImtWyyMxmz1mpG6J4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g1P-J4wnDAgXbjdSJS27zLSvmASfHzyK
X-Proofpoint-ORIG-GUID: g1P-J4wnDAgXbjdSJS27zLSvmASfHzyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDExMiBTYWx0ZWRfX5CRuNzmKpUkS
 N6MOonlZKPJNx5qakA8k7Vc6E9bt8PNp0NjM5T54IH/S3zp67gjaldlRTjIGqtw7tY+NlLffzl5
 jvRfxs2a0iUpP4/CLwaZtp/Xx7gQxgem1YbUOlpTWOSYASGcrO37PEwKkke0nQWGbuao0gGzq8/
 E33tbDQu+rri3guqP7c7FTtC/8vBFm2k8iSHKtauoqDeCXjf7gKts34IaYR0waxGI8J8emSkIzU
 5Gea7eW2g68waWePHScDp6Nor4F/ecrnvEEwI+XgUkcsP1s/t/Q7P6Jz1TrMaAnf2VAxWriWe+m
 /kq34wMzVsT74uBwyaalTfOrBsJISbTVSEWK5ppmWrCJU5bKuIEdsxCU2Nv8XinzR1OR6ZajuH6
 30mpkJygFbCdlfrk/0FkSzNha2f+XDpKgvrzXURplGn1SXNAq3NOsPkVhAdN1C9qyrcFNZcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=924 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_064944_364536_0AFB45B2 
X-CRM114-Status: GOOD (  18.36  )
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

Hi Christoph,

A gentle ping about this patch.  Did you get a chance to review it? 

Thanks,
--Nilay

On 6/16/25 9:58 AM, Chaitanya Kulkarni wrote:
> On 6/11/25 03:39, Nilay Shroff wrote:
>> This change adds the support for configuring NVMe passthru target.
>>
>> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
>> ---
>>   nvmet/__init__.py |   2 +-
>>   nvmet/nvme.py     | 102 ++++++++++++++++++++++++++++++++++++++++++++++
>>   nvmetcli          |  77 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 180 insertions(+), 1 deletion(-)
> 
> Thanks a lot for submitting this, we have been missing this support and
> it is really useful addition.
> 
> 
> Overall this change is useful and looks good, didn't get a chance to
> test though.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 
> 


