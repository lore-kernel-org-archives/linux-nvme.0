Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF466C88E72
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Oo1fo1jqJrCournTmfafLDQPe+D8ImIPNzwYd5qiWQ=; b=RPnoGdRPiDTuhsS+oGuMPCj6aE
	e4laMT8SVu9WG6OZs8WqDcIRV8vKiLmEPJ3ViEJqpnmT5wbxKlt+o3vpz5VxEM1GOg65uKus80g0I
	+9XsfEnyWP6cPwo+AD9OrkSQFNX5psQfO1Z/nf6N8BUUIp3VM+plxeuIhAfiWVZegdPyBsdY+jFSR
	AdnSZlT7LOZ8yBZ3zL/mpzU3KuFfR9wdNFHx4ZC9d/SZPTOtOYWZ5g0SeieH3zK0agKsmPCdtd02G
	7IxR4kdZF6EUgCApDp0YFQr9H7XOkyvPhSO4/ii5esT3P909oVZ53SqWvaqJfOLPWAcXf1Gjw/5zO
	7PST0juQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67xk-000000041T0-1YzL;
	Mon, 14 Sep 2026 14:47:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67xh-000000041S1-32uy
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 14:47:15 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EETix32306848;
	Mon, 14 Sep 2026 14:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Oo1fo
	1jqJrCournTmfafLDQPe+D8ImIPNzwYd5qiWQ=; b=NSNm+8/N9oOEJb5DHuX97h
	VguSDMuUobSfuYuWVxwQgwedpsawKOU+RRH6ruxH5kawdMNyVTmot7RqYr62Fppl
	hnTrlSrBvIo1yGuPg4ZexU8SxxydHRgwROTEuWMKX7tBEZFn60zWYtgQE93IB1k+
	VrpGdC+kvX3nGPoD1NTl2dEM4b43Jlh4ensWgsm7oT3NnIq/AjrDJdV7yYp6/H7S
	bTkFGCZwJFMg5ut8OmSO2hLQVrLvq9y9TqB5TZb47ke4/w8w+XyY5DllZG2tas/8
	X6F+xE6InPStu3sZhuM/esn5adBJfQsV9QPufpn+RJpFVvGVVimhFPvtm8nIIN1g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4t352-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:47:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED54xr2322566;
	Mon, 14 Sep 2026 14:47:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnhevxpkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:47:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EEkJp112124902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 14:46:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 548DF58055;
	Mon, 14 Sep 2026 14:47:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2AAF58059;
	Mon, 14 Sep 2026 14:46:59 +0000 (GMT)
Received: from [9.61.162.129] (unknown [9.61.162.129])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 14:46:59 +0000 (GMT)
Message-ID: <8629dc8c-f7e0-4a57-bd5e-638a0a65c8f5@linux.ibm.com>
Date: Mon, 14 Sep 2026 20:16:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: delay nvme_tcp_reclassify_socket()
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@opensource.wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
        Eric Dumazet <edumazet@google.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
 <20260914074853.3990397-3-shinichiro.kawasaki@opensource.wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260914074853.3990397-3-shinichiro.kawasaki@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5hx_4yuZUVAp0ICvRkR6MafPBN9tn1qp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX80t01diS6mcN
 YhvKpb1MJLsFetJB8NW1zYRgJD/uk87irhBDUkmT0PzGLcJdZs6UsRhwYKCkKA3X5TbDrvDHYfe
 eET/fJ5Fhl6XTZO2xziE0MJlCU29Pqs=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa808e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8
 a=_PoT7rGSI6KTe0zoyJMA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: kATDHF2VLo3KEnKo6_SJOsTs5TnymuwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX5aJnX6UeOOPD
 rrtY0OnERv5qesjwevMxBeMOZre5QwfvLfaDqzYEUYor2BgsFsyAPOlMkws+7UqcgP0VM6a8NBF
 Po7glU1Azfln+OAsbSeoWmfzH87rXvh0d83iYCjOAaAsnQK/MppnFrlhJAhs5NZgIN7+AJe3rnp
 ZUEmHqhA0ya0XMEzuCNJbxq52BIqgmx/TG7bO6M10n4YBofs8M0BvOXtmRoXX58XZhxpovwaTfE
 4+0QP51RwKv7ux+xvAy9a7S/fi5kT99MOca1Ug5o/OS3yMEsT3UCTdZxHNn7f5MiaD8rBy5S1xn
 cLZNV30EL1MU0CfYldNrlNQh2e+qeJN09PCXuAzlhpCNVLCSYmmaBws13X4bu2h7owI1/olNizO
 ORlWtA/DN6mYVY8DPwl6GOEGlmm4J13F1DmA2Uo2+rs+hKpTVreEurb4WZ32YRlyEMkKx21i4j4
 KojuXZEoppWETXJF0mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_074713_786197_07F3EE58 
X-CRM114-Status: GOOD (  17.20  )
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

On 9/14/26 1:18 PM, Shin'ichiro Kawasaki wrote:
> From: Eric Dumazet<edumazet@google.com>
> 
> Commit 841aee4d75f1 ("nvme-tcp: lockdep: annotate in-kernel sockets")
> introduced nvme_tcp_reclassify_socket() to resolve a lockdep WARN by
> distinguishing userspace sockets from nvme-tcp sockets. After that, TLS
> encryption support was introduced to nvme-tcp and it added another lock
> dependency on userspace socket handling by tlshd, which resulted in a
> new lockdep WARN. This WARN was hidden by the commit 19bdb70c77d3
> ("nvme-tcp: lockdep: use dynamic lockdep keys per socket instance").
> However, it turned out the commit 19bdb70c77d3 has a bug of lockdep key
> lifetime management, and it is to be reverted by another patch in this
> series. After the revert, the WARN was unveiled and observed at the
> blktests test case nvme/062:
> 
>    WARNING: possible circular locking dependency detected
>    7.3.0-rc2+ #455 Tainted: G        W
>    ------------------------------------------------------
>    tlshd/75867 is trying to acquire lock:
>    ffffffff91ada5e0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x64/0x6d0
> 
>    but task is already holding lock:
>    ffff888197808258 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: do_tcp_setsockopt+0x499/0x26a0
> 
>    which lock already depends on the new lock.
> 
> To fix the lockdep WARN caused by the TLS encryption support, delay the
> reclassification of the nvme-tcp sockets. Currently the reclassification
> happens before the TLS handshake starts, which pulls in the additional
> lock dependencies related to tlshd. Reclassify the sockets after the TLS
> handshake instead, to cut that dependency.
> 
> Link:https://lore.kernel.org/lkml/CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com/
> Signed-off-by: Eric Dumazet<edumazet@google.com>
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

