Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4B1CDB46F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4yPCWZim4hUbxcm86HSv3Vislx57JRrPAfB5+y8zzs=; b=qJIfZIhGTjQkeiubWwTbX2lC29
	GovfAwivAt5lKcjXH9qTfGruzIGTlo0XXkJ8nd1oTjWxYcXQmXufXEqx7Z3Ng46wv9OICCufK17gZ
	OzgVxHcw4tgLaARZO8WfXvbx4WZE4e1g7826A2kBENr4LRIzZdVAcG7e7agKgCH9C+b68zUqD0jNR
	moRCBl6d2moqoHNIlMjcAmH+AP23tASPbY65qbdeFRZIMcUL4g+M/M8drxRMCKGZWrZnJOqQgCE90
	LAxn6LS6aLsQmIj7y0RzHCSS0Fhc1ZicCRRa7aft7gZNu/sIZclHNYJgTn+3L2ggBGB2JjA/UqSnZ
	2bHPAtTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbdzG-00000004yNS-2lKv;
	Mon, 22 Jun 2026 12:42:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbdzE-00000004yMj-1r2t
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 12:42:49 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MAmxZq2712379;
	Mon, 22 Jun 2026 12:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x4yPCW
	Zim4hUbxcm86HSv3Vislx57JRrPAfB5+y8zzs=; b=aWyjHNA+ECJ69iGOzz9YBd
	rIPdpKG5+P7+z1HatiNvrgsLX7csAKulVY285Ta5leHnVgt8nTfB6QPGeI1fVXmV
	XS/dEjrx5aDicGH3rL9/eKYA8jhRAdKTzWBdKPm0V0WbJo+eAl3nKCgWlGPxoU4Z
	mli+i6szi6oRUAsJPGCJKBQFPIIlCfdo+WOB+VtuVZz5LYdpt0NUOmEAUe/sYxNz
	E2Q/n5Tt9jfIRhRfHG8zZs5nTwwC6yWDSkuzwR4e9XsLzf81S4cQKYusMJOIKUhE
	7kTChX30C9WCGMISOdegPJmOxu3K8q0N3ZM+O97iIC5xzAMXVQqbdA7YV/RxSPjw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqh40g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 12:42:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MCYbIq023527;
	Mon, 22 Jun 2026 12:42:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw6a1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 12:42:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MCga7S31654614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 12:42:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1339F58045;
	Mon, 22 Jun 2026 12:42:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC16B58052;
	Mon, 22 Jun 2026 12:42:32 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 12:42:32 +0000 (GMT)
Message-ID: <3ba6ae70-9541-455b-932f-3a44f7a576a3@linux.ibm.com>
Date: Mon, 22 Jun 2026 18:12:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-rdma: avoid stale device wrapper in remove_one
To: Cen Zhang <zzzccc427@gmail.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
References: <20260621135939.2658295-1-zzzccc427@gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260621135939.2658295-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a392dbe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=WWNdeJu0_B9dxwiAr8kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEyMiBTYWx0ZWRfX18Xl/NrHn7e8
 PM1LcbAcSOH+KoSsL8AZhVjvZQbA9mOzbKeUYqtg53WGLHmeMd0hUCfWOwMZ1PmNBWYsSb/nXSV
 dLv/VdIcAweLWnGYLL9dLFlDDrq2Til/f0ILIl2Al4wtleryWWGejD2uBM+N39R8NhQlwinBVrd
 4eO+JdNeSTbWYRFXupm6D6XcXtl4xpofxugan6vUQaSTJd+au7xochyKXnT5v/sG08XBPqZtHZt
 L++0Vzr1Gy2al4B/14Mhjqne0H2yN/USWhElyIHwVxglEl9UzbLbx4YGQ/DSvm1mEo84VZvgkqy
 cbcBGZWTQ7X8uRnnSigZ9Yjuajzz8h2OAg/cO6fiWkpFi3CtvVqxyn2uLPmAPfPVsQyeNxnlhEC
 iQaSOHGrzoGGTF/gg5cb7pF303uFecp8AYlOimvfnWvZ7HXSXCSF0cB5dGd+IKYmKO5PXE+NH6o
 GNrsQQTrLII4ruq3Kow==
X-Proofpoint-GUID: zWIrN67qvlz0YZkbQvPR_f_Qc3nDnXF3
X-Proofpoint-ORIG-GUID: J72NhZ5sVdXPnyKvn2bIN_Z9NndoumwU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEyMiBTYWx0ZWRfX8JMjBonXMGA6
 twC0ZQfjTIEDg6XCfjI//+w4QEJu71iNATk8lupJbQAlsuZzeSBUvBodse5hh0/volsQPLD+lcW
 Qju7NnRwq/mgq/JDJ6gLK3aFdAwh6cY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_054248_505606_4723AA9E 
X-CRM114-Status: GOOD (  17.75  )
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

On 6/21/26 7:29 PM, Cen Zhang wrote:
> nvme_rdma_remove_one() walks nvme_rdma_ctrl_list under
> nvme_rdma_ctrl_mutex, but it identifies matching controllers by reading
> ctrl->device->dev.  The mutex only protects controller list membership.
> ctrl->device is a cached copy of queue 0's nvme_rdma_device, and that
> wrapper is refcounted by queue lifetime.
> 
> The buggy scenario involves two paths, with each column showing the order
> within that path:
> 
> RDMA remove callback:                Controller error recovery:
>    1. enter nvme_rdma_remove_one()    1. run nvme_rdma_error_recovery_work()
>    2. walk nvme_rdma_ctrl_list        2. tear down the admin queue
>    3. read ctrl->device->dev          3. drop the final queue device ref
>                                        4. free the nvme_rdma_device wrapper
> 
> Fix this by caching the ib_device identity in the controller when the
> admin queue is configured.  The remove callback can then compare the
> cached pointer value against the ib_device being removed without
> dereferencing the queue-owned nvme_rdma_device wrapper.  Keep the delete
> workqueue flush conditional on actually matching a controller.
> 

I think, instead of caching ib_device in struct nvme_rdma_ctrl, we can take a
reference on the matching nvme_rdma_device (or ndev) while walking device_list.
As the reference is taken, the rdma device would not be freed until we put the
reference or while we loops through the ctrl list.

Then, loop through the ctrl list and compare ctrl->device directly against that
matching ndev. That would avoid dereferencing ctrl->device->dev while reusing
the existing kref-based lifetime management for nvme_rdma_device, rather than
introducing a separate cached ib_device pointer. At the end, we can drop the
reference to ndev.

Thanks,
--Nilay




