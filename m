Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89B606D802
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zEF2bbEz;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AVDkoueR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LFYDPfKJMKwJZLcldkq3Wf/ixqe7Il/7xNLHakakAfU=; b=zEF2bbEziZhGbz
	qwBdaVsC+Xvpl9CEsHIHq0/ncqAlwZJyGr+AzcGdPZZnlrriM+voICLtFk5k8rGeKsffQu4jHbp2N
	bR8eMU/J2XhmoiQvXdcnjbAV6DMR/g5zOb3plIMbXlDX1e2i9DLZSd9DYl79g5eu86v+6nrSpa+zy
	GsargnI7oap39h/M4FWPYaraZNE/eTc67apRCklmaF8G7cRxRreZizqqlF4uatZrzgE/d6o3F2y2G
	2yWmr82BLl8GFaiAEZf299RyYrJKTaBFRD7OeWRjFo6dDa3vt35P43Oiz3ovxi53P20HdBFOpaTdn
	x7PjWJu75pUSkDo2qyUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQNXT-00000000WMK-1zly;
	Mon, 09 Nov 2026 11:27:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQNXQ-00000000WKq-2zkV
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 11:27:50 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AEPuA3130742;
	Mon, 9 Nov 2026 11:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LFYDPf
	KJMKwJZLcldkq3Wf/ixqe7Il/7xNLHakakAfU=; b=AVDkoueRLbGyfbctco/XEl
	8QKQa8ueXi+1EydtZZriI2iaQFp/gbY4n2bFg9F5scxvT7PKlnwEzKcLtl23Al0E
	z6fFDTEef9KvBvWNnT0bldksm6OBywhTm5e5zOnTskRz4qKNn3MquS/w0LRXGOy9
	S3Tm5b8kCMLocNBpPH5Qf6zI4BQQy3SHLQTux8jdA0tBGVc1FSdsNRvpn0z4SgUf
	CW4RFUw6IwwricrfhXIaroHUSi8w8h6ZrHZOcb+8gLaOCSjhgDpeZWmNyWef+SCY
	ziXJ2eQ4D+2vPRfjnpfv+clnYNGyICR9EERPQ2+bvmbonKY8PFsD4hGcZREr3oHg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumum8ab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:27:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9A4s9W4140988;
	Mon, 9 Nov 2026 11:27:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthfa2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:27:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9BRYnx33030902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 11:27:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1081958062;
	Mon,  9 Nov 2026 11:27:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D6A058059;
	Mon,  9 Nov 2026 11:27:27 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 11:27:26 +0000 (GMT)
Message-ID: <25bff481-7657-46bf-a41b-86463fe259e7@linux.ibm.com>
Date: Mon, 9 Nov 2026 16:57:23 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] nvme: add per-queue sysfs directories
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, sgogte@purestorage.com, hare@kernel.org, hare@suse.de,
        linux-kernel@vger.kernel.org, iyamahata@crusoe.ai, kiyer@crusoe.ai,
        ganbalagane@crusoe.ai, sjpark@crusoe.ai, bchen@crusoe.ai
References: <cover.1794015622.git.saravanand@crusoe.ai>
 <ce12f1742ea7f8699d85666e4d9d8a2a9d77c90e.1794015622.git.saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ce12f1742ea7f8699d85666e4d9d8a2a9d77c90e.1794015622.git.saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfXzsbozgUlIdm/
 q0t7X+b8/Bh7UtdWi8TLyOLoIkaJmdb8XXrLLcRo7pMysslgdLPegsUa0kuOLc0CUADhRtpGftH
 Su8foOrkfJGvbQODybPGQ47S8vmLSUc=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af1ae27 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=E62CMjav4fx6fC7TxWkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UHfYlCFf8ZIVgk-4uNSHiUW8_fM8ElMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfX9+BWIiVK0x9p
 lDt0+kiXCvwkMYoluVjCOcdtaRRJpxqkVZowpArqFfvecIAMjfziBrhVw2xsFQhsgvmiXIBxW5s
 +DVDG27v3pnDFqaU4aNkpov81EO4Gzu0trq982AVYLqdzGo+sPprIkmIjpbu4QBd9s7B2Ub8Wjt
 O/puUpDsdcxQMEqSRANa00fwuzgT5/0Qv3XzyseY14aGPg62EeiQ40qXytg+O3bKHa/mjeAjzk7
 QywZ14H1M1zNGZKwoiS6ptYHz9sCPeHqzUPYfljRXV0FIK5rxLncozEIFaOyUaZEXMc357kOmHu
 hajyVmax6XWRxg0xySi8tcTbpsEbhhzKu/zki+96KDrvlJUt9uKavf4kg42vhgARdI3FhuNIR7E
 vrL4ShxMpK465a1jC0jzH7Up1/4tLKdULwDzmNu0BBRi10BKP8vl7cMvBNzQWYuxF8KvUWz+f1c
 QzAGVqITAlKeNwz6+nQ==
X-Proofpoint-ORIG-GUID: UHfYlCFf8ZIVgk-4uNSHiUW8_fM8ElMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_032748_874055_F85CA5AD 
X-CRM114-Status: GOOD (  16.65  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 3:23 PM, Saravanan D wrote:
> Per I/O queue transport state, such as the nvme-tcp io_cpu, has
> nowhere to live in sysfs, since the core has no directory for
> individual queues.
> 
> Add helpers that create the controller's queues directory and add or
> remove one directory per queue
> 
>    /sys/class/nvme/nvmeX/queues/<qid>/
> 
> carrying the attributes a transport sets in the new queue_attr_groups
> member of struct nvme_ctrl_ops. For such transports nvme_add_ctrl()
> creates the queues directory. It holds a reference on the controller
> device, so nvme_uninit_ctrl() deletes it before deleting the device,
> after the transport has removed the queue directories.
> 
> The transport adds a queue's directory when it sets the queue up and
> removes it when it frees the queue, so the directories follow the
> queues across reconnects and changes in the queue count. The core
> allocates each queue directory and its release frees only that
> allocation. Removal waits for running attribute callbacks, so the
> transport may tear the queue down once it returns.
> 
> Suggested-by: Sagi Grimberg<sagi@grimberg.me>
> Link:https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Saravanan D<saravanand@crusoe.ai>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

