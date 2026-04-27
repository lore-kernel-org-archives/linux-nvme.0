Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4684FF8862
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89HGq5zk0xXXylPmiYTBUA+Z1FZQobDaD4R9kmYk7Mo=; b=2Y5F3kTbgJ5DlDiVMj7Yhb3qtA
	NhgCHXIzFJsIIYUkNOajCJeiXrQxtDj5fyVJkWyGrj+lyJbJ89/W87DPfs1dG7UaX12TXhrXdACvx
	cF3lxC+8970qZHQxnJKFOACOaV7vZgsR9rUq9R0DmWT36+PYAjEvCx1dEh/YXpfC3qqDFjQpUeNY/
	iV3V4iBLUgRWi2fw0UY4tQHkepgzH703QhJRLC7FTQGTvkdwaEof1ECxz5ZZE7DjwEO2ejq6ZymKi
	9egOk+64GGI51koBEYZ5IjKSUe3gwfDCc5rISBy3VndF49DS5pBIwC9r5X4RxWx9DN/6ayTbfO03t
	HzsNOVwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHGXm-0000000GOG1-0eSQ;
	Mon, 27 Apr 2026 07:38:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHGXi-0000000GOFe-0EGC
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 07:38:12 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QCFJgw1672847;
	Mon, 27 Apr 2026 07:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=89HGq5
	zk0xXXylPmiYTBUA+Z1FZQobDaD4R9kmYk7Mo=; b=O6vglROQoOwhfpesF34hlv
	Pj4rutIlYl87BzlHMk+B62WNdkpVfCUpGdjQYaXssrYf1glWItjuEoiZ6bj3FLci
	SApfDK9bc3TDdCyyofb9pFoALyueY+47EaXh3kckwFzgNGqEDW3GcVpAMQ4rQY6m
	K7bb8+RzeSIG3g2da2I49uoyxfncVn+vO4nGKjBqjjanVcgHgaHRolVfNaiHER+b
	cvfElxPVG8lXNUGKXEBO8l6TixGc+oNgXGvHqsZGW0IkspW8mpRD7m/VXqYYj8bK
	tYbYnAvnsqQeK18EHnT4sUL3rDqBzf6trBBBvkyyxrWjB6FL2IhxNZqp42E5uR7g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb4y7ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 07:38:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R7Nn5Z015454;
	Mon, 27 Apr 2026 07:38:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avm93v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 07:38:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R7c01b62456306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 07:38:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF3858059;
	Mon, 27 Apr 2026 07:38:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6535F58043;
	Mon, 27 Apr 2026 07:37:57 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 07:37:57 +0000 (GMT)
Message-ID: <c5e8020f-1d2e-4609-a5fe-ff84c5653e7a@linux.ibm.com>
Date: Mon, 27 Apr 2026 13:07:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] nvme-tcp: optionally limit I/O queue count based
 on NIC queues
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hare@suse.de,
        sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <20260420115716.3071293-2-nilay@linux.ibm.com>
 <20260424134620.GA17351@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260424134620.GA17351@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69ef125a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=3wjORGWImiJ6AlYRmtwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA3NyBTYWx0ZWRfXzeC3rn42vgSa
 pwMjea48ByoJg3QVNs6qQYT0WtmOlwmW1PZyMAqp9jh71e1n2iJMrC+/BM0gKCa6A6c1S39vmsw
 I9i5Cd+39O/Q7VEzi31Qz1uy14SkMGlPFtei0opXvHuc2SeqQdn+4QW/KQ2fn85D4upg1EOxejp
 yvnmR9hrZ6IxA1Oh4AeIpfn/PCoIBB5vMi1giK4KenpEBWnpupiZPM8lvVA+6+nGtP1n5g3vtRo
 NEx/qbugys9nWJOD0MC+AnQr2H7fcI4pLsQZfGgzk1DV+z19xJW3CRsRV7O/SnNIn8cvI09MM/u
 OeWXiBNcjWPtqh+1iylsmqpl03Ehg/PNPkBbqAoflhE83a6JuoNdNaFotaus2xi/pG5FdoLweGD
 YDyvO14g2j2Dw5d2DOw/ibk4WrVlsvUfLxNzXerbQep5dGmD+67/PIbwuU3e8lJKRZLAhV2XvJD
 q2KKIzMD41aOdMPbf8A==
