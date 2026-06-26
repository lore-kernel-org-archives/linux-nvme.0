Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B435FC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYYIYovBck7UDc5uLG/RSmoG1q9+IFKkb38GwdD3t5w=; b=EtKW9yfKNVgS+9Midm+gCfmd9E
	/7fIYf286RDfXGZu+AEDdbeAIyDKcCsBXcdsVK5FCDzTdyTLIH2CunUN9/6hxSYX9dL5oy+R+nPz0
	b5J26E8wxaC9brrU3qhyE0n7yobX5SJz2H6MHhSQv8z5QLCsCsilWlumoDbju8oU0khSLi3wCg1W1
	hzgfmB5BgrFw95alhgTFgBJuJnQVGs8gwnrBYuGAjksxPBKmi9+iu/tJ+WvjdI/89CfE43CdcmWWq
	X8+CppWN0NBH4FKXycWJrn5CNRNyyUAiK7eJvxYBAZ228yNiy/UM3FJkGinaP/SD50hb2dvsXG95m
	5/6iqFYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd7Tq-0000000BSBS-3y72;
	Fri, 26 Jun 2026 14:24:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd7Tn-0000000BSB4-3VIp
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 14:24:29 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIWUH2920246;
	Fri, 26 Jun 2026 14:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NYYIYo
	vBck7UDc5uLG/RSmoG1q9+IFKkb38GwdD3t5w=; b=rSLpRLAFbRsJjAxDSrR8CT
	SJ4tQ/0tu8QqPKmlsO8MbojC3f1P+84EV/VT4Uhd0lN0FzwvmKsZ0/M+p16EYelh
	JzDSPj9ev176+JqyizzYl7Pm258OyHFt71z+2o+ptBuC8UO6Rv+dHrONKZxozbnF
	JmJoU96j6KqI8B9cM2Z6eC1KgpVWD2tFXM0/VhIqF0PPa5jId6cT2z64kEDKM9bZ
	yUALJGt7/k8TQf8Uqht7/rFumBbfy5LbyzBhABCi61s+tJrqf4llveeQpxaZvjYh
	ahy2NoAEV7/byfUleNER1mpyJKWiONf1HP1UVDIE8I1W0lc3taQ1H8RMGTQLFOZA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr7b4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 14:24:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QEJeSx024768;
	Fri, 26 Jun 2026 14:24:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qunv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 14:24:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QEOG2665077580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 14:24:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB36358059;
	Fri, 26 Jun 2026 14:24:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A55E58058;
	Fri, 26 Jun 2026 14:24:13 +0000 (GMT)
Received: from [9.43.54.234] (unknown [9.43.54.234])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 14:24:13 +0000 (GMT)
Message-ID: <da665639-97ea-433c-9b10-46a0ad929a06@linux.ibm.com>
Date: Fri, 26 Jun 2026 19:54:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 04/17] nvme: add Clang context annotations for
 nvme_ns_head::requeue_list
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-5-nilay@linux.ibm.com>
 <20260626063738.GD10731@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260626063738.GD10731@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3e8b93 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=QYz6wX4XndNIOmzJYU4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDExOCBTYWx0ZWRfX/3PZy4O2i4YB
 fCBQ7g2DrQa/0+KCaSzdAPqWk8TOsR8CvCOEecxRjRomkrMtrj+craVJ/vMyq1iZPEqXs0aHP0b
 Pm/dxyYxEIWPXpYakyYa9V6toMHInfTSbbekqixKkEmU2VX4NcNxsEyXdP+BCG12NPTHN++KmPd
 nKqARS9vTLUiq3RU2koG1vIKajaf9n80VRtDBDLGg5W3dIm6UYdB8vkBRqxt9OIZESJ7M93YbZS
 G+OS8/eq0KrJtXt46LzTTm+5h9PjAhU61aGR3ZNKGFIrUfRLBU+wFcE2gnwWc8+8mdE81KHW6O5
 RCK1bJ+8w799rGXr+A1UfZEQQUDbhTNxziqoywhmYkJffmlOqReW4FLukBdYtN155jj4sX3/j73
 5/vKTGynRd7bYDX1e5Mct8Js8tEMhTmvfMHJM+QOGnnGab9nUIpltjLU5JeFthKG2R1gv5uIlTP
 68yAkC9TzpymkMnxRrg==
X-Proofpoint-GUID: FcbRUJVkMcE9AM29jiN1JheW8o7RPZxO
X-Proofpoint-ORIG-GUID: hENgio2651hcLjrAZD6xN6AynR9oS6zE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDExOCBTYWx0ZWRfX9q1EVVoS4/gD
 MTRaEdWCqR4StqcQ9oA/KFRdTNp5UMThDT7nNOA/3M2cciNFasNu9xVinVoOOdHgDnvzRbUOIeH
 IidgKbjIxzSChDjAV8+9LXcLyLOEzdQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_072427_880871_64625082 
X-CRM114-Status: GOOD (  15.99  )
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

On 6/26/26 12:07 PM, Christoph Hellwig wrote:
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index a275c03e7c59..9e7f12fe8cd6 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -706,8 +706,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>   	struct queue_limits lim;
>>   
>>   	mutex_init(&head->lock);
>> -	bio_list_init(&head->requeue_list);
>> -	spin_lock_init(&head->requeue_lock);
>> +	scoped_guard(spinlock_init, &head->requeue_lock)
>> +		bio_list_init(&head->requeue_list);
> 
> We had that discussion before, but this kind of annotation is just
> idiotic :(
> 
Personally, I am also not a big fan of scoped_gurad(...) and friends...

> We really to be able to just initialize fields without annotations
> before they are first published.  Now bio_list_init is actually a no-op
> on a zero-allocated structure, so we could just drop it here, but this
> is a more general problem.
> 
Yes this one could be avoided by removing bio_list_init() here.
Will update this in next patchset.

Thanks,
--Nilay

