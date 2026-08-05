Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2882C55ABA
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2026 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sOeYLMfQNv5vTlVx2jnze1s3O3+mF0Gp+IT684Tk4z4=; b=yuFGSJ4RAFHlruXKleQnxcCmaB
	rUPC3EyDFT2i6klaOetIcrqx/uuG0uCO6eUuNCMo5yCLw1ikU5xFJ6qIFJ/gDEjTwHfYUBsAgT6qW
	EHcq09p1ljIL5CoRiYXnNLNlfhs7OZGzCBqyuPFv9MWnKhKDX4H6VjY7f8IcMvpAuToUtf5mVW+wX
	RB5HwrdRrYLuougD5pC8lpBROTOVIaYQPAkkbw6dlgc7i0FVntvJ6BFCBMC1t87fiOjbcj33KcVgo
	Xh09RbOGoT5o014b0Lsc4S00WpTITx2f5BLnrxCx54IkViW1FmoJw85IM2VUkzkYyxfRSRu6EGGHs
	Yg+DlkuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrdMe-000000049yu-0KQN;
	Wed, 05 Aug 2026 15:17:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrdMX-000000049yA-3YHo
	for linux-nvme@lists.infradead.org;
	Wed, 05 Aug 2026 15:16:59 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CI56g3794934;
	Wed, 5 Aug 2026 15:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sOeYLM
	fQNv5vTlVx2jnze1s3O3+mF0Gp+IT684Tk4z4=; b=VvJ51wdLzkXXSyGhhirt52
	spoTEesrXHkCKT9mPfpvScOp8Ekn/IvJwRvjfC/ZQv/WjpI/GT5K31acco1POiFq
	C9W+Yw4fyZPTptM/hmdSBVC60YWc437ESso6ppAr5+DTnpP+mi8aC5vCeOxuZk1Q
	TNMEWyAFdvlftXUUcuiE3ku4Q4/HapR8kBvgFz6Q/IZwQAq1MUsNvA0gXwio37+P
	Jdx555PnUmIoWXiqWKqDO+GfVz8Lq44XUErctUllOTIjN7O3q25JDoYxdapk/6rA
	s0usqO/8/5DGmJzmWy6LgLvp/ujAbLxhcDx5IACosNs+sHacLWF4D4peRjustZmg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a43qcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 15:16:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675FBHwD032012;
	Wed, 5 Aug 2026 15:16:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qq7vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 15:16:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675FGfge21168734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 15:16:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD89658055;
	Wed,  5 Aug 2026 15:16:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F9A05803F;
	Wed,  5 Aug 2026 15:16:38 +0000 (GMT)
Received: from [9.43.98.178] (unknown [9.43.98.178])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 15:16:38 +0000 (GMT)
Message-ID: <00877570-486d-447b-97c5-6af6f08410e7@linux.ibm.com>
Date: Wed, 5 Aug 2026 20:46:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] nvme: raise FDP placement handle cap to U8_MAX and
 warn on overflow
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
References: <20260804021901.3777326-1-kanie@linux.alibaba.com>
 <20260804021901.3777326-6-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260804021901.3777326-6-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7353db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=hD80L64hAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=QwK8Kxzwo6IFX08B6Z8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GmH8vi78KXO5dNunWQkYdU7UaUnpDoM9
X-Proofpoint-GUID: I1WJeYI7poI7rev9QvpFyPMfXdx4SlnI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEyMCBTYWx0ZWRfX4d63L00Xxclg
 lWDZnSPpxIucCRiDf0v0ZL0fCQkoltgZoj8kAcezAf2JQQUu7MvIzDE4p3TtgtGRnlZXuajopoU
 oFgRpmgPQLkNpCT8twlJNFmNCxElgmE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEyMCBTYWx0ZWRfX2d12s+d9u1f5
 0TVgSxxKh2CcqwQ8M4QPiGlAkwNU0ZitdBmhjp1j4QX46mxDUy1T6cF/Qbif58okfQUDg1+0kBT
 MGjKF6l93a7VTAwPiLJRLdHm+rvGOnBMdcEEpaGLz9Jh7CusuaBpoTle9y3bb26ZWIVSPHv9Wvd
 E9cE056iQv5DsWZRMETdu/yk/WkdygB2SU32KTdKsP32sLRj3Em2NYJtKgc0vQZCm4g9JlSl3LU
 Cy5dChgsNl+jYoz0Iv4cOOVZT2zo0yKdRdA8zSEOV/Z00kBPefTp5aHMxq03dUL11lhhFdILQCu
 tsqud8JVqHFckYdHnp4qPRN88aAWAcK0e6ECdErsxkbjzVoe5iSNrQvg+GtZfoFVCeHHqp6RoIr
 9JR47XD+VH66LzAGz5urZyNaqGMCNBc3p7Sw31DO5QgefkEdQ1zWnrlaUyjiNzOg40pjfcM5XwL
 sERYE8C8D5JdJc5F/Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_081657_922816_B9B5E3D6 
X-CRM114-Status: GOOD (  13.23  )
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

On 8/4/26 7:49 AM, Guixin Liu wrote:
> he RUH status buffer and the placement-handle clamp used S8_MAX - 1
> (126) as the maximum descriptor count. That value was picked only so the
> io-mgmt-receive result fit in a page, not because of any protocol or
> driver restriction.
> 
> The meaningful upper bound is U8_MAX: write hints (bio->bi_write_stream)
> are u8, so placement handles beyond U8_MAX can never be selected. Size
> the buffer and clamp nr_plids to U8_MAX, and emit a dev_warn() when the
> device reports more handles than the driver tracks so the truncation is
> observable.
> 
> Suggested-by: Kanchan Joshi<joshi.k@samsung.com>
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> Reviewed-by: Kanchan Joshi<joshi.k@samsung.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

