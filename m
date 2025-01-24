Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DEBC02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffeKMb8I2vOQHrwrXy0gjYI5F9AT9ddo39iR9xkaSyU=; b=wyVeXGZIc7mRQH7Ev8Iz3k8HEb
	J+Mm+dY1cTWdgGbfW8LJMIyJS5Ollpy7aFhKwF3cCdhA/XNMef+UJDkRfkymLDpuFdqlD2wsFoHGZ
	xAc4690zSVErQqaJgy4scRJvRCCaFlhgRFy9fqSmRqpGO8kUq/eb/GgD3Qs6sfw0A+3HIHt4aDHk7
	OGf71BZMH6cizTk2Ae/tDmI1s1KLPGqMTpy7GaickrOKI/ZViSM39qFua2kJuu3amfz3dQtZw37Pf
	W6JEmpcDJDG71vbGrj60En8fPDo150juoJ4SSRnowsJiga6UVysMgqUfa3og0Cm5UlHbCeHQJ5nlC
	K1J5U7MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbKKc-0000000EpGU-1a4g;
	Fri, 24 Jan 2025 14:06:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbKKZ-0000000EpFq-3n27
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 14:06:45 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7WkPh021218;
	Fri, 24 Jan 2025 14:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ffeKMb
	8I2vOQHrwrXy0gjYI5F9AT9ddo39iR9xkaSyU=; b=eelzpB4ov2uiVaFwB7deOK
	tj3X61BH2iGcF3nV9waF2cJRH0woX10W6B9uLbUoOjDPGt8yeeggEN9UsNITjetU
	HGeWzO7epMU0zVhlovGW7xyQ3RLVaU6GpTXlI5ofUsBKsT0MOuF6LICWnq1JS5Oj
	mquinxtVA/G/9mumwidE0hdY+V75AvKgMeLmnJ2i12FhislmyuYGOZ0Akp4cTD2J
	UpUf8Nf0juIG/bIFGLzH6W8fnON74XJLgCZq0sihJHl/790+CJ9Cr/uQiCfGW0JS
	8JeNDNA5RE+pQlNrk2WDZsJy51BPGPyXOGgedJpa1Xsku43peJthUCzKQ962RLAg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jnhmjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 14:06:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50O9v5GT032223;
	Fri, 24 Jan 2025 14:06:22 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk3b01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 14:06:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OE6LdL22610590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:06:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B93D85806C;
	Fri, 24 Jan 2025 14:06:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE90758056;
	Fri, 24 Jan 2025 14:06:19 +0000 (GMT)
Received: from [9.171.53.174] (unknown [9.171.53.174])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 14:06:19 +0000 (GMT)
Message-ID: <c125b796-d1f7-4c6a-8e96-79aa80143456@linux.ibm.com>
Date: Fri, 24 Jan 2025 19:36:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: move percpu handling into
 nvmet_ns_{enable,disable}
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
References: <20250124082505.140258-1-hare@kernel.org>
 <afe8968e-ff56-4907-b3ec-a79ac75d5250@grimberg.me>
 <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gUcPI-laUjAvG2_fGnsmuML2d7b2vJzy
X-Proofpoint-ORIG-GUID: gUcPI-laUjAvG2_fGnsmuML2d7b2vJzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_05,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_060644_068800_C97EF518 
X-CRM114-Status: GOOD (  16.54  )
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



On 1/24/25 4:39 PM, Hannes Reinecke wrote:
> On 1/24/25 11:50, Sagi Grimberg wrote:
>>
>>
>>
>> On 24/01/2025 10:25, hare@kernel.org wrote:
>>> From: Hannes Reinecke <hare@kernel.org>
>>>
>>> The namespace percpu counter protects pending I/O, and we can
>>> only safely diable the namespace once the counter drop to zero.
>>> So we need to init the percpu counter in nvmet_ns_enable(), and
>>> wait for it to drop to zero in nvmet_ns_disable() to avoid having
>>> I/O pending after the namespace has been disabled.
>>>
>>> Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
>>
>> Can you please describe the bug and scenario which you are hitting this bug?
>> It is also unclear how the above patch is causing this.
>>
>>  From quick look patch itself looks reasonable.
> 
> Should've said: this is the fix to the reported blktest failure
> on nvme/058...
> 
Thanks Hannes for addressing this issue!

I think while implementing 74d16965d7ac ("nvmet-loop: avoid using mutex in 
IO hotpath"), I moved initialization of ns->ref from nvmet_ns_enable() to 
nvmet_ns_alloc() as well moved killing of ns->ref logic from nvmet_ns_disable() 
to nvmet_ns_free() and that probably caused the observed symptom. I thought we 
need to init ns->ref while we insert ns in Xarray and kill ns->ref while we erase
it from Xarray, but that was not correct. My bad!

Though I was never able to recreate this issue on my setup even after running
nvme/058 hundreds of times, still I think the issue reported by Shinichiro 
appears plausible. So we need this fix and your changes look good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

