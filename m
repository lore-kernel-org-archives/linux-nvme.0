Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A455C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 15:34:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF77F61390
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 15:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF77F61390
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xgTvYemL1PaUpTDoYcnESxBqHhlGbUFog87KQeM5VIc=; b=GGGUcaU2zRadFBTvileVFmsV7/
	UGZ1BW181YUDG/5vKlCSC4SWr7GP3+FfarUc2sLIWswfKs1pfqiXnL3//jqYQFwE7YcjSXGyCNsMy
	uRcW2Cu2WLfxDninq4f7uzo40BdAbiRozXDMyelEWjKfbPwQzjmm16hWWK+Xx+4aQY7hMfhE8UTZv
	bD0Rty500R8HmZyDXeNhWNZebDNdBLMzYfqHTalkmxX0RlyswzIrDhptRrxCL7arY+jyIiHF84Epv
	pR8wwBSYnC/QnT5yAJ+TObdHeuZQLQJrRxRLW6aDcfzJyoRsa0hTLwUeMMuIJZu53TYhSKrWS9G3c
	GLEjf+zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdDbp-0054Pc-ND; Wed, 20 Oct 2021 15:34:29 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdDbE-00547A-Jz
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 15:33:54 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 g79-20020a1c2052000000b00323023159e1so2720165wmg.2
 for <linux-nvme@lists.infradead.org>; Wed, 20 Oct 2021 08:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xgTvYemL1PaUpTDoYcnESxBqHhlGbUFog87KQeM5VIc=;
 b=yWbyaLTZk8suLqXgSFYhu86h+ZSSw6UR3u/qqIt1T38osuKbRaP79JMfus8PL0SuN4
 2ABTRAlRzB+dZHWw6zdsdwA9K6XTFsQ/IEAocGChxDK3SDzvQD5S4dZolbXfxbW1hWNV
 d5lTSmTlox7IMaUu0FLVYhapvk/Rmw9+FagvelLQsL0eczmvmS9g6Npb+WonIlZazSKi
 jo/km+emtni5NYoGsv/Xm1U7nLSEYuHjDb2rVLNA1Bkp+HZnD5QFUfScvOZ+EG2x7XWE
 ZRv22jk7gGfBVm5zhwVXYFN2z7YkCBys7gRUdyK5hpw0Jsv6ynsZhvYeeCEkQ40wC2dR
 y18w==
X-Gm-Message-State: AOAM531Cs7SJA9HDRBsTMRMUNllgf6zNmKlRQ9AdLTqTKDpDaOQ3yYkZ
 UtNltiHXMWFf4NOlWqyV8XeB5wRBE2Q=
X-Google-Smtp-Source: ABdhPJxXqvMzIz7f5hWczZJSRWxY6eKEyk+1mNtrZ8JdiRSeQ7P6XYPJi2JKkF8tjIBdXLYo0/lnPA==
X-Received: by 2002:a5d:6d02:: with SMTP id e2mr443140wrq.427.1634744029871;
 Wed, 20 Oct 2021 08:33:49 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h6sm2322595wrx.51.2021.10.20.08.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 08:33:49 -0700 (PDT)
Subject: Re: [PATCH] nvme: drop scan_lock and always kick requeue list when
 removing namespaces
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Anton Eidelman <anton@lightbitslabs.com>
References: <20211020055910.110695-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e44c4a84-c678-ebb2-b267-c7557d824ac2@grimberg.me>
Date: Wed, 20 Oct 2021 18:33:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020055910.110695-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_083352_717751_F52BF23B 
X-CRM114-Status: GOOD (  23.57  )
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



On 10/20/21 8:59 AM, Hannes Reinecke wrote:
> When reading the partition table on initial scan hits an I/O error the
> I/O will hang with the scan_mutex held:
> 
> [<0>] do_read_cache_page+0x49b/0x790
> [<0>] read_part_sector+0x39/0xe0
> [<0>] read_lba+0xf9/0x1d0
> [<0>] efi_partition+0xf1/0x7f0
> [<0>] bdev_disk_changed+0x1ee/0x550
> [<0>] blkdev_get_whole+0x81/0x90
> [<0>] blkdev_get_by_dev+0x128/0x2e0
> [<0>] device_add_disk+0x377/0x3c0
> [<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
> [<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
> [<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
> [<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
> [<0>] nvme_scan_work+0x168/0x310 [nvme_core]
> [<0>] process_one_work+0x231/0x420
> 
> and trying to delete the controller will deadlock as it tries to grab
> the scan mutex:
> 
> [<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
> [<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
> [<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
> 
> As we're now properly ordering the namespace list there is no need to
> hold the scan_mutex in nvme_mpath_clear_ctrl_paths() anymore.
> And we always need to kick the requeue list as the path will be marked
> as unusable and I/O will be requeued _without_ a current path.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/multipath.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index fb96e900dd3a..475224ecee8b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -141,13 +141,12 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
>   
> -	mutex_lock(&ctrl->scan_lock);
>   	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		if (nvme_mpath_clear_current_path(ns))
> -			kblockd_schedule_work(&ns->head->requeue_work);
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		nvme_mpath_clear_current_path(ns);
> +		kblockd_schedule_work(&ns->head->requeue_work);
> +	}
>   	up_read(&ctrl->namespaces_rwsem);
> -	mutex_unlock(&ctrl->scan_lock);
>   }
>   
>   void nvme_mpath_revalidate_paths(struct nvme_ns *ns)

I think this works,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Christoph, Keith, Hannes, Chaitanya,
Do you see any issues with this?

Anton, can you also give your opinion here?

