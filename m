Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29ECC55173
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wmYCqOjjFow4uWnGfIWRDQoyIpPSRJxzKhTWY1oGnzY=; b=R2vS66F8S5AaICxOrfupH83kLy
	h1f9URjwU6jVX7/1qw63/fehSB7UQhKbdfsIu7KNzVSCtICjc6Mbx1IAa7jtpbvHskEo9gEhdhPwO
	EJSaXDBj0rR/hS8pOLHgWFWQODVVdsFQ8xKNB/DkTx5YX5B3y4HHWa4CQlx7ljSpxP4c+4H2EweNk
	+cDiKLGgUzq0KOoWmjDiPrESHLy+wVPCtQN0NaGW8Bd23FNulwQ/XxGaZ2JYHa4twKuaojViVl4LW
	s7YFsCHsPAqwu3QZz2t8X1VBd3qTN0GDCkdCG9ZBQVg3PRbktV/k6LxobCUQGkmTYK7Riv57HFFRa
	DeJBuJ+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqA2e-0000000EhE0-2OpS;
	Sat, 01 Aug 2026 13:46:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqA2c-0000000EhDf-0XnR
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 13:46:19 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671Cm051649053;
	Sat, 1 Aug 2026 13:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wmYCqO
	jjFow4uWnGfIWRDQoyIpPSRJxzKhTWY1oGnzY=; b=HF5RHoOlIVM3lFZGsvyPRM
	cLk/dnRM3/wo28naP0PNkRIrGIW6DqhXJLn5WAaxvQgu7YzXEv7uEt5YTuGBDT3L
	pU/tRRZghHeQ6BQKP6k24CBHr95RFedLjmRpRJJvhabx/rFXXj5YAXcLQxxqqsfb
	Xk7FsthjVx3G4TR9zQbehNCKadkrga704Cbe5drq/qG0WmZC5uS369mv5i14+uU4
	7x2vDoUFVv063egEof0Pu2BCz7wJlhOLH8VdnByZNFwc1ipLRAUEbupsApbhdZxq
	tNLC0DLqajvogiqiCNB5Awf2xSHiR6mgWPeGy5+8NAXgzY6UaJ0eH9NnYf25vQRg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eu9cm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Aug 2026 13:46:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671Dfbow003602;
	Sat, 1 Aug 2026 13:46:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwm82u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Aug 2026 13:46:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671Dk6sw14353050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 13:46:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 197085805A;
	Sat,  1 Aug 2026 13:46:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4514558051;
	Sat,  1 Aug 2026 13:46:01 +0000 (GMT)
Received: from [9.43.78.15] (unknown [9.43.78.15])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 13:46:00 +0000 (GMT)
Message-ID: <da510bcf-31e2-4d8f-9938-af729bb1fa3b@linux.ibm.com>
Date: Sat, 1 Aug 2026 19:15:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/4] nvme-tcp: NIC topology aware I/O queue
 scaling and queue info export
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, linux-nvme@lists.infradead.org,
        netdev@vger.kernel.org
References: <20260731073918.614014-1-nilay@linux.ibm.com>
 <amzPgFs4whuvrnUW@devvm7509.cco0.facebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <amzPgFs4whuvrnUW@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kDJIl8oXeOdajGukB-0ArXJGKEkdhijU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDEwNiBTYWx0ZWRfX0zcCr/DTh+e3
 6DSr6uVnPm1ZcgxUAUE+dV3oa77dzWOz2YCd1CFLD8QBcwrIu5BRg4YCjnrPZI952HmRw6IuNWc
 B5gX3yaAP16bavxRSNQQsVkFXfHtZr0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDEwNiBTYWx0ZWRfX1duI+C1EnNpI
 kiPjfi7l/qFyUBANCeK8WctEW9xPnAfA+5CM1YjQej4XyBWQTAqJkP89hVZKVHM5striyMhHdkQ
 bUnRNxP7eClBQt8eHoqhOSkTeeQH+28Yn5y577HMbZYjvgSJmOVnd00tKAMN9mFz3DE4To1SUAQ
 thoN7dqA6PUG9qBn/PafqwIET0wbScqEauZg6qamiMR8YLWomWWVPEzQ6CnrgRZ8NwszG/kRy+r
 wdaY2gly5VtIBCaJ0tYxVhiX3RSW3BZdsnxHtIk+GBMUvFfTGVkMXuiPcL0HD/Tn44qqlhLep+t
 39x+DC+oPLDMwkKJ+s6Gho5T+acchE44R/3/fArekhfpm4NKW3QsmY1Q8/N6fX3vNvFZ6LfxEx4
 8M+8mAABevtDaIc23cljDFzSxGWZxa4tU2qg2hfNP+B0aQbodJdPJ2BanHcUjGUSygQ4/Buj4g8
 hhUqHb8/J2ZDkAEwIuA==
X-Proofpoint-GUID: cfxScSJFgB3nA-1Mn55R4eQFmmpUS100
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a6df89f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-mrrAa1H70qYXGFOR_IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_064618_297800_BF957B6A 
X-CRM114-Status: GOOD (  17.67  )
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

On 7/31/26 10:09 PM, Stanislav Fomichev wrote:
> On 07/31, Nilay Shroff wrote:
>> Hi,
>>
>> This is a resend of the previous series to include the networking maintainers
>> and mailing list. There are no code or commit message changes since the
>> previous posting.
>>
>> This series has been updated based on the feedback received during LSFMM.
>> The changelog is updated accordingly.
>>
>> The NVMe/TCP host driver currently provisions I/O queues primarily based
>> on CPU availability rather than the capabilities and topology of the
>> underlying network interface.
>>
>> On modern systems with many CPUs but fewer NIC hardware queues, this can
>> lead to multiple NVMe/TCP I/O workers contending for the same TX/RX queue,
>> resulting in increased lock contention, cacheline bouncing, and degraded
>> throughput.
>>
>> This RFC proposes a set of changes to better align NVMe/TCP I/O queues
>> with NIC queue resources, and to expose queue/flow information to enable
>> more effective system-level tuning.
>>
>> Key ideas
>> ---------
>>
>> 1. Scale NVMe/TCP I/O queues based on NIC queue count
>>     Instead of relying solely on CPU count, limit the number of I/O workers
>>     to:
>>         min(num_online_cpus, netdev->real_num_{tx,rx}_queues)
>>
>> 2. Improve CPU locality
>>     Align NVMe/TCP I/O workers with CPUs associated with NIC IRQ affinity
>>     to reduce cross-CPU traffic and improve cache locality.
>>
>> 3. Expose queue and flow information via debugfs
>>     Export per-I/O queue information including:
>>         - queue id (qid)
>>         - CPU affinity
>>         - TCP flow (src/dst IP and ports)
> 
> [..]
> 
>>     This enables userspace tools to configure:
>>         - IRQ affinity
>>         - RPS/XPS
>>         - ntuple steering
>>         - or any other scaling as deemed feasible
> 
> Can you expand on this a bit? What specifically helped the most for your
> tuned case?

For my network topology and workload, configuring ntuple steering together with
IRQ affinity and XPS provided the most benefit. The NIC used for testing supports
ntuple filters, which allowed me to steer the TCP flow associated with an NVMe/TCP
I/O queue to a specific NIC RX queue. I then configured the IRQ affinity for that
RX queue and XPS for the corresponding TX path so that the NVMe/TCP I/O queue
processing, RX interrupt processing, and TX/RX packet processing were aligned to
the same CPU as much as possible. This reduced cross-CPU processing for an I/O
flow and provided the best improvement among the tuning combinations I tested.

Thanks,
--Nilay


