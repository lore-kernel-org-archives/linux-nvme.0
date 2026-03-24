Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BE4F54AAA
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WRI4llp8lTdESKv+/4rNLSMM7uEXXqAYHkEyROT8Nx8=; b=Y/4XVJIbvkfEDmmeIxKUdMs+yF
	aH0073kKchh4UZn6HxzWGGA+6IhHfP6BtOwie4c3nCZ1z4Rr98/0kL4urwLEdfeE/acN4IynaalRy
	nlJ0KrXJI8gW281bIvv+B2F0bFtZH0GtNW6vAPJNIzQ4kTXW4H15HCteb/oyiVhLSfY2SMEOjkkqF
	0Jekvqn5Ne+lZnjbZ5ehTzcom2GPFfOi02FqdkIYhHbvoiSoi/3XesueiHEEFdUe7LuaSGscBickW
	WZG3ehK9YCnCvj9ubo9HE4iJP4B2nURJO3jGDtsgwHpGHbmns7AgDCu4M5LF/vMPINQ8hSdeLtjBo
	pRvZCczA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w51Pc-00000001U4i-2MFM;
	Tue, 24 Mar 2026 13:03:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w51Pa-00000001U46-03GQ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 13:03:11 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O7rljB369072;
	Tue, 24 Mar 2026 13:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WRI4ll
	p8lTdESKv+/4rNLSMM7uEXXqAYHkEyROT8Nx8=; b=jyb/cl4BV4CuYYzvH8nv5X
	AhDoJyfbxeNKzgowDPf4qWNbM/Bij3OnBxnPjXvC6eMKlcoH4HQIQVTeZZ8dXnVr
	WiZqmCqR2TMZ5u7/3lvhSap4QLDbVkqtjd6IaJO5yeLpaWjt61qr++NjAFNamXMh
	xm5BbTx5wP8D5EJw3IfAaCg4w7Id5UcoYDfri0w4F/WvCHNKS/6Ve3hekMo1GlO/
	obrILhUMfoMpDYSp3vzoEoM6wViilgZ64ppxsaLsAwEqVKw0uRIbR+p0VD99RHf/
	3HOQ3j9PQEtlvPo6F/ve5/DskKbpLFyMeRGEbz0oPMF0pgpbrJlKn3odHpwF05Gg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky02wjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 13:03:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O90FR3011788;
	Tue, 24 Mar 2026 13:03:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk1qaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 13:03:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OD34mq27591414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 13:03:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36D9C58065;
	Tue, 24 Mar 2026 13:03:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABA6258064;
	Tue, 24 Mar 2026 13:03:01 +0000 (GMT)
Received: from [9.39.27.13] (unknown [9.39.27.13])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 13:03:01 +0000 (GMT)
Message-ID: <cc566b4c-fe9f-47c6-827f-d1d436fa477e@linux.ibm.com>
Date: Tue, 24 Mar 2026 18:32:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] libnvme: add support for retrieving per-path gendisk
 I/O statistics
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org,
        hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-5-nilay@linux.ibm.com>
 <1adcb39b-5e88-4ad0-86fb-8d794adc8744@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1adcb39b-5e88-4ad0-86fb-8d794adc8744@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwMSBTYWx0ZWRfX7N1ocWUYmqvk
 igTIW2486B8v9djbqDAfID55/WGvg164H8+RO7VXllXKNYENNznQc8I4z3Yq63pPA/e49BIqaez
 4ZAx8BOhPu2rUzcuMHNX/YUKbI6JSVJggcv1jxjFhnNDuloInbmCPdItGLsanQPJcaV+hRF/XSP
 KylGTbPKbNNawztc7Zmk4fBO6rnywh1T01hhdE7cBc2NtKtcZdxn3lrF4YVH2LmXCeGmd0QhmaT
 48yPHJxjO97dDxy0gUMF0pLaRpGAoE+Mi1aqPWk50U9QrMytYDllvvQXMH/spyrZRJpQFZxxOBq
 q2WPsUflfcXo4Ser/cIwkkMyeSeemonPutEM1OrrS2VvX4YuyhsM8e0Fr2lvM3YRlc9KaXR8UQw
 tN5ACy+lLjziA7UEPkWD39ut+wN66zX6jreU7h4DWP5W24zEdRMKlVrpZlXS3XHy691BgrPVLXO
 R6LR5oslB7loQLmCUYQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c28b8a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=A2P1p8Syzv5ZEhmEUuUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AWtWq5H8L7kT0wa-Y3BCE0rW78dWffEt
