Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066A606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2pPEwn9h;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oqyoMYG+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rWvQ3bfeFQ3gYuvZj5vnEetlMqJHwk+wlW+zezer+/k=; b=2pPEwn9hsbf278
	YVZsTC8RGWX3mtzJJoPLntHDm5Epm55scJkNTrNAsd6nCOyarvSRs3QzPyhV8hH7WcIV5QVuSyloa
	+2u3ignB5tAh3TRXNze8ZFT/SeZ1FXB8xHgg9XuRdbm+otJwj8BKr9YU9Saro2jcfuVqizExmYTgp
	R5BSonEGzf8y7gpWXlG2r0Uu6j92adljL+4ggQPq9R/AX7P9YUYj2ZEXrY5v7xfTFiDFt/1jV7iZq
	q6dMqrqe7Oyjj1HPS7c6+zU4RsoTVSn6BU0I4c1L/W1TdSJpRQtHdxwaCyllNzhVcx6Hc7M+tFcXV
	zQZoJMxu3hWq3nkU3hrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTk2f-00000009qyh-309a;
	Wed, 18 Nov 2026 18:05:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTk2b-00000009qxX-0hgW
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 18:05:54 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHPufr077419;
	Wed, 18 Nov 2026 18:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rWvQ3b
	feFQ3gYuvZj5vnEetlMqJHwk+wlW+zezer+/k=; b=oqyoMYG+lgnfBNwH5PLWh9
	OHk8lbNFW4f5fUH0UXldYZtIU9qbDRrJMKqR1RRG99elPFsQh8MstiBrBjQYvDWo
	yJQowq1KUw9ya0qG1YJ0/HRPfEm6VaUocLy3OhjmEGqgyUJlkDXuhv2EuTrOIwwa
	oQRgTnImryz7TbUPOgzaUhBx1gODLSjQSrRkBH/Vu3V13JHmYaUp/cTUXBXwdVBn
	Km8mpH0Cye8vQYO80yAhErS1pyb01oXxKuzLY2gnIqmXGWjMKbYQv+X1nZCuKnwU
	OxG4rNbRUWv3cU4JNbRMl5p1RNQN2c2/aIB8m4ul+SCkAAUxHujmpSt2l75pLjxg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rkwg6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:05:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIHK22h1223884;
	Wed, 18 Nov 2026 18:05:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ngwag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 18:05:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AII5Vi429229614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 18:05:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9809658054;
	Wed, 18 Nov 2026 18:05:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B3EB5805A;
	Wed, 18 Nov 2026 18:05:29 +0000 (GMT)
Received: from [9.61.99.215] (unknown [9.61.99.215])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 18:05:28 +0000 (GMT)
Message-ID: <569825a4-3bf0-4601-8732-73d03e2b01da@linux.ibm.com>
Date: Wed, 18 Nov 2026 23:35:27 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvme-multipath: apply delayed_removal_secs changes
 to a pending removal
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261118-bug-nvme-mpath-set-live-srcu-v4-0-21f368376c8c@linux.dev>
 <20261118-bug-nvme-mpath-set-live-srcu-v4-1-21f368376c8c@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261118-bug-nvme-mpath-set-live-srcu-v4-1-21f368376c8c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RNMLemAdn4gq6UEjCYeJCfIwyW_4kPtm
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afde8ed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=D3BeKeDXJb-pPu9aK9IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3MSBTYWx0ZWRfXwigfsOPJyR1Y
 z0lle3RdLTFpBvjyaxTAKcDqN/VGUe5ofAKt465lTnMvQV08UVnNSPr9EghUeSv7+39j965Uezr
 H352rntxsBaXUz9iBUifG5Vwjp9w9EY=
