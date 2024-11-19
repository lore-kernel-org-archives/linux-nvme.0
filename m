Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B643ED62067
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUo2YXBR7hKYTkPpXrtLxz3gFTmDl9/cYO5Pzn/Q5KQ=; b=QLs7ai4lWwnCNCJoOaQ3jE8pAV
	fZDffKaEP5zptYnTO3yzDQEdLmcij3EeUpXrET7Vx8u/EtOAZLjE3XlMEN6wiEupHsTaGAikEHGJZ
	Slc5SgbSQ0noEr/nxVcDyhQ/VXWwzJDoufhtxGrQW1s4Jm5fiUJMvTpNIUQ4KAq5UUl0zBWzB8wQG
	ZIxgXjuE3VbJBWVaPIOrnqwC3SxDlEZan4sEFoahu3WH+C6WRDHHaV00x1hzzxjehtah23PexmbBg
	nwk+SEU/IFkie3DeY0X5M+TJFGi9GfzGiKfxUjAWsXbWsVKsJyPHgTT8I+1LKis6+xrHhq+g26L6g
	+uHiA96g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDLJH-0000000C0oe-0fdP;
	Tue, 19 Nov 2024 10:18:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDLJF-0000000C0o3-0n01
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 10:18:14 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7QrLx027111;
	Tue, 19 Nov 2024 10:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yUo2YX
	BR7hKYTkPpXrtLxz3gFTmDl9/cYO5Pzn/Q5KQ=; b=g9ApFH+m7nL5t/nJgIcCzx
	mShERjGaiBfJibp/zQlMkjoFftHI8Y1k7BIWS6k3jbirOtd7weBU754RUqL6MQcL
	e6dG3lLyfF/qUa5xyowNcxaPMNVDz+Zwb2j6Ls9ig1/MOoICZNKyKfkG2jJ6ihLN
	WpjzGvhvJLhXsBmJ6Vu8Sp83fgXeFvajMI3An0eWMaCbE7EClT5+kErAVGsDGWu2
	PbIVesliLt05o+0u0JGWuB748VRHzqd9TSsPcIGR4NsYdT4QVP/vaZ+hQNcRP6eh
	S4rTjdENvS5Ae5EdNteKgvsVRrvXjn/jLPCAd4p5CyXup38l4Xx5x4jv/jS57dnQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2vyc6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 10:18:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ3164S024610;
	Tue, 19 Nov 2024 10:18:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1c7c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 10:18:09 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AJAI9k625756308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 10:18:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA0C5805E;
	Tue, 19 Nov 2024 10:18:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D289E5805A;
	Tue, 19 Nov 2024 10:18:06 +0000 (GMT)
Received: from [9.109.198.240] (unknown [9.109.198.240])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Nov 2024 10:18:06 +0000 (GMT)
Message-ID: <1548948a-3cc6-4372-8d24-7a501da8b31e@linux.ibm.com>
Date: Tue, 19 Nov 2024 15:48:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_NVME_MULTIPATH - Do we need this?
To: John Meneghini <jmeneghi@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Ewan Milne <emilne@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
        Chris Leech <cleech@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>
References: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t2JpksibCCG0lUVEbOgwHyIJQCKJl8VK
X-Proofpoint-GUID: t2JpksibCCG0lUVEbOgwHyIJQCKJl8VK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_021813_238059_6B6A6430 
X-CRM114-Status: GOOD (  17.07  )
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



On 11/13/24 05:53, John Meneghini wrote:
> Now that RHEL-10 beta has shipped we no longer support anything but native nvme multi-pathing and I'd like to do something about the multipath module parameter:
> 
> bool multipath = true;
> module_param(multipath, bool, 0444);
> MODULE_PARM_DESC(multipath,
>         "turn on native support for multiple controllers per subsystem");
> 
> I'd like to remove this parameter from nvme_core/multipath.c. The fact is, setting nvme_core.multipath=N never worked in anything but RHEL and keeping it around only causes confusion.
> 
> For that matter, I'd like to remove the CONFIG_NVME_MULTIPATH kconfig option altogether.
> 
> Does anybody actually use this?
> 
> # CONFIG_NVME_MULTIPATH is not set
> 
> Do we actually support running nvme without multipath.c ?
> 
Yes I think it's supported but I don't foresee any side effect of removing 
CONFIG_NVME_MULTIPATH except that the following blktests would require some updates:

nvme/033
nvme/034
nvme/035
nvme/036
nvme/037
nvme/039

All above tests require CONFIG_NVME_MULTIPATH is unset. So if you're planning 
to get rid off this config option then we need to update above tests.

Thanks,
--Nilay




