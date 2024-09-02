Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4CECA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tgUJMhsIeWirviCtgxbQ/YX1VSs3rQd27CbgS/n4D64=; b=AVY5HrZiJ/uHcvxXhRvpG19rV5
	eh0PifAcFFJOD+4ISlZimnhZKnky3dMCQJFv12fzFuSxrBEE+uM3/fvpJBtVuDEwquP4wAETreq6k
	XwsjyAGd6F3SsmJIvdEWE7zFD0eyU3fQO63zaIGOLCqtChVnilvEemfBRISPYUcipSIrrAIgxXcY4
	eJid1MJN4Q2d4IRI70bNHBzpKys8DWfE+F4RzmMydZWH1VNF47EHhOTjV/qRMfpt/usUT7kkADURA
	+PXXxJPTOfTgiY42C+3w/twZlpfwPpwgtjAK1mErzMWkX6IRIAOGUZJNhJQapoYCZIvKVHdcBMies
	bl+x4M9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slAJI-0000000F5pj-0J9d;
	Mon, 02 Sep 2024 16:53:48 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slAJE-0000000F5od-2YDI
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 16:53:45 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bfb50e4e6so20491745e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2024 09:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296023; x=1725900823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgUJMhsIeWirviCtgxbQ/YX1VSs3rQd27CbgS/n4D64=;
        b=tgBWXK4h7/LLvb0MFZFXwkglj2/3zGUCinVkWJCL5rG8ercjkCg2HgeuiOlnDaaFOl
         lgm2hydqcodkqVaduFyi44EKxwtNIG+BImiOoIX4GUxVBEeby1qSZ3IHHkGrOv5oeSWP
         fg4OHs0eZ++WJZ/JzzxuH8SQthVUNJgRXglsnJIpxWkSbn8hqTkeq+mTnfrdO9yWpXmL
         PjMezJ9HjZ1S/P2nsyx3cshbxVMvuWChR/gwfV+yRdALxU5HS6lVRpMJFaHBjtZMh9Ox
         uD6wUZvQTXKxCFJh0I7x+iT9srqUUOh858FHHB+U6Owtf9aCSWJVJNsly0ATTLnc34cE
         0Xkg==
X-Forwarded-Encrypted: i=1; AJvYcCXxBvO85Ts8FOtyGeQnlGGcZ0ZGqZ295pViPrFiKfyZe8E6nJjtUHWgU2+x58QOWBfXviiF/RSyOIEG@lists.infradead.org
X-Gm-Message-State: AOJu0Yxjbj1bf7Fh22ACB2p3cR3RKqZDYX8TCDT2ig6lzrk3IPQjlgM9
	sCItKmZBrdkX7yE5skDxJz8m+prsjCFB6418JJ3I1FsIm2/go4bH2oJ22Q==
X-Google-Smtp-Source: AGHT+IEMbHsL+bjQnjPwypzHMV6LMP6Bn+t6Xk1tiIHb09v4tud+mmOMrKhiRKZmkSP9NcvZ0tgcrg==
X-Received: by 2002:a05:600c:4591:b0:42a:a6aa:4135 with SMTP id 5b1f17b1804b1-42bb0308417mr122205985e9.20.1725296022009;
        Mon, 02 Sep 2024 09:53:42 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb9ff0acdsm124877105e9.38.2024.09.02.09.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:53:41 -0700 (PDT)
Message-ID: <3e19e68c-91b3-440b-8f05-95cdfb427da7@grimberg.me>
Date: Mon, 2 Sep 2024 19:53:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-multipath: check for NVME_NSHEAD_DISK_LIVE when
 selecting paths
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240902111548.41430-1-hare@kernel.org>
 <20240902111548.41430-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240902111548.41430-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_095344_684693_2A711E07 
X-CRM114-Status: GOOD (  23.65  )
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

The patch title should describe what it is fixing rather than what it is 
doing.


On 02/09/2024 14:15, Hannes Reinecke wrote:
> During repetitive namespace remapping operations on the target the
> namespace might have changed between the time the initial scan
> was performed, and partition scan was invoked by device_add_disk()
> in nvme_mpath_set_live(). We then end up with a stuck scanning process:

I'm not sure I understand what "remapping operations" are?

> [<0>] folio_wait_bit_common+0x12a/0x310
> [<0>] filemap_read_folio+0x97/0xd0
> [<0>] do_read_cache_folio+0x108/0x390
> [<0>] read_part_sector+0x31/0xa0
> [<0>] read_lba+0xc5/0x160
> [<0>] efi_partition+0xd9/0x8f0
> [<0>] bdev_disk_changed+0x23d/0x6d0
> [<0>] blkdev_get_whole+0x78/0xc0
> [<0>] bdev_open+0x2c6/0x3b0
> [<0>] bdev_file_open_by_dev+0xcb/0x120
> [<0>] disk_scan_partitions+0x5d/0x100
> [<0>] device_add_disk+0x402/0x420
> [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
> [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
> [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
> [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
> [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>
> and another scanning process (triggered by AEN) trying to remove the namespaces:
>
> [<0>] __synchronize_srcu+0x17c/0x1b0
> [<0>] nvme_ns_remove+0x12e/0x210 [nvme_core]
> [<0>] nvme_ns_remove_by_nsid+0x21/0x70 [nvme_core]
> [<0>] nvme_scan_work+0x1b7/0x490 [nvme_core]
> [<0>] process_scheduled_works+0x37d/0x6d0
>
> none of which is able to make progress as the first process cannot submit I/O
> (as all the namespace inforation is stale), and the second process is stalled
> waiting on the srcu to be released by the first process.
>
> This patch checks for the NVME_NSHEAD_DISK_LIVE bit when selecting a path,
> causing I/O to be aborted and allowing the first process to make progress.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/multipath.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 01dbbe866d61..f5f2e1667c64 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -407,6 +407,9 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>   
>   inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   {
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +		return NULL;
> +
>   	switch (READ_ONCE(head->subsys->iopolicy)) {
>   	case NVME_IOPOLICY_QD:
>   		return nvme_queue_depth_path(head);
> @@ -421,6 +424,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   {
>   	struct nvme_ns *ns;
>   
> +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +		return NULL;
> +
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>   		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>   			continue;

This looks like together with the last patch address the hang, so they 
need to be squashed together.

