Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921B7C79FAD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZJvywtJtOwc4Mb/dRy7COTr+TYuC6t9lTklJZqRPBA=; b=15Js18hmA+wuhBy3XoQZTvm9ED
	841IgM4hFwrmmQR6FetuwAcnfVdBnw/9JdjdTte5aBGq0TqI3bR1lLPtEMFiE1OCeIniemR8lH0of
	E0UcW/6IebPNV4g3ROwD2nc7DplQOWrKQuQEeat0GqHL80Hum62xLCCHrnJkyQQefyqzxBA/7abCl
	eJn5NHWu21fNrBg4mU3V6AdDebdaxXXOCdiSYLNTAa20zMD/hfqwKuYFv/SNa06Tx7Oi9TWw4JLsX
	hBuZ3QotpnI0aFSFS15rshNmVDjtAiMQTo98j+AhFYVnHjw0gji7ViVyHF2ocJ5gRSPOZUl84o4xt
	r6WAteOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Ebw-0000000BIOt-3xFq;
	Wed, 09 Sep 2026 09:28:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Ebu-0000000BIMv-3Zqv
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Sep 2026 09:28:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fZJvywtJtOwc4Mb/dRy7COTr+TYuC6t9lTklJZqRPBA=; b=HHA5NzwBUXmNi6E7b0GyQUyIdh
	HJAUzpz8q1lfQROo39DQ4sW69w3FAFmDIqSa+v3W+kn8heorN8TepR3sZPUlx1eF0h4XBu1AHq8wQ
	Noi0iA8Wb0ALkXVPWro48JyAHsj8Az78WKW909+aAlfwO5ylF+0FQ0N7wq4HucBSdVDHS736Hb1my
	5fnbNapicYTs62HHdKy1bWI935fPW4ToQCPahnohUVwzvT6+jZietEj4Z5HxtNMljSPgp7fYt6RMH
	OEN3qcrZruGiD5xrMS9efxrUYd6iEZgT2u11FFOrq+aBoe6Lkde4cZCxJAHXwXbuHFydqrt6Yxu5x
	f/sup/Qw==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Ebr-00000000ztG-0uNj
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 09:28:53 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1RI62262496;
	Wed, 9 Sep 2026 09:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fZJvyw
	tJtOwc4Mb/dRy7COTr+TYuC6t9lTklJZqRPBA=; b=kCofFCynp3Dbk2kCrkgw2T
	t7DyiUlj4gMZ0vTUVJnfoyHHsOlc6hcNi5WOMeFXJg2ffcf9hi+CYlXvzGtynizM
	XAxWo7OuFvtrsiaU9YQGryB5TrRyfcCmGQzdpNCXLJWTXsfP764QCR0OVG7j3ufG
	TAHNXif7iCa47YSjEcF7M9wMMq7XWvUMKHrr72SNHw37h03OYRospo2PL1NJxYw+
	MEWhybDE5c1ClHLRtUFA1G8JsXVxLxKeR8Qa/aHx9ACqO9OPFLzQ+HYqz9YLV74l
	yCnBXJCXxM+Z3O1kerRdLP5shIfmdjhSAFVddTNNumhesCwUAvxahCbe41OvK8Xg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkvyda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:28:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6898uMBI020104;
	Wed, 9 Sep 2026 09:28:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yh88h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:28:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6899SYlD30016010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 09:28:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E44658062;
	Wed,  9 Sep 2026 09:28:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 938E85805D;
	Wed,  9 Sep 2026 09:28:30 +0000 (GMT)
Received: from [9.61.40.182] (unknown [9.61.40.182])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 09:28:30 +0000 (GMT)
Message-ID: <e89bdd1c-f0dc-4d7a-9292-cf8d268646a8@linux.ibm.com>
Date: Wed, 9 Sep 2026 14:58:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        hare@suse.de, kbusch@kernel.org, hch@lst.de, gjoyce@linux.ibm.com,
        chaitanyak@nvidia.com
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
 <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
 <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
 <9271266f-3d7e-426e-93b6-6f1f28bc9b0f@grimberg.me>
 <9691f1d3-ec06-45d2-a427-ba46df5fa57c@linux.ibm.com>
 <83e6f964-0124-43a6-9673-eeed631cd16c@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <83e6f964-0124-43a6-9673-eeed631cd16c@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwMCBTYWx0ZWRfX8O1EZ8+b7zp4
 p7+TOVsi3LXNLso8Rz09vsolfBheFdAc50DH9NNDEQ4sq9n+5w438Wjqxxt8aS/EJJ4aAbmDxbV
 e46sG+WU/jwTRU5MPoXJ+kJyvjAUR7c=
X-Proofpoint-ORIG-GUID: EV4FizJiYMBxOCNXQoqLoPwXeS_hnEvW
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa126c3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=F2-LNo64u7IHK_lMBowA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwMCBTYWx0ZWRfX9xwdT+rc2M1+
 AQpvEnyxkSMTijLTD1mOj2ZnCOVfls/JnnAyOoO/RNFobm+gSNFAfWeTwP1aEF1Z2KdW3cVPzAW
 G71lz31OdpZYwolLHkLIUn7zj8Q9O3ZjBV/N6VhMedMXj9xod2L0PWNazjUlL/38jj8CnlPMIeQ
 PmTE4YBIGHV3yK5/FRHXSF20VlcPPXFOeTKdiNUIO3LIa8RKfJOOV1jje07U3pvxh9ExsxM860V
 VHRBzbQGwRkv8c1kER1t6fKnXpANhJGWKyxFUtulhdbyL4JHstQ1Sc+RYgkjjHc5EiqFMUKQ/lQ
 0qV2ZQT4zDJhQ89uY67kBW/7mpcvKqcQuv9nLfCxY8TrG6SdLS0qVtonS7PamZaOGx9Emy53vEr
 6eekmFwPg7IDNukyzkW6Q+f5bkKbN4j09K+0cxbJwPQ39aTaQKhENP+IL3y5Mm7v8quM07M1FJR
 T+PkDnZoIuqu5Y/Zrhg==
X-Proofpoint-GUID: EV4FizJiYMBxOCNXQoqLoPwXeS_hnEvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_102851_999695_7A067A98 
X-CRM114-Status: GOOD (  15.00  )
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

On 9/9/26 2:38 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Mon, Aug 31, 2026 at 10:34:42AM +0530, Nilay Shroff wrote:
>> So the policy would effectively be:
>>
>> if (nr_hw_queues > 1)
>>      nr_io_queues = min(nr_hw_queues, num_online_cpus);
>> else
>>      nr_io_queues = num_online_cpus;
>>
>> This would preserve the existing behavior for single-queue devices while still using the
>> NIC hardware queue count to constrain the default on multi-queue devices.
> 
> BTW, I would like to have test cases in nvme-cli for the queue
> calculation etc.
> Sure, I'd add relevant test cases in next revision of the patchset.

Thanks,
--Nilay

