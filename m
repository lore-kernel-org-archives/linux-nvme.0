Return-Path: <SRS0=D38N=DQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8826CC433E7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 00:08:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0BC22253
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 00:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2XFwKurt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0BC22253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AvC2O3DnCXUQeFL0QU4dC8NhnTGqxwtyVjFVeFimVU4=; b=2XFwKurt38m1ZOfHk70m3lhSy
	XYMGcu2fWkMsXgCtZslNJXDbL7bNxuZwrBIVaCxbcHraZnukvD4Basi89tm87JAEYmrLE0f6pfWcJ
	9qHYV1mtnIEw+XSPlkF3Zoxwm3cuscRbUw2+xojRzprzn23QxDtwut9uePbGJD6NLHuN7kmL7pK9p
	fAXER5nLc/PRam7MXxT/reZlP1rxToWHNh63m1tTNeIaf+1jBgiHTKXQatVIitVlSuHYye3swG/X8
	+JbIXb2vzfWzCNgEmsQzvktRYPlYo7PkCvZjoOGCt6Uu6Dui/un2CNfgJVI/+D+gEKqBh2hAxHoTu
	YS1vfcHyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQfxJ-0000F6-G2; Fri, 09 Oct 2020 00:08:17 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQfxG-0000Ee-Jx
 for linux-nvme@lists.infradead.org; Fri, 09 Oct 2020 00:08:16 +0000
Received: by mail-wm1-f68.google.com with SMTP id 13so8103058wmf.0
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 17:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2W762rg4le9nAqp2qQYkPGqt9/HniqTXRFZ7bllOcSE=;
 b=sOAIG1xTxM7fbrnnTkFnHcIsV7PhVxGuWefwk20R+xdM4mZr3/h/EAGtr1sonVyR1e
 Lcko2QgsRyAEatBrguUuy25VNnbR9rXR1OnPIGX8+sGkeDmRfJ8tQaF4pOpweQB3w3mW
 c1Vz1w+BLyTHD0XOivaWitzCsEruC+L8Q5A2CTR2Ij3Df0UKgmMev7vqaugxJIYVi1nd
 VKZ+CRERZks/9mcZXUBJ1malxjj5DaWTF4wnifzdPRxStZTkSWvZbT31skn0zHNzeBiN
 sXUGfRij48XQ8h7AaA37uRw2+pWNpy+8/hwBfHk0SJSwO4oWTrZiuiDk/K3Epqs3HG69
 rNtA==
X-Gm-Message-State: AOAM530joUJ5Mep3e8yx3pS25I+SoAOc520cllm8mO1a3b44jfGCZEl8
 5kUGiz1ZTFsFylyBjMNMQYE=
