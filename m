Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4877ECD6F0
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yrxxGilDMwdKecEC6njTMZ6elyG5VacJkYCjOMznoJ4=; b=asm44+HuTU0BVl5yo5V8SULik8
	wda5KraXpZ4x2gWD6LPsXgNxf/Cp4dQmHcSCKA2WyojvkOFQRSBQbWnXJB+cPq2Axcd/AmIOHQdnX
	6gcHgxHQBzyZ8wBMsMtPlv0PFbpfiYkVnCjdfzVnU4XPpQr2ZN0kQj5qGdOCL6Hin6Tn/73psKEhI
	fMzJ2TNaGor5Z+en5LvwkbufmJhfs/Ea5qTAKo1AS6KOCqSXwvoCyCxhpPODZqlKk7w1CDRvP+RuO
	ayEWYopKdLIIA5jw8x+vDLSI0tKsufOaCgnAi9Chn4rOLIEAMVjcwjbZYBAcmUUDE5FZsgpxbeSlO
	t/RrHtFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqSLX-00000001m9S-2mym;
	Thu, 12 Feb 2026 08:46:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqSLT-00000001m8X-2ijZ
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 08:46:44 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BLYcDo3251931;
	Thu, 12 Feb 2026 08:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yrxxGi
	lDMwdKecEC6njTMZ6elyG5VacJkYCjOMznoJ4=; b=ptFQ/0Pwu2t1UMJZCUvgWj
	jijiyxv8OKfRzFZ9uxlWmTopVEiNCQ24Sr05PObasS34/2QbNuzNJ0WG30j0zAVU
	zooyi+h4IVuR/5QfcrSPygGEUSI/+lyl3IIx6PC2BVoZvMiwfsZFF81ugIhPXTYJ
	Z4KmZa28vIHptUTcr8RRgVw+idye6VSf3c7M2I9+d6TthO72j8bVD/ZfNM5j8ZQX
	x+bLJKT6tA28V+2gjmaTMlPyzLjuKxUPE38B4DGbBGYye4o9HrCGh4o0jAjxmnPB
	5VY2ltCOKyVRxjBYCGbfZ/ymOefQJ5Bg+5w/jOc2JlWjkjJV+SFRPGIa8ygER7Lw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696x2m1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 08:46:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C4ZFsE019251;
	Thu, 12 Feb 2026 08:46:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk9ecd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 08:46:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61C8kBwX30343890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 08:46:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E696558058;
	Thu, 12 Feb 2026 08:46:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD34058057;
	Thu, 12 Feb 2026 08:46:04 +0000 (GMT)
Received: from [9.109.198.221] (unknown [9.109.198.221])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 08:46:04 +0000 (GMT)
Message-ID: <88a12e1c-05b6-44de-806e-06a8e2ff7c0a@linux.ibm.com>
Date: Thu, 12 Feb 2026 14:16:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
To: Yu Kuai <yukuai@fnnas.com>, Jens Axboe <axboe@kernel.dk>,
        ming.lei@redhat.com, hch@lst.de, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260212080135.1673063-1-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260212080135.1673063-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698d9354 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Ehe4v0DnxFvcZGR6RwMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tws8dfR-xQ1APSIwtfGH58Wd5tW-sV6e
X-Proofpoint-ORIG-GUID: tws8dfR-xQ1APSIwtfGH58Wd5tW-sV6e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA2MCBTYWx0ZWRfXwFWDSSGQ0KwY
 QGMWnMr0BWba2MugJVDt3dOhMDuZQ8zihMvJZm016CrD3nQlon9o8X0CxlXw8uXlKfnZoT0ExEK
 xMRjEx0K8YgsPnzsbQg3F/jYvgXN0bL2Q+Y3uSwX1XC3R4HBRujZGkO0LKvAxa4s1e5c7hC8Adp
 KRSXLy9NK61y/tJ5CurZcwbLaXKZbzoSfEut4xj22Wrf3kKrHHyn7V1buDbjzI6/tq6LRX+k2MR
 +XfiKrhEYuxbNfXof4Iq/3BwjKVD35XlbqeuiFCpgg5+iF0a42yfoQnaXgH8KG4bEBeXif0YShc
 7X6VAduefbm4d8Vz6gztYj1XJSzYCnNwkiRkWy+7ByMVzV3Owd1gFZG+/AlQd3IvBC+6USfh4aC
 TP3WGRotVkyh71tDIJFR1iTtF29WCVh1Bff4zsYDKuc0VDdc5s6g6TekMtdxYDkAWcH9ui3xAi0
 iCqh8eBPgbQPLlfZkXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_004643_811581_7E35F1E9 
X-CRM114-Status: GOOD (  17.91  )
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



On 2/12/26 1:31 PM, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
> 
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.
> 
> Introduce blk_debugfs_mutex_lock()/blk_debugfs_mutex_unlock() helpers
> that combine the debugfs_mutex with memalloc_noio_save()/restore() to
> prevent fs reclaim from triggering block I/O. Replace all raw
> debugfs_mutex lock/unlock pairs with these helpers.

It looks like there are still a few places where ->debugfs_mutex is
taken but the code paths do not enter fs-reclaim. For those cases,
it may not be necessary to wrap the critical section in a NOIO context.

Perhaps it would make sense to provide two separate helper APIs: one
that acquires ->debugfs_mutex and also saves/restores the NOIO context
(using memalloc_noio_save()/restore()), and another that simply acquires
and releases ->debugfs_mutex without entering NOIO. Callers could then 
choose the appropriate helper depending on whether the code path may
trigger fs-reclaim. 

For reference, 
blk_mq_freeze_queue()/blk_mq_unfreeze_queue() vs
blk_mq_freeze_queue_nomemsave()/blk_mq_unfreeze_queue_nomemrestore()

Thanks,
--Nilay