X-Proofpoint-ORIG-GUID: RNMLemAdn4gq6UEjCYeJCfIwyW_4kPtm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3MSBTYWx0ZWRfXwt8AjxY2/TKw
 BOhHcNJwPHl8Oclt7DD7c42zraXjZAKGBOCGP9SKybgqfkzgmb25l37aiqBcPb1drR/3CsIjcOv
 9Lf+QFlcq8/0UV5OYyapm1l9pj+AOdHx06Dc0HF5jpoz/S9YDWsCVXCXn8Vpq8+zJEOaL0Q83It
 5CjIPqLjv3mMJEkhTft4F/iJ+hrPSM/SsOZ2T2gowT+LzOQTGqdFd+af0eCASNMOdeilDBOXiiO
 9yyJyKExkLso5zE1Y+TUii/g+oIuCGWl0OjEUSJy8OvdrGfCHDi9rNho1D4T2M9rieStY/1Bk8r
 RdAcOzoRnhly1kf68nmXa0ttHTYpGJKvesc9Ocsxs5Ymj0JAS1JmrwlvKbWu0NKXerKuQ6qR9Mo
 vs7EIsyiEvs26lYz+IHffffgCExLd2d60ANcqn/0xToNmuewZRPsFqcuXeI4Cr6hjkpHO6YK/es
 pmSFBs3fjlaSq/RVhHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_100553_228145_38848FE0 
X-CRM114-Status: GOOD (  28.86  )
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

On 11/18/26 9:09 PM, Qiliang Yuan wrote:
> With delayed_removal_secs set, removing the last path of a namespace
> head doesn't delete the head right away. nvme_mpath_remove_disk()
> queues remove_work with the configured delay, and bios submitted in the
> meantime wait on head->requeue_list in case a path comes back.
> 
> A write to delayed_removal_secs only takes effect for removals that
> start later. A removal that is already pending keeps the old delay, so
> clearing the attribute leaves the queued bios waiting until that delay
> expires instead of failing them, and lowering or raising it doesn't
> move the pending removal either.
> 
> Requeue a pending remove_work with the new delay when the attribute is
> written. Cancel it first so that the module reference taken for it
> carries over, as nvme_init_ns_head() does when a path comes back. If a
> path is already back and nvme_init_ns_head() hasn't cancelled the work
> yet, drop that reference instead of requeueing the work.
> 
> With delayed_removal_secs set and no path left, the attribute is
> changed two seconds later and the head is removed after (mean of two
> runs, min-max in parentheses):
> 
>    delay (s)  before (ms)            after (ms)             change
>    30 -> 0    26877 (26327-27426)        9 (8-10)           -99.97%
>    30 -> 5    27987 (27464-28509)     5248 (5193-5302)      -81%
>    10 -> 30    8152 (8095-8209)      30106 (30080-30132)    +269%
> 
> A direct read queued before the 30 -> 0 write fails after:
> 
>    before (ms)            after (ms)   change
>    26801 (26243-27358)    6 (4-8)      -99.98%
> 
> Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
> Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---
>   drivers/nvme/host/multipath.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ae8059366b57d..881d8a0145255 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1242,6 +1242,17 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
>   	mutex_lock(&head->subsys->lock);
>   	head->delayed_removal_secs = sec;
>   	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
> +	/*
> +	 * Apply the new delay to a removal that is still pending. If a path
> +	 * came back and nvme_init_ns_head() hasn't cancelled the removal yet,
> +	 * cancel it here and drop the module reference it held.
> +	 */
> +	if (cancel_delayed_work(&head->remove_work)) {
> +		if (list_empty(&head->list))
> +			queue_delayed_work(nvme_wq, &head->remove_work, sec * HZ);
> +		else
> +			module_put(THIS_MODULE);
> +	}
>   	mutex_unlock(&head->subsys->lock);
>   	/*
>   	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen
> 
The above change works and fixes the race which sashiko reported.
However, I think moving the cancel_delayed_work() check in
nvme_init_ns_head() under head->subsys->lock is more intuitive.

With that change, delayed_removal_secs_store() can always requeue
successfully cancelled work:

if (cancel_delayed_work(&head->remove_work))
     queue_delayed_work(nvme_wq, &head->remove_work, sec * HZ);

And nvme_init_ns_head() would then become:

mutex_lock(&ctrl->subsys->lock);
...
...
list_add_tail_rcu(&ns->siblings, &head->list);
ns->head = head;

#ifdef CONFIG_NVME_MULTIPATH
if (cancel_delayed_work(&head->remove_work))
	module_put(THIS_MODULE);
#endif
mutex_unlock(&ctrl->subsys->lock);

This way, path addition and delayed-work cancellation are serialized
with updates to delayed_removal_secs_store() through head->subsys->lock.
Consequently, we can eliminate the list_empty() check and the
module_put() from delayed_removal_secs_store().

Thanks,
--Nilay



