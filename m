Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A827EC61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+SUPoHHPw0mF/bch7D9vN3W20nq3H4FIOb7kgeyb72g=; b=MkOc6oab5EhEVyDoxjQ8UJuUW0
	T5YXW+BI4KdHU2S4I9ixk5TKBAkuNyjiKLYReZJSfo1GZqpSLYuTlQ681IBhv4iduWLp+AlMt0/Qv
	MGVO6ohbvlhu9mOPxUo6klDQIdOOiOVQC8xvVo2osPXTQCuGkFJlx4lzAQzByPNJTIzw0wlRGDnY/
	CUr5w92qlCzf8DYhpSnBBrzhewlK8p1nkDigxYMmaXTXSuOUWp35kNupm7IHLSinr8IXiIY7px4SB
	E4aclGOA2+8AmG75ssz/ZVAFpyn28+QLx4/dXn1Z9w9jjrAWJ1vmcZNfFYFUDQS18GaCVwdIAyaaZ
	30HZJGfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0meE-000000085jf-3LZI;
	Sun, 30 Aug 2026 21:01:02 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0meC-000000085iw-0IBr
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:01:01 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so31516555e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123658; x=1788728458;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+SUPoHHPw0mF/bch7D9vN3W20nq3H4FIOb7kgeyb72g=;
        b=QCpK6X05nVFq4j5Q1Uig+npFaDPNxvuM6TTbpsFN6qxzYMmHrungHcQ+rdwTCv/5tu
         JTjv6o8MvJYL4UUE4S0AJ3pcNgAGvAuzsKzEPdY8tlbbAfoyMgjDFUrxxKxP42KfxuhX
         I5Ld8MMLr1k6LyfI68+cyrFnYdnooevXAEOq/vsNW6sSDRdqIqwtl2ctEQHUoJG8bQ95
         Y2+IwxS8ipco4lhJBxkq38Uok3AfmmGwSznUjb4bdVKsX7MTDFoxW9EGAiQCCfdM8r0N
         Z5F6CGfgxV89+njUKJmG4lurhDcK7fbrZHBgC/DETBcWykLUUiBszOnC/cH4ua0lSUin
         j/0w==
X-Gm-Message-State: AFuF++nP0CtOWGRLEoI/i0lW8GnlytacxWixHRVX4UzIl7OAFV++JGz0
	r/z8j7Fj9xdpt16IeIcj4l3OxhnuH7e1Rorkjr8hPTrYQhctjuuwjnLg
X-Gm-Gg: AR+sD13v/Rcl1ZaWdFYIPmmM2uaQNvRTmVhQT4TEs+CW2/v7XlvzI1wKr6XRMg/QS9u
	DxOCjh0kNDfJXg4UGXiv703ZH9bQPeg5pLwiX4M0Rsog430+QyJXNRs1GDWsf5wjD8cMqtKyaqA
	oVdL+kg5PIGjyej5BJfVBGvYHOuEVebXqAouOVcTKz8U3ZrUicMS/4HPKyzdz/6wyhOm2pfB7D7
	EMfa7hRgxTXERbFufwUfDJsMN5WJCGC5Pv2FL3tr5VP4FNudGtp9ObqePcK6JaBmIzRUzec2hPx
	6mx4w6YbLPfRpR/W8Jrz8yx2almmWzO4DzzQSw3GgCIlaHuJUmJ+rVSK54F68s+ayGqXMuer1/T
	TzTuBCInxEpcSsNeQS9uevhR3pXWhQJWV5w89ABG1hs5lO/FHmz7aK7QWDWT2FnDwjtZjSAmstM
	tHXfZh8b46+aKs5HzuYi9zFVezXSM3U19vPfbGFIkSzCCEDmDnYcs04JIdQ1nf2TgH80lP2GxWi
	H7tljwsQtuVA9EFj1Rebw==
X-Received: by 2002:a05:600c:5487:b0:495:7888:281c with SMTP id 5b1f17b1804b1-49b91bd1463mr258542345e9.0.1788123657772;
        Sun, 30 Aug 2026 14:00:57 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm270763245e9.9.2026.08.30.14.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:00:57 -0700 (PDT)
Message-ID: <a1770149-e633-4a58-af06-849da27fa7cb@grimberg.me>
Date: Mon, 31 Aug 2026 00:00:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-tcp: report a bounded MDTS instead of "no limit"
To: Alfonso Kuen <gerencia@idkmanager.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260828222356.1264-1-gerencia@idkmanager.com>
 <20260829013900.10392-1-gerencia@idkmanager.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260829013900.10392-1-gerencia@idkmanager.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_140100_155748_93126F9C 
