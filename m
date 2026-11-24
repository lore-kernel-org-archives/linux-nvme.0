Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0D606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bqW0wWub;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XNQlydJF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JZBj0mYuFzhfiXUhmVite0Kd8+MpADUHCGHr0B9wOBc=; b=bqW0wWub5N0/a0
	IOjttzN7HvmLvOrOJ0HTUEDQA18euBxpTz9An/6UCGoyUXK8bwKj5NhXiwqLLas97vr12i3r+lnkn
	IsPjPyYltiYChMOtb9zMNUhsxWEOlKbrMVYFbzR36oRKGNNKPyE1VhybDxR6s/buOao7WCA2cRxDU
	j2oVMHN3JuZynoJacqAykJ6fl4Rx3UW4HbNCARQPNQFaMz9WssbE91K6lAJQ7o74ovmHw+xTzSAiJ
	cnXCdKcxYTCLU6jOnm32wLT3brLhnTu7Q63ihQWhsr7PMA44hDs+bXdxdvYBlbAFIf9BZMpI1YYBI
	uARwgINBTnPLWYXgaH9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVm2q-00000005viT-0eyN;
	Tue, 24 Nov 2026 08:38:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVm2l-00000005vi8-12I3
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 08:38:28 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO35BL4002986;
	Tue, 24 Nov 2026 08:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JZBj0m
	YuFzhfiXUhmVite0Kd8+MpADUHCGHr0B9wOBc=; b=XNQlydJFgeWj/JWF/1K9I+
	m5J/exhdMGoni0jMrwxuOuhrAb4DOi8aAag0U1dk3tMngzWtPs3p9+OnlRClHhaR
	fJfD/KFknMipvNy91dIJKvclT2d/OVzqke44RdD1mjuEn3cD667iWhEDbGNPH67U
	3PLbeBeYpN9k/sWWCi6cWEsJvAHWMVQMoUrqQ4+eqLNLlv/ZdowEMOkBXQnHUzwF
	ayjN5V3gYq07yneBNUwZxrTTn4Bv5tkEaaEfLTB8vbM2hk5kHQLQQJ69KPwJyssW
	aS0UcoGWIj3e3cTNiMLpggaGumu3PSno8e8hYMCKnd1NLC9FXAzs/i4V3KrQV0WA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4ea85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:38:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2nLtS021923;
	Tue, 24 Nov 2026 08:38:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmk1waj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 08:38:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO8c9CF3277652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 08:38:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FC335805E;
	Tue, 24 Nov 2026 08:38:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F6E05805C;
	Tue, 24 Nov 2026 08:38:07 +0000 (GMT)
Received: from [9.61.113.35] (unknown [9.61.113.35])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 08:38:07 +0000 (GMT)
Message-ID: <c99118e7-013a-4bf6-b7d3-1a17d829b251@linux.ibm.com>
Date: Tue, 24 Nov 2026 14:08:05 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvme-tcp: expose per-queue socket addresses via
 sysfs
To: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, dwagner@suse.de,
        hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org
References: <20261123173727.2022020-1-nilay@linux.ibm.com>
 <20261123173727.2022020-2-nilay@linux.ibm.com>
 <9affc195-9715-45b5-8daf-f778ccb90f39@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <9affc195-9715-45b5-8daf-f778ccb90f39@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMyBTYWx0ZWRfX9hPwGLbX8IJF
 WT4fQ9T9+AutQ76LaXJQJ+cyt+wT5f4g7cjSs317x6FVwEaBCjSWaLY2g9z+vNkYo171ZfjdR83
 5dcfCdGYj7eoz9IUsn4U4CdHuGxVYSs=
X-Proofpoint-GUID: 4N3voYxqMxjokx_W4GGamH3_CRDsw-_4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMyBTYWx0ZWRfXzMeXqG6WcMCM
 dAbdLVLD1vwI5ci+K1D0HMNKg2ZS2yl/Jx83o0A6SVOFALjWmFd4Kugm9u1jvNYRj5iQHnbg6Rf
 1FkRTuk+Q/oZpE5PD+12MS+ZbG/rAqZlqkCG866FINHMhKLBz2NXuc8WkO9uOfhkFjoXdZfQISs
 6urGWGE1HNoZSIwpgztDJqtrS65aRhIJFPt3ipF2T/1QOqjvX7H+RWSazTmN2cERZ3BxQ7+P1j3
 rn3Pl1swMFqKAFMO77HNmkDvGrkJD9Jh3GrLV+YPEA4UcruERcDTTnFoFfRVZ/ELB1T0SIG2U4c
 5yVT70nZNGbkOzemTy96ToDINIomSVFIeBnu628I5kEl5Bz9ZTwVOtxDz1fTx38UVIiN2Jk/JdS
 Tmojtu2cEwuWR3xUFqxDG7Uky9Pce+XrBXvBG/u2EUs16bKOX0xm91Icid839T6PI36HHjlmgGU
 u/OnRpgtO+apfq3xPCA==
