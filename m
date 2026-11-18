Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D11606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ez0ABDCB;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TxtEkeqe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DD+ek40OQ3Io3dLgitp/gYv+ZpR7R+u8Zwwo0XJpBOY=; b=Ez0ABDCBDtVXYc
	U4EWtlIrjgfiwO4da8sfynGeso7mDkZHDquLrX2NB7lyzrpN9sTerGj/GdGjAQ8KHFD3ozLtNtSIs
	jX1ajNOfRzgqUvTtZ72bFvI6yhm6UYl9YxFe2vg9sLawdAVklJE+ROJgALVkdSFXNvUC3Cz28mILW
	hg9CUztBGKvtPuKgZRBzIuzqMLYmVbFz92GDYqzop0SephGvQhlKqz6HRfVGzQNW7eeOvs0VnFuL/
	cmaBaFl09xJLiGDINZDYXcfBpQ8Ys6hdj68HLGK5YWs55VjJTG3V9reiOBk3Q1qzO5BTVQq84RzX3
	nfgcQLu5WA8x410+7vVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaSm-000000084KI-3q6f;
	Wed, 18 Nov 2026 07:52:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaSk-000000084Jv-3wXc
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:52:16 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SDxf4044933;
	Wed, 18 Nov 2026 07:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DD+ek4
	0OQ3Io3dLgitp/gYv+ZpR7R+u8Zwwo0XJpBOY=; b=TxtEkeqenZQzs3355kym+G
	nwntYk6u5ZgRo85YQNLsA5TxSYHVylCzRBwALH1R/hALHY9Kd8jkERmbFHbi16hP
	I8RSXfjetyRgH3qZYPuRtevWl9jY3OPULLrbX2hE+4ETKqMl5VOUAWsGheuTxywb
	W6mFU3kAhUX/9srO9SsGzMTkuN5lUQEVemUUk54IC9t5eyw0PECGBif+CaIuZhDZ
	MhVJQDg43ErEIRbxEiHZATK+xuYupgSit20dGfOcWZzZouyhzvQZRPaycYWC25d7
	C3649uFSKbKn/dWVOxIlpUoKmbO02LorF8JnrYCelXyi6NyfJCPxzfcgOqr6GSlw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wscb4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:51:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI78Al61660723;
	Wed, 18 Nov 2026 07:51:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4r36e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:51:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7pv1n27460200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:51:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FA84581F3;
	Wed, 18 Nov 2026 07:51:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19A12581F0;
	Wed, 18 Nov 2026 07:51:55 +0000 (GMT)
Received: from [9.61.157.4] (unknown [9.61.157.4])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:51:54 +0000 (GMT)
Message-ID: <712711ce-558b-4d58-b5e3-fe0a31eb8986@linux.ibm.com>
Date: Wed, 18 Nov 2026 13:21:53 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvme-multipath: apply delayed_removal_secs changes
 to a pending removal
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334@linux.dev>
 <20261114-bug-nvme-mpath-set-live-srcu-v3-1-d84651de6334@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261114-bug-nvme-mpath-set-live-srcu-v3-1-d84651de6334@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gcGu-DDTEKxBPENJUBaz5vOm2KffZmbx
X-Proofpoint-GUID: gcGu-DDTEKxBPENJUBaz5vOm2KffZmbx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX0e7M2gpwhN56
 2L+Biuse3kRSy8CAQ0rs6q3NB5eLVzoQ+BFocuIN2nnwCbcTJ9wlL02M2HbwngdfPQqSyaXtgMR
 2DXrTPtVGCTTTcdpjwmMakC4HDW7EisT/rj1yxnPLA3CmvNqTSRoSpWN506KvIOR399bc+/7VRU
 rUiTAMRHrT0z5n23RvB4z1K0sBYjV7uWpXV+HbOmH8Q/nCFC4u3yZy8EEQ5Efvp9/AKyARb+AXe
 dnTK3TR/IXm1HS8agC9BICIiB31y6odisUjm3Vc5tu1mxFpnPu/d+UvonHdE7NGJTM3Omc9KOR4
 Vf2q6m990WW4ufy2lbYRYuk2LKkclYBA0SyZUznFhC4pF9GhATQMTJM12z5lLaWBQ07Qi1xX/4N
 ne9a1sxhOlpjCgPaw1xKYAQ9ZidBaoHOzZyxP0oUm6izakOlw8kdFX5/EvfQ+Gf5lPeow6fLrKh
 XCq5tfKFE1cOTqUOpsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX7Gz0DzkuLhBf
 RjoeOELJYBYoZCMVjV7/ZqgtAoKfaAq3+iIlNu9qSEVobAlsWzu5aM/DBDvzn1jffify3JWazBU
 +s7JR27xrwDW8SGuWe0QnpjgtyaEdGM=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd591f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=6lXwRn2U9-3ZQ798VywA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_235215_120584_B0067DB0 
X-CRM114-Status: GOOD (  25.47  )
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

On 11/15/26 7:45 AM, Qiliang Yuan wrote:
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
> carries over, as nvme_init_ns_head() does when a path comes back.
> 
> With delayed_removal_secs set and no path left, the attribute is
> changed two seconds later and the head is removed after (mean of two
> runs, min-max in parentheses):
> 
>    delay (s)  before (ms)            after (ms)             change
>    30 -> 0    26510 (26053-26967)        8 (8-8)            -99.97%
>    30 -> 5    27994 (27457-28531)     6194 (5589-6798)      -78%
>    10 -> 30    8131 (8086-8176)      29802 (29522-30082)    +267%
> 
> A direct read queued before the 30 -> 0 write fails after:
> 
>    before (ms)            after (ms)   change
>    26466 (26017-26915)    4 (4-4)      -99.98%
> 
> Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
> Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---
>   drivers/nvme/host/multipath.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ae8059366b57d..35278b9c4de60 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1242,6 +1242,9 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
>   	mutex_lock(&head->subsys->lock);
>   	head->delayed_removal_secs = sec;
>   	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
> +	/* Apply the new delay to a removal that is already pending */
> +	if (cancel_delayed_work(&head->remove_work))
> +		queue_delayed_work(nvme_wq, &head->remove_work, sec * HZ);
>   	mutex_unlock(&head->subsys->lock);
>   	/*
>   	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen
> 

Above change is good however still we have a race which needs to be addressed
as reported by sashiko here:
https://sashiko.dev/#/patchset/20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334%40linux.dev?part=1?

Can you please address it?

Thanks,
--Nilay


