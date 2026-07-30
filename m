Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091AEC55165
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qbn/v1UtUH4AsFMfV3mMVVkCnjRZyu4SCWzFwbkcjcA=; b=nwx/EGgJ84RqTJG2yqfny5xztV
	vMIhORLabvOMDDLG0u5GVR/YYTZOJLdKI3l+L7MDmCvSZs9EvNSUQkvZkjRVYq1N8fTXdYIFwuTiN
	qHZveQb/mn+EDjdeNrPmQUGPOyyiRKnTsW+tlUkJY1rMyqAB6kUKQxdfpNIDw+WLCJKM3+hmGqqww
	2QJRj3oHgfldv7ng+s+wStVckle5P3V+nIrUTaHCYqvMw2eIRnauySWE5z4ONy+iORqrmuZykceLF
	3YtYJKF3CAEMO97yLTnzEWuVeCj8rZSijy4BgHwe/hD+2VV4aNayWGenYIOpMq+7tSftOfxJmJN5C
	icydUUnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPYu-0000000AQjO-2rRD;
	Thu, 30 Jul 2026 12:08:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPYs-0000000AQif-1etC
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 12:08:31 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHd1c2742051;
	Thu, 30 Jul 2026 12:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qbn/v1
	UtUH4AsFMfV3mMVVkCnjRZyu4SCWzFwbkcjcA=; b=XNoe/zNbBVYdwPXdDkKR0m
	zMjpXgOqaPuON+T9BIRcDom3zc7t3ceT2h4Ix3Vu9BA7/gxYlBeg2Z7pITj/64yC
	b2ImboxLMT+gQ3Iesgnqo1FS+GBlvr3ERMhKhhXO7lyaNxYzPO4KYoe5xIY9REvT
	J7Z/ntYfs/wb4P1lhyXGRjarLkzxZIQN7zKa6Cx8pvSvnZzs9k9NqbFpCMyPLqQY
	OTh6fdF6KUPpnQ+1ogv8t9yrdpCaoDK/kIfI5vfrAcq9bhdY0H5HY6/K8hvDy/pE
	FkOK52tyxWeNKwMdrH87I1ues19u/N9+EYGzxsIE4y3NwZLh23T4YXyuyUGP6ZMw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xykyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:08:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBuMTJ008864;
	Thu, 30 Jul 2026 12:08:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhk4a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:08:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UC8Lh431982104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 12:08:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA6ED58061;
	Thu, 30 Jul 2026 12:08:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C58715803F;
	Thu, 30 Jul 2026 12:08:18 +0000 (GMT)
Received: from [9.43.106.218] (unknown [9.43.106.218])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 12:08:18 +0000 (GMT)
Message-ID: <ea60739a-d755-4b53-978e-bfd6c71bf04b@linux.ibm.com>
Date: Thu, 30 Jul 2026 17:38:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: clamp FDP placement handle count to the buffer
 size
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-5-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260730043105.3071328-5-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cU5Vhr3Ipkh7sYQkVssY4N9A0nur-biq
X-Proofpoint-ORIG-GUID: LHRd6ozIkehYCCIpfOTSD4yOTlUxjrRj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX0ejDIPKpGCDe
 /ATxrtoYcse0D3UOskK1pKcKDih9PJt1PU+x8LsW24mzflqBq6gviDFJtveJWCQuo2sGhdXxlp+
 ySWO2k08siTPyA6LY30bzQVkH6sC28U=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b3eb8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=_L4HOc6PGz4v6TUnzwQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfXw3rpFmLkPXON
 RTT4NczgfptJtBfvS4p0e9vJhlj0NXItgX1rjNH6PT9ANQoJeJHeCZaxEHPwAWhe8ZFf0NiZoXR
 xoaiffz/BkfHpS/nn1lwkMIIEKWok7J58EgvNpSY3nrIhVPc9U0ibh7nn1UC6ifsc3Qs1Cy41Gg
 yUh3DylxfkOKm4vvUVixgW84LX3tg9nkQi/d9PEMUHiMrZAMHmBfcX7rrpocdkvItMrIWlJXyKH
 QlH3HJ4Pwn4w/WPJ0/GfUSuquj0HSAn5Jszfr2rzxfyeXfifvIqqbyhw1ZROfs0hYzL0RY3Zt2z
 2zmPP5qqPtXqTW97pmZchCOaVun61BVpP3VivE3L/SSMDjyp836nz7yJ6DrqHU5idtDjkdhlR6i
 x6GMWYXfeJkj+Bu6CFs+zwdfhElhltbmlwptbvzj8e8RdLaaVvxB4SBsqLaBkhrFo9QV4du7M97
 gX4NQjqonoTEBoeWXEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_050830_442775_C5B13AEC 
X-CRM114-Status: GOOD (  14.51  )
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

On 7/30/26 10:01 AM, Guixin Liu wrote:
> nvme_query_fdp_info() allocates the RUH status buffer for at most
> S8_MAX - 1 descriptors and caps the io-mgmt-receive transfer to that
> size. head->nr_plids, however, is taken verbatim from the device-supplied
> nruhsd field, which can be up to 65535. If a non-conformant or malicious
> device reports more descriptors than the buffer holds, the copy loop
> reads past the end of the ruhs buffer (heap out-of-bounds read).
> 
> Clamp nr_plids to the number of descriptors the buffer can actually hold.
> 
> Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