X-Proofpoint-ORIG-GUID: 4N3voYxqMxjokx_W4GGamH3_CRDsw-_4
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b054cf2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=bLtT4wpTqnwrUG5m7akA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_003827_408103_9867B85B 
X-CRM114-Status: GOOD (  24.62  )
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

On 11/24/26 12:32 PM, Hannes Reinecke wrote:
> On 11/23/26 6:37 PM, Nilay Shroff wrote:
>> Add a read-only per-queue sysfs attribute named "address" to expose
>> the socket addresses associated with each NVMe/TCP I/O queue.
>>
>> The attribute reports the socket's peer and local endpoint information
>> using the following fields:
>>
>> - traddr: Peer transport address
>> - trsvcid: Peer transport service identifier
>> - host_traddr: Host transport address
>> - host_trsvcid: Host transport service identifier
>>
>> The attribute is available at:
>>      /sys/class/nvme/nvmeX/queues/&lt;qid&gt;/address
>>
>> Together with the existing per-queue "io_cpu" attribute, this
>> information helps correlate NVMe/TCP I/O queues with network stack
>> components and tune their interaction, including IRQ affinity,
>> RPS/RFS, XPS and NIC flow steering (ntuple).
>>
>> No changes to I/O behavior are expected.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/tcp.c | 50 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index f1d29d9f75cc..c7e736df71d2 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2123,14 +2123,64 @@ static ssize_t managed_show(struct kobject *kobj, struct kobj_attribute *attr,
>>                 !test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags));
>>   }
>> +static ssize_t address_show(struct kobject *kobj, struct kobj_attribute *attr,
>> +                char *buf)
>> +{
>> +    struct nvme_tcp_queue *queue = nvme_queue_info_data(kobj);
>> +    struct sockaddr_storage src, dst;
>> +    int ret = 0;
>> +
>> +    mutex_lock(&queue->queue_lock);
>> +
>> +    if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>> +        goto out;
>> +
>> +    ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src);
>> +    if (ret <= 0)
>> +        goto out;
>> +
>> +    ret = kernel_getpeername(queue->sock, (struct sockaddr *)&dst);
>> +    if (ret <= 0)
>> +        goto out;
>> +
>> +    if (src.ss_family != dst.ss_family) {
>> +        ret = -EAFNOSUPPORT;
>> +        goto out;
>> +    }
>> +
>> +    if (src.ss_family == AF_INET) {
>> +        struct sockaddr_in *sip = (struct sockaddr_in *)&src;
>> +        struct sockaddr_in *dip = (struct sockaddr_in *)&dst;
>> +
>> +        ret = sysfs_emit(buf, "traddr=%pI4,trsvcid=%hu,host_traddr=%pI4,host_trsvcid=%hu\n",
>> +                &dip->sin_addr.s_addr, ntohs(dip->sin_port),
>> +                &sip->sin_addr.s_addr, ntohs(sip->sin_port));
>> +    } else if (src.ss_family == AF_INET6) {
>> +        struct sockaddr_in6 *sip6 = (struct sockaddr_in6 *)&src;
>> +        struct sockaddr_in6 *dip6 = (struct sockaddr_in6 *)&dst;
>> +
>> +        ret = sysfs_emit(buf, "traddr=%pI6c,trsvcid=%hu,host_traddr=%pI6c,host_trsvcid=%hu\n",
>> +                &dip6->sin6_addr, ntohs(dip6->sin6_port),
>> +                &sip6->sin6_addr, ntohs(sip6->sin6_port));
>> +    } else {
>> +        ret = -EAFNOSUPPORT;
>> +    }
>> +out:
>> +    mutex_unlock(&queue->queue_lock);
>> +    return ret;
>> +}
>> +
> 
> Hmm. This is stretching the definition of 'traddr' and 'host_traddr'
> a bit, as normally these are controller settings, not queue settings.
> I do see the logic, but I'm not quite happy with it.
> 

Would you prefer sip, dip, sport and dport instead of host_traddr,
traddr, host_trsvcid and trsvcid?

>>   static struct kobj_attribute nvme_tcp_io_cpu_attr =
>>       __ATTR(io_cpu, 0644, io_cpu_show, io_cpu_store);
>>   static struct kobj_attribute nvme_tcp_managed_attr =
>>       __ATTR_RO(managed);
>> +static struct kobj_attribute nvme_tcp_address_attr =
>> +    __ATTR_RO(address);
>>   static struct attribute *nvme_tcp_queue_attrs[] = {
>>       &nvme_tcp_io_cpu_attr.attr,
>>       &nvme_tcp_managed_attr.attr,
>> +    &nvme_tcp_address_attr.attr,
>>       NULL,
>>   };
>>   ATTRIBUTE_GROUPS(nvme_tcp_queue);
> 
> But in general it's a good idea.
> 

Thanks,
--Nilay


