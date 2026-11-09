Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA16606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HtsbizUj;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nG/svqOg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FYEJ9KHekUaIW8m17zKmXcjo7ZmwQ0L5S9brJ4Eud8Q=; b=HtsbizUjt0XLRe
	AT0yz6LUsaZ8Xa24xSgwc4ICNAji+7kNIOBtjiorc0BmoyEJM6vkRilXNdjpA8kaVVkIXVoXrkwv9
	tzBGqeSBH7x82uiG+Y5iyn7woUMuq5VCBhFwwmFJ9ugnZtWY1szzRl2Fn9Ow6kCo0tHIDrHvP1rTJ
	rrY4g/PSYlhtmSfGxjCa65TAZtWoWJOmkieeljUhLZr36B6Mj121/ck+M4qVz0onI3TWyGPnqOGem
	kj1gU/l6EwnuSXJiQIjMkhO7ZRawWfMU/ElCs0az0Q03enzjdvSXuqHzWnDHclaigNiLNGFzFsP85
	QrksdEKBdY/RJnBqw2hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQNkG-00000000Z1P-0Pw0;
	Mon, 09 Nov 2026 11:41:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQNkD-00000000Z0c-0nIs
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 11:41:02 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AEAmC1915846;
	Mon, 9 Nov 2026 11:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FYEJ9K
	HekUaIW8m17zKmXcjo7ZmwQ0L5S9brJ4Eud8Q=; b=nG/svqOgtAY9yge9FFJmLO
	Yufh9J/0BjaNSAISRuvTRPHhr/P5iKFMi2GjucZlrV1SkU8h3tll1zj0g6mq2YXM
	XUxX/zvEQHJ5pMoZ4pggx1qEjl4oWet6x9s7Key+AlfSS0okrUm5/44RrYU2TFDm
	NUhbac/lRRB5sBWqVr8wP1Tgm+G5Wt5dn5a/IjrodTbeuCRypyhvKc7niZ6yGCih
	rAxJHw0PesEXllb0EwZq9KCinyqt+RXhQ7meyLyvH/RCaaJ8ejCIxhtvnmsiYmme
	oMlgq0qKRMDHsw0jcEysIuvEtgm/pp/tuYg3wlNIz5ppfAS6WNYi95GKUVzB+bBw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdfvnfc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:40:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9A4ufg2923995;
	Mon, 9 Nov 2026 11:40:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghfy7pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:40:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9Berjq28181210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 11:40:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C040558058;
	Mon,  9 Nov 2026 11:40:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 797E658057;
	Mon,  9 Nov 2026 11:40:47 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 11:40:47 +0000 (GMT)
Message-ID: <16cf83a9-d147-4a4b-ae67-93ca07923f85@linux.ibm.com>
Date: Mon, 9 Nov 2026 17:10:45 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, sgogte@purestorage.com, hare@kernel.org, hare@suse.de,
        linux-kernel@vger.kernel.org, iyamahata@crusoe.ai, kiyer@crusoe.ai,
        ganbalagane@crusoe.ai, sjpark@crusoe.ai, bchen@crusoe.ai
References: <cover.1794015622.git.saravanand@crusoe.ai>
 <394e47d486979175bc5ebb94c789db8bfacb1736.1794015622.git.saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <394e47d486979175bc5ebb94c789db8bfacb1736.1794015622.git.saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af1b147 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gnRofaAz8YiOwmkHck4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfXw8vTRiF3l863
 iruyBWNlb7q+z6Q72qOZ3WCfi6EsSnNgF3vFw7Rs8uaI1Q5PCHlM5XQ96YcxBcCZqQR6sjP2hBY
 00TTAO2XczdFrztZePDZKkEYFZlgAbYebqNAVTsb8IuIsYVmgDP4LnAcmEK8ZiI3aFKvsep9ybK
 8Cmv7xPFjWE4YTRY9CPdqBglOd8v58boMonedPDKmCdHELucBuSoA4xlIxWc8x6JQj3tSRHSfYW
 12luT9VS8CHxBGY2fL85aETGcOfdxDKhb0/UdN3jFJDSnx8UcXMW6V68BSLcjZ1kZrLRVK+iqKp
 9k7YVFJcYmPkBD0A8cGkVaTA9RxHYjtfyzIR8B4cpKDKgxoJYCefSKg/PKAUCq12c+XgCqNoz8m
 BewgIFfecLCslbpcO8JKRBtDtf6COEgvy/rKyVOV0pvpitdEuWQupZlh/5tJ8H8Wjd3qPuQlecm
 wlIMVEWQHpwlBntDTow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NCBTYWx0ZWRfX6oFUwWxORQ3K
 RsVKsG9MTIy6lB5ciYTuQjt14csSQGndEXT/Pul3E9DfCcXpdayeJaWPBHmCuTl622c8o3GfZwd
 DpKkPI52m+aioTNwQQ3X2A4cCwwrrow=
X-Proofpoint-GUID: DSOO9okzoSCkkc1dHLWgo3xqnEXa3yM6
X-Proofpoint-ORIG-GUID: DSOO9okzoSCkkc1dHLWgo3xqnEXa3yM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_034101_353147_CBF00E4C 
X-CRM114-Status: GOOD (  21.56  )
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
> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time
> as the least loaded CPU in the queue's blk-mq map group, and all socket
> work runs there for the connection's lifetime. This decision falls
> short when the host partitions its CPUs after connect time. On a 384
> cpu multi tenant host with 128 queue controllers, blk-mq folds three
> CPUs into every map group, some groups straddle two tenants' cpusets,
> and 9% of nvme_tcp_io_work executions ran outside the submitting VM's
> cpuset, seen by the neighbor as steal time.
> 
> Expose the io_cpu in each I/O queue's directory
> 
>    /sys/class/nvme/nvmeX/queues/<qid>/io_cpu
> 
> so a control plane that owns CPU placement can set it directly instead
> of relying on the driver's heuristic. The attribute accepts a decimal
> cpu number, -1 or "unbound". A user assignment, unbound included, is
> marked in the queue flags, persists across reconnects and is never
> reselected by the driver. The read-only managed attribute reports 1
> while io_cpu is driver managed and 0 once the user assigned it. The
> accounting of nvme_tcp_cpu_queues applies regardless of who set the
> io_cpu.
> 
> A queue's directory is added once the connect time selection has set its
> io_cpu, so readers never see a placement that is about to change, and
> removed when the queue is freed, before it is torn down, so a sysfs
> store never runs on a freed queue. All io_cpu writes, from
> sysfs and from the driver, serialize with the accounting under
> nvme_tcp_cpu_queues_lock, while the I/O paths read io_cpu locklessly.
> The queue stop now clears NVME_TCP_Q_IO_CPU_SET under that lock, since a
> sysfs store may move io_cpu in between.
> 
> nvme_tcp_free_queue() now clears NVME_TCP_Q_IO_CPU_SET and drops its
> count, because a queue can still be counted when it is freed. A sysfs
> store may have run after the queue stop, or the connect may have
> failed, and the setup error path frees such a queue without calling
> nvme_tcp_stop_queue(), where the count is normally dropped.
> 
> Suggested-by: Sagi Grimberg<sagi@grimberg.me>
> Link:https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Saravanan D<saravanand@crusoe.ai>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

