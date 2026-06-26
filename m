Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2CCC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6fkZZ1HGVwrfUPNPdbVxpz4fYCpfOkajKfkeOLetQ00=; b=QnkSH4IG9mKRRjl7mdWIFTkqcp
	vgK41rzefzlfcSbkdlmaouJzNFxhMD47F2BCxhwGLCIV5HG8GCmO8mo1kElHDkl+nmLhzdy4Dr6xD
	+o0m+1pBopCk7Dhfna79XlbO9fQi44nenBwzB2Yk3vceYi94QTsEtmnTMir9E/FnZU1VnnQ6/Xf5T
	jl8LXIivwNVhYJiXZvHLa/lawtVnjIG1tgcgU3HhKkwHFQG6TeD1D/x/XjIKjjOcduUxU2JIVLEvr
	xcnN+c+kd79nsvao0r6wWNUwPDPfKVqeiOlkpCYtybA73sp3uZqsVIjvzKkPX4DtVe8BB+siHhBu6
	4OFDT+Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd7Qk-0000000BRue-0znY;
	Fri, 26 Jun 2026 14:21:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd7Qi-0000000BRu2-2X5q
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 14:21:17 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIEg52719766;
	Fri, 26 Jun 2026 14:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6fkZZ1
	HGVwrfUPNPdbVxpz4fYCpfOkajKfkeOLetQ00=; b=HidsgjCQ8dbH4cqffq/ZmD
	UwzBWasCSwwSYK/6a0U22LJlOazbgzNdypjgHWCAUDD2J0maSvG/fEav6lK0TjLU
	Z7QE21YgFAS5NVEv/O6aLKz1UDmw5zZkXHvQufGE0goOgJoQFTBhhMBlX4QkWANQ
	nTgAa7CbN7VXrm7fDKzKyWwcy7Pf22GkGFY6mswkfQG4Fk03l8zGcE8UO5arN8rJ
	rScIrGZ6vXmPfJJkzce1PMM5xpFXv20B3iGWjtqXJDyAiC6zrEQBPX8oPA1SRTkj
	WOUcGYo2d3GIyEyP0Fw9vHejCDqB7LYrzMqizpt6ckPhNnXHoSyDadnKU4vRV3Pg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4yfec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 14:20:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QEJkdG001608;
	Fri, 26 Jun 2026 14:20:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7w0341w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 14:20:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QEKwam25100896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 14:20:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E6E158058;
	Fri, 26 Jun 2026 14:20:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E14758057;
	Fri, 26 Jun 2026 14:20:55 +0000 (GMT)
Received: from [9.43.54.234] (unknown [9.43.54.234])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 14:20:54 +0000 (GMT)
Message-ID: <c2918a28-10c5-4424-894c-596949eac9e0@linux.ibm.com>
Date: Fri, 26 Jun 2026 19:50:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 02/17] nvme: add Clang context annotations for
 nvme_passthru_{start|stop}
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-3-nilay@linux.ibm.com>
 <20260626063347.GB10731@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260626063347.GB10731@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDExOCBTYWx0ZWRfX0Ioq/lw/SBAm
 iufhswcUzu/5+aTafrMEKqvKG0cP6RgkMrgexb0OCJ+J2j5qDGxhnLVVhRHKL0gvlP6hJ1kP96W
 wJBGQ4kbXXeY10aCd3kXgUTzi4FFx8M=
X-Proofpoint-ORIG-GUID: zwUJ8681E6EY7JZSGvI7_2h3h8x1w9Sc
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3e8acc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=l5mnpRCxdIeBdmcAbkgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDExOCBTYWx0ZWRfX70g3eaPyaYH4
 lXrmw8NI6KSsXxlnvRt+ymkZleAH9XRLjXdN03ogqUSPZCkGstEqYwHXrUZTn6+bVA0EpOOFPTm
 oPJQbMx68YzK1+Yvd7C0nJ5a3sXxqLOHw6a6gYyKhJWGX3MNd+r4moZG5mgbIpoJhcxGmSyjWFK
 y+5jgbn3ElGGmYuFP3M48wA8r7WudMpAPEdbjycTDAZvLS8kQFTUGTCz+MFrFHVnJvBsmU53N2G
 h2fWeOGmksC5FYQABUM4SVgffv5qx8EStfYpklMx0xsb0jBrTbwDhst8+mlwTiCxarzrEhXMv3m
 dqxyAhUTZ+bQffOet5IfMif9/oxcZhiqBvlbOPvgDYU56ap9hWwM8EvFWtrxzhNsJScV00PQgCM
 BZ8sqOz6qPJ8xTrBpU1tQVWr3gVjvsW4d+FwUK2Iju74nF9vk90F7ciKutI0GA762pd2gymFSOp
 OwNxcBeLdINh9an/lxw==
X-Proofpoint-GUID: Ne75kf82fRcj9wmTrGLx_7bsNXdmZaQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_072116_650535_4BD10EDD 
X-CRM114-Status: GOOD (  10.69  )
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

On 6/26/26 12:03 PM, Christoph Hellwig wrote:
> Note on the subject (also the following ones):  please just say context
> analysis.  Currently only clang implements them, but that's an
> implementation detail.
> 
Yeah, I will update the subject accordingly in the next patchset revision.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,
--Nilay

