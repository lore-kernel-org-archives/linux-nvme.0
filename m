Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A410C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l2bA7e6+fOPWw9IGmjqip+5jiO2/oenlMgRP9p4idgU=; b=S/BbimQyPD8/lX9n2RaStnjJzY
	b31qGVIoXsZuwwp7RdWXneWr0i5casI+Q+7IYo1xin5m7hE4kG488GlSSNDhtP/a71x1K4R3bo0zU
	0tDHSQM0ZnY+V1tb0rtfhWVak49qzI2KrhA41HYHPD+oxZ3UghLP5n8WAsrXfBIhsPtMDkkxLyVGT
	UM966CmYPxSruA/KDChk8QHNRfF1N8Dg+hYcli4B5VTiDnkNmeZX6YIgcZLMhBkXuJHP9oxyHvvie
	QIghpKGm4N35HOBW8DkQdmosp8q0j3Wk4E55MHXyj9JhHbPpV8snEcYpdZoTKVOIx3tzFKkKw088a
	7y/e5YUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd7ru-0000000BUlO-1yUr;
	Fri, 26 Jun 2026 14:49:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd7rr-0000000BUkh-3Pe9
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 14:49:21 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIcbY2609069;
	Fri, 26 Jun 2026 14:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l2bA7e
	6+fOPWw9IGmjqip+5jiO2/oenlMgRP9p4idgU=; b=N5DDQXD3IqQeBPC88invt+
	QKEkpy5EpP6EuMQlVSF+E5hpr0R0DpZLYlsBDU43cot0hjmwo+UCrvvHYmsbczyZ
	+K6hxURdn4pzgqshG8d1xaGoaBn0pMx1pUMS/Ej1HcDjo6702/8BxEifFczX4slu
	zlNgH2sVXAKEENlPzV2jncZrFVPkri3t0wlnWqyygGLoOarES345uguArFy1KU4v
	mAwFL/1hWY0GdZtkGiFrYn6Yx03tnHtzKQN7VtKNbJOKXLu6l8KHG2cGjVNOs3fT
	gFBd3RfktME0Sx2l3NUJo8K9ot2VPN5FomKrR6XX89T+nZh05C5wnsoIg7E/xYGQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgt712b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 14:49:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QEYiFx007780;
	Fri, 26 Jun 2026 14:49:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66kkj39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 14:49:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QEn0r933817228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 14:49:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 652095805D;
	Fri, 26 Jun 2026 14:49:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1987058057;
	Fri, 26 Jun 2026 14:48:57 +0000 (GMT)
Received: from [9.43.54.234] (unknown [9.43.54.234])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 14:48:56 +0000 (GMT)
Message-ID: <7c841336-72a4-4072-ab26-5f6356f228c9@linux.ibm.com>
Date: Fri, 26 Jun 2026 20:18:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 09/17] nvme: add Clang context annotations for
 nvme_subsystems_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-10-nilay@linux.ibm.com>
 <20260626064528.GI10731@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260626064528.GI10731@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyMiBTYWx0ZWRfX9TxJZZ7AAxMr
 bnOz5vNVJVB0sI0raiu1j8dvhB+OK0Xw6fSZPy1lYJvxQrBtYrP9F2cRFfneP+jpigkkJ+zpyjm
 lRNLDZ1b0A8JL6AUXOGkjPwg+kGbmJsGBfyrrBmYCawiUv3ms8UKnl8c91hwnJ4z1MS4fukpfHd
 dgflWfRC0YvjdD84XBXoX3Hg6GYdwg0h224JWxAPfKlfX2meCef57I4XaK8AK9TVF4qTDYO36bQ
 5/oYUhgZ4bkdAFiHJJPleJGvrg17HVF5F4puj0SVzg6MyWXqwn08uUyOeMtxqsTL9v2LvD3Xzxo
 BjeshtEQ+Gk81cVleVmJ16cwubkCVc7dMnBTNRVu+tmvvzvd848iTk+Rfqe+yih2sB0aQieB9hr
 EB+4kIcQJgpA/vXogtpVcpgv9/6BV1BXStSkWjAQZs9F4yYHJ9euk3iWVOUbVZCgxqUPMVq67er
 Imoxst/V7Agk8Ly/LWg==
X-Proofpoint-GUID: LCx_FXUtNXCEb3ubHPsM9MegjfkoDViM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyMiBTYWx0ZWRfXyIQOK2Qg+AyU
 Dko4+27sDUIYUOO1VtXdcjxFUO//Qvzhfvl2gvKcjY38bOCV+k+Pydw6nobtJDIS+awbE/gHvYj
 HWTcD+1UgroCi8YqDxtHotTQ3QCmHII=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3e915e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=5K5HBGWdcSMPtTgEFkcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1w1INloGNWxNE7zM5Sy6GBGUURag4PM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_074920_016544_81354C95 
X-CRM114-Status: GOOD (  18.18  )
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

On 6/26/26 12:15 PM, Christoph Hellwig wrote:
>> -static LIST_HEAD(nvme_subsystems);
>> +static __guarded_by(&nvme_subsystems_lock) LIST_HEAD(nvme_subsystems);
> 
> Having the guard_by before the LIST_HEAD makes this a real mess to
> read.
> 
> Can we add a
> 
> #define LIST_HEAD_GUARDED(_list, _lock) \
> 	__guarded_by(_lock) LIST_HEAD(_list)
> 
> and use that instead?  And maybe do these after the lock declaration.
> While the compiler doesn't care, that's much easier to follow for
> humans.
> 
Makes sense. Will add this helper macro in next patchset.

>> +	/*
>> +	 * Initializing subsys->ctrls list doesn't need to be protected
>> +	 * using @nvme_subsystems_lock. So suppress the Clang's warning
>> +	 * declaring context_unsafe.
>> +	 */
>> +	context_unsafe(INIT_LIST_HEAD(&subsys->ctrls));
> 
> This could also use a helper.
> 
Maybe INIT_LIST_HEAD_UNSAFE() helper as I suggested in the earlier
message ?

BTW, I think these helpers should be added in include/linux/list.h so
it will be helpful in general for other kernel code as well.

Thanks,
--Nilay

