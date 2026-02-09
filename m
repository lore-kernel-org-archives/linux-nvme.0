Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF08E81BA6
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tx23drNoQuN0Vma6Fxd9hOuMLVKOaKmdka7gcxZPZ+Q=; b=rJems/lVElNXyO+gz1pKoB375r
	rhaoV4wKfz8SWIFtNB4obGmH36hjL1KNO5yO33M6AwpSZAsMUGvqj2NRjWVscffdfPzeuqR7XLzWB
	TY8I+E9jGPDggr1+3FxZOSITPojHPM33v+k/N/lCUWgc+uWe1z0vy4mmkfv1cV2TkNWvzYSa3FCsa
	/zpJuzEkgz8up8Lx0KPx1z+T2AR8VOE/hoB3eqSs40FLa5lYFPQCzC3DkChBTP6n6RVIWkP+E/EKK
	LOVr1ZmyGN1yole4ZofNOEhnKsNtRnrzN5GXnuA42A4W+g/tw8fxpzdnS3LDSUg3gu2G0Y9PowarE
	LmAwmluw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpPpY-0000000FKaS-2mkE;
	Mon, 09 Feb 2026 11:53:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpPpW-0000000FKZz-381u
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 11:53:27 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618AYgCr3298581;
	Mon, 9 Feb 2026 11:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tx23dr
	NoQuN0Vma6Fxd9hOuMLVKOaKmdka7gcxZPZ+Q=; b=dHK817sTiRJPQ5btWN5RSq
	cwt5obplhIoN2A8ojI7EJ7VWU4WIpxbT0Hro4xmbDtoWUebJPE9wnraaVjeyv+Ps
	4ssuBiUopClsdsOlhPacgL4+1VSYSdtpDlYDqq+MEBQPc/zsJJIH5Emlac4ZUnN9
	FYwSIJizxWsp5LpKu3O5hT4I7gwIXix2mgzI2KrUlUvdGRFYuPkuPP6DNnsJSpWl
	WEuDR4eegr/nDrgi+Ki2znarZBZEy3sS44LS3y6j21nyPNbzXsU1luexXasjAcf5
	sXm+5ji7KSYhyRL6PYT3asknfpFWSjfIaq7p4nsWpXf+zxqBOgGj56aF3o0uKC4g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696unked-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 11:53:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 619A0ZM3001873;
	Mon, 9 Feb 2026 11:53:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je1vp70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 11:53:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619BrIPj25100824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 11:53:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5022E5804E;
	Mon,  9 Feb 2026 11:53:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C8E15803F;
	Mon,  9 Feb 2026 11:53:12 +0000 (GMT)
Received: from [9.111.86.70] (unknown [9.111.86.70])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 11:53:11 +0000 (GMT)
Message-ID: <b3e6f0f6-8388-42c2-97fc-82d3bf0fddd4@linux.ibm.com>
Date: Mon, 9 Feb 2026 17:23:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/7] nvme: export I/O requeue count when no path is
 available via sysfs
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, hare@suse.de,
        dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260205124810.682559-1-nilay@linux.ibm.com>
 <20260205124810.682559-5-nilay@linux.ibm.com>
 <7d73bff7-96eb-4d94-b9c7-3d3271ce144b@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7d73bff7-96eb-4d94-b9c7-3d3271ce144b@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA5OSBTYWx0ZWRfXxuR1OGeZSAtt
 UimW4q1JQqgoODhKG5Pa1PUFWBhk/L9oXoNiwnFOSF9op4Liw8ADfKUpQCEk2tOPC4NXhX7mUq6
 M/+n4WNVYiaVt1oDgs29H5MGBn/rw5nkzMxVF3+4F0zzh4g5punZ25960MhWzH1nbrrIGlveM7F
 FkugwDP4eKdQlgKQh7IZJSvifZ/X36vcRNhBCTc+mqpu7/8O+5s4kvZz4A9Qi2a5ahsLOvs2Qmz
 3ALR3SVsY+Mpbjqu0Tuir7PcPH7cTu1pJ9moo9HZaKikNT8LApxQE4edBRPf4GjKjH9RE+LogdD
 Dt1w33YFWHyWaeRSiDz5seH8a+H76tZIB0jIZR6OSxqXqBLkclnoN7yJw55wdEFQFqdFxic4+A9
 CxeuhPSGPd2MSkYBjt5SfFhn+geuzXv7h8U5Hf5RkwQCkQptkFqknnUhwZFwdVas1yCq0hzG+hU
 MOTBSn9jGK2J+5cue2A==
X-Proofpoint-ORIG-GUID: DCzRLAlqbiac6soJ3Zfd5xasweVAD_pd
X-Proofpoint-GUID: DCzRLAlqbiac6soJ3Zfd5xasweVAD_pd
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=6989cab0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Nt-Aj00FSpRQK8-20CcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_035326_908143_4AD8FE38 
X-CRM114-Status: GOOD (  15.03  )
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



On 2/7/26 7:03 PM, Sagi Grimberg wrote:
> 
>> When the NVMe namespace head determines that there is no currently
>> available path to handle I/O (for example, while a controller is
>> resetting/connecting or due to a transient link failure), incoming
>> I/Os are added to the requeue list.
>>
>> Currently, there is no visibility into how many I/Os have been requeued
>> in this situation. Add a new sysfs counter, requeue_no_available_path,
>> to expose the number of I/Os that were requeued due to the absence of
>> an available path.
>>
>> This statistic can help users understand I/O slowdowns or stalls caused
>> by temporary path unavailability, and can be consumed by monitoring
>> tools such as nvme-top for real-time observability.
> 
> Other than the debugfs comment, would it make sense to have a reset
> functionality to these files (via write to the file)?
> 
Hmm yes that can be added, however do you have any usecase in mind 
so you think that allowing resets of this counter could be useful?

Thanks,
--Nilay

