Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BDAC982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1q5K/cLZjXRg42bG+JnMzvgjsxp2z9Tt9ZXqU6p1qHI=; b=Q/FQc2JnQLrv0RRAPZx+Cqoyvx
	pmhvxpmkhG4DJl58HP1U87FYBhy6tJf8pPMl8v0KPzb+uEKki3m8RPa+fdpZk4uGuzXjKI0wnJobY
	mLXpUxLwneByPKZL2GctHNxBX274uS1ryX5o5qOBf6aUcqg/JuB600yflweVNPpbjGYsFT3JQ94Ne
	hCJYuY5yf2+mf2MXmTEoYcpJVgUsKuIVPMUvlmKIJ57ma1tjXWMGpIc+FX6qIC19KXskPeRtH6baT
	75684mXO1gEAqkKtPpvRrpnQVy2Q60O6rlGVZ1LUeIBxRg8W1HvIhQvTB9n8bHBfEJ/xWuF0KPNzt
	VTkjzhVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x92VQ-00000005rDV-26UL;
	Tue, 22 Sep 2026 15:34:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x92VN-00000005rBr-1nVJ
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 15:34:03 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MF5cTa588419;
	Tue, 22 Sep 2026 15:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1q5K/c
	LZjXRg42bG+JnMzvgjsxp2z9Tt9ZXqU6p1qHI=; b=jXsVx8gJPvlo83hVfdZnB0
	2/MCney1NhimQ5PxfMnbaB0aP6xiFys6v5N3Ytq0sTk91BYVvHo8WrZOEnOVr757
	kDdKu1o7mWXZlhl2yZJH2TbkpA5QZrbWzEHPW44YIFjtwGBWour2e+ILYXSoD8K2
	2QW9k7DcRBDP+DY4Byv/7Jl8lIzAfr1MHw9veY4OxxYqYhxo7wOX06aqNtaZL1/o
	DfX/1BSkBUVMuEoFyMqAquGBKAR2/u7FMhOkC9oKaLyPFsTei1OBUgRxXN/9pFwn
	o/gY8wB6WATsVHXjtAzf/fEhrk9vW7Yd4Keu/YDhiycAVjzEFJZkL7x+DRlJ/grA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1ec24-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 15:33:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MElYut2988032;
	Tue, 22 Sep 2026 15:33:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vjgjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 15:33:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MFXiNp29295142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 15:33:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F03575804E;
	Tue, 22 Sep 2026 15:33:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 439475803F;
	Tue, 22 Sep 2026 15:33:40 +0000 (GMT)
Received: from [9.61.143.235] (unknown [9.61.143.235])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 15:33:39 +0000 (GMT)
Message-ID: <fe4e7f28-14ec-4b8f-81f8-d230569cbdad@linux.ibm.com>
Date: Tue, 22 Sep 2026 21:03:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
From: Nilay Shroff <nilay@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Jens Axboe <axboe@kernel.dk>, john.g.garry@oracle.com,
        wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com> <20260902133104.GA20945@lst.de>
 <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com>
 <20260902141347.GA24385@lst.de>
 <61165430-a724-40d3-a00d-2cbe1ea656b0@linux.ibm.com>
 <57629796-d346-4cc4-8c9c-b153a60e1709@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <57629796-d346-4cc4-8c9c-b153a60e1709@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kFBjXS4CSfRMpNEojaEDg3_ROwQ4t63Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIyMCBTYWx0ZWRfX/y7/jmwuKZOR
 dx4wYc7ncpi/NrnYRa55jdppXUHEYqB9LWy1HtFtWFglAfmxvEF+1ao5rmCwORAN04y4WYGfZJ0
 3/McXoQcQf41xwyvU/GwjbGw77qyUpwf/2YBfrWjQrwi2Y16zyltwi81D4d89NWA/duVT1bM8R5
 6wJv7iG9UynAVaNGVYUmLX6PTg29K/VvylOiGnTGwDVtRzYgdQKH2MdfgJfOzhUlf9I794Dfuqw
 t2Sa/bTlr73Yh86Eo2uEqerjmKM4EqVSnIIfjQbtQLr5Cfgi3+UeSpImHR872uhVO1/cSmbnEH5
 YC6d8r7Q/JINrgCsEOPA/lvuDQIDXuSSIXR6mBYvc57HCXyjBBZOM+He7uU7FyuPOjHWZeQn7eJ
 UApE2jmrFIYRHAehFlCQO0Um3JVA/jPvVskLaQhWz/jmXcAffrXJ7AGKW2t0vEduFU619+AKwGr
 VNFk9joZaqHfT2kzkQA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab29fd9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EYdalptScvJjkWXT3cgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIyMCBTYWx0ZWRfX5WA2n7ZmB6zs
 VRhjTZ97Myh8OxU1FEfN7Ka7o+NPSQXhj+nrtS597y/XhBl9SxkF1jFW2gF8MjYtMXEep/GB+lV
 SyMSISRSR4GLPQ14M4xc2HR9rY0yzlk=
X-Proofpoint-GUID: kFBjXS4CSfRMpNEojaEDg3_ROwQ4t63Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220220
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_083401_597895_1FCCF2C6 
X-CRM114-Status: GOOD (  20.55  )
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

Hi Christoph, Keith

A gent ping on this one...
Do you have any further comment/feedback on this one?

Thanks,
--Nilay
> On 9/2/26 7:57 PM, Nilay Shroff wrote:
>> On 9/2/26 7:43 PM, Christoph Hellwig wrote:
>>> On Wed, Sep 02, 2026 at 07:39:32PM +0530, Nilay Shroff wrote:
>>>> So the practical problem is that an open multipath head can continue to
>>>> be used after its underlying transport module has been unloaded. The
>>>> proposed change keeps the transport module referenced while the head
>>>> node is open, preventing the module from being unloaded in this
>>>> scenario.
>>>
>>> But why do you unload it in the first place?
>>>
>> Well, in my view, unloading a module while it is not in use should be a legitimate operation.
>>
>> In the example shown earlier, the NVMe transport module is still being
>> used by the open multipath head. Shouldn't we explicitly reflect that by
>> incrementing its module refcount? We don't explicitly unload the module
>> as part of normal NVMe operation, but in theory I think the transport module
>> should remain referenced for as long as it is being used. That would also
>> prohibit user from unloading module by mistake.
>>
>> Thanks,
>> --Nilay
> 


