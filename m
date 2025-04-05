Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F6CC36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+QzA0WQ3nqkS5mPnQZX892fdVYzYjNfZU2G7FrKWv6A=; b=ujpANvvXtpzT+E1eHRTh8tguB+
	/fszKqXoMtVREQHgwGOMGKO0jVDuan5WSu5GA7nxaJ23OQFpRBQnCmG7Zp9KPSmGDnrTFxnxBlgq/
	a2vkASnrCiuAf0nW+8yjQyyaCcMi4MAmAxaRncjcy1LbvQYeXdJyrRJK8vkLdg85BuWI+ukDPVIu0
	X5fGM37ZXtSvCiaMNi/344GINW1Nk2uHxTjXl0PpQc2acTVKtHnK5XJKcchMEMMOOU9uLM8jIiEcm
	BnQ4nui8LxMwIXvrMyhRwtwNXw7aVTl8iTC3NlG3vrjRKiqABnUKLDvBgoCIR7vFATtGCfxz+gSCJ
	vKXkgnXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u16BX-0000000EC8s-0dRe;
	Sat, 05 Apr 2025 16:15:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u16BU-0000000EC8J-1LOe
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 16:15:53 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 535CHld5007461;
	Sat, 5 Apr 2025 16:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+QzA0W
	Q3nqkS5mPnQZX892fdVYzYjNfZU2G7FrKWv6A=; b=pUah0VFYrDi7Na/plLSt4v
	wL9g8FB3ag8XdxpiZX+No4NMkMDmWh50+kbBA0ipeB/bWyhjta1ApxSMca2uMwz4
	JgWa+dCPYZ4vem0mKpZEQNIFx6YxGe8ND13IpilKW9HtwdIBtclru5MkzV8IKyuO
	CPGyQHEba8qexxsDaC6SHt1lD3xqm9eeZvi3X2uFIbzwCDAAlh0yfSJXHWk2AQGV
	2074dNX3U7WMpqKVeUdTTN1iU4uXkJaGKnZDG8f1jmoD+w6eq21FW1Z6n3CntAlg
	09zvnObGOi0mRQNQo8nsWhZrr9NJXkZDuAS/nRMZYW5hA7K0CYY6IWj43dulYXfQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45tsxp2aht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 16:15:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 535G4BII030473;
	Sat, 5 Apr 2025 16:15:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45t2e4ywbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 16:15:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 535GFk6429491818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Apr 2025 16:15:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E735158055;
	Sat,  5 Apr 2025 16:15:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27AF25804B;
	Sat,  5 Apr 2025 16:15:43 +0000 (GMT)
Received: from [9.171.30.151] (unknown [9.171.30.151])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  5 Apr 2025 16:15:42 +0000 (GMT)
Message-ID: <2e0f1dcb-901d-4203-ae3a-3f92e4a078c6@linux.ibm.com>
Date: Sat, 5 Apr 2025 21:45:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] libnvme: add support for discovering multipath of a
 shared ns
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250405130255.448345-1-nilay@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250405130255.448345-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JhojE1hYhqW8QwJp-Huhzbsh0xVa0BvN
X-Proofpoint-ORIG-GUID: JhojE1hYhqW8QwJp-Huhzbsh0xVa0BvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=473 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504050102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_091552_490833_7A74AC1E 
X-CRM114-Status: GOOD (  10.66  )
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



On 4/5/25 6:32 PM, Nilay Shroff wrote:
> Hi,
> 
> Recently released Linux kernel v6.14 added support for easily discovering
> multiple paths to a shared NVMe namespace. This multipath information is
> exposed to userspace via a new sysfs group attribute named "multipath",
> located under /sys/block/<ns-blkdev>/. More details on this functionality
> can be found here [1].
> 
Sorry there's a typo here. The kernel version should be upcoming 6.15 and 
not 6.14. I will correct it in the next patch. 

Thanks,
--Nilay