X-CRM114-Status: GOOD (  30.76  )
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



On 29/08/2026 4:39, Alfonso Kuen wrote:
> nvmet-tcp does not implement .get_mdts, so nvmet_ctrl_mdts() falls back
> to the port value (0 by default) and identify-controller advertises "no
> maximum data transfer size". The initiator believes it:
> nvme_init_ctrl_finish() sets max_hw_sectors to UINT_MAX.
>
> What the initiator then issues is decided by the block layer. The
> generic cap is 4 MiB (BLK_DEF_MAX_SECTORS_CAP), but a namespace that
> advertises a large NOWS raises it: blk_validate_limits() takes
> max_sectors from io_opt once io_opt exceeds that cap. On the array we
> measured, NOWS is 65535, so io_opt is 32 MiB and the initiator emitted
> 32 MiB commands -- from a controller that advertised no MDTS at all.
>
> The target cannot serve those, in one of two ways depending on the
> kernel.
>
> Since 4a3f00262a04 ("nvmet-tcp: bound SGL data length before allocating
> command buffers"), nvmet_tcp_map_data() rejects any len above
> NVMET_TCP_MAXH2CDATA (4 MiB) with NVME_SC_SGL_INVALID_DATA | DNR, so the
> command fails hard and deterministically. That is the right response to
> an oversized command, but the initiator had no way to avoid sending it:
> nothing advertised the limit it was exceeding.
>
> Before that commit the command reached sgl_alloc(), which for 32 MiB
> needs 8192 scatterlist entries -- 256 KiB, an order-6 kmalloc. Under
> fragmentation that fails, and it surfaces as NVME_SC_INTERNAL, a generic
> status, so NVMe multipath does not fail the command over to another
> path. A 1 MiB command needs 256 entries, 8 KiB, served from the
> kmalloc-8k slab, which does not fail. That failure mode is intermittent
> and load-dependent rather than deterministic; on a vendor kernel
> predating the bound it cost us roughly 98 GiB of a 2 TiB image copy,
> with the copy tool exiting 0.
>
> nvmet-rdma has advertised a bounded MDTS since "nvmet-rdma: Implement
> get_mdts controller op" (Max Gurtovoy, Mar 2020), which left the other
> transports untouched.

Nit - instead of this patch reference - you should simply say:

>   Do the same for TCP, using the same 1 MiB value,
> so initiators size their commands to something the target accepts
> instead of discovering the limit by failing.
>
> Signed-off-by: Alfonso Kuen <gerencia@idkmanager.com>
> ---
> Changes in v2:
>   - Rewrite the rationale. v1 described the sgl_alloc() order-6 failure as
>     current behaviour; since 4a3f00262a04 that path is unreachable and an
>     oversized command is rejected earlier with SGL_INVALID_DATA | DNR. Both
>     failure modes are now described, and which kernels see which.
>   - v1 attributed the 32 MiB command size to a "generic 32 MiB ceiling" in
>     the block layer. The generic cap is 4 MiB; the 32 MiB came from the
>     target's own NOWS raising io_opt. Corrected -- and it sharpens the point,
>     since the same controller advertises an optimal I/O size it cannot serve.
>   - v1 called the 1 MiB SGL an order-0 allocation; it is 8 KiB.
>   - No functional change: the diff is byte-identical to v1.
>   drivers/nvme/target/tcp.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index e4f603b2a..414ba896e 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -23,6 +23,9 @@
>   #include "nvmet.h"
>   
>   #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
> +
> +/* Assume mpsmin == device_page_size == 4KB */
> +#define NVMET_TCP_MAX_MDTS		8
>   #define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
>   #define NVMET_TCP_BACKLOG 128
>   
> @@ -2243,6 +2246,11 @@ static ssize_t nvmet_tcp_host_port_addr(struct nvmet_ctrl *ctrl,
>   			(struct sockaddr *)&queue->sockaddr_peer);
>   }
>   
> +static u8 nvmet_tcp_get_mdts(const struct nvmet_ctrl *ctrl)
> +{
> +	return NVMET_TCP_MAX_MDTS;
> +}
> +
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>   	.owner			= THIS_MODULE,
>   	.type			= NVMF_TRTYPE_TCP,
> @@ -2254,6 +2262,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>   	.install_queue		= nvmet_tcp_install_queue,
>   	.disc_traddr		= nvmet_tcp_disc_port_addr,
>   	.host_traddr		= nvmet_tcp_host_port_addr,
> +	.get_mdts		= nvmet_tcp_get_mdts,
>   };
>   
>   static int __init nvmet_tcp_init(void)


