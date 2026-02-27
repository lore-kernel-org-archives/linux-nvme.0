Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BCBFD9E34
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dbl14ewsJTRR0m2V3h663rFZnwBM4X8TidoOkwLqV/c=; b=F41aHANd/lvf3UuQy3rO3KLblj
	2I6mdGAUEQMnyqjH7MkGErff1LYN8+MdtU6x2fVjqrM8cWE8O9cOe8VDNmJjFpeet08jCsfTAcqF6
	owGV0X+KOBs2wC1sGQM32gBhZvn3azUixdBGa0th4GmQUxANdjLcNJPm2M0aaDC/pCKSzulQlLwRT
	3XMHMw34pWo8UbtDx0oZwZsLOdh64qLa6zB6NZwbFNfnm1OWl9i1nS+uVbb9+3lfoncV2zuOpjSK3
	NY1ORIkRzjwkftE5Ln2EbMBCSd+baYpGek2ArJBrTLsp3xVufuy73OsN3IVfEf9kiuST26UF+zjUS
	vwlB8mVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvqpO-00000007kBr-2p0W;
	Fri, 27 Feb 2026 05:55:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvqpM-00000007kAn-0yBi
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 05:55:53 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QKn0lL1936303;
	Fri, 27 Feb 2026 05:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dbl14e
	wsJTRR0m2V3h663rFZnwBM4X8TidoOkwLqV/c=; b=k8X6Y5cziY+wo7FJqR/UEB
	qK9wP4SGGYoAk69OcsGOrf2WU3aufQpxuk7WSJ6INaLkhAIv0y0y6WB6d1a6zszw
	hSVL8L841O3cPIpZNfrkBAkXh193HcDq6J8pjoaiJT0sHGSZkqRH8e6XWchIvkiC
	F/qU4lZhgAryxsGODl3M4rtq2xGMn2uyUHMesgwZlSCKoZzndcDjLo8CkrgQJ9rB
	pQvwJAOXuKSC+rzGIOyyURTH34IdMuvwpnfCNUwXBH1Q6W9LqeM7h7V96jasHykv
	AfdbW0RRS7ljyTGl6FO+bTXXmKsM1N6/C8yKCahr9U4ZaU1UJ1+gLUqIyWvLsTgA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bsa36p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 05:55:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R4C2KP030267;
	Fri, 27 Feb 2026 05:55:47 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhkrbrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 05:55:47 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R5tPM329295294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 05:55:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C326958064;
	Fri, 27 Feb 2026 05:55:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02E4858066;
	Fri, 27 Feb 2026 05:55:44 +0000 (GMT)
Received: from [9.43.3.109] (unknown [9.43.3.109])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 05:55:43 +0000 (GMT)
Message-ID: <df61602f-2d34-4283-b5d5-58ab8dfb9b5e@linux.ibm.com>
Date: Fri, 27 Feb 2026 11:25:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] nvme: fix unmatched id's under delayed path
 deletion
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20260226183216.2098584-1-kbusch@meta.com>
 <20260226183216.2098584-4-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260226183216.2098584-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FBE_ESFJboMR1ytzXtayPs8-HwpAsM-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA0NCBTYWx0ZWRfX1kKW+XzzUuIq
 lHJYl/3YrpjM9gS6y+6AR2PmVMtfrW6x/KLHOYjO/NjC3R9asqM01KVUL6HC3SdqYcSCyg36WtV
 yhaq6+Lpi5s6HUz7Nc4bk/sT2vJ/OZtZ/2A0wW3vV13YkUNzd9uiU7F+cKXgYjXnXwqwl3WaTs8
 epyRkM+rSZ1t4bChKi1bbANJBlRTaNp6q0euwOCizkjihFEpXsecvMkFnuGwU19OGF5Ic9LwFb4
 wCYs4OrV1txlntBZ/yoXnQGXPpq1K4WCzSFyfOoTYG/FopFJDt6av/qQ1+k3lSxPP9wuNbdpRrr
 RqhELtbNROITbsw4fwWI9a4bkwdjZrGhfaF5iAtL6ICdWkQmdHTnRkU49cFFYYRB8F/kf26gkJF
 AVfHv57RUCnaloq2stcrP2CWXBe4miLC9zVustUEFG8TdA265ankW1pDCBXAJfhcU2DDqBKPO4b
 lu4iupQJtmYduBiYLBg==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a131e3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Vuf4bXvDtPRvE5iXt6EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FBE_ESFJboMR1ytzXtayPs8-HwpAsM-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_215552_393967_DB769725 
X-CRM114-Status: GOOD (  10.26  )
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



On 2/27/26 12:02 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The NVMe controller is allowed to reuse an NSID for a new namespace after
> deleting the previous namespace that had been using it. The delayed removal may
> have the stale namespace head in the subsystem list pending the timer, which
> would cause the scan to falsely report an ID mismatch error for the new
> namespace. Flush the pending removal work and retry to resolve this.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


