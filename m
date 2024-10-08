Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7152CCEFC39
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NoAJVLPIdLSKdrsr5/g9OGWSSV/1ABZCYzF5Hozp+R4=; b=1D4xlzmUM/Xxhae25oQ4Sf5Pvf
	RvalLTJA3NaF2sqZZIZuGTpVZEn+8WqLkLZ31G48JLarC/Qw4AJUInCK/m7s3nV3OxsoAbxNyENGw
	E3cUnQWGremm3r40uOMqJW6SLwubuVri+FT7Vx8UneEfQH2YD4yxCKPPGY7OZ8xH07qlnIxu6/j2C
	cxXnLLQKgMI3Ya9XFWMWq/7zQ/Q4AlKylqPd7h9qs6+TyqMmi0+7EYuyLWz7/8dRNZPlhu6B4CNUs
	Z87f5ffjHqKtL4Zj0FlVMRfAm7BAzvMNtxHLDkGtlbDkjZcKDUHfB9R+qhdF+JviXfouqQS8tIYWd
	VPjS0Trg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syEOB-00000006iTO-0SOA;
	Tue, 08 Oct 2024 17:52:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syEIV-00000006hXJ-1wOo
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 17:47:00 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498HJhao015954;
	Tue, 8 Oct 2024 17:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=N
	oAJVLPIdLSKdrsr5/g9OGWSSV/1ABZCYzF5Hozp+R4=; b=evEuhzEax8HjPk0+O
	Yd/pkP56+L7Lao89E1fqzpzjRZTY1iRaxMojPIGF13dwxUPEc5sCQ10CBUYtdzCN
	i0RcxKfgWE/IjbgBxc4tRGaa6pY2qnRJJWTJl/EYE+kF9KS7Yc51EgATssrzHZEu
	4IpWFWmBJbJnsJMVq/rGJbOwYG69omN2vB/IZdFd7zLEKRMHBftLuP3rZnbaHZH3
	t1N8rb9LE1AcH0R6dcaWxtXDump8fWBiO62xCPlC5fhQIbFxyVUHZ3DMHvQROO+N
	d4La6Mgrd6RS1ePAD9u9BjGiB6i6YbQyIObxKhrjtcEYvTgM2MouUj+IOOZEYlx3
	hbPMA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42591qr4us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 17:46:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498FUemg030253;
	Tue, 8 Oct 2024 17:46:49 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmns1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 17:46:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498HknfU19595836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 17:46:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22DF75805D;
	Tue,  8 Oct 2024 17:46:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6C7658059;
	Tue,  8 Oct 2024 17:46:46 +0000 (GMT)
Received: from [9.179.0.95] (unknown [9.179.0.95])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 17:46:46 +0000 (GMT)
Message-ID: <98154482-8777-42cb-b470-ba0f0db1c59c@linux.ibm.com>
Date: Tue, 8 Oct 2024 23:16:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme: make keep-alive synchronous operation
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
        gjoyce@linux.ibm.com
References: <20241008062210.1094083-1-nilay@linux.ibm.com>
 <20241008062210.1094083-3-nilay@linux.ibm.com>
 <20241008070459.GA22711@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241008070459.GA22711@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gsegdd-fXxCGtrnRKh4T-fjmnA4rIKR8
X-Proofpoint-ORIG-GUID: gsegdd-fXxCGtrnRKh4T-fjmnA4rIKR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_15,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_104659_663191_8218EB90 
X-CRM114-Status: GOOD (  23.89  )
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



On 10/8/24 12:34, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 11:51:51AM +0530, Nilay Shroff wrote:
>> This fix helps avoid race by implementing keep-alive as a synchronous
>> operation so that admin queue-usage ref counter is decremented only
> 
> Please spell out q_usage_counter as requested in the first round.
> 
Yes sure, I will do it in the next patch revision.

>> after keep-alive command finish execution and returns its status. This
>> would ensure that we don't inadvertently destroy the fabric admin queue
>> until we finish processing of nvme keep-alive request and its status and
>> hence it's safe to delete the queue.
> 
> I still fail to see why this requires a synchronous operation vs just
> calling blk_mq_free_request and thus decrementing q_usage_counter
> afrer checking the controller state.
> 
> Maybe I'm just dumb and missing the obvious even after the last
> explanation, but then the commit log needs to be improved to explain
> it.
>
OK, I will update the commit log in the next patch revision.
 
BTW, I just tried experimenting with your suggestion of "removing the 
blk_mq_free_request call from nvme_keep_alive_finish function and returning 
RQ_END_IO_FREE instead of RQ_END_IO_NONE" and I could still hit the same issue. 

The issue here's that after nvme_keep_alive_finish returns back up to the 
block layer, the nvme keep-alive thread running the queue dispatcher operation 
(and hence accessing the queue resources) while this queue might have been 
destroyed on another cpu.  

nvme_keep_alive_work()
  ->blk_execute_rq_no_wait()
    ->blk_mq_run_hw_queue()
      ->blk_mq_sched_dispatch_requests()
        ->__blk_mq_sched_dispatch_requests()
          ->blk_mq_dispatch_rq_list()
            ->nvme_loop_queue_rq()
              ->nvme_fail_nonready_command() 
                ->nvme_complete_rq()
                  ->nvme_end_req()
                    ->blk_mq_end_request()
                      ->__blk_mq_end_request()  -- with your suggestion, we now decrement admin->q_usage_counter here
                        ->nvme_keep_alive_finish() 
 
When above call stack returns to __blk_mq_sched_dispatch_requests function, 
the admin queue might have been destroyed on another cpu however the 
__blk_mq_sched_dispatch_requests could still access the admin queue resources 
and causing the crash as reported in the cover letter.

> 
>> -static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>> -						 blk_status_t status)
>> +static void nvme_keep_alive_finish(struct request *rq,
>> +				blk_status_t status,
>> +				struct nvme_ctrl *ctrl)
> 
> And as a nipick, this should be:
> 
> static void nvme_keep_alive_finish(struct request *rq, blk_status_t status,
> 		struct nvme_ctrl *ctrl)
> 
> 
Yes will do it the next patch.

Thanks,
--Nilay

