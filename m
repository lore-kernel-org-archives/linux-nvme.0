Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E7CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/cJglt2It0vAFBNe7JfZUIX6WEMhzz3bGN954OQxpc=; b=EgwBCyn6nqZAlOQg+ZwUEXkVX2
	nFq1cJqNnr/6XL6tFkAJNNjbvqDh7krsCW+B34XDtsBnUp4xA5/NYeekwiYeDOgVVNUFwd2nqov1W
	W/hagkoHkCWUQ681fb19nkmrrg4jV54OqTPXmhIoH/YsuSIITeNKTOyE1KweDwpwU7L04j+LhsYm4
	zoL4t4IsQOtdvLzcqubjVDQHuoyLoDOIX/2FO7jlctMYhPXGkNu5kFkyR6jPSIxuHyGVd3b1HtKHF
	qCeRuJM6Y712I46n+mqlngBvyo1Dmwu+/lQ2NYI424jrG6nLCNAoSaraMIrxkJordPV4iQn3OA6UE
	O1TMSHAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMRFG-0000000Dqo2-0Z5N;
	Mon, 11 May 2026 14:04:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMRFE-0000000Dqn9-0GKh
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 14:04:29 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BDjYC14115533;
	Mon, 11 May 2026 14:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v/cJgl
	t2It0vAFBNe7JfZUIX6WEMhzz3bGN954OQxpc=; b=fEmTg4vvnGr0EdHkya08Rd
	uZcbDg4ltXGxIhF4qAhGHBWj6sXVRUU3bibyZYeAnf1L6pVtjoSsNblUwLz9VWSf
	JSC2uHXdGDEqGc9t7PQFZCRa+MyxNRh67q85Ry6a3BW12rFC2mJoOADHL+CDqjZD
	kjasOTp6ysKM9T6InxVS7xNiIBxRuOEbwxdamBSRbubFUeoyL5aUUF5nzPaaOHSI
	X5Y67QUx1cYpJPwdpae0MD1GeyZ//fRWW8+Di1Pxv4ZxSkURR6/rPia0My9ZF8Me
	qOKRIH6fo0RcLgcAHMjXoDC9d5YGkGK7NCvN6pT513uL2zdnsRrSfEtsp9Wi9a3w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju7yxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 14:04:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BDsNmS004911;
	Mon, 11 May 2026 14:04:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg5c60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 14:04:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BE4Crv26804788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 14:04:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A6D35805C;
	Mon, 11 May 2026 14:04:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC305805F;
	Mon, 11 May 2026 14:04:09 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 14:04:09 +0000 (GMT)
Message-ID: <ec9920f5-1350-4f24-bdc3-e451f5c680be@linux.ibm.com>
Date: Mon, 11 May 2026 19:34:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme-cli: add nvme top command for real-time
 monitoring
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
 <94f23fce-c968-478c-ae88-c3286d644eb7@grimberg.me>
 <9799c2c0-f6a0-41e6-9fa0-2993b60f1801@linux.ibm.com>
 <36ef5a04-8b34-479c-bc09-09af6cd104f5@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <36ef5a04-8b34-479c-bc09-09af6cd104f5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1MSBTYWx0ZWRfX31M8nMjszIHz
 xeQpYiJhvB7PVAZ+clcPYPnaSKYzEvua5IDTCWCF2RY5n/RemYscvghLG45DGZ6bxMnXhD9HJwJ
 1E+vdMeg2tbT8ET0Zdpw5Igl0K6mN5ZSSRnYNUnkGRqPJn9tKmql7DK5WzndK0wXY+46RZTidKu
 YHiANnMv9okChrSSX8LbcfFr5T8/3LXXINYnoiIqvZ1ICHIZ/4i4ROmgJeUYAdfIEfGRxkBNOcL
 Qe4eqLzprVfexX01wrkB4ksnuIIxcjUOBysY2CZYW8uGYDAkPc3+S6eT5Ri+yRZW6Anyk5YELx0
 LobFq/VsT339gQQL+f6pPbqjnLkaBilR9r9rFwXyJ5HrW10hUJrYf6jr1KCI9oRnTJjL+U73rDD
 abnXRP03ItrIYVrD9WLIMHedVt9BWg==
X-Proofpoint-ORIG-GUID: iTMYvMv9VDqrt_HO0nqieibFbDT5GHtV
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a01e1de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=_AHWdlMlAe0Zzjg2qMsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iTMYvMv9VDqrt_HO0nqieibFbDT5GHtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604200000 definitions=main-2605110151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_070428_222183_547A09EA 
X-CRM114-Status: GOOD (  18.49  )
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

On 5/11/26 6:24 PM, Sagi Grimberg wrote:
> 
> 
> On 11/05/2026 14:59, Nilay Shroff wrote:
>> On 5/11/26 4:04 AM, Sagi Grimberg wrote:
>>>
>>>
>>> On 30/04/2026 13:52, Nilay Shroff wrote:
>>>> Hi,
>>>>
>>>> Monitoring NVMe devices and paths in production is currently limited to
>>>> static snapshots via nvme-cli. While this is sufficient for basic
>>>> inspection, it is not ideal for NVMe-oF (fabrics) deployments where path
>>>> conditions can change dynamically due to varying network latency,
>>>> congestion, or link failures.
>>>>
>>>> In multipath environments, administrators often need continuous
>>>> visibility into path state, ANA status, queue depth, link speed, and
>>>> error counters. Today, this typically requires repeatedly invoking
>>>> commands or relying on ad-hoc tooling, making it harder to quickly
>>>> identify issues.
>>>>
>>>> This patch series introduces "nvme top", a tool for real-time monitoring
>>>> of NVMe devices and fabrics paths, similar in spirit to tools such as
>>>> top or iotop. The goal is to provide a continuously updating view of
>>>> device and path health, enabling faster detection of link degradation,
>>>> multipath imbalances, and transient failures.
>>>>
>>>> The series first adds the necessary building blocks for supporting a
>>>> top-like dashboard. The initial patches extend the table APIs (including
>>>> support for additional data types such as unsigned, long, float, and
>>>> double) and introduce a generic dashboard framework. The final patch
>>>> adds the nvme top command built on top of this framework.
>>>>
>>>> Future work:
>>>> - Export NVMe statistics to external monitoring systems (e.g. Grafana).
>>>> - Improve topology change detection in multipath configurations. The
>>>>    current implementation relies on kobject uevents for topology change,
>>>>    but namespace path add/delete events are not exported by the kernel
>>>>    since they are associated with hidden gendisk kobjects. This may
>>>>    require explicit uevent generation from the NVMe driver for namespace
>>>>    path changes.
>>>> - Wire nvme top into an MCP pipeline and feed it to an LLM
>>>
>>> Nice, However I think that the traddr information is missing. Often the network
>>> has some routing issues for specific IP. This tool show this.
>>
>> This tool prints the traddr but NOT host_traddr. Did you mean we should print host_traddr?
>> If yes, then I think that should be a fair ask.
> 
> I didn't see the traddr...
> 
> Also, ctrl+c is not existing which is annoying ;)
Yes that will be fixed in next version.

Thanks,
--Nilay

