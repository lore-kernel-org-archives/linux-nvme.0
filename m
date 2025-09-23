Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A113CAC5A7
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 03:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fzF29EH1Xg6BxFf93FKpodCpvNgilvx3u98IW58zXgc=; b=hkZ/uEuCCHxXs3RLxvievzF3/S
	y9U8pXvzcb/OnqkytpiEJQ1mJCTe0EhXjRqbf3OksRHRC7vtxiD5cbRSAUUTmfDvNNP6UQctJb8d/
	sZ/EnQ+cmPZ5KMrKdSSR3t/Vh14XO3OOU52CQOuDYn5bSa9C0WBlQvqrekxTJaGnqkn/SboGo4CmZ
	rwJaRG64SQ/C5dyFNoHE7bBQx+72fNnnYvT44wjjemNhjhHXjGDrEd/UoHFNmmkcBjiZ1nzLynElv
	0octkEQ5aV7T7SUgaewFfpEN5ccwoY1wzuMjqIQPpyQLuqmkDzZd/AeQ/p0gVGqMKM9YQEAyhtbRF
	LsJ2X1nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0u66-0000000CHT1-3PSO;
	Tue, 23 Sep 2025 03:53:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0u65-0000000CHSP-0DGe
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 03:53:46 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N0g3Tk008240;
	Tue, 23 Sep 2025 03:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fzF29E
	H1Xg6BxFf93FKpodCpvNgilvx3u98IW58zXgc=; b=WEF3oNmocRO8iwe6/fG0Cf
	FXC4sheR6RunVQyNce+KoFDdg+ecUGg7pk1bq5jmozsPMbTq0uZ/9FvM96i1qNr8
	z6K5df5oxlAp6/L/h3yKrxTA/EU9haad9TfZKVRVfXhg6XlnnagUF5xRIJmPUFl4
	JSC3SMYlAzZymDD/Y/ukt40g04OpNVaOETZ2fbpnmF0gQJxdns7LG4+A/+U45DoF
	cg7MFUDCd7Bctkx8/Fh5+X2JhEVNkR3Eq+XzLnXmUjidGD6xS7atqk7+gdf/hhQI
	QgEouTpFrtYBRRmtGAPmOedKQtqUqxEjS2ACxKHxPzBC3OIpZLj+Kx3zvJdM+hVg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq6cp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 03:53:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N2h9Y6030359;
	Tue, 23 Sep 2025 03:53:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a11095-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 03:53:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58N3rcYx35324670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 03:53:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D89CC58056;
	Tue, 23 Sep 2025 03:53:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 941EA5803F;
	Tue, 23 Sep 2025 03:53:35 +0000 (GMT)
Received: from [9.43.93.136] (unknown [9.43.93.136])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 03:53:35 +0000 (GMT)
Message-ID: <3b21b6e4-8cc4-444c-87d0-ad31c76df429@linux.ibm.com>
Date: Tue, 23 Sep 2025 09:23:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] nvme-multipath: add sysfs attribute for adaptive
 I/O policy
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-4-nilay@linux.ibm.com>
 <a89e6316-3857-4ae2-b907-5d8973777a6a@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a89e6316-3857-4ae2-b907-5d8973777a6a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d219c4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=0D3H2QZpJ9AYVK_Gr5wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: q9VvHksPaXs47LsrOu1uPqX6uMfLSQ9f
X-Proofpoint-GUID: q9VvHksPaXs47LsrOu1uPqX6uMfLSQ9f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX77WXo0nFjJus
 xwCth+KThMrnjRXhyGed0D+jp95XwZdcVS4L6L+aBEtwHUc/Zr5KYkippwct2efr7psqZ86I30b
 x674f1+t/ck7QeDddAsE8ADyDIfAygxmb233LWgPaiSlLuBdp/CyPiEnYoMYEItOGP0+A+GmMaJ
 DlebPQJr6NfQGZ2TCuS6g/vkZPBmesdX5OuOtL15J38Cb3Vvag66a6Sepn8uMOpLtcyAdICRuVB
 P/8wS/SwDShoRD0wwHbGLlNoIaoJgeX+O2XB64QpZo7uXO9janTUcQpJDvurMf/i5O5eRSIFDvP
 L58AzcIo99Msm6+98Ey4kDFEKpugNdAuTbHP8gpOSSskv5jWX9PbiKoZPQmrYNGIG1TFImjL5qe
 6SV+/nvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_205345_206091_E47EF68C 
X-CRM114-Status: GOOD (  18.59  )
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



On 9/22/25 1:05 PM, Hannes Reinecke wrote:
> On 9/21/25 13:12, Nilay Shroff wrote:
>> This commit introduces a new sysfs attribute, "adp_stat", under the
>> nvme path block device. This attribute provides visibility into the
>> state of the adaptive I/O policy and is intended to aid debugging and
>> observability. We now also calculate the per-path aggregated smoothed
>> (EWMA) latency for reporting it under this new attribute.
>>
>> The attribute reports per-path aggregated statistics, including I/O
>> weight, smoothed (EWMA) latency, selection count, processed samples,
>> and ignored samples.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/multipath.c | 77 ++++++++++++++++++++++++++++++++++-
>>   drivers/nvme/host/nvme.h      |  2 +
>>   drivers/nvme/host/sysfs.c     |  5 +++
>>   3 files changed, 82 insertions(+), 2 deletions(-)
>>
> Wouldn't this be better off if situated in the debugfs directly?
> Exposing the stats is not really crucial to operations, and mainly
> for debugging purposes only.
> 
> Exposing the weight from the EWMA algorithm, OTOH, really does influence
> the performance, and might be an idea to expose.
> 
Yes I think exposing this under debugfs is good idea.
Maybe we could also expose per-cpu stat under debugfs.

Thanks,
--Nilay 


