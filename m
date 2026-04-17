Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB24F43698
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+FT2W5yYh4xh00GxJg1EeuW2XmXiJG4+bYu9qwac8tU=; b=KVaLHVoKLmWvNRFCBjfRQKc4ex
	7I2nlQXdQgTq9jLG6ZKddFkuuHHx02Tggg0300OZBD1lz7gxoUV/PFEcryygFX4RJPTfXex8CWsL9
	7fyWzyXzA+l9qk83fPzLk/6jEqvoKmnU5Qyro8padV65CyxJiqfBMZQk4K4JUtOn3RwRIayQOahwl
	xGzfYn6RAV7+id+43a68O0MI9ZHf2J7eeHyhMLd1fd7StZKezasN1apAzCeaaV0k8fYAULKY0LxMa
	lMS3k7X0cyO7nobEJ0Gq/2Wd19zmAebBxnYuFkJ0/t0cVk2EMqqx0uK29Hnt5ZtQRKVNv0HKsPRKa
	sqXFm8SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDiQx-000000042kY-0Drx;
	Fri, 17 Apr 2026 12:36:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDiQu-000000042kE-40W1
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 12:36:30 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HAOUDE1285416;
	Fri, 17 Apr 2026 12:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+FT2W5
	yYh4xh00GxJg1EeuW2XmXiJG4+bYu9qwac8tU=; b=dydnd1aeohn8JYgqJBlBmB
	82WG9GqU2eHg74eUQ9F4PphjpUyCttrcJQoW9wGXEK8TiIgrjCpmKmssXoxjwZnL
	SKTeiJbV8iGmuePdOib0fMlnFhcn8Lj1/vjeSnCj6kYwrNz8knOlXJrSRXOosGyX
	q2aRZsw4EG4/RcjCMcW6RJXFrcTX7NoujBwtQlFEdBHMcCXWYAXSMkk8gN70ndG1
	HfN6W/NjS9na9ixqxw0AhFKa8TJjTT6wBcpUxHfrGaVlRSciMn9N5I8LSUIgHx6E
	PZVKeDmeGTvk7bpQqrWkF9TSCojMqJ6qH6t9wgmQviuUT++4gCXB4ULMiwL4bZEw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89khaf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 12:36:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H8UOaR025862;
	Fri, 17 Apr 2026 12:36:26 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujy0fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 12:36:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HCaPRc28967462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 12:36:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E9F358057;
	Fri, 17 Apr 2026 12:36:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69E4558058;
	Fri, 17 Apr 2026 12:36:23 +0000 (GMT)
Received: from [9.124.218.191] (unknown [9.124.218.191])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 12:36:23 +0000 (GMT)
Message-ID: <7009b70f-bc19-4034-9426-2b94522afcbd@linux.ibm.com>
Date: Fri, 17 Apr 2026 18:06:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] nvme/068: add a test for multipath delayed
 removal
To: John Garry <john.g.garry@oracle.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com
References: <20260417094854.2135472-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260417094854.2135472-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UTYyiHuSLvEGyYe10GSWWW4hDNCap6Si
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyNCBTYWx0ZWRfX0Z68G0Yhgoze
 bNfeJ0+gHQxXc4mGF3KSFIHdV7ESBRFktGCoFUS1nktNgmtnBpcZQdgrjcpAMdie22uxGEAC13o
 s22UNzN9bluy7QfYNccQuA4/ogkzizZnIrIXePN7bavc5skXS9rpYZ80E6U7EL5nV+YfvZcdA4k
 lwxodXxhWTEfbnZ23Q/gj85RjbZryBsqJ1lD3E6OOHaR0EfcH/ru7gHyM/hAm7Tw8OOCuVLKjzv
 qFxYy8Pv+JVHC+wfJGYdQw38Rxk96fPMK9jrqqdKA3o/Uzd1Qfwar4EHuzLDk+nYtwfPxfEIqTc
 fKbXGkOw3t6xjeRTdaSpDnIcxPYFRgT8vHPK8izoPe2mMgQEdZh/Q3jGPdwhdg3X/2FDeIO4u1G
 kWr3OapAXnin/uTjZlWm4nPyDQHNVVp1BMFYkrIiTue8HBGyeS0T/WACb4D36RrE6CwtDW1H+gS
 r2CBCWXyCPTtpw6TmIg==
X-Proofpoint-ORIG-GUID: UTYyiHuSLvEGyYe10GSWWW4hDNCap6Si
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e2294a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=vFfYFJvREM-Gq1xf8H4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_053629_143009_530DDB74 
X-CRM114-Status: GOOD (  20.09  )
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

On 4/17/26 3:18 PM, John Garry wrote:
> For NVMe multipath, the delayed removal feature allows the multipath
> gendisk to remain present when all available paths are gone. The purpose of
> this feature is to ensure that we keep the gendisk for intermittent path
> failures.
> 
> The delayed removal works on a timer - when all paths are gone, a timer is
> kicked off; once the timer expires and no paths have returned, the gendisk
> is removed.
> 
> When all paths are gone and the gendisk is still present, all reads and
> writes to the disk are queued. If a path returns before the timer
> expiration, the timer canceled and the queued IO is submitted;
> otherwise they fail when the timer expires.
> 
> This testcase covers two scenarios in separate parts:
> a. test that IOs submitted after all paths are removed (and do not return)
>     fail
> b. test that IOs submitted between all paths removed and a path
>     returning succeed
> 
> During the period of the timer being active, it must be ensured that the
> nvme-core module is not removed. Otherwise the driver may not be present
> to handle the timeout expiry. The kernel ensures this by taking a
> reference to the module. Ideally, we would try to remove the module during
> this test to prove that this is not possible (and the kernel behaves as
> expected), but that module will probably not be removable anyway due to
> many references. To test this feature, check that the refcount of the
> nvme-core module is incremented when the delayed timer is active.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

