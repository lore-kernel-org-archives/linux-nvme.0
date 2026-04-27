Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ACAFF885E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nxBbV5rH1Kl96Y9LpfQ4SotcCBICFbfbFZ1mMRo0KjA=; b=BPuRwr5aLGIVcvX3KtHcIJ9cD5
	ua3+WVVwIk65MDT7HcJD7+Ep6m9DDCSRpSvxGljp/7vZfKAzAq2VaZpDUmjus4Amu8WgWyoxZw/YE
	DQa2F6/4HAI3pTrBejTKw7wQVIAUR3TAav3y8+y2wouHxQ9IhaL6Tr7xTbU2kAR7g4d5cFptgIeha
	7PTrpLtzLi1HAKnv8bAKWHAkFes10a2IvV3PpTmM+wBf/CYEJ68v2aA4ufsgnkcHO4QmnpNmgC3sv
	CyleFXCuu+/95BsALjmIXF8b3ht9sbuazJn8aHke3L38n8x1GjBYCFdERoXY445r0RPzGVFTO6pSe
	n/WvPU7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKpi-0000000Grd6-2X0O;
	Mon, 27 Apr 2026 12:13:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKpf-0000000GrcU-2wlT
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 12:13:00 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R9I87E1950188;
	Mon, 27 Apr 2026 12:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nxBbV5
	rH1Kl96Y9LpfQ4SotcCBICFbfbFZ1mMRo0KjA=; b=KGY5JyqXl59y//QnQdaN89
	3A6EZ0Fz89AytpC52JHaKieDE8CVvDo6olxZTjgDqypbXAyBtq8BzjY2YhYXAzJo
	lf7UBUSQ1e4jcoJ5010gQgWheh6Ut0m8lm240Rh94TX4DqzocKixduPIJIL7CZW2
	ElzxfZnZVTd6sPNOQ6b7d4abNztbww6XCSTcH3qIeL2BLmgnZTzOmx73pTqeb1WB
	UHxoFAkZXLOt5GEAQXEDJxb39GZ/YRAKLu6XRUX4yUEorenpfkBIlUd9NRG46cEW
	aUN02MiIrrQtUk3tiborbnkpWbnM4L9fFePgaeGJC5FEAstHM38MLVWF7jh0X+kA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jfpmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 12:12:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RBroJk032434;
	Mon, 27 Apr 2026 12:12:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g4vvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 12:12:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RCCsGx28508702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 12:12:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5516558061;
	Mon, 27 Apr 2026 12:12:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5A8058057;
	Mon, 27 Apr 2026 12:12:51 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 12:12:51 +0000 (GMT)
Message-ID: <4d64ea94-9690-4295-8544-52f3c4580e68@linux.ibm.com>
Date: Mon, 27 Apr 2026 17:42:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] nvme: expose queue information via debugfs
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <20260420115716.3071293-5-nilay@linux.ibm.com>
 <63b9aa3e-978c-4448-828f-9119f8e210ef@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <63b9aa3e-978c-4448-828f-9119f8e210ef@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyNSBTYWx0ZWRfXzqnnB5koxWGc
 Xg3lCbrcYhUa42TK5Vpu8A2RTc7guiy587qS9HhGvf/eDn7yB43lG6nbHk/vhLL5VZIV1s2oiKH
 ZpbHigW/DNJ1mjuOWIPHJyCMLQlXAHEEmVV4WduUzXh2IOgXDT1WkCZNGEpP01B6xtfZxnJ/pYM
 5GRnL8SimWYmfDqLHSg05iUnrbbtFAdAnvE3d1SGofA13iSledwt2sp/2z+urS2Aqhzi5W+KP3u
 WRJ+3lKvnLwHkWsytH9wgHIKNiN2Xjiv5B4Slh4aIBERPk6/ql2FGgPQG1QEw1Bm08sbtrP87zq
 6OlSQF2iJwN1x9sH4UCcz3GU7RR7KI/N1cxNuSlJEgMIR6KP0DRVBoimIpbbK9nzhJz4i6dpZHr
 JAE1ox3IAYaQDXAxtqpSAg90z6ndt5iY0iCM7lsr+wVyxM3F3DIillXqJ/qqHFcmV+YMmpY5zs/
 EuLI4Kz/dxoXJYkW8yQ==
X-Proofpoint-GUID: OBfbSUCmqP3NR4VYAiBJk-PyJMQL6lrJ
X-Proofpoint-ORIG-GUID: OBfbSUCmqP3NR4VYAiBJk-PyJMQL6lrJ
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69ef52c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=B79Xyk5FaiB-nFXd1foA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_051259_862159_FABF0220 
X-CRM114-Status: GOOD (  12.48  )
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

On 4/25/26 3:53 AM, Sagi Grimberg wrote:
> 
> 
> On 20/04/2026 14:49, Nilay Shroff wrote:
>> Add a new debugfs attribute "io_queue_info" to expose per-queue
>> information for NVMe controllers. For NVMe-TCP, this includes the
>> CPU handling each I/O queue and the associated TCP flow (source and
>> destination address/port).
>>
>> This information can be useful for understanding and tuning the
>> interaction between NVMe-TCP I/O queues and network stack components,
>> such as IRQ affinity, RPS/RFS, XPS, or NIC flow steering (ntuple).
>>
>> The data is exported using seq_file interfaces to allow iteration
>> over all controller queues.
> 
> Don't really mind having this. Not sure who will actually go through
> the process of mangling RFS/RPS/XPS for based on this 5-tuple, but ok...

Yeah it may not be used always but I think in performance sensitive
workload, user would like to leverage this information for tuning
I/O stack.

Thanks,
--Nilay

