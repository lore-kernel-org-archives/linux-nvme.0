Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C817FCED26B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 05:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZGCLhfzHNPaZ1E55jvXY1K4xUDHfEoLv7/Rf4v8ow5w=; b=Oet0xKmHjT1EmrOYHaU8GH5Ree
	B2LF+1PDRZmrHDVrbp+EubL9g9BkXv7V5KoQRFcXV0UlaZywOYdhZiRtbmGi8bhIFWnAZjA9qb9qW
	V72ccizi9cErDqUyXt1l/73ZotKrcRduXa/qrHHj59QKEeabb41c1XCV9xmLGcl20/l/W9n3k7vwO
	jZUy+0GBQq/LN04tLIhXuLxddl4MkhIOAfykcLPmO4GTeyMY09UBgUCY5f2KfsueE4mME3T3kwyOa
	oAFhpDrtV0m6GtpmVy4KZb93lMznI1HYIbaDz5ufPujk5s7j3Bk7Y7n8FFnAs+z0ZK5l69TQoMxP1
	Nk8/gn4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy2tw-00000004Z94-0rsw;
	Tue, 08 Oct 2024 05:36:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy2tt-00000004Z8G-0yrX
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 05:36:50 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4983ms7v016702;
	Tue, 8 Oct 2024 05:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Z
	GCLhfzHNPaZ1E55jvXY1K4xUDHfEoLv7/Rf4v8ow5w=; b=aJKIsfFUEPy9IjCuE
	tNC6q1+u7QwSkWPkDbE17dgPHiqVFhVYUdcs+EiCZ5K8JkcwDgnzpjyD9uG4yC3v
	2ZbQC1nCC1uF/S/lkyYS9lCiYD6A+SNNURTAu0LsjzYa3g2+3QGClAlLzUE9uSwW
	8Q3CWNjG+3OOZdPX2AjXWCU2Ij2cabDclutUs2ZDvZ/uV5FI6eSUv1tjfIpyVR2X
	mGZFph7IKtK/l84Qxw4UT++feHb59W9MpeNTHfUaXbIcczAPGiSUs5CGzldDXP/M
	jwUHVIpr7e6ddMwdFC5Fj2PigQxO2dvkbwSGQxaS2FeSwpNE7iehZl5LA4QYcsFS
	/4bDQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424w4cgcmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 05:36:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4983FS7m010715;
	Tue, 8 Oct 2024 05:36:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0ja5jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 05:36:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4985ag7J23790156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 05:36:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02B835804E;
	Tue,  8 Oct 2024 05:36:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0F2858054;
	Tue,  8 Oct 2024 05:36:38 +0000 (GMT)
Received: from [9.171.23.125] (unknown [9.171.23.125])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 05:36:38 +0000 (GMT)
Message-ID: <48689ead-f3c3-44a3-b1fe-be3ff01babaf@linux.ibm.com>
Date: Tue, 8 Oct 2024 11:06:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_finish function
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com
References: <20241008041436.1073281-1-nilay@linux.ibm.com>
 <20241008041436.1073281-4-nilay@linux.ibm.com>
 <4e159735-7703-4f39-b98e-25c21824506c@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4e159735-7703-4f39-b98e-25c21824506c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zlZ7Pa3LaQoiGW0iudsChqyQGx_e7hxd
X-Proofpoint-ORIG-GUID: zlZ7Pa3LaQoiGW0iudsChqyQGx_e7hxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_04,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 clxscore=1011 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_223649_535801_0C3DBAD7 
X-CRM114-Status: GOOD (  16.00  )
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



On 10/8/24 10:49, Damien Le Moal wrote:
> On 10/8/24 13:13, Nilay Shroff wrote:
>> We no more need acquiring ctrl->lock for accessing the NVMe controller
>> state and instead we can now use the helper nvme_ctrl_state. So replace
>> the ctrl->lock from nvme_keep_alive_finish function with nvme_ctrl_state
>> call.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  drivers/nvme/host/core.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 736adbf65ef5..5a690cf16e5e 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1296,10 +1296,10 @@ static void nvme_keep_alive_finish(struct request *rq,
>>  				blk_status_t status,
>>  				struct nvme_ctrl *ctrl)
>>  {
>> -	unsigned long flags;
>>  	bool startka = false;
>>  	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
>>  	unsigned long delay = nvme_keep_alive_work_period(ctrl);
>> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
>>  
>>  	/*
>>  	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
>> @@ -1322,11 +1322,8 @@ static void nvme_keep_alive_finish(struct request *rq,
>>  
>>  	ctrl->ka_last_check_time = jiffies;
>>  	ctrl->comp_seen = false;
>> -	spin_lock_irqsave(&ctrl->lock, flags);
>> -	if (ctrl->state == NVME_CTRL_LIVE ||
>> -	    ctrl->state == NVME_CTRL_CONNECTING)
>> +	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
>>  		startka = true;
> 
> 	startka = state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING;
> 
> But do you even need that variable now ? The below "if (startka)" could be
> replaced with "if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)", no ?
> 
>> -	spin_unlock_irqrestore(&ctrl->lock, flags);
>>  	if (startka)
>>  		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>>  }
> 
> 
Oops yeah you were correct, we don't need @startka. I will spin a new version. 
Thanks for your comment!

--Nilay

