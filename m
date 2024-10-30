Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9CED7496D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aBXc8UXps+Hm3l1zUJi4n5wnvzgj1UZOFQNXoq+e64s=; b=uwIP1BxYlo+g5WWKYkkIv3v+li
	Vntmr8NTwz/UvmXUHgVHSOmYqUx/0suFHlDBwR8ubRdPCnQNMckQQgg/SVa6E8FmplEFG9O9teH0e
	C7Lt4WMVhS6IfX1eLzs0Z31KmwTwrT080c0VHP9AZPrLvcVx8QaTsLhrE2AthEAp7EUq6y1YnLlkx
	W1h8knRUocyOKYw1XWskxWTeJ+v1hBYHz/qikF0y8OkJTQ8qcGDbT2XRR4ocBXYXbXM7VluTZaUQj
	zUxyHUwI0zrPbAxT2XEdQSCV1EiWcbx8QNSOhcND2gS4FPebNzYQ9+Pw9ZjbuADW9tcGtQR8362uS
	BlNX5WIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t61rv-0000000Gr7I-1gPd;
	Wed, 30 Oct 2024 06:07:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t61rs-0000000Gr6M-29b6
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:07:46 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d29I012483;
	Wed, 30 Oct 2024 06:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aBXc8U
	Xps+Hm3l1zUJi4n5wnvzgj1UZOFQNXoq+e64s=; b=KTRwd3m8ft0OzOae7p2RrK
	L5wbkifTXZA/t1RSOeHO/zRuRVCQZ//w0ZmsneYtwkxeCMxBRHc8KpB6JHdNlOpQ
	HX35DlHU0y13ZAnCBPjbcmhz1qc4gvZH0t2WYM9VVcA1VtAGkEby0WsO0LRqTfi9
	1mmzhJkMGeJeOJHAgK9x9PwYDgRrfLhwi90y37Xlr89YblT9CVKNfCm2Qt/EqLhW
	WJ0pXhDVqz5PumbKKjdzgSPbzBCaGXUdRWpLORbCF1EzY1P1wGU74DIv4h5YsQil
	XHKVECTmeuy1xc29UVM3vjHRcDbWBxOxGbkMd2vzRFNwOsPmo00DJNKNZZiXffzw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42k6gt1unn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 06:07:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U4071m024716;
	Wed, 30 Oct 2024 06:07:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyjeeen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 06:07:20 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49U67JH752167136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 06:07:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7525158062;
	Wed, 30 Oct 2024 06:07:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6C3958054;
	Wed, 30 Oct 2024 06:07:16 +0000 (GMT)
Received: from [9.171.67.17] (unknown [9.171.67.17])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 06:07:16 +0000 (GMT)
Message-ID: <480b7c6a-9f4b-4611-a3d6-de82c39bfe6d@linux.ibm.com>
Date: Wed, 30 Oct 2024 11:37:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_end_io function
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-4-nilay@linux.ibm.com> <ZyD433W-caGMfVsv@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZyD433W-caGMfVsv@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZFiUmPkWSF5B4Ou0jMU6DeI2ITj0PuOm
X-Proofpoint-ORIG-GUID: ZFiUmPkWSF5B4Ou0jMU6DeI2ITj0PuOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_230744_718448_527FF716 
X-CRM114-Status: GOOD (  19.70  )
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



On 10/29/24 20:31, Keith Busch wrote:
> On Sun, Oct 27, 2024 at 10:32:06PM +0530, Nilay Shroff wrote:
>> We no more need acquiring ctrl->lock before accessing the
>> NVMe controller state and instead we can now use the helper
>> nvme_ctrl_state. So replace the use of ctrl->lock from
>> nvme_keep_alive_end_io function with nvme_ctrl_state call.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  drivers/nvme/host/core.c | 11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 865c00ea19e3..6e814daf1002 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1296,10 +1296,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>>  						 blk_status_t status)
>>  {
>>  	struct nvme_ctrl *ctrl = rq->end_io_data;
>> -	unsigned long flags;
>> -	bool startka = false;
>>  	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
>>  	unsigned long delay = nvme_keep_alive_work_period(ctrl);
>> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl->state);
>>  
>>  	/*
>>  	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
>> @@ -1324,13 +1323,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>>  
>>  	ctrl->ka_last_check_time = jiffies;
>>  	ctrl->comp_seen = false;
>> -	spin_lock_irqsave(&ctrl->lock, flags);
>> -	if (ctrl->state == NVME_CTRL_LIVE ||
>> -	    ctrl->state == NVME_CTRL_CONNECTING)
>> -		startka = true;
>> -	spin_unlock_irqrestore(&ctrl->lock, flags);
>> -	if (startka)
>> +	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
>>  		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>> +
>>  	return RQ_END_IO_NONE;
>>  }
> 
> This restores what you had in the reverted patch, which was a
> significant portion of the diff stat. If we're keeping this chunk, maybe
> a full revert isn't necessary, and we can squash the series to just one
> fixing commit.
> 
This doesn't exactly restore what was reverted in the patch. If you 
closely look at the reverted patch then you would find that we reverted 
the nvme_keep_alive_finish function which is not exactly same as 
nvme_keep_alive_end_io function. We renamed nvme_keep_alive_end_io() 
to nvme_keep_alive_finish() for the upstream patch.     

So the revert patch restores nvme_keep_alive_end_io function and also 
restores the nvme_keep_alive_work changes. Then the current patch in this 
patchset, actually works upon nvme_keep_alive_end_io function.
 
Thanks,
--Nilay


