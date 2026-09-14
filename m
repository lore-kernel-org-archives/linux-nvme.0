Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B33AC88E73
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ej+g2Zsu436VjkT+bVcCiG++yyyO1mP5WVyCmpPnPU=; b=V5MFCIr/+LYK+fkmubh2nIV8Ge
	pKzatv1I0wEKoGvNiueYzuHpCti9bavLfkW1WhOsl+PvJVnCD3jccIvDHIYzMssJrk+I92kAUjamJ
	+ASyskstekufN1QJHna+AF6tL3psTbJbIvzijpR4MC9zus6OLAGabLRqP0rt5qgQ8exwfOq8wmoJE
	hid/69k3iddgzXWicJkaxHsMB7yAhnSu+HmQSWCqBFjIQo9ook25R/9ZYk0PNJI/hUDnSNVjypmPn
	wyPsiccwPqGHhUOf9ZKTReR51yzQmWLFy682uRj2by7IMGvyqWv4n4XU5GV1LYQOkwgTG+EqeC4LH
	dBnlGjmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67zW-000000041s5-3cRK;
	Mon, 14 Sep 2026 14:49:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x67zT-000000041qt-49Hy
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 14:49:05 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EETmDP2325779;
	Mon, 14 Sep 2026 14:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5ej+g2
	Zsu436VjkT+bVcCiG++yyyO1mP5WVyCmpPnPU=; b=kG5+GObY7NDV66fyW23cHJ
	OFbwtgWg7oTBzULY/iOclmly8Bvsk3YCtjirTH31fkXZC28K5Ow4FbN66gEABGNZ
	qi/7hu9gz78YDIgfeqh31TKXbw551L4rkaiMZqcYYnwoJBI4Jp875skjlafbhmxj
	yygHGrzcs9KRUpgqvDKnwGg21ZW5WV5ABrRJi2A5niwOt0n4kGrCs4IOKBLc9pSy
	Kei5lFm54fzStZYq9L4TjcIFY4AUet9BANWVL6atOwMreGaAswBGKW/TU/WlgToR
	6ecAU7Nby8I1sWQMMSmkxq1rarykT9odn3k/n+ZPh894PkaV+ycBxvNDHW6hzIVg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcusw31-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:48:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED54Ha2352564;
	Mon, 14 Sep 2026 14:48:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry6as1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:48:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EEmo3266585062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 14:48:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AB8A5805D;
	Mon, 14 Sep 2026 14:48:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F69A58055;
	Mon, 14 Sep 2026 14:48:48 +0000 (GMT)
Received: from [9.61.162.129] (unknown [9.61.162.129])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 14:48:47 +0000 (GMT)
Message-ID: <8284b88f-542c-425c-88ec-0486a6393fd1@linux.ibm.com>
Date: Mon, 14 Sep 2026 20:18:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme-tcp: do not use dynamic lockdep key for socket
 instances
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@opensource.wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
        Eric Dumazet <edumazet@google.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX7RMqOJN42rE3
 M/P2Ym/4dIPisgr2QgoMOz0G1T1iu5uEwK/f8xuM+9n0xrX6cGtH850ALACAgULOzLD+/8Hpl+9
 eHST8KplM2xBrdBd8q9t/prTx60HD5E=
X-Proofpoint-ORIG-GUID: yAI6cSu8jjoBjjJky0joJ0coIKsAp0Lt
X-Proofpoint-GUID: HBD2pQ5DpmmMWgzaKHrsuxfMW7iPAykn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX8Uw7+Hjob5FK
 v51OyPYTxz714SnOLHWEUPkr/kR3AOchJJYWr46V5ZWh6nwcNKXBZguMUF0NQox2kr1PhNPp5bq
 MiSt/1XYs9nlOnPWGonQ/FWZCNvl8cOSCEp4O5d3aP5nrs9CoB7jYx2fsiipBdqxEFxNj86IX1D
 GBB4PP/ZOgDH0y11LbPp5EUkqBdR83tvgpG8d3MGiBDOvwINqBEJW62KXaSDPqdW6MrcUtfI9nr
 D3dgEKv67xzYP42XOMV6+FAIl3T+GFLxNdsugLdQbZZ3dFq+HavwQgZniV4pPlM+AZJMYcMa8w5
 9RjsS9ArXO9JDwV9Y0hJV+AhjClos8HnkPFiDF+L9ZLGZtpAG/2zJTg/CVMvqaOdULAjN69VZA4
 Nyo8G+1fj0l9a0G+Ko2Fi6p8pcQWzBmAYNAwHZJAU1M0ZsRZkL1Eynr9BlSCEC5fDQuPvwsD3Um
 b85zr4W63/Lh8yxpl0w==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa80954 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=JF9118EUAAAA:8 a=WDjLDh2rHF31mx7-kmgA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_074904_148508_851D1E2D 
X-CRM114-Status: GOOD (  24.87  )
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
> Keith and the maintainers, please consider this series for upstream.
> The commit 19bdb70c77d3 tried to avoid a lockdep WARN issue, but it
> was imperfect. With Eric's help, I propose this series as a better
> solution.
> 
> Eric, FYI, I prepared the second patch with your authorship and your
> SoB tag. Thanks for the fix idea.
> 
> 
> Commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys per
> socket instance") introduced the dynamic lockdep key to avoid a lockdep
> WARN. However, it had a bug in lockdep key lifetime management and
> caused another WARN [1]. The first patch in this series reverts the
> commit to avoid the WARN.
> 
> Reverting 19bdb70c77d3 re-exposes two lockdep WARNs that it had
> suppressed. The first one was observed with the blktests test case
> nvme/005, which was caused by the lock chain below:
> 
>    set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_counter -> elevator_lock -> set->srcu
> 
> This WARN needs no patch in this series: it is already cut by the merged
> commit 0ba6912f7e97 by Eric in the v7.3-rc2 tag, which removes the
> "sk_lock -> cpu_hotplug_lock" dependency. This series therefore depends
> on that commit being present.
> 
> The second WARN was observed with the blktests test case nvme/062, which
> was caused by the dependency newly added for TLS support. The second
> patch in this series delays the socket reclassification timing to cut
> the dependency.
> 
> With this series applied on v7.3-rc2, nvme/005 and nvme/062 pass with no
> lockdep splat.
> 
I have just reviewed both the patch in the series and both looks good to me.

I also looked at Eric's commits 18666c73afe9 ("tcp: use GFP_ATOMIC in
tcp_send_active_reset()") and 0ba6912f7e97 ("Revert once: don't use a work
queue to reset sleepable static key"). Both look good to me.

However, reverting commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep
keys per socket instance") means that lockdep will no longer be able to distinguish
between the socket locks of different nvme-tcp queues. This could unnecessarily
create dependency chains between socket locks belonging to different queues,
even though those sockets are independent in practice.

So, while Eric's two commits above should address the lockdep splat reported by
blktests nvme/005 (as well as syzbot reported warning), IMO we should still teach
lockdep that sockets belonging to different nvme-tcp queues have different lock
classes. This would prevent lockdep from constructing dependency chains between
unrelated socket instances.

I agree with Eric's initial assessment that the lifetime of the nvme-tcp queue and
the lifetime of the lockdep key associated with its socket need to be tracked separately.
Based on that, perhaps we should consider introducing a separate object to track the
socket lockdep key lifetime (separate from nvme-tcp queue object), similar to what
Shin'ichiro proposed here:
https://lore.kernel.org/lkml/ao2QHIDrGeYjltX9@shinhome/

Any thoughts?

Thanks,
--Nilay

