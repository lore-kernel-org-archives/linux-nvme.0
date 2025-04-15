Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22FBC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 06:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4qra+junVPYS0EI3hBsJkuDlmqbdfR9YgJByEaxJIMc=; b=WZTjQVvH7DY2gIgbQLASxinvFS
	LcJAPmZ+2DS2V1CXOxz30S8c2mWQL3jMUpGHXevFFQRsNC9ErdUHV+DeBynuZANzX/tr9mYDccSQF
	vJjqsGrvLSghivKuztQDRp/q/xZjvqDdBCf85SvZ2Ac01iohn7GxC87PE3XB6OvjyWhvfKUyi07SV
	4HSFWsEBBxAPDCMG4c3aTuTSCFo2GalAVWCpPU/jxtHVLExHhZ76ul4xkI/LZeGtSgAWGHtvHJ9Ec
	vDZwjKdNJX+JVhXvH2TBuAEwhJrMHW+26p7hArxbomsGDNT4wwEweaLsVQ4EjMb+wSYLM3XkBB6/m
	+wkMIfeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4a7V-00000004hyB-0DRH;
	Tue, 15 Apr 2025 06:50:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4a7S-00000004hxY-0xj0
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 06:50:07 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ELdRcN020615;
	Tue, 15 Apr 2025 06:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4qra+j
	unVPYS0EI3hBsJkuDlmqbdfR9YgJByEaxJIMc=; b=EGLxO5S4Ex5NPFeYpMA9mn
	4E/pONgkJ5xwSJdXAZmFfV+rBp/wrRvVzhCJDakCZtVZOLDhum1MASwTUgtuK3S4
	LuMh53sLH6jmP0k4M8mstxebTMMbNv/XSHeZnVuBC/VD5eCfgBG/pV9YOFLdXQUL
	cKJcUYjaefKIBtt77rhf5zmCGlhxCazdmQwMzyvAO8IquXLnMbF/vK10seOPqeI7
	z6AOb0GxrmsRrf05UGeAVdtdUgtVaWeK9YTZShwHJzJoD4EkMxPWJ+pJr4Q5Y9nS
	6t00M24vHlJ+ZxRLTiT/bv2FXHFN26xY+FGslHdCbfE23jR7/ZlENmYh/mMCoajQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461af51tdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 06:49:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F2vZr6010387;
	Tue, 15 Apr 2025 06:49:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qk1hh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 06:49:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53F6nrHv53543312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 06:49:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9655A58061;
	Tue, 15 Apr 2025 06:49:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D15C258053;
	Tue, 15 Apr 2025 06:49:51 +0000 (GMT)
Received: from [9.179.13.11] (unknown [9.179.13.11])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 06:49:51 +0000 (GMT)
Message-ID: <c1df7a8c-4ba6-4f88-8862-2b411655a503@linux.ibm.com>
Date: Tue, 15 Apr 2025 12:19:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-multipath: sysfs links may not be created for
 devices
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org
References: <20250415064737.80953-1-hare@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250415064737.80953-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1ce47C4ow7BBSXNH6foT0RB3GB0HzWrF
X-Proofpoint-GUID: 1ce47C4ow7BBSXNH6foT0RB3GB0HzWrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_235006_285524_7D458838 
X-CRM114-Status: GOOD (  13.03  )
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



On 4/15/25 12:17 PM, Hannes Reinecke wrote:
> When rapidly rescanning for new namespaces nvme_mpath_add_sysfs_link() may be
> called for a block device not added to sysfs. But NVME_NS_SYSFS_ATTR_LINK
> had already been set, so when checking this device a second time we will fail
> to create the link.
> 
> Fix this by exchanging the order of the block device check and the
> NVME_NS_SYSFS_ATTR_LINK bit check.
> 
> Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Cc: Nilay Shroff <nilay@linux.ibm.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

