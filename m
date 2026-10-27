Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62044606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZAJMvuMY;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BkS9fvh8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4Vjeomtc6hG609yK/1ODIpDfxqsbnTFOHlXuUS8oxWg=; b=ZAJMvuMYfTUFci
	yakD3BhJQsiCOYn4RFKvRnV9NhybQ2iOoCIGzHcv+O+nbaNb3iRMMrTtCVSyfOSowXgfW0p9eRkzh
	6ft+ktiR8EG6Bt8JUcw6WnYBa4IZ1m5NL5n9TWv+siG5mkpmYEpiJgDARsNX6Kl75GKWfM0Xaenxq
	zNUcu99DYjyJDwmnIR1DjWsnqo9G3KH/nZCUqYy2JBDtPuzhpAu6Z/VDll68IOT+DZ2Uapf1KXpBS
	zpOk0vyWwf3ilkQmXek9uFcfudv3qFxU6MQN+AlT7c1R0F7v6ocKtMjHj6+RgdWdDF+vZieWH+Mq6
	AtRGaOiL1WdYtKowsWJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLf6y-00000004QEy-2eUf;
	Tue, 27 Oct 2026 11:13:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLf6v-00000004Q9w-3gNE
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 11:12:59 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5iqo31527608;
	Tue, 27 Oct 2026 11:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4Vjeom
	tc6hG609yK/1ODIpDfxqsbnTFOHlXuUS8oxWg=; b=BkS9fvh8TvsAytkH9kw/H5
	9tcgvvv1F0YFBuXYzH4rTTVSvRU+ChtAYb9tuSEPzzVkIdUs0cESkmWYVmN8oNjl
	9D2vxjMvjoGrGyvY3519MeN8anO5GGmU0k5JtrvHmbrgmDkao/o9sywDnfrYq99O
	6Iu8cAzqLnUKBCN/+2zgbBbvzjquYKpFQtVsWHQZ5kx1wc7eSHUWNEWRwhRfheEG
	Q8mRsy5G+Lsw+oo/Krlonhkr5k/oX4d4yRv4rrnrpOqIur0CYt83xqgpFrfSTKvG
	jNZGzzePpVdeEDBx+QydTdeclegOqZWZIdtW7gsPiEOH1IPLWVbxJ9FWoL2tLWPA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavej97-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 11:12:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAXhIp3745287;
	Tue, 27 Oct 2026 11:12:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh2b40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 11:12:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RBCYbS30540432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 11:12:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 662255803F;
	Tue, 27 Oct 2026 11:12:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3DFC58061;
	Tue, 27 Oct 2026 11:12:31 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 11:12:31 +0000 (GMT)
Message-ID: <7e73b7e7-190d-4c81-af7f-aac1c0233931@linux.ibm.com>
Date: Tue, 27 Oct 2026 16:42:30 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: Validate the queue state under the queue
 lock in the address attribute
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261027073725.2292265-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261027073725.2292265-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae08723 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=S-favvd9EZlU53cgQb0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U0ROndrqHMRI72_9krVQfyUwoa2yc5lE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MiBTYWx0ZWRfX4Xw4Rwt5xjrb
 PbTJseZNH0vDVVqRrvqOddajUGnlO1H1AEdASAKeL/Q9Sqqf0gQALd1alZD48WLbSYiPPYi91LI
 mped715uy2FqDfCyTZ+FMzosnpENly4=
X-Proofpoint-ORIG-GUID: k_lfyV27YmBfIZ6cUJSXJn6sPTBbApyk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MiBTYWx0ZWRfX5UNTrA+gsgzJ
 Qskhpz9/RHOdNJF9fpIue1kuTF8VeaDvdk651i/t4zmoHiJtog/bAqK3nF5cuK2UTF2f8auoKyv
 m0+2J3jeYp352RgnmQcNJ25QKEhS3Spc4/QSTbHXVUxMRWMBj7kzMwzfD0pbmqBbFxaE+RpS+kB
 02QuOHiYbPbMYXAxnmnYUlf8HeioYpQOBqp5TBgrXDyiI8Ejef/Qk1kWw7/LzeX2Rixq/rJMETC
 YLz7u4yc03xQ6LS8vHZAbgk+tahfPk7WosYw3+6UbrDdTc1iVJ2ZYG+7BHew9oY6wpGhglMUmOC
 uzrr1JHr6AO+7FijvY8fqZJ8kOsjkcWrFNvdBEql0ioj3qYo8hXSxPQrUqoRVfKgjNKzwNU9Ykt
 DW13vKW1SgjTwN3YF3uiyej+zDYSowRZsVfh2tRoSjND3uVQGiLH3xHeI32M1UihpEILLmwY5Cs
 TxDlGKadrkeRXvQbYNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_041258_068091_AB7EAD13 
X-CRM114-Status: GOOD (  23.81  )
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 1:07 PM, Guixin Liu wrote:
> Reading the "address" sysfs attribute calls kernel_getsockname() on the
> admin queue socket, which can race with the queue teardown during
> connection error recovery: a reader can observe NVME_TCP_Q_LIVE set,
> then block on the queue lock while nvme_tcp_free_queue() releases the
> socket and clears queue->sock without holding the lock.  Once the
> reader acquires the lock it dereferences the NULL socket pointer.
> 
> Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
> error recovery") had the queue liveness check inside the lock.
> Commit 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock
> and destroy") moved it back out because the lock itself is destroyed
> in nvme_tcp_free_queue(), so a reader arriving late trips
> mutex_destroy().
> 
> Check the queue liveness inside the queue lock, and clear queue->sock
> under the same lock.  The teardown clears NVME_TCP_Q_LIVE under the
> lock well before the socket is released, so a reader either sees the
> bit cleared or a socket that cannot be released while it holds the
> lock.  To also close the lock lifetime race, the queue locks are now
> owned by the controller: they are initialized with the queue array and
> only destroyed when the controller is freed, which cannot happen while
> a sysfs attribute read is still in progress.  The opts-derived queue
> count is used for both initialization and destruction, as reconnects
> may shrink ctrl->queue_count.
> 
> Fixes: 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock and destroy")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/tcp.c | 46 +++++++++++++++++++++++++++++------------
>   1 file changed, 33 insertions(+), 13 deletions(-)
> 
[...]
> @@ -2627,6 +2632,10 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
>   static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +	/* the same count used to size and initialize the queue array */
> +	unsigned int nr_queues = nctrl->opts->nr_io_queues +
> +		nctrl->opts->nr_write_queues + nctrl->opts->nr_poll_queues + 1;

This looks good. However, since the same expression is used to calculate
nr_queues during both controller allocation and freeing, would it make
sense to define a macro for it and reuse it in both places?

Thanks,
--Nilay

