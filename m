Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68188606A8AC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3yJnmU+j;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TUN9+46e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wdrQMimsr06UsrvVkT4VirH0dk8ELFr3wh6/8qMiEQs=; b=3yJnmU+juSwVbl
	5+ED3D4vnatb8FhgpTDE2Bc9ZGkCwZmsXCQfZ42YP57JsJ+B3EFEI/cPUhI9MelPVeQ/SJsiOXe69
	wuxZWVPrl2YGPzztiv6ZpvuXpZRPtVMzeGJTIPfx0PecekrdUbwK/CBt1atyjaeFmy+/vfyPCAauq
	AP+bujt/YgXXYB07+Bh/VjssuMeC/ZMhYxNYv8n0SLjkv54M2S+a8ebO5LnK3vgbEFrM4MV6Y+o6m
	5GwF02C+eY+FmYjG6bQe8eydjkv2n75q+nNUYEWisOYOZGTeCAORD3TCSRekcYPnv/UaP7Mp2cFgI
	twb4qm+ip1lQx1Xjp/2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXxK-0000000AfXw-2lfh;
	Thu, 12 Nov 2026 16:47:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXx1-0000000AfSt-2oyC
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 16:47:07 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFiA4D243800;
	Thu, 12 Nov 2026 16:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wdrQMi
	msr06UsrvVkT4VirH0dk8ELFr3wh6/8qMiEQs=; b=TUN9+46e6ANBLl8YFflJLM
	Xjw6o+Y0BhPStb4LXmVuKYwsHxg9paj3n/yZz9zaOukowWZr7kG2HN3L5Klzeekq
	pNifxQZhtHIuPiqmmaSvdqtear11k1Fe4YUarmz9pEhIrjcuay9Z1kwbxT6kHwNg
	657Kn2GVGyRMDbv/NwwBquoHRV6u4tBP9s2fzh0En2wTWuw+GDx5xaxeeC93skVj
	5xeWqyMfir1rnbIkUGwOAueyoC2r7Uz1v0BkpMuK31+12wr/RwTdOSgJxZ3MF1vg
	xm6IRcQjTvK2YumhJxA4ItFDWBTIpDESlaj6GJtLZO/dpyibQJPDBbkYD8E5WCxQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq78e6g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 16:46:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFrIoM953027;
	Thu, 12 Nov 2026 16:46:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0x3ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 16:46:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACGkjx44981452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 16:46:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F36F58058;
	Thu, 12 Nov 2026 16:46:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5AB658057;
	Thu, 12 Nov 2026 16:46:42 +0000 (GMT)
Received: from [9.61.136.41] (unknown [9.61.136.41])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 16:46:42 +0000 (GMT)
Message-ID: <b5b0c267-85aa-48f0-bd94-bc00644e926c@linux.ibm.com>
Date: Thu, 12 Nov 2026 22:16:41 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvme-multipath: fail queued I/O when
 delayed_removal_secs is cleared
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
 <20261111-bug-nvme-mpath-set-live-srcu-v2-1-fc772914d293@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261111-bug-nvme-mpath-set-live-srcu-v2-1-fc772914d293@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX9bRwAkBd4RWH
 yDMo9+ZXTzuNTPydshpz5URheBYQLBdJJ6T+4C/o/SC7tbfICT8ziSbWhlEdLdiFxn16LlK8uH8
 U7wTZsbLTECOeEWRQK64d+Qg/0B040U=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af5ed77 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=1GhpcVe-4WaB1LUQQbEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r2Mv6_bmXUmPoK_lmRq0bg4o9xRXxGP7
X-Proofpoint-GUID: r2Mv6_bmXUmPoK_lmRq0bg4o9xRXxGP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX0BlMkSCKspHS
 ri2YrnOws1Km7hBL/+iaqHn/Aq9g+wVlrdzyNPk0slWsptw+CdMxuHSnnkV6E7YWFMFrxzbqVOd
 fEJvmVCou4bo4OoE6lgrEAus3oxgfRPDSrN50RkW0/OQDHGkTcegXMhyb/7l7Gkhh13BDN/KAYL
 9CQGE/9nxsYb+7Eaps7e5OfYijYl0P3CODAhTIWmqUanZ1lVtw+h2LF/Ms6GmJxhqLTF2fI3rvG
 c86FQv0fFyvS83ssVsiubVpMZetRKMPe4vB/TzIlqcvJX7IKqOMgKfW2C5adUAv7bzpPFv0M+H+
 WEdLVUWkRqyAumGIo/PdDxMa6wyNMbSFHJvMKl7ZVA97iIwma1eFVY1ZCmkuSIbG+RchB3/cgZQ
 TJVkdodh2VJiID/vAmxvk2WXPWj4FC/suIDwQUfSOtpuMuS1MGnqMA42FztFROhFu+/5zqQsJBO
 jccMWPz4KR2joCWcOBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_084705_055954_CC34A09B 
X-CRM114-Status: GOOD (  26.08  )
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
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 6:40 PM, Qiliang Yuan wrote:
> With delayed_removal_secs set, bios submitted after the last path goes
> away are queued on head->requeue_list, in case a path comes back before
> the delayed removal of the head.
> 
> Writing 0 to delayed_removal_secs clears NVME_NSHEAD_QUEUE_IF_NO_PATH
> but doesn't kick the requeue work, so the bios already queued stay
> there until the removal work runs, up to the old delay later, instead
> of failing right away.
> 
> Kick the requeue work when the attribute is cleared, as
> fail_on_ctrl_loss_store() does when it is set, so that the queued bios
> are resubmitted and fail.
> 
> With delayed_removal_secs at 30 and no path left, a direct read is
> queued and delayed_removal_secs cleared two seconds later. The read
> then fails after (mean of two runs, min-max in parentheses):
> 
>    before (ms)            after (ms)   change
>    26234 (26209-26258)    3.5 (3-4)    -99.99%
> 
> Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---
>   drivers/nvme/host/multipath.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ae8059366b57d..a92a05b1f925a 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1249,6 +1249,10 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
>   	 */
>   	synchronize_srcu(&head->srcu);
>   
> +	/* Fail the I/O queued while waiting for a path to come back */
> +	if (!sec)
> +		kblockd_schedule_work(&head->requeue_work);
> +
>   	return count;
>   }
>   
> 
I think the original design was to apply an updated delayed_removal_secs value to
future namespace head removals, while allowing an already pending removal to
proceed using the previously configured delay.

When the delayed-removal timer expires, the removal work clears disk-live, waits
for the SRCU grace period, and then schedules requeue_work to fail I/O that was
queued while waiting for a path to return.

Given this, I'm wondering why we only kick requeue_work when delayed_removal_secs
is set to zero. If a delayed-removal work item is already pending, wouldn't it be
more consistent to rearm that work based on the updated timeout, rather than only
scheduling requeue_work? This would also ensure that changes to the configured delay
are reflected in an already pending removal.

Thanks,
--Nilay



