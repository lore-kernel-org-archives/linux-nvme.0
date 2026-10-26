Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A150606A31D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zGAo1OUk;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IEqXSIYp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8wEwEB2mVxz0utoKjv+sPBJATrRXuRrwAqnTVX7WR98=; b=zGAo1OUkDdc+7C
	L8A6ufM1rwTa0RKtDv/kvFg5XGYSJN3K41hmYYsZboJGfuBgWGtQjsxOHNn+60YtaPLDIFIsb26Gx
	9Jas0AKRi0jO16+K67DUaWEdAlpoWZw07Oa/I8m9WKQCkht78HPA4df5g8KcRzzym2BRElHX1+rVf
	Z+B0lzQ3i/oCHBgOTahYIOgsLVXM8qaPVu4IgaOe2HSD/xx3vddmnrVkrx/S255Z7hUQIqG6UIeYG
	9aTVrsakkVfyOfncCHHPIOcE1Xi/2W6/mbxnL97oQPQGpPatDATblTycraK7Q/q/rrcmbgema/pm3
	9ZCETPf8T0w19lq6yh5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLNGo-00000002qL1-2oSp;
	Mon, 26 Oct 2026 16:09:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLNGl-00000002qK9-3wNf
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 16:09:57 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QFE9Mb2295465;
	Mon, 26 Oct 2026 16:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8wEwEB
	2mVxz0utoKjv+sPBJATrRXuRrwAqnTVX7WR98=; b=IEqXSIYp3T0wYFGUEnoAKZ
	q7/MWzhGjku1pDDiP9/FrJcmV83rFCe3iJCh0kWBAIutG4X0h2EKn90fo7umhIFi
	Qph4FHvhMfelZAO4VnMLPo9Rl4CyGH+U3g8qWx7QMXGPNNR1da/hhrqPu7bj0RJ1
	N66NV0kldESUNp24El8kiL22BRpToY4JKEiXtjMfEtzJMy63vaaaOQf/GzshE8/d
	1xu97HIyCDhOzbHkrz9Wb5iI8NcFxXy+YFzCEL0CZsYBTyMcvpEwXgWYiJhBO70B
	SegLmsRdO+kvrzzX9rsZdQ72lV2iAehq0xZziqqE/7T312dBSsNYPsMK23MpP7vQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsu1ar-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 16:09:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QF50P01551779;
	Mon, 26 Oct 2026 16:09:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gpkwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 16:09:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QG9er962325238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 16:09:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C92B58043;
	Mon, 26 Oct 2026 16:09:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F7705805D;
	Mon, 26 Oct 2026 16:09:37 +0000 (GMT)
Received: from [9.61.162.42] (unknown [9.61.162.42])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 16:09:37 +0000 (GMT)
Message-ID: <fd85a538-14c0-4186-80d6-e755b190530c@linux.ibm.com>
Date: Mon, 26 Oct 2026 21:39:35 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Validate the queue state under the queue lock
 in the address attribute
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261026105532.3688128-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261026105532.3688128-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2MiBTYWx0ZWRfX2lwI+BaVS/F3
 DY5AqKWnxlczYWKHv/7PSYpxaDspwvySLWFO5wO1q4yXMxcLhpB/VuItwkhAlcb21k3FKJsonsQ
 gH4N0M74GYgTA65W12EOoqYsUDvXbt+F/u6CqgQtmXJ81uvwT5bOs7CTfUXOQzaZw0QW1SzYJK3
 3Tzf+Gu72b70F4Bu2HFjacFyq/B3Vf3Oddkj+eIJwnTf7we10jSkFxr3j7/xzYOHAL+Nk5Om1Oy
 0GQmOWSU9WUeqPHXU7z4FM2Mi+TqaVUVB3BQKTLWxFZ57lkl2ijSQDz8JVc90+SjtDsEXUBm/Cj
 P0RvoKoBuLpHR+2rFQLsvLSG9lmEJCkxM0KVPweJAqs5aI0ZuoSwNElxUyUDwcs6yhTFDiW5bJb
 B7y/XGFPpUiAaZGr9SEzrUzlVcA/t5qH4Fi9fIHiuxj+bFWA7O+YM5akIj+C+k1aOzkSFPouZie
 ohDFSbjEcExSyLgBJsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2MiBTYWx0ZWRfX15ExAJvLFOP4
 QUL1uy0eAq3M02IbB+Tnl+VkXzjW90/uV2hIDJ77SwM4MjtI/1KGI9t/k+6PxD5/4LAvfIOTiBr
 suYcdq1Et78qNxIRjyx1KoVr7oStDx0=
X-Proofpoint-ORIG-GUID: RhsoRAmhdHAg_t55nikAc4SfkUfhZXYl
X-Proofpoint-GUID: m7FglFZmDBLs1CqPk_she-QErQeKFL6_
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6adf7b45 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=S-favvd9EZlU53cgQb0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_090956_004922_7B8B733A 
X-CRM114-Status: GOOD (  23.48  )
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

On 10/26/26 4:25 PM, Guixin Liu wrote:
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
> a sysfs attribute read is still in progress.
> 
> Fixes: 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock and destroy")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/tcp.c | 43 ++++++++++++++++++++++++++++-------------
>   1 file changed, 30 insertions(+), 13 deletions(-)
> 

[...]

> @@ -2627,6 +2632,7 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
>   static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +	int i;
>   
>   	if (list_empty_careful(&ctrl->list))
>   		goto free_ctrl;
> @@ -2637,6 +2643,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
>   
>   	nvmf_free_options(nctrl->opts);
>   free_ctrl:
> +	for (i = 0; i < ctrl->ctrl.queue_count; i++)
> +		mutex_destroy(&ctrl->queues[i].queue_lock);

What if in case ctrl->ctrl.queue_count changes during the lifetime
of connection? I think in case num of queues changes during reconnect
then ctrl.queue_count would not represent the initial value of the
num of queues.

Thanks,
--Nilay


