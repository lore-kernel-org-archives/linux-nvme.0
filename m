Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DB606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yoNhO8Te;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hzsHnFZV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bPq57VhC1eT6C3oWLh0wFB4RkgJpNICv5oxYVxwHXE8=; b=yoNhO8TeCxvWKh
	QYfVh6v0vSR2BdQMtvkun3UBxPAHUyDJ3TFa5FGy7+hLJnH8441wGTFozhVbMDoGbm16kcN0vtJJP
	qNqnKdtfEIi2Ld4MWj+lUFCLSrAlfXc/UkbFdrJ4Gdva63cb8AiCi5KAGv8D3esQtDHH/vPLyxAl+
	E18CcFKoGZiK9iRlzU8+NaenuNVB6UTHXBY+zUPru3lOBL6B4vJjBHY1Fp+p6oXh0EUkRO+anPsGa
	NP66NK3bGUF3+gSCuTVIFT4Ek0Y4hNFbY2hXM6rIopo48/IyapK0ydgMHjGYXVKSA0/rI+G2kplmd
	JkdbYpC5RKb4T9C+2EYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMnrf-0000000BsfD-3N79;
	Fri, 30 Oct 2026 14:45:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMnrb-0000000Bset-2xuC
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 14:45:53 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEiCG93395951;
	Fri, 30 Oct 2026 14:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bPq57V
	hC1eT6C3oWLh0wFB4RkgJpNICv5oxYVxwHXE8=; b=hzsHnFZVP4SaUCQ6ErScuV
	Pgl65+fR28R5zMo/TYzPvKHwVEhe38xOPujopK6+63jrMimC/Y7U624hVDqL6gY9
	Q3Pl4Xj6tpDtfXT0nPy5uZQG85WUIV9hnusbDWBskfuMByoW8Im9wJxl+g1I6UFw
	2upe2arcranZWQ1t/C6UDJs4TJCg0LJAKrtmwguY5FI2QLhTtiEZe5zm5Mw4qMEv
	4HfyW+6QeDUjccp32gPTC3VwQm/s9YlMX5mTarbg6BLxcBdm7agrqgCT/whGUYlG
	j7mkWgLwMapnkT4Wip1/KRxaOPyK+VeeAO4Gkhr51SyzgsfQ24ozq7w2RjikkCVA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeay38wa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 14:45:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEZ6JN649977;
	Fri, 30 Oct 2026 14:45:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e50c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 14:45:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UEidma22479478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 14:44:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9468B58055;
	Fri, 30 Oct 2026 14:45:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D52A55805F;
	Fri, 30 Oct 2026 14:45:22 +0000 (GMT)
Received: from [9.61.35.48] (unknown [9.61.35.48])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 14:45:22 +0000 (GMT)
Message-ID: <4b3a601f-3035-4883-ad2d-c6a20d2891ef@linux.ibm.com>
Date: Fri, 30 Oct 2026 20:15:20 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, sgogte@purestorage.com, hare@kernel.org, hare@suse.de,
        linux-kernel@vger.kernel.org, iyamahata@crusoe.ai, kiyer@crusoe.ai,
        ganbalagane@crusoe.ai, sjpark@crusoe.ai, bchen@crusoe.ai
References: <20261023230426.6425-1-saravanand@crusoe.ai>
 <20261023230426.6425-3-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261023230426.6425-3-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX/vNfpLKaKA2z
 fZY4KzFs3mYC/b3X5ykXewF7OmU9j1nOlshi+N+pgmk1ESxDMit/fRZGdB5nSR4mwuysyAAQFVf
 HNrOA3pbSSUw7/s4U1SM9F27vVo4+If4xL75S1kfui5dzWzKZ8Xu+ZrfrUGagtkjW06PHOv5tSG
 GZXGOfd2jVB+P6ddfE8GJUtEcNNEmtwEQRTGs+lT5PnU3iReCoJcfBgp6abs0WGPFPV8LhIYIga
 MEJJq5h+ysC6qoh/veqzUWjtMUZrMDhCO/eLJRWrKtk9kcRKl4TUv0ajdmxrNcwQbs8qXgYRJW0
 L25agbnKERYoNuB79c4oe3/rbyzpoKTcJYZzA9ITV71vxvXvMhFA0nwOmD5lYxf/pdDWppGeZXW
 JIxcwCcr1ehKCqk309bObqrzuQb5vovCITOmDBlxe4agzOcY2jeg2JvgBoNlSrDJIcKgyPsnPWV
 oUc7eKYfUOViropZ8SA==
X-Authority-Analysis: v=2.4 cv=WJHqzXsR c=1 sm=1 tr=0 ts=6ae4ad89 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=nN4Wz2icVkWj8QAAA9QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6w46d9JECINyg7M4edK7_u7UzvH7HdHV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX+TLJEcIjJMJE
 z0uL31qj91O6I3IWjG+Qu4ciANGn6EhXHfbP/XoKhIldrNUreAYeCGa5AOqWOSOmkWdi9hHk9xf
 NIFXRy1ZNh016rcS81dYti4n3c29r8g=
X-Proofpoint-GUID: 6w46d9JECINyg7M4edK7_u7UzvH7HdHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_074551_763825_62CC8458 
X-CRM114-Status: GOOD (  29.44  )
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

On 10/24/26 4:34 AM, Saravanan D wrote:
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
> store never runs on a freed queue. The queues directory is created
> before the I/O queues are set up in parallel. All io_cpu writes, from
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
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Saravanan D <saravanand@crusoe.ai>
> ---
>   Documentation/ABI/stable/sysfs-nvme |  31 +++++
>   drivers/nvme/host/tcp.c             | 172 ++++++++++++++++++++++++----
>   2 files changed, 183 insertions(+), 20 deletions(-)
> 

[...]

> @@ -2303,6 +2429,11 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   	if (ret)
>   		return ret;
>   
> +	/* the parallel queue setup below adds the queue directories */
> +	ret = nvme_queue_dir_create(ctrl);
> +	if (ret)
> +		return ret;
> +

I see here nvme_queue_dir_create() is invoked on every reconnect. Although
it is guarded by ctrl->queues_kobj, the directory is controller-lifetime
state, so it would be cleaner to create it once from nvme_add_ctrl().

Moreover, this also makes the ownership asymmetric: nvme-tcp creates the
queues directory, but nvme-core removes it from nvme_uninit_ctrl(). Could
nvme-core manage both creation and destruction instead?

One way to do that is to add queue_attr_groups to struct nvme_ctrl_ops.
A transport that provides per-queue attributes can register its groups
there; for example, NVMe/TCP would set:

         .queue_attr_groups = nvme_tcp_queue_groups,

Then, after cdev_device_add() succeeds, nvme_add_ctrl() can create the
directory when queue_attr_groups is set:

         if (ctrl->ops->queue_attr_groups) {
                 ret = nvme_queue_dir_create(ctrl);
                 if (ret)
                         goto out_del_cdev;
         }

where out_del_cdev unwinds the successful cdev_device_add().

This lets nvme-core own both creation and removal of the queues
directory, and nvme_queue_dir_create() no longer needs to be exported.
It also means nvme_add_queue_info() need not take attribute groups as
an argument as it can use ctrl->ops->queue_attr_groups directly.

Thanks,
--Nilay

