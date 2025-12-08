Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CEED3B7E2
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DbHHkduGncpuPtot795Xe6V8uWxMjY6W8fGIG+hxDeg=; b=Ntt0WmsdCj8eqgCfnDSVs24bQb
	h5Dk1d0QQShtXey6ziwZcDtZ808UMXglg/wRPjfqkkHlNEWzEuoD3wCOrBpETum8LExfWh3E9088G
	+0zg8ackyXcqXg1IKU7zPaToWg+n8D9I8eruwbOV2RsY7l4H1/4c+gPI+1ioyPwHdrNt3D5ZHbA8s
	kL8vU8S4WkWKBiHyLWxgJVblDbkP8BCAUQvE5g8S/fvsRoCrNv9PhypolmNw2yVW4qasKzHTj6h5r
	Pa17NNvDHnrf8I5oeAEM0tvE1W80YuIcecMVYD+jzo4J6S30j10+E7MZNx8j+eWgL49DV8n6x0YWF
	u81is9OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSbHj-0000000D7kE-33GY;
	Mon, 08 Dec 2025 13:28:15 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSbHa-0000000D7jo-0fuH
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 13:28:07 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso3913671b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 08 Dec 2025 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765200485; x=1765805285; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbHHkduGncpuPtot795Xe6V8uWxMjY6W8fGIG+hxDeg=;
        b=ftxmPlA/7n5VXQnhs3GlQo8zlyOB3QL3TnjB5JL8sUK8bxotIZ7GGn4Yn5a1qGt8ot
         md/14LtJvgobU4oNaHnzn5iZnFTLwX8bMGT2LIcjhtkbW5vml2imqsce0UOywJLyiBZk
         Av6bTwGfOF1tD4QGU7uK/YSOD8a+JCMHRUdP5UoTuFk/PsKLQkAcLapNNrJZ8W4kuhUD
         2BoIr7kCx9ZkJmowWFIfNlebxiSwupE1ihsLrpu58FVV9N1yqkxopi9MtRVK5wD+ZXLF
         rPaVDRT1Gv8ESyIdYa9tRHRwbHTeN3Nzl0GNCHUhMES/XtQy4OQOuO6Fx56C4ipB52bp
         VodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765200485; x=1765805285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbHHkduGncpuPtot795Xe6V8uWxMjY6W8fGIG+hxDeg=;
        b=fb+Xd2oIzo6/LRqOLnbp7zgxR2xKY9qrWcfEz/f7oI3yj4yvpfAcppiY6mZF3tws9k
         JpS7kd+d9kGEDCuQfYHGrrpLaj5HqNEsiUZwX0sLhLjxDW2WjgqE8n9JAqaArl4YtEkE
         pM2cCIBJyDtyZ0w29GqkklFRFyKsSafVQ2jkhFqxPVlfdF9oKfhhPIpl3nURhBdwyeGp
         uzlMgkxsPG9kUu8mVRP2RZP53O1JujDfZc2ylkOA9VnWx6mxGz5Z4swB9XAyYFTNmx7x
         WrwXop4vMQtQpY3r1RdVWyZLHbvhzX045kkakJ9abXtv+d7qjThC+/ZGckrrdCHlP844
         rz/g==
X-Forwarded-Encrypted: i=1; AJvYcCXUIMXFRUh0Ea84JCdBLkoyiKZCkfhTNY1J7t8qj8x7mkq/dr8Fzy9V0FnUZDdhewpAsLzR3U5qXVNF@lists.infradead.org
X-Gm-Message-State: AOJu0YyMOv50T9KapgFnq4yI6wECJkGafoMEmRcczxqy6LgBvgcNq6QQ
	jN3Fbd2WMWq5uc8SY1SVJx+vAunxC88hJ+aXiGFRV5Zqymq3g27QXg1Vk2+6hx2F
X-Gm-Gg: ASbGncvrVrXRJQ12ciPsIm2rcc7LK/xznCFMTYdtkGGkVI//h/na1fgPks0lya4XOih
	vVSzKBAMkMlh+xOoB2ahH1ZfUWgb+iNODLX9owoezME0HsNJBmpVy5YEYVFhBnOxHpTxrjhwsDJ
	NaX/tySz+ZHhEATyKc+c1D+wGNSteZIcqqemJ8hy0mEiZ78XIC9XS5woXGFzh8xDhpijrFq3nFn
	eCWjp/F+u9jeEfFBZdhNt+CdJPD+Z+V2Myx3mmklQDQB5Z1q63mmhvvlq+Z0/HahtKRW5xvlUsR
	B/NU4jwDpFlDEfWfwY7LMdYIhiS8UjxoFY8OvibVkepN8TvDmE5s6dzNU1Z4Vsz/YaTsVZ92RJ8
	7ea8Odn5RgMKEjYVT0R1Te/cFz+ZihifqSM0wrJUW13T5sp2IhpnclRAwswj1CitspH49kJrio1
	4fjUOfIvM=
X-Google-Smtp-Source: AGHT+IEJink5dffLsMfjiF2kZmo0I3LJowM/dJuNuWV+1SloCdfrgSufG4LI0yl6V1FTUBYmf5D2Fg==
X-Received: by 2002:a05:7022:2226:b0:11b:e21e:5653 with SMTP id a92af1059eb24-11e03262c31mr5354387c88.19.1765200484612;
        Mon, 08 Dec 2025 05:28:04 -0800 (PST)
Received: from [0.0.0.0] ([2605:52c0:1:b17:84f1:a0ff:fe39:857a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm58067184c88.6.2025.12.08.05.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 05:28:04 -0800 (PST)
Message-ID: <19627811-c325-4ef3-8982-59fcd9ecbdfb@gmail.com>
Date: Mon, 8 Dec 2025 21:27:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to
 disable secondary temp thresholds
To: Ilikara Zheng <ilikara@aosc.io>, linux-kernel@vger.kernel.org
Cc: Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
 stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <20251208132340.1317531-1-ilikara@aosc.io>
Content-Language: en-US
From: RigoLigo <rigoligo03@gmail.com>
In-Reply-To: <20251208132340.1317531-1-ilikara@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_052806_209027_570D678C 
X-CRM114-Status: GOOD (  18.38  )
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

Hi all,

On 2025-12-08 21:23, Ilikara Zheng wrote:
> Secondary temperature thresholds (temp2_{min,max}) were not reported
> properly on this NVMe SSD. This resulted in an error while attempting to
> read these values with sensors(1):
> 
>    ERROR: Can't get value of subfeature temp2_min: I/O error
>    ERROR: Can't get value of subfeature temp2_max: I/O error
> 
> Add the device to the nvme_id_table with the
> NVME_QUIRK_NO_SECONDARY_TEMP_THRESH flag to suppress access to all non-
> composite temperature thresholds.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilikara Zheng <ilikara@aosc.io>
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e5ca8301bb8b..31049f33f27d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3997,6 +3997,8 @@ static const struct pci_device_id nvme_id_table[] = {
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>   	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> +	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */
> +		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
>   	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>   	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */

I have tested this patch on a CTCISZ 3B6000M-NUC with an exact same SSD 
and this has resolved the error with sensor(1).

Tested-by: Wu Haotian <rigoligo03@gmail.com>

