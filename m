Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C97FC982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pehibpCPyDRDbFQqcj4T8itKVuZIRFom0hhNZdWjvzA=; b=DH97uAlfCgYUP2X78el1/ufWH3
	1NCMcretN8BL2JRJB+nrbK09qYN0xDthEF1GT5iNcIZ3xjlvgv/rwIFsARY+yTCRp/87+EzZHQ/vo
	c2V8OOwQKEPBId3VZRAr77DnBbsK//+RQcUgrlyrgspsrbViuutZ8BmId0TegQl90FNlqRekzEK4c
	cRWLgFXt6Z9TgCriTigWaWczcdZaBEA8frDRGNkhtaC/4aDFUK7z7kPA3ZsIhkZP2mdtf4bh5UxjT
	yk1LjdrGNdEfAadY0Ni5XOnHFEbUI9KrTC05zdYJmZ6TepR74qgfaPQpacKNcC1F5s1GwdcbSer2H
	gcNviVgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aJu-0000000Eqem-1thv;
	Fri, 18 Sep 2026 15:16:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aJq-0000000EqeB-3p7g
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 15:16:08 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVgUh1393944;
	Fri, 18 Sep 2026 15:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pehibp
	CPyDRDbFQqcj4T8itKVuZIRFom0hhNZdWjvzA=; b=tioG1EhOQVghvMPy/uSJBv
	IYClzNuBoCFesgGAeyzdVFuRLVk2qUcTQAjoav7en41I2BBSQC8IL5YEx3EUtiZb
	g1JJc2+qJTNtEWh+7AG0MM8VefQsftLRwcK79jLiwUbIlsLlvjko5LMLWsa+RM4W
	8qG1RMpQsJQLUB/NWDgsdg/rizKCCgRaClwDauZRTw3kw68HLi08/iCdXrjIjJBM
	OPLYcXERHjW12WVhdIFUEwnssD/PllKsiiIb5HYJpL1wrufyIYx/xhIOShGkn6cD
	x5VDArtHxxoCmh9aA+p5VJiK5mnUpF3fwBJDyCe5yIhXF/mlzu5UWNl21jFteO1g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5gvbs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:15:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO2qN771897;
	Fri, 18 Sep 2026 15:15:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5fffww5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:15:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IFFq3J32113232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:15:52 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFA7758054;
	Fri, 18 Sep 2026 15:15:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 825EC5804E;
	Fri, 18 Sep 2026 15:15:49 +0000 (GMT)
Received: from [9.61.58.220] (unknown [9.61.58.220])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:15:49 +0000 (GMT)
Message-ID: <8895ba88-a870-483d-96e2-08ee3fba3198@linux.ibm.com>
Date: Fri, 18 Sep 2026 20:45:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: defer setting ns->enabled to false in
 nvmet_ns_disable()
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gjoyce@linux.ibm.com
References: <20260916151012.3702896-1-nilay@linux.ibm.com>
 <20260916151012.3702896-2-nilay@linux.ibm.com>
 <20260918120825.GA16547@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260918120825.GA16547@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UFZf08bDyglMZdTNvt6lqNxiySICpZrj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX5V2PaWiAj3o7
 uo7Xn4sHv7dinzI0xFhwYY7W0aVG0BtCWJ35wGXxiUiyqR8ELeJ8csEk2IqmqbNNSqQDVo7TmF6
 Ci7mMSUDjifxXljzokmlnG97MwX7KpM=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aad55aa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=gz7Zwl-rS44PqqtBqqwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UFZf08bDyglMZdTNvt6lqNxiySICpZrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX0y+Iqhc2pOVY
 IWxlznNuyAyJl/GDJN49i1VU3QAaaMtoMZK/HBfRUUeQI3MqNTR1K3VE7eFOm+Gu5xpnlxOdSPH
 ICOL8IgCAspBDjOM+B+sP1rRStcB4UYglnArUsv90iEFXt0gQRSIIVjx8cYHqM+v/uM8ZNjuUTe
 bN9ETUpir0H749wOjgk7g0G76TffabMXjcYB5Sp6GQiCRTJfgULnrkuBekZSPCDFxms/ndSxKWW
 gYCy80/ebkT2Vo1jYCqxQZRdEotmU/V31Rc26ouz/eIc5kFgyLIrmLik3Len5IzUcOKNKYR8Vvu
 U9PoE9/NzBZjvltWAX2t2x8mbH/nvhAi7Ic2cGBHMSRso2CMN938oXA6c9CXanoqcsxcBBXwMOF
 h6t3gE362WVnHkgGZaCdo4NJaGMsrYJomcssLSaC8Tt1FU8lcbe+kkvwkNBRGpcvUmcm4tq4UHd
 0bw7MjyFTvG4YMUsVpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_081607_385081_E296495E 
X-CRM114-Status: GOOD (  15.56  )
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

On 9/18/26 5:38 PM, Christoph Hellwig wrote:
> On Wed, Sep 16, 2026 at 08:39:59PM +0530, Nilay Shroff wrote:
>> In nvmet_ns_disable(), keep ns->enabled set while existing namespace
>> references are being drained, so namespace configuration remains blocked
>> until all in-flight I/O has completed. Set ns->enabled to false only
>> after the namespace references have been drained and the namespace
>> device has been disabled.
>>
>> Since setting ns->enabled to false is deferred in nvmet_ns_disable(),
>> use the NVMET_NS_ENABLED XArray mark in nvmet_req_find_ns() to
>> determine whether a namespace can accept new I/O.
>>
>> Similarly, use the NVMET_NS_ENABLED XArray mark in nvmet_ns_disable()
>> to prevent concurrent callers from starting namespace disable.
> 
> This does look sane, but have you looked at profiles if getting the
> xarray tag might touch a lot more cache lines vs the flag?  It might
> make sense to turn enabled into an atomic bit mask and just have two
> flags in there.

Yes, you were correct. Using the XArray mark in the I/O path touches
significantly more cache lines.

I'll fix this as you suggested by using atomic bit flags and send out
the next revision.

Thanks,
--Nilay

