Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74C7606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VhqD9hZY;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lkpk9ngI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/UzbNZ1drUHp89khCDRZ9WfXtgw6mtSDZ30XIN2lAfM=; b=VhqD9hZYsjsdHR
	EsU3cFiNeR8GFicdVIrBmJJKSXGqzNgMBxgjw62Bjw0C7jws7zd5sadA2oqcOFXOaCu+8Nwe3teiD
	4IWp/ovKELx7wu+0UJYH+2f6h1F5QRAkvdIxnFr+KdCnU5pbLQNXmmSd+dx92nTaiTEMlpRWcS/3o
	voGbgGM7HioScB0F/ZqJFjyXKtf2WcFcsuIgZJna2LJnydLztfIfKGQFSBHDvCG+ym95bS+S2jiWG
	hpGZhQXMzUEB0HG35oknxuA7a12196w7dZkb06j/PPIEf7XiW2uk2S5aOulBWPL809GMB/T0F/iDo
	E4ly4miIhVCdWoLzvffA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVm3R-00000005voj-2TH0;
	Tue, 24 Nov 2026 08:39:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVm3O-00000005voA-47W0
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 08:39:08 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO34ajY3825940;
	Tue, 24 Nov 2026 08:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/UzbNZ
	1drUHp89khCDRZ9WfXtgw6mtSDZ30XIN2lAfM=; b=lkpk9ngIWD7celpvfyTP7J
	jFFLWg4J4ywcO0JmftJ7iY1sA3LOjvp1LfEbIleWhYPu6hPJDtnYcZzxphT0n3dD
	rDP56Hn7JaNAlok7mGV0jTvSUmlQHZgSV2amNzc6dzqsGECNDofjWd1ov9zo9/Sr
	Aj05Dl8iyiy7pbzNyhVUSm3JuK2UER82eUq60CLmEfTxYO90jsdiMOdAIOKxiyLU
	UzbZkMBNq97DBqvRSkksM0fI7qD/ZUu4SqHa+G/9AS6ga6r+zeGAnKm/XJlG4E4V
	qQWkXm8t7DaF4ib1I0CgKrr1TMHvUqI9J320dvQsjL14njD1hhbNC2RkS1j4oe2g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g36u8j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:38:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2nGbP2086937;
	Tue, 24 Nov 2026 08:38:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vj1e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:38:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO8csWB26149406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 08:38:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E792658051;
	Tue, 24 Nov 2026 08:38:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A76C658062;
	Tue, 24 Nov 2026 08:38:51 +0000 (GMT)
Received: from [9.61.113.35] (unknown [9.61.113.35])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 08:38:51 +0000 (GMT)
Message-ID: <d176a40e-9446-455d-8ae5-8bb76ae33682@linux.ibm.com>
Date: Tue, 24 Nov 2026 14:08:50 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] nvme: document NVMe/TCP per-queue address sysfs
 attribute
To: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, dwagner@suse.de,
        hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org
References: <20261123173727.2022020-1-nilay@linux.ibm.com>
 <20261123173727.2022020-3-nilay@linux.ibm.com>
 <a4ade153-75b8-47f6-908a-b61b207c85da@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a4ade153-75b8-47f6-908a-b61b207c85da@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b054d1f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=GJq86qgG9mpgkJBzaI8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMyBTYWx0ZWRfX4GgDCW0OScWV
 IudssZdQ62AZzxxs1IanBGtqg0GdwPaBvys3g8Q+m+68dZhfliNAOPo3eQGduKsZuNndEFdggpm
 geNead56X+wtZy4vXYlXUzeADvbx60w=
X-Proofpoint-ORIG-GUID: j9OGs4PuP7hNxgG_PD-oHzdAMRjnohLp
X-Proofpoint-GUID: j9OGs4PuP7hNxgG_PD-oHzdAMRjnohLp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMyBTYWx0ZWRfX2ReEE0Lc8SV/
 uBgy8Edc2cV7wAb9PmDrM9Sq/cS+zU61kLX10pg8YlLABUdWlKPYqhIgtcBI8Ll4Jho1zS2x9dC
 Iqz86mEDC/92YzFgyOLLt4UZkU/eleZLJjCENHlO8MsLnToE2ZA3MSOGUyWWDoWN2SoJ3130qrb
 /3jLDspablSTJSZ+vCdqnH4fRQ0cTXIqDG4JMkf2J7C4v0jHDw5Z1Lb9y8eAQ5hEJ2aiyY2PhEW
 WoyZXBx9dwsQK/g9DmFUOhserqtkJ8QOcJSXkUPECJ9IKt1P6nwKlWYV0NEQrhiTaaSWSNx+lHh
 dh4ZIOm7d0s85UbV1J0PMUpGEc2oTme8XAIASRlY5NKi33Kd1ZSVEsV9/EN/HjIAddufiR4Zhh6
 /rfRf5ocXyTGwDQ78mJDs3Ai2SLCEBYN0XmUNgqbYwdSgfBMwx6cMZp0fxZF8riT/x2MM8sbqnI
 Nd39duQpAyT6vjA/uLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_003907_026488_9C81A66C 
X-CRM114-Status: GOOD (  16.51  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 12:33 PM, Hannes Reinecke wrote:
> On 11/23/26 6:37 PM, Nilay Shroff wrote:
>> Document the per-I/O-queue "address" sysfs attribute introduced
>> for NVMe/TCP. The attribute is available at:
>>
>>      /sys/class/nvme/nvmeX/queues/<qid>/address
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   Documentation/ABI/stable/sysfs-nvme | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
>> index fcfd0426866c..953ecee81c43 100644
>> --- a/Documentation/ABI/stable/sysfs-nvme
>> +++ b/Documentation/ABI/stable/sysfs-nvme
>> @@ -534,3 +534,21 @@ Description:
>>           managed: (RO) Shows who owns the CPU placement. 1 while
>>           io_cpu is driver managed, 0 once the user assigned it,
>>           for the life of the controller.
>> +
>> +What:        /sys/class/nvme/nvmeX/queues/<qid>/address
>> +Date:        November 2026
>> +KernelVersion:    7.5
>> +Contact:    Nilay Shroff <nilay@linux.ibm.com>
>> +Description:
>> +        (RO) Shows the socket endpoint addresses associated with
>> +        an NVMe/TCP I/O queue. The output contains the following
>> +        comma-separated fields:
>> +
>> +        traddr: Peer transport address (IPv4/IPv6).
>> +        trsvcid: Peer transport service identifier (TCP port).
>> +        host_traddr: Local transport address (IPv4/IPv6).
>> +        host_trsvcid: Local transport service identifier (TCP port).
>> +
>> +        Returns an empty result if the I/O queue is not live.
>> +        Returns error if host or peer transport address can't be
>> +        determined or transport address family is unsupported.
> 
> Please merge it with the previous patch.
> 
Yeah will fold this patch into the previous.

Thanks,
--Nilay



