Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D57E6FE49
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 07:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNFkHCK3lhc8K8XOT75HbL6ZnPc1ASFsZ0Fnh+eVzcY=; b=rDWL4a7vW1RJ0lSPbhYOT/IdVF
	OTQGbwod6beyzTILxIf0cCLtL2uATgxYPbl05tu1m8uDm1bxGNATNAT3ypyQqDH8vDXKQSachJlFg
	cQ9plrWXBCJSQgr5DrKZZqk2Yfs+NYoIAkYYOHEfs0lVB0aUtskU3aZY8g7Je18nR3p6uaXIcjVK+
	eJ6KcknSMAPITVYSXZsISjUvlgDF1L7QaCQCmL1Y/5f037mNUb3+WkFIQxLcDr7SWVrxZRr/RQ83Y
	O/5CtzVbkFn6kpmw1RiTt3QvngDGDiu2i3iwsEK1CQA6a1rvVxSfcA42QYUP/FXAQeh8nRkSztpP3
	tunN18hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snCEm-0000000GIXD-2UMl;
	Sun, 08 Sep 2024 07:21:32 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snCEh-0000000GIWX-4Bzf
	for linux-nvme@lists.infradead.org;
	Sun, 08 Sep 2024 07:21:31 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so29532305e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 08 Sep 2024 00:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725780086; x=1726384886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNFkHCK3lhc8K8XOT75HbL6ZnPc1ASFsZ0Fnh+eVzcY=;
        b=lC8XU8KC9WNkSz6WPLT/73PGSjnJ4nCO5VVWKuwQpc+9l2RCI33Tb7iwAO6hW1FAeu
         URMJ9KunsHDk1IAZ++Le8hp7sMJGrW0Ohm52XurWQRoF/evi35fm9A/uSfdiXFSWcXXv
         uJVKdCjYH4ba/RC8AKBQjiPQOuumDv3mbpahxOXWCSYVqJw0cXb/1NfoaavBV0sVeWd7
         4u4IeKjCURUI3UVeZDGgl8NKWIgqlJF49SzZObgAt3zL61lobtxSYVWVAie4lH+bCCmS
         oIm2QscYLmrY5OQQSEi5wjIQeFG7cHnQgFL3oXPa4uHhmi2LCoEzAzJuQDXm/zKC4psw
         Qfgw==
X-Forwarded-Encrypted: i=1; AJvYcCU3jnahrJo8HKWkZJ0ZlhNwHcCYstyORK/U3o5o+Xn4nz7vti9IsK2NuPev/2ht6f1sopJrhKTSJrEj@lists.infradead.org
X-Gm-Message-State: AOJu0YyPl8ipewJGKFVU7Sm5SqvqQdmKxiNeKuVbQvCx7k6IaBxv4jxl
	XJqSkRhFno6RTAm8SxGagHk+3lwp2CNF+K/yTi7lvE8bCsZC5anj
X-Google-Smtp-Source: AGHT+IEVWa7WI+pevFpod/cIwA0JcshlgC1IrYeV+2FOmaeEMO7kqwupbRDT9eKt4FUuTPCVKYe10A==
X-Received: by 2002:a05:600c:468e:b0:425:5ec3:570b with SMTP id 5b1f17b1804b1-42cae79d262mr19201045e9.35.1725780085003;
        Sun, 08 Sep 2024 00:21:25 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca8cebd35sm51588475e9.0.2024.09.08.00.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 00:21:24 -0700 (PDT)
Message-ID: <1401aec0-059b-43fb-97b9-0b0896c2a56c@grimberg.me>
Date: Sun, 8 Sep 2024 10:21:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: 'nvme disconnect' hangs after remapping
 namespaces
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240906101640.44417-1-hare@kernel.org>
 <20240906101640.44417-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906101640.44417-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_002128_072404_9BA42147 
X-CRM114-Status: GOOD (  12.88  )
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




On 06/09/2024 13:16, Hannes Reinecke wrote:
> During repetitive namespace map and unmap operations on the target
> (disabling the namespace, changing the UUID, enabling it again)
> the initial scan will hang as the target will be returning
> PATH_ERROR and the I/O is constantly retried:
>
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
> Calling 'nvme disconnect' on controllers with these namespaces
> will hang as the disconnect operation tries to flush scan_work:
>
> [<0>] __flush_work+0x389/0x4b0
> [<0>] nvme_remove_namespaces+0x4b/0x130 [nvme_core]
> [<0>] nvme_do_delete_ctrl+0x72/0x90 [nvme_core]
> [<0>] nvme_delete_ctrl_sync+0x2e/0x40 [nvme_core]
> [<0>] nvme_sysfs_delete+0x35/0x40 [nvme_core]
> [<0>] kernfs_fop_write_iter+0x13d/0x1b0
> [<0>] vfs_write+0x404/0x510
>
> before the namespaces are removed.
>
> This patch sets the 'failfast_expired' bit for the controller
> to cause all pending I/O to be failed, and the disconnect process
> to complete.

I don't know if I agree with this approach. Seems too indirect.
Can you please explain (with tracing) what is preventing the scan_work
to complete? because the controller state should be DELETING, and perhaps
we are missing somewhere a check for this?

nvme_remove_namespaces() at the point you are injecting here is designed
to allow any writeback to complete (if possible).

