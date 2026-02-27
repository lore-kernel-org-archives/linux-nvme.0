Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C1FFEFB6C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iljSpR4CFf6PJAu69TUX/l2iVWQ0MVs6pJKDiS+Enhs=; b=Imxy+K5fPoS6rDTNScijen7Ltq
	qfNHNtuM88q75isR5E7CE7Wb6VWPyQ6VloXTkGX4gITZ35NxzZ8Ou3k8QoBljFc3eTwD858A0qTCO
	+a3012zT+ONPYjH/n/H9MLyDKdb8u79M1hW1Dq0IYNp4LzQ0DCiyEPaZlTbHkD/889xK3hyMFZ2+Y
	3gFRj+yS0ymzwvqQKAHyehSloqB7IXeStBdckFBf4wlCqFoX14wXmw+SpVNsOcv/75VSgF3mMaDJd
	n6cDBjNRMels3v7ZXPKOlprXmruWFvkLoLy20MHLBEpwY92dmOc6YdHTEVbLpN5yEa9Ulx47gxD3c
	rux81PLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw0Dl-00000008gzr-1e6l;
	Fri, 27 Feb 2026 15:57:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw0Di-00000008gzW-49Qf
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 15:57:40 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61REZ1oU2632518;
	Fri, 27 Feb 2026 15:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iljSpR
	4CFf6PJAu69TUX/l2iVWQ0MVs6pJKDiS+Enhs=; b=MBzd8ToNP6KJJK5qG67/CL
	A1OwucTZ42Hfferz9stGyJtIzMFYrpbhIhmBpHh+HpaMVlFCgXV+wc0G5NODIq3q
	CDV0Y246gEbfFdfKeF2HEuBRFGpi+h5/YgLHI5MLHAlchgS0OhekrRYbLcda53Pa
	GeEsLvDNudt4GN0LO9eOaAOsQ4GkFboWbAoWvRcalsflG0CnvW5PGSTsUdos6OuW
	1LYn185Gu/hHxztlOh13A/Binap6YFHa0pio0+BmKO7b8yj2+zJheA2cFEWPcKCK
	fYQDPZKK9NqaMBrEm00Z3FrBR/KS9xheKRqoF9h3NszLtapgmlwjiIO0YWRmBcPw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bscf3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 15:57:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61REns0h015983;
	Fri, 27 Feb 2026 15:57:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1t31nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 15:57:33 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61RFvWPW30212640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 15:57:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB7758054;
	Fri, 27 Feb 2026 15:57:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B46F5805A;
	Fri, 27 Feb 2026 15:57:29 +0000 (GMT)
Received: from [9.43.61.241] (unknown [9.43.61.241])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 15:57:28 +0000 (GMT)
Message-ID: <343bc90a-e502-4178-86ab-74e0fa4f33ff@linux.ibm.com>
Date: Fri, 27 Feb 2026 21:27:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] nvme-multipath: rescan siblings on last path
 removal
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20260226183216.2098584-1-kbusch@meta.com>
 <20260226183216.2098584-3-kbusch@meta.com>
 <7797a6a3-d47d-440c-a580-40bae546728a@linux.ibm.com>
 <aaG5dpk_w16ZN4uO@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aaG5dpk_w16ZN4uO@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j4Y4NT63IEVUo3bpYYnA9C5ucp9eEdm2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0MCBTYWx0ZWRfX0yTtZKZrAW5r
 tais/t1dZ+60NjcFeGsWYrns4/V6qcy1l1vQLl3VVYU84Svh+kWBJc5gnPXdt2pHO0XaNif3l+j
 hDm8ip3lV/wYCoK+WkOOQOyZHMJt6PEvWaPUTR9hjjvVcTNGceT31lmbBnvWtsAfHAiqvT3KZsf
 5c2KXfdHUCDs3j9IFjii/KkWxAJ/ajgNKiaikpgK52yG5icyIVZTK5HnKonrf5j9g4BK96+WiKB
 q7xwVKr0D2ON6qYEWybHerZJNKRzCTBNmSSgzDjwb9LkGLORQ6V51ccR3DuYLJ4V/1DQdUjaPUh
 38b2Lc/J/31Evc33u4dU9Sw4nRjqWC1YYOMalv9Epxp/hiZFSHtyExz0c3FcfhCCnV8ATjlLVu9
 JiKxl0y6xkLo8+pOTI0mysiQZUeIBKdd7EWvy/3Vb0svaECy3vDyHAHZ/P4zdhUueuCabtChxpj
 4kySO8n5UMPPtuHpXPw==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a1beee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=bZhc5tH6S1NQCDocyvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j4Y4NT63IEVUo3bpYYnA9C5ucp9eEdm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_075739_158622_DC2BC2FB 
X-CRM114-Status: GOOD (  15.15  )
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



On 2/27/26 9:04 PM, Keith Busch wrote:
> On Fri, Feb 27, 2026 at 12:29:00PM +0530, Nilay Shroff wrote:
>> Should we consider reordering patches 2/3 and 3/3? It seems like this
>> patch depends on the changes introduced in 3/3. 
>>
>> Without the updates from 3/3, if delayed head removal is still in effect
>> and the NSIDs are recycled with mismatched identifiers, a forced rescan
>> of the sibling controller may still fail to instantiate the namespace.
>> In that case, requeueing the scan alone might not be sufficient.
> 
> But the other way around, if we're racing with another controller's scan
> to complete the last path removal, then the delayed work hasn't been
> scheduled yet so patch 3 has a significant gap without patch 2 preceding
> it.

Yes, that’s also correct — both patches depend on each other to some extent.
If the user does not configure delayed_removal_sec, then patch 2 by itself
is sufficient to resolve the race. So with that, overall, the changes look
good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

