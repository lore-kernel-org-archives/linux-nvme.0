Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ACDC2BB85
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmYCNIzzd/shatlH14CoDfIMguS94rK9E3jAKvz2dDQ=; b=KEaUlxXnZDQOdq4ro3Jd/VmK35
	0/WtfgMPXP5OGWoJbHXtPupb5FCBSE4v7h324IQ1vedjkaHGzXzs1FBP5NZtRvlu0jDYxgmf++J6S
	U3/rrN6WqpVICvnq5MmwCvce/Tj+KfGZICMG5o8f2SXIfN5E9GfnhdF7ioYuvZFIUjW/zUEpkVIyQ
	o2zB7m9CpMBWE3c1VZLEJdNk/KBGa+arhQzgYilSkm8VX/crnbuW1XBk+7yna7LV0out3tRsU4TzJ
	W7c2JZq2AkooVAhoSE8f9mxPmpbENxoMRPmECB8ud/vSeJr3JmqubYP86d7cvEtxnIbti9pD7lt/T
	+VIHm9Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBTh-00000003pr2-3qPH;
	Thu, 20 Jun 2024 06:41:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBTe-00000003ppD-1lz8
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 06:41:00 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K4wta5025801;
	Thu, 20 Jun 2024 06:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	hmYCNIzzd/shatlH14CoDfIMguS94rK9E3jAKvz2dDQ=; b=QHqu9iroqj8Ztxtj
	g+inueZFQmfusR/vs1eoGyTcagI9rWEnDrsNtr4m1yx0sJixmOX552atd0gg+RRc
	Vm3HY//QzWQ6pRX01+YcyngCGGVm/bF4eTv6cDufRPMnak/iRzqnuYVG2E3h3RE8
	fck9TDl6aeQ/5tyez1BMRSHyDYOEZAMye9bMe8Rz1e+pFUhArBatVPCs5ADCJ8VO
	VdgoqvB5VmdRFK6+mzTeQTwE8k1RNjLcrjO9NBUnPUG3Jfhy9uc4rdbKPF+p1cP/
	HQ9U4JKTzF4fTXS4xGJ54ydrYoEmzqzu9b7SQYv5+Re4FYQce+Q7uqBedASkjztB
	x0U5mA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvdv8870p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 06:40:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45K5Aiu0013392;
	Thu, 20 Jun 2024 06:40:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr043078-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 06:40:40 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45K6echS21037740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Jun 2024 06:40:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 245E05806A;
	Thu, 20 Jun 2024 06:40:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2501258072;
	Thu, 20 Jun 2024 06:40:34 +0000 (GMT)
Received: from [9.43.39.114] (unknown [9.43.39.114])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 06:40:33 +0000 (GMT)
Message-ID: <ec685e52-0ea9-4928-8b96-4ba503e8664b@linux.ibm.com>
Date: Thu, 20 Jun 2024 12:10:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org,
        sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, venkat88@linux.vnet.ibm.com,
        sachinp@linux.vnet.ibm.com, gjoyce@linux.ibm.com
References: <20240619172556.2968660-1-nilay@linux.ibm.com>
 <rxeyn6susgjlguqg3jk7ntthjvhn6gt3meu4dcb5kchynz3b2e@uznnvlner6ri>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <rxeyn6susgjlguqg3jk7ntthjvhn6gt3meu4dcb5kchynz3b2e@uznnvlner6ri>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M_VTLM2jpijficeK4BYCFMJhY5ZbIx-X
X-Proofpoint-ORIG-GUID: M_VTLM2jpijficeK4BYCFMJhY5ZbIx-X
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_03,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=692 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_234058_687054_F4524E1A 
X-CRM114-Status: GOOD (  15.42  )
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



On 6/20/24 12:05, Daniel Wagner wrote:
> On Wed, Jun 19, 2024 at 10:55:02PM GMT, Nilay Shroff wrote:
>> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>> +		uuid="$(uuidgen -r)"
> 
> This adds a new dependency on an external tool. It should be mentioned
> in the README and added to the list of tools to check for:
> _check_dependencies(). Alternatively you could skip the test if the tool
> is not available. Anyway the rest looks good.
> 
The "uuidgen" is part of util-linux package and I saw that it's already mentioned
as one of the required packages for blktest: https://github.com/osandov/blktests

> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 

Thanks,
--Nilay

