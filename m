Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B587C982C1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8e7d3C6dAe3VqESD9ZVxkX3s7WqFGTXKBNW+ES6HE/w=; b=1MRxXEDcD52JvVh3gxRK2dx6+a
	Me7gdYIOcbu1YBC2gKHSvTdMVLBIVL+EP5mzD6PQ8puaX/lUQbPON+kknpo3XVAw0w20MjuFapoze
	CbDZXVsw/midoRGj+InX4L4TPOImExteb6Oez2Zx8lFcvHJeZpmhrHlNINLqvRvUemlhbPCNYPiX6
	BSd0dEaqY+sorOrvXAuuB2dWb8RGB6gj6iF+ZLn167OHs7iKXauXe8EH19q5Ed2JXZp9lciMfvpi1
	ejJrSvXJCEawhZUx5PoXTM8A4u2B20rDRpO7shIlaN2M2jyR0Ma4btoUxyOZq3P6mC11Pduac44sC
	5UlTHltA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7749-0000000Aq1N-0TFq;
	Thu, 17 Sep 2026 08:01:57 +0000
Received: from out-191.mta0.migadu.com ([2001:41d0:1004:224b::bf] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7746-0000000ApzT-1lSu
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 08:01:55 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=qg2ugQF6emIDBkiYN6wSYozKB/xd4uS0K25DPIiJOvI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789632112; v=1; x=1790236912;
 b=VA/5CN33gLrn2T7iFeask5EIEi0umUdAzm27vnWLuqKnG525NA8Nsy34n9IcLGAYUL+2A+bn
 mior3VKn4hHLA7XYMkq77WikoQi3K8qDRza7o0qrfhgrNc++WEpOs/OjqzGDS3zA3anu59glqIp
 mY+/mVJ1R2sZRqI+mSkryT8s=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id bcfab2cc7206916a;
	Thu, 17 Sep 2026 08:01:52 +0000
X-Mizu-Trace-ID: bcfab2cc7206916a
X-Migadu-Flow: FLOW_OUT
Message-ID: <e1ae8618-bfe1-481d-993e-7c7b909899af@linux.dev>
Date: Thu, 17 Sep 2026 09:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: work around -Wformat-security warning
To: Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Maurizio Lombardi <mlombard@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@kernel.org>,
 Nilay Shroff <nilay@linux.ibm.com>, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260916114533.237863-1-arnd@kernel.org>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260916114533.237863-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_010154_608382_3CA5B62A 
X-CRM114-Status: GOOD (  15.13  )
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

On 9/16/26 12:44, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
> 
> Passing a string variable into dev_set_name() causes a warning
> when building with -Wformat-security enabled:
> 
> drivers/nvme/host/core.c: In function 'nvme_cdev_add':
> drivers/nvme/host/core.c:3911:9: error: format not a string literal and no format arguments [-Werror=format-security]
>   3911 |         ret = dev_set_name(cdev_device, name);
> 
> Remove the temporary strings and let dev_set_name() do the
> same thing internally.
> 

Prior to 26acdaa357cd, we had the caller of nvme_cdev_add() also calling 
dev_set_name(). Maybe it is better to revert to that (but keep the 
functionality to set NVME_NSHEAD_CDEV_LIVE). But then put_device() call 
for errors becomes a bit messy.

...

>   	}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2cff9fcbf740..e0260f4d24fd 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1013,9 +1013,9 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
>   void nvme_get_ns_head(struct nvme_ns_head *head);
>   bool nvme_tryget_ns_head(struct nvme_ns_head *head);
>   void nvme_put_ns_head(struct nvme_ns_head *head);
> -int nvme_cdev_add(const char *name, struct cdev *cdev,
> -		struct device *cdev_device,
> -		const struct file_operations *fops, struct module *owner);
> +int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> +		const struct file_operations *fops, struct module *owner,
> +		int ctrl, int head);


nit: maybe @head arg would be better called "ns", as it is the "ns" index.

>   void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device);
>   int nvme_ioctl(struct block_device *bdev, blk_mode_t mode,
>   		unsigned int cmd, unsigned long arg);
> -- 2.53.0

Regardless of comments:
Reviewed-by: John Garry <john.garry@linux.dev>

