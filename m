Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E8C3B18B
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 15:34:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3A720675
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 15:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nXSN9rLV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJroqirZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3A720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SqcuL6bdhO17pr45RgRMyKR8kW4mjq07R27mKRzjZqI=; b=nXSN9rLVgj2BgKpGfZbIEcaLU
	X9h7Cfp1Sy4iQmpB6lG/Wm5LrMetl0GNzQhnaKR3oI0jHbJMjzrGufvSeLXdbpKSM1jHptWilwLtB
	erXZdOgkwKPFTxQ9P1HNe7eSzKQcoHTA0ZiGVkYVo6bvMidjpUQ0M/fEoNbhMJiC2iUR6UqFDPIop
	eRLkhbezD/54IcnM206Js3TxtTZaBKcoXCqJ6Prvwj0GH2A3jsUkCYYXwIJZoApT3l9sWliCZpggy
	/6lzNl3mKKrNa4c3122FdC5xH56WTlJWteThqCH9eUV4/21yxxDm+UoIZ+B35BngEFkkswuU4qryw
	7AcTYsIiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2GVB-0007S6-Uv; Thu, 13 Feb 2020 15:34:05 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2GV9-0007Qu-5D
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 15:34:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581608040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZPzAQ01ornT4c03XWJ9Jnba7M17Fse36u2YWhSo9Ss=;
 b=OJroqirZRkHfpQSPqxjEFb0ZhVUxa2jU5hG8k0hSZgyevPEdUK/U0rteklNJBwN6YPF+Az
 YxY9GGBrUrUjp46t7G1dUJ0Lg9Xd3EFj5VPYaOg9OIIN58Nq4K0wW56P9LNIKCyVGqvPmQ
 ynJpcJVOZIrbZh+4g/lfVlrsNoV7x6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-wf-I53EYN7a4gbdgD8cYWg-1; Thu, 13 Feb 2020 10:31:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E97588018A2;
 Thu, 13 Feb 2020 15:31:50 +0000 (UTC)
Received: from [10.3.116.11] (ovpn-116-11.phx2.redhat.com [10.3.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB2BF5C131;
 Thu, 13 Feb 2020 15:31:49 +0000 (UTC)
Subject: Re: [PATCH] nvme/pci: move cqe check after device shutdown
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
References: <20200212165232.23015-1-kbusch@kernel.org>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <a4ec3bc8-54ad-3d09-06d5-c8df761bc66a@redhat.com>
Date: Thu, 13 Feb 2020 09:31:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200212165232.23015-1-kbusch@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: wf-I53EYN7a4gbdgD8cYWg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200213_073403_277906_9BCF8E08 
X-CRM114-Status: GOOD (  22.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yanghliu@redhat.com, Yi Zhang <yizhan@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,

On 02/12/2020 10:52 AM, Keith Busch wrote:
> Many users have reported nvme triggered irq_startup() warnings during
> shutdown. The driver uses the nvme queue's irq to synchronize scanning
> for completions, and enabling an interrupt affined to only offline CPUs
> triggers the alarming warning.
> 
> Move the final CQE check to after disabling the device and all
> registered interrupts have been torn down so that we do not have any
> IRQ to synchronize.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206509

Yi Zhang and Yanghang Liu both saw the above stack trace in virtual 
environment when removing NVMe device. This patch resolves both
cases.

Thanks,
David

> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/pci.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index da392b50f73e..9c80f9f08149 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1401,6 +1401,23 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
>   	nvme_poll_irqdisable(nvmeq, -1);
>   }
>   
> +/*
> + * Called only on a device that has been disabled and after all other threads
> + * that can check this device's completion queues have synced. This is the
> + * last chance for the driver to see a natural completion before
> + * nvme_cancel_request() terminates all incomplete requests.
> + */
> +static void nvme_reap_pending_cqes(struct nvme_dev *dev)
> +{
> +	u16 start, end;
> +	int i;
> +
> +	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
> +		nvme_process_cq(&dev->queues[i], &start, &end, -1);
> +		nvme_complete_cqes(&dev->queues[i], start, end);
> +	}
> +}
> +
>   static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
>   				int entry_size)
>   {
> @@ -2235,11 +2252,6 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
>   		if (timeout == 0)
>   			return false;
>   
> -		/* handle any remaining CQEs */
> -		if (opcode == nvme_admin_delete_cq &&
> -		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
> -			nvme_poll_irqdisable(nvmeq, -1);
> -
>   		sent--;
>   		if (nr_queues)
>   			goto retry;
> @@ -2428,6 +2440,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	nvme_suspend_io_queues(dev);
>   	nvme_suspend_queue(&dev->queues[0]);
>   	nvme_pci_disable(dev);
> +	nvme_reap_pending_cqes(dev);
>   
>   	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
>   	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
