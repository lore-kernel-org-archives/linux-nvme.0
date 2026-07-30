Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE9DC55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HgaxBdrD4ydUPOFc2T7xovn480tt1ZPTLhGZEOl/hqo=; b=sIvBfIl5YPXsnTPT63/1OYDbad
	a3tlR60/0XdCVWgr9IXYKNXEHq+2Y7vm/XgfqfRouyiMTNcBopgI0ULwYTCr+cT7Yc54vlX0qTqyK
	DR8oqFkbgfQLe1XpNQPyPhLwuugzK6eR8JhSUOO8NDx6mkxfhUCppjyBlpA1FXGD5xtRB7cBi2adC
	yRG5DWuBVPsL7EaA+IeYQNYEs5ZsqFZlqNxzEwNa7N6+SYGM2QsxcMRyyu3ZeSBcaVdaQMNlNN20X
	atyITlCbJVpTYchqHt8eWjtvLl4NEAsjRht2khwL2MPa94EiRFdbq8dwl539gOcIfTw0G6fOPnf/t
	3DK1ZO1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPX3-0000000AQFf-3oy0;
	Thu, 30 Jul 2026 12:06:37 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpPX1-0000000AQEV-0s9L
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 12:06:36 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAJ76U2763076;
	Thu, 30 Jul 2026 12:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HgaxBd
	rD4ydUPOFc2T7xovn480tt1ZPTLhGZEOl/hqo=; b=e239AyZkh7AnGd5+nwceo+
	1gNHi8s9PEAZh+7nSqNmp0w+92oKGjvZMTvQkMUfm7Ln0e0329DWXyyQE1FFrdZZ
	UHG2zMXI+jACxFcCiM/ZBXMZnu3+fx23VAhKFvbZeLyStYeU7N/Q/cn7uxfo6X4f
	LxOVlMyokCe/UC91xxCdHui0LOJMaI4PACS+6SKqaQp4l29FuURd4BtHbcZ7ilCb
	LgSDserhzN4vbUluuu7qedvspn4B4F1ERF/jdq6QZ2CHaYVwnoeN8GOV18Kp1Js7
	XSNfFlZ18h9iZmduEUe/HKph6wCpc5IejgzPJU+LCHXGFEynYeSsK8lJ9racFapA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd6q73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:06:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UBuEMK012621;
	Thu, 30 Jul 2026 12:06:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqkcxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 12:06:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UC6Jlp8913418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 12:06:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 964285803F;
	Thu, 30 Jul 2026 12:06:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F51B58060;
	Thu, 30 Jul 2026 12:06:16 +0000 (GMT)
Received: from [9.43.106.218] (unknown [9.43.106.218])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 12:06:16 +0000 (GMT)
Message-ID: <fae37aaf-e867-4984-bf62-7422104ad229@linux.ibm.com>
Date: Thu, 30 Jul 2026 17:36:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvmet: fix NULL pointer dereference in
 nvmet_execute_identify_nslist()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260730043105.3071328-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: gEF7zIffCbvwn12nq_NWn3V3nWEe2Rtq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX+rAxSUynzeEa
 7VdipaJcvOTtcROtA5SzZNT9vDKBX1Rf2t9Og8NZQDQ/nF1MLnP9+vjiUchQ9ZDbILzjgX+iDVb
 Ph3Q3utxA4CdWuBozmDIM5N1KcARP7Y=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b3e3d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=60SpfR-ajcjdftOPQwMA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4OSBTYWx0ZWRfX1w+JhuqyYdFk
 /inx50pomFki9sNMp0j/0OepeSwpnWw+Zs35l208Mk2ClDRGkDf520K+QGZ5JBzVJ5RBSohb6lf
 z7TePkPCOkIT/VtyfJBZD73lepZoZmJUic/QiVTw2N5/C2LuxkKHbmbphM41foSG+q2MauPuzHK
 w7J3sUm4VIleV9XTj16Flr/EPhc/sijnmIpvzYv4jyLcvRoi+qAdtEV1M2gjZ99/+8qwhr5M/AI
 ytI4BAmOmuQbYWpYJjqrU/TgvYfjD/7GdtHkxjSpqEb8f/lXDHjVkD/x8TH/8/gcdYKF6uH9rYD
 VT5LfSJvx1UTnsJ1NoiQeiEO+PlgNueeda6Ii1QdUhcfgy1kc32Cc985A1xJnMg0ZDhJE1lrmhL
 SJ7z8i8Ue0bPS9m25RDNvdG7/6TFtlriHP3nIU2eD9dCK1Soroa5rdXxZNfRpGU5VoBpCcFf2bl
 I23eJ7FukfDnbnNOY4g==
X-Proofpoint-GUID: mlyvwvFz0IB3F0s1j4-e7RR642jsHCAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_050635_390693_E1767B3A 
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

On 7/30/26 10:01 AM, Guixin Liu wrote:
> When a host issues an Identify command with CNS 07h (Active Namespace ID
> List for a specific I/O Command Set), nvmet_execute_identify_nslist() is
> called with match_css set. The command-set filter dereferences req->ns,
> but this handler never calls nvmet_req_find_ns(), so req->ns is always
> NULL (nvmet_req_init() resets it to NULL). As soon as an enabled
> namespace with an NSID greater than the requested value exists,
> req->ns->csi dereferences a NULL pointer and oopses.
> 
> Besides the crash, the comparison is logically wrong: to filter the list
> by command set it must test the command set of the namespace being
> iterated, not a single fixed value. Use the loop variable ns->csi.
> 
> Fixes: 61c9967cd634 ("nvmet: implement active command set ns list")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