X-Proofpoint-GUID: AWtWq5H8L7kT0wa-Y3BCE0rW78dWffEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_060310_173956_37F03886 
X-CRM114-Status: GOOD (  23.40  )
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

On 3/24/26 2:35 PM, Daniel Wagner wrote:
> On Sat, Mar 21, 2026 at 08:58:03PM +0530, Nilay Shroff wrote:
>> +static int nvme_update_stat(const char *sysfs_stat_path, nvme_stat_t stat)
>> +{
>> +	int n;
>> +	struct timespec ts;
>> +	unsigned long rd_ios, rd_merges, wr_ios, wr_merges;
>> +	unsigned long dc_ios, dc_merges, fl_ios;
>> +	unsigned long long rd_sectors, wr_sectors, dc_sectors;
>> +	unsigned int rd_ticks, wr_ticks, dc_ticks, fl_ticks;
>> +	unsigned int io_ticks, tot_ticks, inflights;
>> +
>> +	memset(stat, 0, sizeof(struct nvme_stat));
>> +
>> +	n = sscanf(sysfs_stat_path,
>> +		"%lu %lu %llu %u %lu %lu %llu %u %u %u %u %lu %lu %llu %u %lu %u",
>> +		&rd_ios, &rd_merges, &rd_sectors, &rd_ticks,
>> +		&wr_ios, &wr_merges, &wr_sectors, &wr_ticks,
>> +		&inflights, &io_ticks, &tot_ticks,
>> +		&dc_ios, &dc_merges, &dc_sectors, &dc_ticks,
>> +		&fl_ios, &fl_ticks);
>> +
>> +	if (n < 17)
>> +		return -1;
> 
> return a proper error code, e.g. -EINVAL or whatever matches better.

Yes will return the proper error code.

> 
>> +__public int nvme_path_update_stat(nvme_path_t p, int curr)
> 
> Do we need to expose 'curr' to the user? I'd prefer not to expose this
> implementation detail to the user if possible.
> 

Here, @curr represents the bucket index. As you may have noticed,
nvme_path_t maintains a stats[2] array that stores both the previous
and current statistics.

Typically, at a regular interval (for example, when nvme-top runs with
a 1-second interval), the user/nvme-cli invokes nvme_path_update_stat().
This function reads the gendisk I/O statistics and updates one of the
entries in stats[]. The @curr parameter indicates which bucket should
be updated with the latest values.

After updating the stat, the caller/nvme-cli invokes nvme_path_get_xxx()
APIs to retrieve specific metrics. These APIs also take the current index
and compute results by comparing the current and previous statistics.

In the next interval, the caller/nvme-cli toggles the index. This effectively
swaps the roles of the two buckets—what was previously the current stats becomes
the previous stats, and vice versa. The caller then invokes nvme_path_update_stat()
again with the updated index, followed by the nvme_path_get_xxx() APIs to
retrieve the latest computed statistics.

 From this, you can see that if this logic were handled entirely within
libnvme, the library would need to maintain internal state to track which
bucket to update. Instead, I prefer leaving this responsibility to the
caller, since it already operates within the interval loop. This keeps the
library stateless and gives the caller explicit control over the bucket
selection for each interval. Does this make sense?

>> +{
>> +	_cleanup_free_ char *sysfs_stat_path = NULL;
>> +	nvme_stat_t stat;
>> +
>> +	stat = nvme_path_get_stat(p, curr);
>> +	if (!stat)
>> +		return -1;
> 
> return an error code instead -1. same comment for the rest of the patch.
> 
>> +__public unsigned int nvme_path_get_io_ticks(nvme_path_t p, int this)
>> +{
>> +	nvme_stat_t curr, prev;
>> +
>> +	curr = nvme_path_get_stat(p, this);
>> +	prev = nvme_path_get_stat(p, !this);
> 
> Do we really need to expose 'this'?
> 
As explained above @this is also a bucket index which is used to
calculate/derive the io_ticks comparing the ticks values in the
current and previous stat buckets.

Thanks,
--Nilay