X-Google-Smtp-Source: ABdhPJzwlEIarjsxAWlYg/GQLVoEP1LDdmKNVW9I4VGq30eJFPkS+Q8gJVh9OJJEd1eSXa9y9sZ3OA==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr11491970wmj.79.1602202093166; 
 Thu, 08 Oct 2020 17:08:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id z127sm8915684wmc.2.2020.10.08.17.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 17:08:12 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 00/10] nvme-tcp receive offloads
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <42560022-6b2e-327f-2a77-0700132ab730@grimberg.me>
Date: Thu, 8 Oct 2020 17:08:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-1-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_200814_669943_DF45EE91 
X-CRM114-Status: GOOD (  40.19  )
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
Cc: boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/30/20 9:20 AM, Boris Pismenny wrote:
> This series adds support for nvme-tcp receive offloads
> which do not mandate the offload of the network stack to the device.
> Instead, these work together with TCP to offload:
> 1. copy from SKB to the block layer buffers
> 2. CRC verification for received PDU
> 
> The series implements these as a generic offload infrastructure for storage
> protocols, which we call TCP Direct Data Placement (TCP_DDP) and TCP DDP CRC,
> respectively. We use this infrastructure to implement NVMe-TCP offload for copy
> and CRC. Future implementations can reuse the same infrastructure for other
> protcols such as iSCSI.
> 
> Note:
> These offloads are similar in nature to the packet-based NIC TLS offloads,
> which are already upstream (see net/tls/tls_device.c).
> You can read more about TLS offload here:
> https://www.kernel.org/doc/html/latest/networking/tls-offload.html
> 
> Initialization and teardown:
> =========================================
> The offload for IO queues is initialized after the handshake of the
> NVMe-TCP protocol is finished by calling `nvme_tcp_offload_socket`
> with the tcp socket of the nvme_tcp_queue:
> This operation sets all relevant hardware contexts in
> hardware. If it fails, then the IO queue proceeds as usually with no offload.
> If it succeeds then `nvme_tcp_setup_ddp` and `nvme_tcp_teardown_ddp` may be
> called to perform copy offload, and crc offload will be used.
> This initialization does not change the normal operation of nvme-tcp in any
> way besides adding the option to call the above mentioned NDO operations.
> 
> For the admin queue, nvme-tcp does not initialize the offload.
> Instead, nvme-tcp calls the driver to configure limits for the controller,
> such as max_hw_sectors and max_segments; these must be limited to accomodate
> potential HW resource limits, and to improve performance.
> 
> If some error occured, and the IO queue must be closed or reconnected, then
> offload is teardown and initialized again. Additionally, we handle netdev
> down events via the existing error recovery flow.
> 
> Copy offload works as follows:
> =========================================
> The nvme-tcp layer calls the NIC drive to map block layer buffers to ccid using
> `nvme_tcp_setup_ddp` before sending the read request. When the repsonse is
> received, then the NIC HW will write the PDU payload directly into the
> designated buffer, and build an SKB such that it points into the destination
> buffer; this SKB represents the entire packet received on the wire, but it
> points to the block layer buffers. Once nvme-tcp attempts to copy data from
> this SKB to the block layer buffer it can skip the copy by checking in the
> copying function (memcpy_to_page):
> if (src == dst) -> skip copy
> Finally, when the PDU has been processed to completion, the nvme-tcp layer
> releases the NIC HW context be calling `nvme_tcp_teardown_ddp` which
> asynchronously unmaps the buffers from NIC HW.
> 
> As the last change is to a sensative function, we are careful to place it under
> static_key which is only enabled when this functionality is actually used for
> nvme-tcp copy offload.
> 
> Asynchronous completion:
> =========================================
> The NIC must release its mapping between command IDs and the target buffers.
> This mapping is released when NVMe-TCP calls the NIC
> driver (`nvme_tcp_offload_socket`).
> As completing IOs is performance criticial, we introduce asynchronous
> completions for NVMe-TCP, i.e. NVMe-TCP calls the NIC, which will later
> call NVMe-TCP to complete the IO (`nvme_tcp_ddp_teardown_done`).
> 
> An alternative approach is to move all the functions related to coping from
> SKBs to the block layer buffers inside the nvme-tcp code - about 200 LOC.
> 
> CRC offload works as follows:
> =========================================
> After offload is initialized, we use the SKB's ddp_crc bit to indicate that:
> "there was no problem with the verification of all CRC fields in this packet's
> payload". The bit is set to zero if there was an error, or if HW skipped
> offload for some reason. If *any* SKB in a PDU has (ddp_crc != 1), then software
> must compute the CRC, and check it. We perform this check, and
> accompanying software fallback at the end of the processing of a received PDU.
> 
> SKB changes:
> =========================================
> The CRC offload requires an additional bit in the SKB, which is useful for
> preventing the coalescing of SKB with different crc offload values. This bit
> is similar in concept to the "decrypted" bit.
> 
> Performance:
> =========================================
> The expected performance gain from this offload varies with the block size.
> We perform a CPU cycles breakdown of the copy/CRC operations in nvme-tcp
> fio random read workloads:
> For 4K blocks we see up to 11% improvement for a 100% read fio workload,
> while for 128K blocks we see upto 52%. If we run nvme-tcp, and skip these
> operations, then we observe a gain of about 1.1x and 2x respectively.

Nice!

> 
> Resynchronization:
> =========================================
> The resynchronization flow is performed to reset the hardware tracking of
> NVMe-TCP PDUs within the TCP stream. The flow consists of a request from
> the driver, regarding a possible location of a PDU header. Followed by
> a response from the nvme-tcp driver.
> 
> This flow is rare, and it should happen only after packet loss or
> reordering events that involve nvme-tcp PDU headers.
> 
> The patches are organized as follows:
> =========================================
> Patch 1         the iov_iter change to skip copy if (src == dst)
> Patches 2-3     the infrastructure for all TCP DDP
>                  and TCP DDP CRC offloads, respectively.
> Patch 4         exposes the get_netdev_for_sock function from TLS
> Patch 5         NVMe-TCP changes to call NIC driver on queue init/teardown
> Patches 6       NVMe-TCP changes to call NIC driver on IO operation
>                  setup/teardown, and support async completions.
> Patches 7       NVMe-TCP changes to support CRC offload on receive.
>                  Also, this patch moves CRC calculation to the end of PDU
>                  in case offload requires software fallback.
> Patches 8       NVMe-TCP handling of netdev events: stop the offload if
>                  netdev is going down
> Patches 9-10    implement support for NVMe-TCP copy and CRC offload in
>                  the mlx5 NIC driver
> 
> Testing:
> =========================================
> This series was tested using fio with various configurations of IO sizes,
> depths, MTUs, and with both the SPDK and kernel NVMe-TCP targets.
> 
> Future work:
> =========================================
> A follow-up series will introduce support for transmit side CRC. Then,
> we will work on adding support for TLS in NVMe-TCP and combining the
> two offloads.

Boris, Or and Yoray

Thanks for submitting this work. Overall this looks good to me.
The model here is not messy at all which is not trivial when it comes to 
tcp offloads.

Gave you comments in the patches themselves but overall this looks
good!

Would love to see TLS work from you moving forward.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
