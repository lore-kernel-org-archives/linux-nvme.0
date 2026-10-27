Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E59606A31D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dyvUNZyH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=X/GqxhwzDfkNlR7rtD12qLgd9HV/zNHUYPrEnneK0SA=; b=dyvUNZyHvxJNPv
	GaV54qHoSbjtQ067eUajT5O0QxQz5lrCwHEa+hhmzVfu+tE8uZ5ueMZcJRKq6TtOHjWtIvohN9Va8
	8GkznMAWgXH9Pnn/7XqMpuOyTrMvSsJg0+1yoF2PakvGIDnANbDJdRrrNz1FJEcr59Cxk64ssOE5T
	Q7Ss32duA1LSSTmIdMLwKi+jbi/WpRB2OP+/5fXamP/GRgjRFEMOxlbPd6ASM2/4AHkGQ8cuLXP5q
	BIxi4ne5piE3EBjfZA1IEc17UFZkSXLKfKcynK4eTbR30mUkN6voKqh9/r9m8Fgu2HMfNX1sPajpC
	G7UqBDq46OiGBT/QpFmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLis9-000000058Oe-3QGc;
	Tue, 27 Oct 2026 15:13:57 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLis6-000000058O3-24hT;
	Tue, 27 Oct 2026 15:13:54 +0000
Message-ID: <022548b6-607b-422c-b7db-5d95b0ba6b79@infradead.org>
Date: Tue, 27 Oct 2026 08:13:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-tcp: validate the TLS handshake timeout
To: Yingjie Wang <1075151112@qq.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, hare@suse.de, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1793103202.git.1075151112@qq.com>
 <tencent_02EC3FD2E750D09B95ACA70091EE65DE0906@qq.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <tencent_02EC3FD2E750D09B95ACA70091EE65DE0906@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/26 5:13 AM, Yingjie Wang wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cc54d5f169f67..a5adbf58fb8f7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4801,6 +4801,11 @@ Kernel parameters
>  			Example:
>  			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
>  

Maybe add "host" and "target" in the descriptions?
or something to clarify/distinguish them.

> +	nvme_tcp.tls_handshake_timeout=
> +			[NVME] TLS handshake timeout in seconds. Valid values
> +			range from 0 to the smaller of UINT_MAX / 1000 and
> +			MAX_JIFFY_OFFSET / HZ. Default: 10
> +
>  	nvmet_tcp.tls_handshake_timeout=
>  			[NVME] TLS handshake timeout in seconds. Valid values
>  			range from 0 to the smaller of UINT_MAX / 1000 and

-- 
~Randy


