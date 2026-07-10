Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A36C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AHDsFMi/TGo1n41jN1GI2sFJMmRgrR171764xb7VuCw=; b=u3+fH+jXX6B8BYlfQHFemZmtFR
	kUyO1gsC1/CjC77Jdf9pp/dmYbVkC9f/IRWxizbBXolxANzf8RLDfaho8D5QpDpRD7uJseOP7YDu1
	Uo5YR/n1/KR0fZAN7fn0HBbh3cX0jMzfHoKcDfDHe098j1d//VdNPbLl2phZNBGANbgQnOKHABkDU
	Mp1YCoMeANodoqaxRp4AmKaX1rFNhKBiEAGc54P33x5gTgJ5kyvPCvL85FFOchhnbG8aOmQtRn7J0
	Q39v9SnJNbQfHaur4jMEW0ZLz1DIq2FDGF5NQse2Qe9v0kpqzLGPxepjs3ruSnplXX9bcJtqHI/0B
	cUWfYjdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi6JS-00000004Qh2-1pLC;
	Fri, 10 Jul 2026 08:10:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi6JP-00000004QgS-3dUQ
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 08:10:21 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7mJmd4024913;
	Fri, 10 Jul 2026 08:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AHDsFM
	i/TGo1n41jN1GI2sFJMmRgrR171764xb7VuCw=; b=hPIU5oua6yBQruSoKuY9Xf
	Zd3cGijNN5z9cpPSwM3SgVuK3TfyTtGA3ipXvE6XIb9AReJL5h1jmX2pUnioz3+g
	bHefVLVcQ/R7StpScHQgBDdCakblaDHce0ebkLOyg/ZJGLGc8ERi2YFTupvkdcrD
	CCreVMI8skFxaCcYh01qRtgS5FdWZ1da2Yo7owdySiWInZU0GvQ91ELrH8GIqzYo
	O/gdFhA6l57kIFHkJTvvn8GbEFL2ZVYpkBXZDioIKdRQzd4Am3Ax7DXYpIkHDYJr
	CSVCheGBV2gGagqHmWQQPmLWmNa9wlI2+CHJdivDyXaRGEILHkDqN8p1NfTVv7cg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke5xpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:10:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A84jKw008259;
	Fri, 10 Jul 2026 08:10:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqggv8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:10:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A8A0na22479426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 08:10:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C85DF58062;
	Fri, 10 Jul 2026 08:10:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91F575805E;
	Fri, 10 Jul 2026 08:09:57 +0000 (GMT)
Received: from [9.43.90.92] (unknown [9.43.90.92])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 08:09:57 +0000 (GMT)
Message-ID: <1e72d8d2-ecfb-42c8-9ba4-97cf70f8b70b@linux.ibm.com>
Date: Fri, 10 Jul 2026 13:39:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/18] list: Permit context-unguarded access with
 list_empty_careful()
To: Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        gjoyce@linux.ibm.com
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
 <20260706141452.3008233-15-nilay@linux.ibm.com>
 <20260709063020.GC18056@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709063020.GC18056@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50a8dc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=x7wxYoYxGjGoRpqTYEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfXx4hBz9tNFLxj
 aznqZGnkNINZclQXgTb7gLSdpvcc6BdJ9QgdCcd4wksoihojhUlHcs4hVNqCwksII4g0L2AKt6X
 D0KIuIr+KOtwVXzsNeDLJ/o0e3/IsKVfVdtGzfBqre/hgIbHkP8BaULsmOVIlvRxVI2mp/z9WqL
 mzLZN2qhjbnvAMXrU5FRsKRSqQ+n9tzRR3JuubmzAzklXR3CBF1KTsPlPuYIW5nLV8yTXXJUKgc
 l5brru29EMn/JbPk9MoMgA5iSxD72cEGg1qWxhDPX6/X8R7OCwFphWMa/vNaiGxWajHt420g9QI
 6R5LJmAMDCFGL2y6rCu2UMYf4fe93aqvgGhg30VMAq2+6KuHZj3TrqPEln/2wQo5Vv1k76Pt7Gn
 B/P3fBSLhVJKOD16uD73a8EmcbsEFMOCx2C0Ck6cSJNvUZmX4P8T+F96sjTzv/2/v7ppgSSavEJ
 /nE3z2QdJXhrGDIKwTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfX4A4vqXu+2qpG
 F6i865eOl0YuajISeUFhf1af0C1mIu4GAWQalPjh3/q2R3TkSBpCGzAHVcbk4C6WNxihs6kDUMD
 +JF7e3h+E05MVV4fDZn+My2BaLR02yI=
X-Proofpoint-GUID: uc_WQRERGeJxbc8ensrKpUfVdtxFEloy
X-Proofpoint-ORIG-GUID: 54v5Di_ezg29vN3KkPnvG2giajRKTjT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_011020_029459_AA6B6426 
X-CRM114-Status: GOOD (  18.61  )
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

Hi Marco,

On 7/9/26 12:00 PM, Christoph Hellwig wrote:
> On Mon, Jul 06, 2026 at 07:44:16PM +0530, Nilay Shroff wrote:
>> From: Marco Elver <elver@google.com>
>>
>> With Context Analysis (viz. Clang's Thread Safety Analysis), list_heads
>> that are __guarded_by(..) require holding the appropriate context lock
>> when accessing and manipulating them via the list API. Because Clang's
>> warning diagnostics do not perform inter-procedural analysis, this is
>> enforced by Clang with -Wthread-safety-pointer in the caller at the call
>> boundary; a warning is produced when passing a pointer to a guarded
>> variable without holding the appropriate context locks:
> 
> Same thing here, maybe try to get this to Linus late in the current
> window as it's trivial and makes dependency management much easier.
> 
> If that doesn't work, move it to the front of the series.
> 

Would it be possible for you to send a pull request for Linus directly, or
would it need to go through another maintainer?

If you're able to send it directly, we also have patch 09/18 in this
series that should go to Linus. In that case, I'd suggest including both
patches in the same pull request.

Otherwise, as Christoph suggested, I'll move these patches to the
beginning of the series in the next revision.

Thanks,
--Nilay

