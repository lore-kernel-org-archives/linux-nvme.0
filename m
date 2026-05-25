Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6599DCD5BB1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLfc5lsOUQn26mIH7OBc9dIIv+6p/xPjua5NdkPP4C4=; b=VWt13lotVFWczJyG6NBqHEBr+M
	/wpDzLwYWBVvX426ZwHzbmIJHU+8U3jEALsSKm6fa8Yr5sVt1nC8LKRiJtBN7XNRqMDhULHigQs8f
	Wwr/QkC+yENa1FMUJMF7TMCD7uBeXddLG9PhZa+mOrfh2exHA3/YEXqvd7YWS0SOGt6j95PcaMwnO
	Wjo816CXZDdhLk7taEXAAsUYww2sh9rtHhygSo/uU2eRyIXVcMTz9wKPnBPDe5MBnLVDOI9nj4qYX
	rqn0S/Y1bL+AOHuXtjs3HMATe3+coSQcPCJujvUSdx3vPMuCG1SQ4WW4K/nW4JTQQ3Wh2fDewkwdF
	ShjoDBzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRUfP-0000000HDKn-3CY4;
	Mon, 25 May 2026 12:44:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRUfN-0000000HDKA-0w3e
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 12:44:22 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ONgSsb2382361;
	Mon, 25 May 2026 12:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FLfc5l
	sOUQn26mIH7OBc9dIIv+6p/xPjua5NdkPP4C4=; b=NCjBnOXkgiANDjVmK1a51b
	BMeADVTiSF/ak7JAiPpgSZCx32w35HjAhcNS/BEIxFhP39n1nNpCC4qiWK+jW/8M
	v1RBfqEL4b5K9ZVz+px2kSPrVEzyinRRU81pbetcD1si+Myw2WFI3iRZEdEP22PL
	hOnsAFv11xmj8IhX+qKZWAcUxeuIjDQ0LV6kTW5+3lyLycQk3eqZ1LoKBwriw7if
	gx63B/MBMwruCleGg3z1ZccPFyuXIXrMZ5cV8MShKHc8y8/YP6IqKNiazeuCNiJo
	w1PPKtbj+jymy1CrDtHMKFTlK+oLFmy3QARNgYaaRlO5EroZ8l4cwwFYJOT6Sf1Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pd714a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:44:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PCd9pB009659;
	Mon, 25 May 2026 12:44:18 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjn5gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:44:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64PCiISe6226722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 12:44:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2369658066;
	Mon, 25 May 2026 12:44:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0D8C5806B;
	Mon, 25 May 2026 12:44:15 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 May 2026 12:44:15 +0000 (GMT)
Message-ID: <c4ddc101-184a-4e4f-82ca-c3123bce5e34@linux.ibm.com>
Date: Mon, 25 May 2026 18:14:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v7.1-rc1 kernel
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        nbd@other.debian.org, linux-rdma@vger.kernel.org
References: <afB5syZbUrppgsDQ@shinmob>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <afB5syZbUrppgsDQ@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a144423 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=vQOCgV4Tn3I5ADnQ9CsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: su5EMVMOaRWSafhMkHwr0dqrOxF_KKYG
X-Proofpoint-ORIG-GUID: su5EMVMOaRWSafhMkHwr0dqrOxF_KKYG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzMCBTYWx0ZWRfX7KdBxysjR5ob
 NJF8wt+/+HOBMD7PKjevk32JZS9FYVRv4r7O13KWb6jYCFJExOATyxbiNMRnmzez2dNBFPFb45L
 50nCrVcurQlxau8wLvlZlqpHzduQuwZvsbQANJtrGkslTUWclzqknzfOvtG8/eSUqwab2UgpJY3
 dZtqSFEYyIOK5dAw3x9k8xMQl68+/vhjBaR0/N2nubzIWOOqG3q0CqdF5yOaTc0Ajavb2Iv52c2
 BwvqoC1s0uAYYGYMulvC+rfvMCkwIAEQAryMYCulDd7p2Pi6pulwFqYXbQdDSSkZnFVEiKcG9NQ
 Yr9eNe+OvDag0wPc1P1QmaJh00JGyeotBy+x+A0Kj1ygKmt8nAD4kLtY6BDhHk4vao9YrYigg8f
 YKODN7UVkJT8FshAZC7pl5ENn1YXP7JDHyPGv/keChXjsLg+Al0kyN1xS6VSqBWm1fh2an/fRJF
 TkLTIUfrUVmdkccOdMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_054421_391016_192D4F5B 
X-CRM114-Status: GOOD (  24.31  )
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

hi Shinichiro,

On 4/28/26 2:43 PM, Shin'ichiro Kawasaki wrote:
> Hi all,
> 
> I ran the latest blktests (git hash: ea5472c1adc8) with the v7.1-rc1 kernel. I
> observed 8 failures listed below. Comparing with the previous report for the
> v7.0 kernel [1], 2 failures are new (nvme/045, scsi/002). Your actions for fix
> will be welcomed as always.
> 
> [1]https://lore.kernel.org/linux-block/aeCDXI5hY_ivSWm4@shinmob/
> 
> 
> List of failures
> ================
> #1: nvme/005,063 (tcp transport)
> #2: nvme/045 (new)(kmemleak)
> #3: nvme/058 (fc transport)(hang)(kmemleak)
> #4: nvme/060
> #5: nvme/061 (rdma transport, siw driver)(kmemleak)
> #6: nvme/061 (fc transport)
> #7: nbd/002
> #8: scsi/002 (new)
> 
> 
> Failure description
> ===================
> 
> #1: nvme/005,063 (tcp transport)
> 
>      The test cases nvme/005 and 063 fail for tcp transport due to the lockdep
>      WARN related to the three locks q->q_usage_counter, q->elevator_lock and
>      set->srcu. The failure was reported first time for nvme/063 and v6.16-rc1
>      kernel [2].
> 
>      Chaitanya provided a fix patch (thanks!), and it is queued for v7.1-rcX tags
>      [3]. However, nvme/005 and 063 still fail even when I apply the fix patch to
>      v7.1-rc1 kernel. The call traces of the lockdep WARN are different between
>      "v7.1-rc1" kernel [4] and "v7.1-rc1+the fix patch" kernel [5]. I guess that
>      there exist two lockdep problems with similar symptoms and patch [3] fixed
>      one of them. I guess that still one problem is left.
> 
>      [2]https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>      [3]https://lore.kernel.org/all/20260413171628.6204-1-kch@nvidia.com/


I looked into this lockdep warning, and it seems that Chaitanya's patch indeed fixes the
original issue reported in [4]. However, the new warning reported in [5] appears to be a
separate lockdep splat and, from what I can tell, likely a false positive. There are two
reasons why I think so:

1. The lockdep report suggests that thread #1 is sending data over a TCP socket while
    another thread #2 is still in the process of establishing that same socket connection.
    In practice, this should not be possible because request dispatch over the socket can
    only happen after the connection setup has completed successfully.

2. The warning also suggests that while thread #0 is deleting the gendisk and unregistering
    the corresponding request queue, another thread #5 is concurrently attempting to change
    the queue elevator. However, once gendisk deletion starts, elevator switching is already
    inhibited for that queue (see disable_elv_switch()), so the reported locking scenario
    should not be reachable in practice.

Based on the above, I suspect this is a lockdep false positive caused by dependency tracking
across different queue/socket lifecycle phases. We may need to suppress lock dependency tracking
in some of these paths to avoid the false warning.

Thanks,
--Nilay




