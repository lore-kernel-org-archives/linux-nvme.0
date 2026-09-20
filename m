Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE367C982D0
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPj2aJtlZC2B7mxhgmoEZ/eL4C4zT6BNQeOryEiiC6Q=; b=PeVCj6wOeDheq1dr2EwIo1Aetv
	wK8xHHDLlahNyuR2WmyRPg8+N2zvVGRjqXMtrmaKToy8YiA1HKa9eCcvCiCsKZyH+az8wyS360kV8
	VTEsyVwp6d3hENcQgl4ieUQ5XVsYuq5Pa92WFys9MBJ1Y+shcW7dwmdKsUme45BYplHEIEHUVJ1w3
	UGaa8i2F+nkmvtO61ES7FHr+R7vmQ4nynVNG3aZQZZ4une27d5Q5Aj4SO5NFy6V6WCUbk49u5LY95
	D+h7ODAENFx5uVBji96gTLNIQqflLJAacMRQEd8wqS7B4/hOseRyZZKKM7oIoREhTaIHvuSo6v3cY
	+r0aj1bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ESh-0000000HEbA-15S0;
	Sun, 20 Sep 2026 10:07:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ESf-0000000HEaG-1Kmd
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 10:07:54 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K8ZYdo373513;
	Sun, 20 Sep 2026 10:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IPj2aJ
	tlZC2B7mxhgmoEZ/eL4C4zT6BNQeOryEiiC6Q=; b=gdYWqGCS3bohLUnr/frHv6
	pbZFAurb42z/AvU24j/sYk2OxZkK0ZerOEWXU18B++MdoWXcmKPf/JJ8BhIJkz5Y
	gVfYHzLpY9V8iEhm5UNsHyAFIZuDo0J9ep817UyUOvSlOmcDIqzu9Wa/nMx9MFx1
	k0tciXGcsu0an5ewzxXa/JLBp374SCFy10LCt8lbDpdI7TUfAcECOHjj/66UHU32
	0xVUaf6aYIF/HpkIQToSasdjp1CV9UI9WzGbFru5x3gQfYV1adMUi+ow0OfyHdzv
	O78Om/Je2URuoat1WAbEo0U8vWrK6R4XlB9XANQvTV5ydmDv9riMYvmxVX+DPa7Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1c4r4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 10:07:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68K8WTUe3689120;
	Sun, 20 Sep 2026 10:07:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq1ax4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 10:07:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68KA7aEZ30147244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Sep 2026 10:07:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49A335804E;
	Sun, 20 Sep 2026 10:07:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AECE5803F;
	Sun, 20 Sep 2026 10:07:31 +0000 (GMT)
Received: from [9.61.138.180] (unknown [9.61.138.180])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Sep 2026 10:07:30 +0000 (GMT)
Message-ID: <0c2345c6-f4f0-4e7f-8a70-58a4ff734a4c@linux.ibm.com>
Date: Sun, 20 Sep 2026 15:37:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] nvme-multipath: expose path_state via sysfs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260920025214.3089533-1-kanie@linux.alibaba.com>
 <20260920025214.3089533-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260920025214.3089533-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: s2uqBr6SIvaJLz1kLvkZEw-LhGZIHI4z
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6aafb06a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=aoXNJ8CIXF7otjfFpLUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE0NSBTYWx0ZWRfX4RMGb268jInN
 8kNfzXfYL4jIrkpkd3c4B8hf/oIh5ssjlzAZA3vwDqkZ7ZoPp0BA4Oi58K3FXBpnho+FhiRQzdA
 q9yRbi9368elUqYzdrsOX9Bz/uGN1AY=
X-Proofpoint-GUID: 7_F0zp29VrhTUytlQ-ODm6b4r62hCa45
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE0NSBTYWx0ZWRfX4ADRx0q3dTit
 bDaXb4nDTzj84iHuwyYSwKbPHj3e6FtMKvI8qzh3bVCfz9Hgw7UiiskaZUIjSsrFPqTpz7T6w7F
 8Fj8I958FJyZ7TQLwaOjXpXxVlPw4BnnKC+lafaG/7s7pcfQX9kjwclJB6VDG54ihTzEHEIR/7C
 xkbmRqUcERfwO4rlew9KQyIBIeEG+FtdkQh4YPs7dgld0tjSr8QsrkOU0f25g4ry/iBbcvRktIO
 JE3hr7N9ynCjUGMx6gU8nvutjJ64SojoLcgqYg8bNFDEzhWQRxLks6dl2TA4L2M5OSTb5RTIDSG
 KJH3G1ew5WED4EWWdypgQPbaEAAGTbQ9EGidKvE/zMp6j4yfCfH4OiO8j1h7kdmvxqmgMeohWy1
 C9za2AUyHd18OCIQb7THLQl1xi63ylUNcsdqeIWqY9Zr+5e2TmB7+RIwEmYcF5twMdJ4CwhQKUm
 k3nQb710E71lrSeAO2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_030753_366203_1BA0ECEE 
X-CRM114-Status: GOOD (  14.94  )
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

On 9/20/26 8:22 AM, Guixin Liu wrote:
> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
> current path state, including whether the path is enabled or disabled
> with a specific reason.
> 
> Factor the path disable checks from nvme_path_is_disabled() into a new
> nvme_path_get_state() helper that returns an enum nvme_path_state. This
> keeps the path selection logic and sysfs reporting in sync, so any future
> updates to the path disable criteria are automatically reflected in the
> sysfs output.
> 
> Possible values:
>    - "enabled"      : path is usable for I/O
>    - "ctrl-down"    : controller is not live
>    - "ana-pending"  : ANA state change pending
>    - "ns-not-ready" : namespace is not ready
> 
> This gives userspace visibility into the multipath path selection state
> without requiring users to piece together controller state and namespace
> flags manually.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

