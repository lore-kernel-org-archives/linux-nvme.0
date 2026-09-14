Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B78C88E72
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xr3OWMl98NInpDDuCv9WA1plR/03jIOHdMfCObDRfP8=; b=xpPC6bm49fUMPsi/xAyyT9WP0j
	QU9sIx0JXXzzYud7ogBcsq6lthyUQeWq7Ss3lSdGkcjHioVm5RHGo77s4x4OCpixZUNSRr2gZr9mG
	Q07jzMVrS/JO9tl25DumUyHY67CHKc88ub/QCd6v5O9Ysf6NtOcHiy32EVhyRxqESJ3Rui29A9dVe
	5hlOwIRkSh0oVZhBITONKqoPxY1n1/KQmorQAhkSciNU8vldo5UuoMILHpNc1JHRERysbj0+2LQKo
	Ii7gJ5/stFnAYn8AFnCE2RnNxLq/P8hboTGUGnMq+Tz0TjamvW7+/Hneix+bY9u46fjAkWdcBu3Pc
	mI5R3sOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67xE-000000041IY-0dHV;
	Mon, 14 Sep 2026 14:46:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67xB-000000041Hy-3eSr
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 14:46:43 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EETpG4419162;
	Mon, 14 Sep 2026 14:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xr3OWM
	l98NInpDDuCv9WA1plR/03jIOHdMfCObDRfP8=; b=mFH9aLfXGt6y2ryY6sKWoo
	OgYIiiJWY2ptPaQSPF/huLMPnOe0eH2kIqwn2IQWvrogvxCWzJtTHELOxfnxqWDQ
	WIkimZ2/6WsRs2s2fbYluG8njtvYz91kuSD7KtXLMBDjGlhzZ4NmN2t4dOe7zjhH
	tHFL13cNiDdCED4nlazglOcpaRQJTtInEGwpQ2eSQCFNm5duzjhierau7Iyp9BHy
	wXfUB1KF/4/yCewYz1W98YF611YBBQNr7v0i1R2eCMq0qiVjxNtbfJCn9CjMMXBC
	EjtXJ6uPWqSZ3fB+AlOuBHUq56aXkAYjJM5ToiVha1pQmkzQgwmtTwkqi9n5D+3g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq22ek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:46:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED54xi2322566;
	Mon, 14 Sep 2026 14:46:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnhevxpgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:46:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EEkMAB4981432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 14:46:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D935258055;
	Mon, 14 Sep 2026 14:46:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C8AB58043;
	Mon, 14 Sep 2026 14:46:19 +0000 (GMT)
Received: from [9.61.162.129] (unknown [9.61.162.129])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 14:46:19 +0000 (GMT)
Message-ID: <2ab1e26d-dc25-4bc2-879f-9ca3b94ddb81@linux.ibm.com>
Date: Mon, 14 Sep 2026 20:16:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "nvme-tcp: lockdep: use dynamic lockdep keys
 per socket instance"
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@opensource.wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
        Eric Dumazet <edumazet@google.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
 <20260914074853.3990397-2-shinichiro.kawasaki@opensource.wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260914074853.3990397-2-shinichiro.kawasaki@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX0PrXHvwXLwz3
 ZjIidoHfkoShz5AclRYSUAEmSrjXgU+/pj923Ol1Zzk1HueoHC7wKi80OslCWLnYXQlMHunDoPG
 4LejQ9ktpvKXLW+sj094NIKudoQCoycjXW8c1BjWUXJYUNjauCoVDNspGSRijljbWu0l1xysRIu
 rW8QqoGYmSy1b1j70Vh9QsuWeYQx0Gb/KXAm4TQeo+hKtrLjgE327PvujGGcJJV5zeSPdP6Grc0
 QPRsJKV2TciWqyCBvqvdEovM/BpxNu2IowmIshMqtv8RX8f7f+zKH2XKEcRWHa68WOP3T16zlRU
 SK6zekDWfngF5DKX61NiLgCaaxMSgDO5q+IeVcNjdm0j2HUiA2clrNw6e89KN0jzQRtpxKrSVS2
 iTKcbHPotesNozRctSUIt2DK3xTyXX0EFHx0Bftck/jU7geW+WGA/bAFItMO6Cl3z4gL0zZOfjL
 iNFOF7vwd6xlVnh5Itg==
X-Proofpoint-GUID: KVzgi97Wq542aoma-LItVeFPKJdzpynk
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa808c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8 a=1Q_J1tQ_zso_PzdLv5oA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: csCO_GiG2i_ecX0pJY3RsypxU8xZBEnE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfXwwrx27h0x5u0
 qmD/nGmJYxwrjTjHTW/OpS3Cbw74LX1aTU1V8xsHGlp2NvmaOHdwRf86QmA6F0+HihoioPHL7YY
 7bQRxreIU9m9dpWdcS3NRZPBsrYtYDc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_074641_921769_DB0CC720 
X-CRM114-Status: GOOD (  16.18  )
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
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> This reverts commit 19bdb70c77d3b24239a453291299b64040bdba86.
> 
> The commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys
> per socket instance") addressed the lockdep WARN caused by the circular
> lock dependency among six locks:
> 
>    set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_counter -> elevator_lock -> set->srcu
> 
> As its title says, the commit cut the dependency by introducing the
> dynamic lockdep keys per socket instance. However, as described in the
> Link tag URL, the commit made a wrong assumption: it assumed that
> __fput_sync(queue->sock->file) in nvme_tcp_free_queue() would
> synchronously destroy the socket. This is wrong: when in-flight packets
> cause delayed free of the socket, the prematurely freed lockdep key is
> referred to and causes another WARN. The commit is an imperfect fix.
> Hence revert it.
> 
> To address the circular dependency among the six locks, another solution
> is required. It is provided by the commit 0ba6912f7e97 ("Revert "once:
> don't use a work queue to reset sleepable static key""). It cuts the
> dependency between sk_lock and cpu_hotplug_lock. This solution is
> simpler, and reduces the complexity in nvme-tcp.
> 
> Link: https://lore.kernel.org/lkml/CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>



