Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E348CCD37B9
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0UAfPsKQiZx9NU3b2GwErgEnTdQPktJBiH5k8iqDqnw=; b=o/qAwempEWTHZUL15s7+/sdQU9
	Y/9pKBAxTXTvpCVgNdhgQ5sa7j3fPuD5nYsgaitlWx/pBxFdEahoPn0EUYmJj8H8rBEP80R8Zu3Fk
	8WX6cuxzNv1+OZj3UDC/6ZyLngLT71ge6gPwh3r5ot8nGLfi9m6ORc5SZO16kk3KECO/fwi74GQzY
	UG30T6703Ro2HMANwj8E3+Rp/LkBe+ulem/r8PQrboW3WdCRMjrlo5W0YW5H4EyCgZ4AegANg60C/
	M8iKQqHDsTqd6UGRl0wR6p6s4jAKW8ijjOocduzxzeOMZbHBK+juVqlc/PH9ek64u5Q+HkTMOrEfl
	d31qkWBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPI8-0000000DRDg-3UcC;
	Mon, 11 May 2026 11:59:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPI7-0000000DRDL-2pzk
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 May 2026 11:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0UAfPsKQiZx9NU3b2GwErgEnTdQPktJBiH5k8iqDqnw=; b=ZZg++xoLyk3xS28LGcvWREJNLJ
	PxOnQbz4CAhj7Yo5eFmULEo6JVETVaAMiZOvIvD+4djGzimjkIxrBWHwCGJ1s6qhRc3bYiQz8eA20
	Sz+NAQpUmaiQi/PBp6EOOqAG4rivBt8XbjQPk1QwsxbMqHNsLPVwxZkUbK97BW2q+/GSWwgNz5BRU
	duPT44y4Base0lgNdJ5ajEGnOBpWpbv7gXXy0AaNv8K2rz4qnIdWAnFJ/F/ki++mh8kHbtZ5RKk3q
	EilkPwssj/TjHMVY8QpV/zHiLj/m7WoBYIGqn129JPqaDcQoPkWTwkDbwS7fRama7kZ/D5ygp3NYG
	qr/pPlBQ==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPI0-0000000BYFB-3oJU
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:59:17 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7w14N2508013;
	Mon, 11 May 2026 11:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0UAfPs
	KQiZx9NU3b2GwErgEnTdQPktJBiH5k8iqDqnw=; b=Z3nk5YYqhnE9fgIxo6fOAG
	3nWA9Jr7htZcVy+l5AGgAToTMonIzA98E5HM82hJ6pM8dVVHYS+ZTbVt+TTCQcNx
	J9xyjrgFawJDc1eNBFn4DVBub4/3mmNaffE0jriGFTRovjCvxHrTvq6XjsVEQ6Wa
	I61FfUakq1IoMRiVe1o4s6c75SF5G1zTKhnFwLofS+rkY18pvUpBw+AG5hZ5ZZuV
	w3JPDZ64JgYciL6yQgO3eSx7aphvTaraPaJZTiz5c6xIWkoUlr/gVi6fJAZY3vDa
	MlcV++V8RxxvA+t89Tc0fuIDePwENEto1aNXMFbXcMsjQ+LOhAjylLXMFdZeBoMA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhqrwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:59:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BBsQh2025467;
	Mon, 11 May 2026 11:59:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hxy4u9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:59:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BBx6YQ56492522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 11:59:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EC3C58054;
	Mon, 11 May 2026 11:59:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B9B35805F;
	Mon, 11 May 2026 11:59:03 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 11:59:03 +0000 (GMT)
Message-ID: <9799c2c0-f6a0-41e6-9fa0-2993b60f1801@linux.ibm.com>
Date: Mon, 11 May 2026 17:29:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme-cli: add nvme top command for real-time
 monitoring
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
 <94f23fce-c968-478c-ae88-c3286d644eb7@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <94f23fce-c968-478c-ae88-c3286d644eb7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01c48c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=AgBTrnw9a5PYZDs8nd8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3fCLobNg7apAIUdLeSXNLo9xnHECBK3v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyOSBTYWx0ZWRfXwG9ft/1lUF2V
 UOkaTjambnuwJJwYkFRAWGXC6Y5x+uVGdEFkQycvQCZ9LCrne7h2+dhnYiCH/QX02/6QVae9Rvr
 SMGP2tLFNAbmZAwvAWM58CY3+k7Wbp3UJuhVrCVFWkvWMjzaFjz0IN60aJq3qBjARTxeAcP7OEX
 Zw75+njbHrRI9x7YiK1PijC12G4vwtFB54MZVlt2M5RCTW4T0mkNqA2Yz847a6wYT6/WwLhv6gt
 NJYeFsdAPTYF5WiiWaNroKjB62cEiKg/zEFO/AJu0MhnDzMjU865IwqKdVDJOL1t2EGtv3EOW41
 r9sjWztcbM4UROCP0jXp/3TVTAs+izY01C3uhSMEkuutPaJ5inX02Khpr/gxDJHHIj1T3ADpCpk
 cw5r2mOYzXTRQVzd0Bd4813PR+EV69EzKAUFltZYqI2u4EP4rfDpqKqSQue7NS2DDtOtrxv4r3h
 J6kMo5CcFHqyVAxqJlg==
X-Proofpoint-GUID: 3fCLobNg7apAIUdLeSXNLo9xnHECBK3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_125916_382752_9E2251C6 
X-CRM114-Status: GOOD (  19.38  )
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

On 5/11/26 4:04 AM, Sagi Grimberg wrote:
> 
> 
> On 30/04/2026 13:52, Nilay Shroff wrote:
>> Hi,
>>
>> Monitoring NVMe devices and paths in production is currently limited to
>> static snapshots via nvme-cli. While this is sufficient for basic
>> inspection, it is not ideal for NVMe-oF (fabrics) deployments where path
>> conditions can change dynamically due to varying network latency,
>> congestion, or link failures.
>>
>> In multipath environments, administrators often need continuous
>> visibility into path state, ANA status, queue depth, link speed, and
>> error counters. Today, this typically requires repeatedly invoking
>> commands or relying on ad-hoc tooling, making it harder to quickly
>> identify issues.
>>
>> This patch series introduces "nvme top", a tool for real-time monitoring
>> of NVMe devices and fabrics paths, similar in spirit to tools such as
>> top or iotop. The goal is to provide a continuously updating view of
>> device and path health, enabling faster detection of link degradation,
>> multipath imbalances, and transient failures.
>>
>> The series first adds the necessary building blocks for supporting a
>> top-like dashboard. The initial patches extend the table APIs (including
>> support for additional data types such as unsigned, long, float, and
>> double) and introduce a generic dashboard framework. The final patch
>> adds the nvme top command built on top of this framework.
>>
>> Future work:
>> - Export NVMe statistics to external monitoring systems (e.g. Grafana).
>> - Improve topology change detection in multipath configurations. The
>>    current implementation relies on kobject uevents for topology change,
>>    but namespace path add/delete events are not exported by the kernel
>>    since they are associated with hidden gendisk kobjects. This may
>>    require explicit uevent generation from the NVMe driver for namespace
>>    path changes.
>> - Wire nvme top into an MCP pipeline and feed it to an LLM
> 
> Nice, However I think that the traddr information is missing. Often the network
> has some routing issues for specific IP. This tool show this.

This tool prints the traddr but NOT host_traddr. Did you mean we should print host_traddr?
If yes, then I think that should be a fair ask.

Thanks,
--Nilay

