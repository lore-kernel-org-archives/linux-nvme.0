Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246C8CD98C6
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2026 04:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y1PNvJbIKEkFK0Bbu1SA8b5XSidGGabdppPvcrsnmRE=; b=Emx922QOHqGjN/Bkp4WDwOm69b
	o1WkgwZCXGY3HpCHMWbjAwo9Aj4UdGjbTI5MI8Y0gSE61ZdAydAeMsYTmC1nxMlnmSn4sR1q2VURX
	xgXO8u79NfdP13PYMO8XTuuqvZmkqDTS0yfURz1VAVFDmGVmTCdbUnw56e9G3fQEkdkV2BuDj/mUf
	5tFPyEJq+721HG64W/3677W8VgD6g06wiz6YYXbtt4ZUgiYwpP3qm4A7xUWP6LJw3R2H2nTU6pFzn
	SlWmpRKFvB+/8vUk/q9viZ+PgqCb8ssJc8CcALb9v/5zL7d7knwQsJC+npe+25dhVCm6JoENYEc96
	TdJwSxvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXXCt-00000008gO9-3iG4;
	Thu, 11 Jun 2026 04:39:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXXCr-00000008gNo-03dN
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jun 2026 04:39:54 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu59K3872855;
	Thu, 11 Jun 2026 04:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y1PNvJ
	bIKEkFK0Bbu1SA8b5XSidGGabdppPvcrsnmRE=; b=RyaHYT8PlyL0viz/W0dOLV
	42Yt734DQQIW+rWFWjGzDacamrcB/RHe2Xr/rYuMS660VSUNU7VHbSnJOILtXXbM
	As08MqdFQcRr+I4f9/fy8t2CK4itxIWxTbr02Y2ctq1b02W+eN2eAI3C/QkLXObv
	77OCw5HKel735as1CjIRBD5IDkH0gwD26xByG8B5ixFysgbuLH7IkkncSD+LKqfG
	zLH9R16lFlnHczTE3stQeeZjjAveJQrIGq4vvZwK5sW2gjrTrIOt+mdLVIM7mUsS
	tt3ixrlkA4RJ3KmHahseuFppEHTMqplZ9aOTVcNxdibIOeRejdAer6oP2HkoDPhA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ese6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:39:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65B4YawP005391;
	Thu, 11 Jun 2026 04:39:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08smpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:39:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65B4dTl942205512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 04:39:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D043F58074;
	Thu, 11 Jun 2026 04:39:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88F0158061;
	Thu, 11 Jun 2026 04:39:25 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 04:39:25 +0000 (GMT)
Message-ID: <088d5750-1123-43d2-9fb4-148775a442de@linux.ibm.com>
Date: Thu, 11 Jun 2026 10:09:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] nvme: add Clang context annotations for
 nvme_subsystems_lock
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-10-nilay@linux.ibm.com>
 <cf0ba660-a96d-4a79-9581-9339551db88e@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <cf0ba660-a96d-4a79-9581-9339551db88e@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX6jEe0vHviLBQ
 wGPhm0CDAIQ/thkQvhh9x5lGC+9oft85ketwU+G56YnElBm54/3O1zSJLkVgqowYx3DnFK3m0dQ
 wZ7CJTHYsAKQnCjgEfSzlUywxR71KQcvCF2kuixzCd8Hw5gSOGteQABF9AQE0U5BeoGxOKqV71R
 +uCcwxVUVMj7UWmklLauPvjTo+ajd5HxdzOfjrIzWjfNGxbEQCfazEFlggrGw/2Vi1YgScUwZKE
 DAVu4zOYynF7o1A8Cgds/7RcyYhP+jg+JvcL+5XtjW/RTu6IR3SDXMk2eHm/h2ERaDx/+Y35TBi
 /eFhwXfwz7Qahki6f25hM7llrZYzSLfWJ4dYclUGQWLoHW/R5m0pRV/NriZRnVgu38mECFhqZec
 9gZqNIL+KyEr0ZQCwiQZP0ovTXRxFggSAZ831Q4kOfrnMOdLnxWAUyAxh2BWkWH1S4pToafP6w1
 +wbK/n7/zpkTaBGSpJA==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2a3c03 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Qw4qUoVrAT-dN4PLDloA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CWUGXhMH82Y9i8NYwpvRAlcZqQnIS7Na
X-Proofpoint-GUID: AlWE0_e5xFgu5sQ2tFC0YSw7hKEbBLtb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX69xWZeTWgGbC
 jqVYF5qk3lz8c6B0TLrA4K2W3o9w58vpwhH82i0QFsD4Eoc0+NsRUpIAaaUOFmRWPHsXguIf/Hv
 qRJEnCOdW7ZcSXIXd7R7uVKYgl/mlYA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_213953_056867_82DE8730 
X-CRM114-Status: GOOD (  11.82  )
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

On 6/10/26 10:00 PM, Bart Van Assche wrote:
> On 6/10/26 7:27 AM, Nilay Shroff wrote:
>> -    INIT_LIST_HEAD(&subsys->ctrls);
>> +    /*
>> +     * Initializing subsys->ctrls list doesn't need to be protected
>> +     * using @nvme_subsystems_lock. So suppress the Clang's warning
>> +     * declaring context_unsafe.
>> +     */
>> +    context_unsafe(INIT_LIST_HEAD(&subsys->ctrls));
> 
> Why context_unsafe() instead of scoped_guard(mutex_init, ...)?
> 
Well, in this case the subsys->ctrls is protected using a mutex
which is defined statically: DEFINE_MUTEX(nvme_subsystems_lock).
So to suppress the compiler warning, used context_unsafe.

Thanks,
--Nilay

