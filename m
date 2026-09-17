Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F12C88E72
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 04:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CfyHM9UDN9yu1RBkKhLZ3nd5rwjAaA9P1LOEdUVCkHA=; b=ubiopVztVrKQiLNX9mY/PXXVGO
	a65co8C017wJqVDv8t2hirsAKZVF80KOFeOCC6YJ7kyV7/0kN/+6ScrB6s5XCMVD5fAKgC96S6gxy
	PPs5GnLiUSUmXcAUD5YkFyRPjA5vDEb9fzL/hv5P1wzBHLPVNU+UGyETV48igjU2F+3HWwKEVpH1C
	q7WUIbAVUomJfz5rr09Sfe2EETXCjlmr5nvhPALLzbF+L7llwMXoPN/+3Il4eYVqx1zn2DijyMyzH
	rf08taD17QmJUGIccsUP+pbq+YnBOPVabwftqZxlh3drisCjkDFXdMPHxoOs13N5Yuee+TGmJuoPM
	JsYV9rFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x73Wn-0000000AYke-1hD0;
	Thu, 17 Sep 2026 04:15:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x73Wk-0000000AYkI-1Pfb
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 04:15:15 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1iYC3041587;
	Thu, 17 Sep 2026 04:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CfyHM9
	UDN9yu1RBkKhLZ3nd5rwjAaA9P1LOEdUVCkHA=; b=qq5uxD6SCDLZoVi4xmXTjX
	eCcGdD0m9g9tmbgYaKHYGMpYOiJ+ZrysYdTTBy46P+7P46xXo7HF7cqxp/kwrccX
	I8zR1S6TCm6h4VRJZ0rK+nkvha18hur8cgz2lnKHEUzm0uyo6LymaNefpgnFxUNx
	f2dUBqlr7z//4uBhRU0JLPSc2u6MZrblU76YY+pkaW49X7lODstgEsm5tHKdB5Fy
	TgRio+2vx2VdhvZ4pgw4YSekgzCIVg1BU29loC7H/uRHCOOH0tVtrCCI0L2TPn/I
	QYgVSi1MCXx9qQvCrcqRLdLyn8ZaOfZLli78wx+706Tye/AMI75GRWIOdM6HeVHw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e7xwc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 04:14:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H41Uct1712957;
	Thu, 17 Sep 2026 04:14:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywf1shf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 04:14:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H4EuCr20841008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 04:14:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0EF55805A;
	Thu, 17 Sep 2026 04:14:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA85458054;
	Thu, 17 Sep 2026 04:14:52 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 04:14:52 +0000 (GMT)
Message-ID: <1b36e312-222b-4052-8a8c-0583c908ea19@linux.ibm.com>
Date: Thu, 17 Sep 2026 09:44:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: work around -Wformat-security warning
To: Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Maurizio Lombardi <mlombard@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        "Martin K. Petersen" <mkp@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260916114533.237863-1-arnd@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260916114533.237863-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA0OCBTYWx0ZWRfX+jwI1UAiFUKC
 bZGMy4HDwhgHsMTpEjVu7CnqSgR/UcWVVAv0LAJ/yj3RDD5gzYIHyqCZxm9OMdFMBxeQnmEBlcS
 2DTkPUfddrwbaPVwnxhMxoj9yRAWJbo1Bx4LAg+HG2etwCj3mzYEqPJkq/2uGj/uKBMMqnleyOV
 k89j9Cm2kIC8ytF5/VKXs+D3jWZx7B6IM/yU0cj+cofsgwM7vecbob3f0KXMzbtWXvmxBANHMZJ
 8iziJ6IM3e1AknoWUcPJuKgnqmYAd/rd1oubkZHaStLXpfHafTSN9yL44hMjUgjDbl2vASo7RcW
 zG89Xuio6jQ/wUvOnlR1miH7VusVpe1l4HS/9XaEtrSDiB8PNvMVk0sD1EE0lHqJrmY6kHYN3w8
 yjWlDlto+1ds9ARFbZ8GoVvzZs/ZpopHO8wlhaIly8Iczw6bvjLClKCnKUwuveB9FeRQKrPiaYi
 PdQJhrEqZqCBx8ga+Hw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab6942 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=6V3HVOWhoI-O6267OnMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eevnxZpdkAC0SXi4f5JCv3omkCwXd3r8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA0OCBTYWx0ZWRfX7b5p4SvaJ3WU
 WsGi4pv24ItoSGcdTY4z4B7Cg4ooxzK1IEpYvSu0WYWTNOk2Xmior1Lza+5yDGtCnJeHv8J1PIH
 Hsy70tn/Lg/JtYhwAf4PkgkAffMVKUs=
X-Proofpoint-GUID: eevnxZpdkAC0SXi4f5JCv3omkCwXd3r8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_211514_496780_A97D4641 
X-CRM114-Status: GOOD (  15.28  )
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

On 9/16/26 5:14 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
> 
> Passing a string variable into dev_set_name() causes a warning
> when building with -Wformat-security enabled:
> 
> drivers/nvme/host/core.c: In function 'nvme_cdev_add':
> drivers/nvme/host/core.c:3911:9: error: format not a string literal and no format arguments [-Werror=format-security]
>   3911 |         ret = dev_set_name(cdev_device, name);
> 
> Remove the temporary strings and let dev_set_name() do the
> same thing internally.
> 
> Fixes: 26acdaa357cd ("nvme: fix crash and memory leak during invalid cdev teardown")
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>

The changes look good. However, I applied the patch and built
drivers/nvme/ with -Wformat-security, and I still see a couple of
additional warnings:

$ make M=drivers/nvme/ KCFLAGS="-Wformat-security"
make[1]: Entering directory '/home/nilay/Development/linux-x86/drivers/nvme'
[...]
host/sysfs.c: In function ‘cntrltype_show’:
host/sysfs.c:682:9: error: format not a string literal and no format arguments [-Werror=format-security]
   682 |         return sysfs_emit(buf, type[ctrl->cntrltype]);
       |         ^~~~~~
host/sysfs.c: In function ‘dctype_show’:
host/sysfs.c:699:9: error: format not a string literal and no format arguments [-Werror=format-security]
   699 |         return sysfs_emit(buf, type[ctrl->dctype]);
       |         ^~~~~~

I think that if we're fixing -Wformat-security warnings in the NVMe
driver, it would be useful to address above warnings as part of this
patch as well.

Thanks,
--Nilay

