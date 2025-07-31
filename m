Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8ADC87FCC
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BY24FdmtchJUvuN32NVlL3rlhZq4BDX4D8Yeo6GITkc=; b=lSMy/snGJFC1VqzpqoSR5MZ6hE
	IjbTsMSIc9dAYO7UTkqHHXuEigm0/ad13PJLz4T1UFI3apULev/8kWVbgbsgRvrKzc63TnR5/cWv6
	2OF+b6WN4bjEhQSm7NUfIHk9Pp8wJbPwtSBHkrwKZSpNcV7neol5msJ3lVaEk/CtOsKSW1eHIXpEL
	pkYC2ZwGL2+UCsqbKicvEk+DIlNPQVadUMUXAPhh4J4B5soW86CZbNI8FkI00pBGJ8Fix2utjQqDd
	kCbM0pXGXg8Um3p+5K2Ob3CLZ/MiXIa3bdwE4afTgZfAeOMRcgLRb3Y69wl12X19kl5iEhTdDUFZm
	e113i0iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhStX-00000003duB-3J8c;
	Thu, 31 Jul 2025 13:00:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhSPH-00000003aPu-2ea8
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 12:29:13 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VB923f016110;
	Thu, 31 Jul 2025 12:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BY24Fd
	mtchJUvuN32NVlL3rlhZq4BDX4D8Yeo6GITkc=; b=tnNtaydomKh80qXFE4raeD
	DONiA0Hych27b8p3w8CW8S4gMdeeIiX+Xbry1iVSy5pCgeQaKMEkZl/nstQ05sJ1
	roIvfwCpLO5mkv3nrZRaW5fsS1RfHAUkLFMDFA6FfUkmL7MVD7dIy4FAeYWZH9uQ
	6/9fGeP2EVvkDTmjduveY7vE9Qg0LVONyprzzaCVWE50b8MDmMJEWM9J2v1CmJky
	9mGO2kqMpvZ2LlnzPOQCc5GV3vsIRg3K/xfMe8gn4KI+r5kQ4wXgzIHtzg1vMJMo
	2NYNLH4+qN8f8plXGufCOLYJAbShaSF7aTRbGXHFrgxAclrVFqbTLpxs7Nlle1xA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgajv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:28:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56VBL6pr017278;
	Thu, 31 Jul 2025 12:28:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r0cghj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 12:28:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56VCSrXZ26608302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:28:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06EEE58052;
	Thu, 31 Jul 2025 12:28:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16B0158056;
	Thu, 31 Jul 2025 12:28:51 +0000 (GMT)
Received: from [9.109.198.148] (unknown [9.109.198.148])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Jul 2025 12:28:50 +0000 (GMT)
Message-ID: <2973b3de-ad03-4900-8153-d7d37af1623e@linux.ibm.com>
Date: Thu, 31 Jul 2025 17:58:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmetcli: allow running arbitrary commands
 non-interactively
To: Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de
Cc: hare@suse.de, sagi@grimberg.me, mlombard@bsdbackstore.eu,
        linux-nvme@lists.infradead.org
References: <20250728155504.403426-1-mlombard@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250728155504.403426-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA4NCBTYWx0ZWRfX4chXLNQBwYGP
 G6q6wrnMc/GGhGVYJO9+N0NloZ+d09oaN4vNi3JvhsGZhYEy+EZqi8IFsjhSgKc4pbNvd4Y6ZIJ
 smTpegLcwjIwPtRSxKwyeOf2gj+UeBGtf1BLfnp2Ied6BSVvTN99+uv1+7rnrCWTtH63srQNa4R
 eGfwKjb2330qjoGKpnBgKlsxq4Sr9sNShDFjfQDvBTbzLmydY/d0DXs5kt60qQhQp3nka8vrF0r
 xygIl+v5xUn8jm2VAhYGrNeR1FQC3ddHUdZfTpcKMEEn1RtdDRqniz4rZb4hG+Kgn88RhjR6EuJ
 pV2rPOv0X9mVYrAT2IOvm3TvogcfOqeWR/GY5Kt4ovPjmTXdnUGZB9qV7+Byx4c3qJy5RX54hvf
 tUVsyUrcUJF6+wcYrxbvgi+yKEcLMww9HYIbfUWx/64pn8BjpI/YQ7kwfW5mlDeg51UPUIF9
X-Proofpoint-ORIG-GUID: TBgb5OkTtiadFkczvFFRkyEvAExZFuAz
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688b6186 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1CJaQgpyAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=_ZbRuRf0ib_9sU74BswA:9 a=QEXdDO2ut3YA:10
 a=t7m4wJFJlSapEl1s0kF4:22
X-Proofpoint-GUID: TBgb5OkTtiadFkczvFFRkyEvAExZFuAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=860 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_052912_141078_13077671 
X-CRM114-Status: GOOD (  17.09  )
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



On 7/28/25 9:25 PM, Maurizio Lombardi wrote:
> This patch refactors the command-line argument handling
> to allow for the execution of any valid shell command directly
> from the system's command line, without entering the interactive mode.
> 
> Previously, only a limited, hardcoded set of
> commands (`save`, `restore`, `clear`, `ls`) could be run
> non-interactively.
> This change removes the special case for the `ls` command and
> introduces a generic mechanism that concatenates all command-line
> arguments and executes them as a single command within the
> `nvmetcli` shell.
> 
> This enhancement improves the scriptability of the tool.
> 
> For example, users can now run complex commands like:
> $ nvmetcli /subsystems create nqn.2024-07.org.example:sub1
> $ nvmetcli /ports ls
> 
> The usage information has been updated to reflect this new functionality.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

IMO this is a useful addition to the nvmetcli tool.
I have also tested changes and looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