X-Proofpoint-GUID: -AWBRZ6YGn_BMNvnGpte-q_9DfOPhx0J
X-Proofpoint-ORIG-GUID: -AWBRZ6YGn_BMNvnGpte-q_9DfOPhx0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_003810_911362_28C734F5 
X-CRM114-Status: GOOD (  26.37  )
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

On 4/24/26 7:16 PM, Christoph Hellwig wrote:
>> In such configurations, limiting the number of NVMe-TCP I/O queues to
>> the number of NIC hardware queues can improve performance by reducing
>> contention and improving locality. Aligning NVMe-TCP worker threads with
>> NIC queue topology may also help reduce tail latency.
> 
> Yes, this sounds useful.
> 
>>
>> Add a new transport option "match_hw_queues" to allow users to
>> optionally limit the number of NVMe-TCP I/O queues to the number of NIC
>> TX/RX queues. When enabled, the number of I/O queues is set to:
>>
>>      min(num_online_cpus, num_nic_queues)
>>
>> This behavior is opt-in and does not change existing defaults.
> 
> Any good reason for that?  For PCI and RDMA we try to do the right
> thing by default.
> 
The only reason was that in certain complex typologies it may not
be really possible (for instance, QEMU) to get the real num of tx/rx
queues. In such situation, I thought we're better off using this
feature and hence I added the opt-in. But yes I'd also love to remove
this option and find a better way to detect such cases where we can't get
the real num of tx/rx queues and thus aromatically fallback to creating
as many I/O queues as num of online cpus. I'd explore this and see
if that's possible.

>> +static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl)
>> +{
>> +	struct net_device *dev = NULL;
>> +
>> +	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
>> +		dev = dev_get_by_name(&init_net, ctrl->opts->host_iface);
> 
> Return early here instead of the giant indentation for the new options.
> 
Yes okay, makes sense!

>> +	else {
>> +		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
>> +
>> +		if (tctrl->addr.ss_family == AF_INET) {
> 
> And then split each address family into a helper.  And to me those
> look like something that should be in net/.
> 
Hmm okay, I think if we want to add these helpers under net/ then it should be
in include/net/route.h and include/net/ip6_route.h for IPv4 and IPv6 respectively.

>> +
>> +/*
>> + * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
>> + * be determined.
>> + */
>> +static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
> 
> drop _current to make this a bit more readable?
> 
Sure.

>> @@ -2144,6 +2243,24 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>   	unsigned int nr_io_queues;
>>   	int ret;
>>   
>> +	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES) &&
>> +			(ctrl->opts->mask & NVMF_OPT_MATCH_HW_QUEUES)) {
> 
> The more readable formatting would be:
> 
> 	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES) &&
> 	    (ctrl->opts->mask & NVMF_OPT_MATCH_HW_QUEUES)) {
> 
Yep, I will change this.

>> +		int nr_hw_queues;
>> +
>> +		nr_hw_queues = nvme_tcp_get_netdev_current_queue_count(ctrl);
>> +		if (nr_hw_queues <= 0)
>> +			goto init_queue;
>> +
>> +		ctrl->opts->nr_io_queues = min(nr_hw_queues, num_online_cpus());
>> +
>> +		if (ctrl->opts->nr_io_queues < num_online_cpus())
>> +			dev_info(ctrl->device,
>> +				"limiting I/O queues to %u (NIC queues %d, CPUs %u)\n",
>> +				ctrl->opts->nr_io_queues, nr_hw_queues,
>> +				num_online_cpus());
>> +	}
> 
> And splitting this into a helper would help keeping the flow sane.
> 
Alright, will make it into separate helper.

Thanks,
--Nilay




