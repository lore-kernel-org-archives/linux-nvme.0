Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67E9E85376
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5lp5CVd7Fjq/vo+cdZOjA+zcmNrmtn1TM3gFRS8KznQ=; b=Pop9uVP0FyS/i0eyESvJRIfcH6
	Gunl4NtikgmlERVfic/mrmDOt18ghujxoW8ytdselLhek2AmFq5E5v0sJTnLCEqdo5SRa6euedAaA
	3J56oALMUYXVARveJ+IqSRrybYAI3bA41jhLNsYFry997H88XB0hBK5HtcK/fijJ7/mXZsSY4cryt
	Ubjtn8BJYkkJsM3YXEjch0AdJa2KAXfMKX9BiL4TfRyDuZbSjZa0jVrJVKkeW6nNvd1xbnt5HiEKf
	78Wmp5Wm72lWsBlozu0j6HAClnmVwzQME7N5qPT/fRO6ALcJjTmzVVFueMDIRnyW3i1qRbeB2vIg0
	2D481Hqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8gkn-00000002EYT-1WnG;
	Fri, 03 Apr 2026 15:48:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8gkl-00000002EY8-0kRO
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 15:48:12 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63380SLB1113742;
	Fri, 3 Apr 2026 15:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5lp5CV
	d7Fjq/vo+cdZOjA+zcmNrmtn1TM3gFRS8KznQ=; b=GCAl0dpChQq0xB+KDDmAPs
	0E0ME+1ZDrsJq1H0vmTIEuloLnjf4A0NhINmfygSmZbNmNYivF8xY4BuXhMUOWFv
	KzLF+nAepXdbjHErtbOCarDKiNRH2X2bwJF5psAxvSYTPcnkKVd2Ce802CyNWeRQ
	87rfTgXTImvUshonXPSc1hM8HOv7tWAr7GcB6d3h7rQ7YqWHu08Jgg1VUQWVuO3r
	E/kb2gMx1Gi5YbxNmDhWMxtY0D6s8Dcn8VmS2xcZetMCTAMoHkn+vdvapO3qWk0v
	n3bGItEzvNWlabw7JGqobDyBC9Cv5QN3KIzNwz+u6WnayEpUzbJmDLfPbbCkOHjw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3hauj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 15:48:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633D9g78006362;
	Fri, 3 Apr 2026 15:48:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyenus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 15:48:05 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633Fm3qX25428532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 15:48:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D580D5804E;
	Fri,  3 Apr 2026 15:48:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 680065803F;
	Fri,  3 Apr 2026 15:47:48 +0000 (GMT)
Received: from [9.39.19.5] (unknown [9.39.19.5])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 15:47:48 +0000 (GMT)
Message-ID: <7138eea4-3192-4e1e-bf31-eb0f90897812@linux.ibm.com>
Date: Fri, 3 Apr 2026 21:17:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] libnvme: add support for per-path diagnostic counters
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org,
        hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-7-nilay@linux.ibm.com>
 <8b123263-297b-43bb-b9ea-272a9dd419c5@flourine.local>
 <afc7e386-e474-4ba4-8e3f-b710eee781f2@linux.ibm.com>
 <22c01a60-f9c1-41ff-8f74-b48dc330e867@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <22c01a60-f9c1-41ff-8f74-b48dc330e867@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lc_0GyTepj4An0nD10S68u9pExETvgAC
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cfe136 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=CWf0Ohr9OLmK9kstVowA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Lc_0GyTepj4An0nD10S68u9pExETvgAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE0MSBTYWx0ZWRfX1abtS7jN/51V
 l9BAR679mJvNOeCTiRzaNgPVWbSPKl9wHBLYxrhuYRYsdxhcD/rHe5U3CPo562jU9QnX2RecqoE
 9dh6wHBPqT0T76JiJY3jMMjAL8Zt9EK95YMuNpdnWg/En8waL2d2YjJeeRckYz8kBKkQ08Rux7P
 xHj8TDT3tLWirFB5wNAvwhKgoZ3sVXqwm9qKlS8aRn5aqJ3O5JtfWUOUce07r68AApmeWZ7PQuw
 VTJCK/qKW2TPBVC2nvUyjlycCcWuo3MIRM5/lEpxYFrHQS+aHCVVDEmuPVdJN7NxasyXL+WMeqA
 oicHPpRFMMBIL3bLXwnwX7Kwwd8/EaBpDs8jlD0+Vl0055NYSdHEey8L4pRmiljXQSLE3nt+mgl
 uqlv9Bgxaiijuq6RKBaE8RdJkGMqHyGjtti7CB+UDZopFH5XGW6yzUjtHNefwvffNhxEqpvU4R1
 FoUIvm6n8TtgJOIe1mA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_084811_228384_B6E6DE15 
X-CRM114-Status: GOOD (  21.94  )
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

On 4/1/26 9:24 PM, Daniel Wagner wrote:
> On Tue, Mar 24, 2026 at 07:24:11PM +0530, Nilay Shroff wrote:
>> There are essentially two options,
>>
>> 1. Include the diagnostic counter patches now:
>>     In this case, nvme-cli/nvme-top can start using the libnvme APIs immediately.
>>     If the kernel does not yet expose these attributes, the counters will appear
>>     as zero in the dashboard. Once the kernel support lands, the correct values
>>     will automatically be reflected without requiring further changes to libnvme
>>     or nvme-cli (unless the sysfs layout changes).
>>
>> 2. Defer the diagnostic counter patches:
>>     In this case, the counters would be omitted from the nvme-top dashboard for now.
>>     Once kernel support is available, we would need to update nvme-top (and libnvme)
>>     to add them.
>>
>> Given these options, I would lean towards option (1), but I’m happy to go with
>> your preference.
> 
> I’m not sure if I read the room right, but I sensed the patches might be
> blocked by the libmultipath project. If they’re just delayed for the
> usual reasons, I’m fine with option (1).
> 
I think that the proposed kernel changes shouldn't come in way for
libmultipath work, but let me ping Keith one more time... Oh I see
Keith is already in this mail list..

Keith,
I am not sure if you got a chance to review this:
https://lore.kernel.org/all/0832f4dd-0ab6-4e11-a404-fdb18ca699b2@linux.ibm.com/

But if possible, would you please help let us know your thought/suggestion about
the above thread?

> FWIW, the 3.0 release is still months away, so there’s no hurry. I still
> have a few TODO items and want to wait for feedback from LSFMM. I’ll
> likely start the -rc cycle after that. Realistically, 3.0 won't land
> until August.

Yes understood, sounds reasonable...

Thanks,
--Nilay


