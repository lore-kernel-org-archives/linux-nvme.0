Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECD6F54AAA
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q3Zz280glr8BCTDfnZDrxFFO58yHTV1bKMKZru3weow=; b=VRCZeFVGuTyYp2HFVcIWL63gkN
	dAUWT4zS8WNarrxCGWKgyOMtkRKVP6hcsVS9Sh+Pi28HCWj0gGHYO2qHJA8lj3+l0Xa62MlqbA/3i
	PssYhUgJb6KKGv7ej7DzVsRdLI0lWOWsTo40NX2sEGLcyJDffQnd7CANazXxd2njLmKzZTWHaKyE2
	ha9RD/h8X9TBUyN/KOHzMiUvtALg3z2VOCmu5Tqaz9EnxU5GK92L+ZvhQmttaztXhmH9RtrVGDvHk
	cLxMWEQ1sWew/oUw2vc2Gu/j1z8s7Raa00ybYqWVExZ1yUDjFKAWLiauhBHujEAwVvNNhgQMmZvwI
	ywcKtPMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w51UV-00000001UdM-32Iz;
	Tue, 24 Mar 2026 13:08:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w51UT-00000001Ud1-2XzU
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 13:08:14 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8gDtN662269;
	Tue, 24 Mar 2026 13:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q3Zz28
	0glr8BCTDfnZDrxFFO58yHTV1bKMKZru3weow=; b=MsaPDi1q3dir1GQjusfYdJ
	Frbkyq56mug71Rm/jiVxpfPYBzaKZQneGLHGd0llA37mf9V5I3Qe7FVewmG8cnIY
	EenQRw4kEaDiQqw7kKgsShIR3GEUTAISc/Vl52pbDL6DVIdQ5AXejSpNRsDbaeLi
	26/MdzZn/XTWpNEur1RjWlDub9hXvRjXLAWDu3JQEuD0ZqyqSJz1QSfpGfg1paEo
	1+uvm3iEtL6LruSWxXKIckgaxf472PGqz7hvrIyploQCOTfzaOKGpOLFI19Of0VW
	eDzqvBSujLjkv7N1jouSDbJU7D31AFv642u1+HhKHFgvRCpmlrhy5+tjrgGta3IA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuu06w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 13:08:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OBY9IB006009;
	Tue, 24 Mar 2026 13:08:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yj2c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 13:08:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OD7hfK25756282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 13:07:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CFBE58052;
	Tue, 24 Mar 2026 13:08:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEF9F58056;
	Tue, 24 Mar 2026 13:08:03 +0000 (GMT)
Received: from [9.39.27.13] (unknown [9.39.27.13])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 13:08:03 +0000 (GMT)
Message-ID: <d3a07c87-f387-4712-880f-4558c2f0ade7@linux.ibm.com>
Date: Tue, 24 Mar 2026 18:38:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] libnvme: annotate nvme_path::ana_state with
 !accessors:none
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org,
        hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-2-nilay@linux.ibm.com>
 <6ed0f13e-2aad-4b2f-a8b7-39e6b3f85606@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6ed0f13e-2aad-4b2f-a8b7-39e6b3f85606@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UCdWTnp07gfaM7k8GLxoibSmMeFBrh1f
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c28cb8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=HnzzlDkuqILrSwW5VMsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwMSBTYWx0ZWRfX9fcrTa3qLVb9
 FvyuSYa3yIO2X1CB3X7XpJ4B5pZJBPXk7KORsmsylqsX2DTakPFlhcdXmL0mfR6ZRMWVCNdXv7Z
 eQ4gfR3qqRS7qX8XF/EW/oBywNskL3kz6Reu6Q5u6Wi99kvcrWK7o+98Pymuip6LTa93dUo5hg8
 1U+C+Qtxwscg3vPg5he5CR0a4ET4iEQEDeGx83WoU9BdbdP031Stij0qfNfk9SWmwJouEc8NN+g
 /YehN1JKi9xXtDpDsweSzvF8lIPS8wlvvypSzbX6sCTZiSqd8qMrRI5m3sdk7yW2cHOLxaKVSD6
 x0km+G/i1eoI65CV167D3LE8JK+TkgxYGjpJXG/L4Z3v12KeKeq0DuHpBZMlvRc7MvKroPmGpj+
 Io+/mDTs+fTDypbq+qBC2p6CM+O260w5ZGhMS0e1pSmGnUTRAYlDzCiBCq2sRRkR4qGJsMr7C0L
 ltW4gPM5YvV2Y3fLZrw==
X-Proofpoint-GUID: UCdWTnp07gfaM7k8GLxoibSmMeFBrh1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_060813_795834_C15581F1 
X-CRM114-Status: GOOD (  12.26  )
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

On 3/24/26 2:25 PM, Daniel Wagner wrote:
> On Sat, Mar 21, 2026 at 08:58:00PM +0530, Nilay Shroff wrote:
>> +__public char *nvme_path_get_ana_state(nvme_path_t p)
>> +{
>> +	_cleanup_free_ char *ana_state = NULL;
>> +
>> +	ana_state = nvme_get_path_attr(p, "ana_state");
>> +	if (ana_state) {
>> +		if (!p->ana_state || strcmp(ana_state, p->ana_state)) {
>> +			free(p->ana_state);
>> +			p->ana_state = strdup(ana_state);
>> +
>> +	}
> 
> a couple of tabs indention here
> 
Ah, good catch. Will fix.

>> +	}
>> +
>> +	return p->ana_state;
>> +}

Thanks,
--Nilay



