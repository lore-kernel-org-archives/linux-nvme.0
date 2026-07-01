Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67A8C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j7yjBxn+RXlqEyGtEL1doJnueXp/GEdmgWXccPGDj50=; b=zUHR/lodj0lJ1MJYOiEQfSbX4e
	mtDBZHJjg3GGU/sgoNANcUZjCDeroGmg+z3F6BnnDAhL1UJD4NDT3/Z5HFFXoqGrJjIinrXmw3cEV
	lo8vr83xAQL/j3NS6jyGassM4jmRbEVWw1Ux01gNG1wnPBqrPWHmee621nf8gc2bmaY7pANyKZPVE
	NqgLafrtL53atgOXPQue3ngfRNAYWIQhn9qjD8P2EabL9bJySY+eU6X/c6DFSeTv0TVHsgbckL1E8
	ZzKKVj+HNddVKV+c7OdqkFg2es8UVdSEwE9S4wupA3OV83SVzSrB7czChX1QHv7CI1a3evCq9UqUE
	7SmTrf/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wepiQ-00000000xEm-0DQX;
	Wed, 01 Jul 2026 07:50:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wepiN-00000000xDX-22rS
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 07:50:36 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613ITbR3867661;
	Wed, 1 Jul 2026 07:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j7yjBx
	n+RXlqEyGtEL1doJnueXp/GEdmgWXccPGDj50=; b=qrTsMb8BjVysxPdBYsHgmX
	6IY1IJ9fiXZag7L3GjFmqxVLpYhNVzdMJe58prrHotRO+tZ1DT3x65bmrzjHvZpL
	E46RyOal7ntf6yByyhrPjXYXaDx7iGLoLLzr/peyQ5i26wSDt5Jm4hUCJZKBPHJh
	ev4J7IqAktL+KuPPVmZ0h/BhwlDHfS8w7FtGf0PLJ96Y0enYbmCN7X3XE+5qlErI
	ND9im9RBr1lzfv+1Z9I27LAcM046GoWuz/bnlChYBn/AU3OegCcVsc0kkg4+2hof
	s+wvf6hqiRir4BZHz4mqF24JLRvw1QUbZSF4SvHxvxCJSXeOyv9/wRpM/JtGbpyQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5u8hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 07:50:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6617nfXi010409;
	Wed, 1 Jul 2026 07:50:25 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w6bqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 07:50:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6617oOmx55574820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 07:50:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9C8B58063;
	Wed,  1 Jul 2026 07:50:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 324A458059;
	Wed,  1 Jul 2026 07:50:21 +0000 (GMT)
Received: from [9.43.78.19] (unknown [9.43.78.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 07:50:20 +0000 (GMT)
Message-ID: <cd496c93-091a-42ea-8c68-825ef71d14f0@linux.ibm.com>
Date: Wed, 1 Jul 2026 13:20:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 14/17] nvme: fix Clang context analysis warning in
 rdma.c
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-15-nilay@linux.ibm.com>
 <20260626064916.GC11106@lst.de>
 <d72e3efb-875e-40b4-80cb-1fa642bea7a5@linux.ibm.com>
 <20260629125054.GC23695@lst.de>
 <CANpmjNPgvdKLvQTFvt2OUYzG4V7GMPSmrDfV0jPbbtNxv36GJA@mail.gmail.com>
 <4fba3fdb-73df-4cd0-9318-00ff5a1e4fe6@linux.ibm.com>
 <akOciemHZ2K06tEz@elver.google.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <akOciemHZ2K06tEz@elver.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3OCBTYWx0ZWRfX+QgTZy0TbngW
 vaFjrjb3Ik/Cy++MGymWXNKRnFPi3DZJhu0dFRGS4+w6Nl4RBcUUb5UGaq4G+xh3SSJFgpPChEr
 UxCCSKXLcUVTFIaU8iUbw9xgbJ0HyukyCoX+xmDhHRgurEL2X+mxWhBSiE57pLK61ny/QmepPsi
 1wqC3bMiFyrniV/7bdG5COnRwV1y0cSNmevGhZMDpCSv5Y1FFkDCtzEIqwqDpBsxTdJ45fOKUn4
 Xm2ivXczz7M7l5NnTQtmwY+sLkes6a/t5zQztFyQWlA0eqJl+PdhNdAZQ+NZ3phFWyZVd1zjkfJ
 OQX6MXGuqD9VeKdyrtb5n6A02CpA/E+d+/LDJAzGuohYTldAFHBxoaSJ9Z/ITNf8k8KwBms5U5b
 u+qWFww79ICRxAwNANON6nEdFnaqRFqOqXtmxyHLlcOhbxGPvHiLXNh5o/g9TeS34mAfncsD9IV
 juNQpnosKOHbrrCBERA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44c6c2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8
 a=3hIta75tlVvESI0EOnUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kXYas2i8sCdRJdWU2SNm9Bdsk7K-D7ur
X-Proofpoint-GUID: YtEDIEQDcBMfrNSlcSlFZKTOl2CaEcGw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3OCBTYWx0ZWRfX1jponuy6qqkO
 4b4DsyAMm4tpsqLIPBcK8G8IgtANQ9b6RTJkBu8AhC7LnDMfq86gzW5oEtVDf+trsq3uUSJ9Wkn
 lvJjjejYRzs1nww7IPsmwDN0ovFXdgE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_005035_541241_2553837D 
X-CRM114-Status: GOOD (  23.82  )
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

> 
> See patch below; to avoid more dependency issues for you, I suggest you
> pick it up and carry it as part of this series unless someone else wants
> it before for other reasons.
> 
> Only lightly tested, please test.
> 

Thanks! this is useful and it's working as expected. So, yes I will pick it
up and send out while I spin the next version of this series.

> ------ >8 ------
> 
> From: Marco Elver <elver@google.com>
> Date: Tue, 30 Jun 2026 12:01:26 +0200
> Subject: [PATCH] list: Permit context-unguarded access with
>   list_empty_careful()
> 
> With Context Analysis (viz. Clang's Thread Safety Analysis), list_heads
> that are __guarded_by(..) require holding the appropriate context lock
> when accessing and manipulating them via the list API. Because Clang's
> warning diagnostics do not perform inter-procedural analysis, this is
> enforced by Clang with -Wthread-safety-pointer in the caller at the call
> boundary; a warning is produced when passing a pointer to a guarded
> variable without holding the appropriate context locks:
> 
>    warning: passing pointer to variable 'list' requires holding [...] [-Wthread-safety-pointer]
>             if (list_empty(&ctrl->list))
> 
> An exception is list_empty_careful(), which is like list_empty(), except
> that it is permitted to use without holding any context lock (carefully).
> 
> Mark list_empty_careful() __context_unsafe, which disables context
> analysis within list_empty_careful(), but also suppresses warnings
> generated in callers related to its pointer arguments.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>   include/linux/list.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 09d979976b3b..ba3c255f6112 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -436,6 +436,7 @@ static inline void list_del_init_careful(struct list_head *entry)
>    * if another CPU could re-list_add() it.
>    */
>   static inline int list_empty_careful(const struct list_head *head)
> +	__context_unsafe(/* intentional lockless access to @head */)
>   {
>   	struct list_head *next = smp_load_acquire(&head->next);
>   	return list_is_head(next, head) && (next == READ_ONCE(head->prev));

Thanks,
--Nilay



