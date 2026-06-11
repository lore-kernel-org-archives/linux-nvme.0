Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5613DCD98C6
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2026 04:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ACtCJw06+jtmNgYNXYzS6R/9Xg5SNEqYYjF8206mzz8=; b=cjDSrWjTLsqssFEsxoI96HhMCy
	biMyW2RMIt+RXOID4wJuT8iIQz9N2K1TKEdb/1ssSDVh/WVQKlgAPqoUMnjmdFLGqEW2sGJ/gaN9X
	Jmw7HnMlaYtJzBxhW3lsz8wJGjvt0J8vjaNLgKSV/qmFh/WHX9uOX1c3HVJlCxqSukZVTJ+BHpnpn
	mWTcbqgyzWzOB941qPM1B8l56vPb2WMHR3VQUeZ0GVxjLIrADgsxTZv0NObBCh/1aXcCF+tlBbXd8
	DbjmIs+MJHL2GEwZ5qDqOycSou+1hWxMMZwMxkXoPFvASwhO3DELZUKV6rRMpesNAHcc9ThYEPBK7
	ArKMVhRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXXPk-00000008hEH-2Uy1;
	Thu, 11 Jun 2026 04:53:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXXPi-00000008hDs-2Eff
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jun 2026 04:53:11 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu6Tc4146619;
	Thu, 11 Jun 2026 04:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ACtCJw
	06+jtmNgYNXYzS6R/9Xg5SNEqYYjF8206mzz8=; b=Fa3O9uBP4n68LzjNIQ1PRm
	zTP31tkW6pQvlhq1NqBfQPrS+NybaZF2llCNLfcEYBjW+3TpBeoVTNee7usP2+go
	6oepz8Z4MrPQpBXdKLfWmogUmGp2gZhAnDg2+Ojk7FJ85oazXReHHOOtkksux6HA
	D4YnZSKHhn916VI1VSHujWSUqEj8YCJyIAtBB2czXXgH6UVkFb7+KXmkx+m4qEAg
	SS16nfQYDx6V/bOZHd5m0kTFZLWmG820ZsX1rOSjCb3HT4Rg011UAxPfEN9SGMPR
	vl4hfZECY2F6hHnvltFa9yY/iTRidOlDYhGE4SXEqhotpBFF2H7yVAphxIoKVeaA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c1fne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:53:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65B4nlW6005977;
	Thu, 11 Jun 2026 04:53:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a1nwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:53:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65B4r0wa20775598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 04:53:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8062F58055;
	Thu, 11 Jun 2026 04:53:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2881958043;
	Thu, 11 Jun 2026 04:52:57 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 04:52:56 +0000 (GMT)
Message-ID: <0cdc0ff5-fc58-4915-86ec-74fa3b1e0dd2@linux.ibm.com>
Date: Thu, 11 Jun 2026 10:22:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] nvme: add Clang context annotations for
 nvme_queue::cq_poll_lock
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-13-nilay@linux.ibm.com>
 <b360713d-9518-4e46-875e-974317e74ddf@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b360713d-9518-4e46-875e-974317e74ddf@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX/PBQFP++cDap
 NjMgheWpBTvwafEczsEjAmlvhHmjGejjyQPDxBLHLR91FbjyLu2GS0ENrTmqbKxVFB9QFo3sNvm
 9fHXkbGTuqT7GBfpUMKPZvNCtS9uqH0=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2a3f2e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=-BXssvoQmy4FsglJak8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cYmbU71LQQClS_SRsBhDAKFwlCye1CCW
X-Proofpoint-ORIG-GUID: EIhqsorfAqq8GlUxCxdKmNYz6uzMkxHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX+LoEkdixKsf9
 GyRBiSQKOGTOgYvEQv3M0UZ14UzkgCtDFWWeDpz5i2HaluKn8b8bmz/WMzjLQWoHxKwajLSpRja
 sc2D/AaklYy72AUamQNiYEFXFF9FqQ7wJNSaoh68vIbybBkiXEcDt4aFFZiEF3jo12VOnfChaYH
 DhyhXG15/OONW5cYv/jTgHIuMN4wI68e3QE8y6G/aBZflzT75iLCr3glCepPM7pl04m67Dtf3tV
 6VCNwzQFJAIkwPfPS3KJXb2ML4amSnebTWXthmsEQhJZ+SkMCCkUMK8eVb+FccOWW4j+NCBMT23
 3t6fzzwgkbCP2vLW4lzGbt34+PwLkLnCbreUBPusCTY1imMj0JPjcfgUgyqRfs4dZwFNcJOjgyE
 gyzZB3h9hI7l784CdPQ2X0GrgRstfB+MAMDMKnboavBJ6CYVi//DdtldG5gbM4+oSN6XBNDBpye
 2T9uLODHdGcK5/gQ9Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_215310_580428_0C5BA906 
X-CRM114-Status: UNSURE (   9.86  )
X-CRM114-Notice: Please train this message.
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

On 6/10/26 10:05 PM, Bart Van Assche wrote:
> On 6/10/26 7:27 AM, Nilay Shroff wrote:
>> Fix the warning by acquiring nvme_queue::cq_poll_lock before invoking
>> nvme_cqe_pending() in nvme_poll().
> 
> Please separate functionality changes from Clang context annotations.
> 
Okay, I would split this into a separate patch.

Thanks,
--Nilay

