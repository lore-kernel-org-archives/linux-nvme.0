Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F92E71062
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Sep 2023 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eynQlZvjE27JhyoDUSsmCVMjkh9tOc45JWjWr2Vd8i4=; b=4Kmt+rb5VvaaVA7EunuRPn2Btn
	cTv86N++iBmCz0gf5SsG8mFrMavETKxBmdtXlh1cXRXHLju+lEVr4TVXr2VmCjoxFcHlwvWoMd3HR
	JBk2NGL5sqZ8GUWgmAAU7GNqaLr5CxGvHiU9F/aKyLq+7DX+WXh6sGxFzZhVFWGPn5erRu5WL76aC
	FbR3wKU6Ag/5VMoomtNwS/Kd3eWUrPEa3+WGTk8JDJH7ySPWCG6h2FkC241f2rdfvUD9nW3mzkGe8
	K1UosF90ipCaYsJ75FgSZ5jFPEHKGRa7kjGMbhJXNYeAtrJ6eso9BQBQOChvzn4g8TUX7BPZB2D55
	JrrJxrMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjIry-0061rv-2g;
	Thu, 21 Sep 2023 12:33:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjIrw-0061pA-07
	for linux-nvme@lists.infradead.org;
	Thu, 21 Sep 2023 12:33:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id D4010CE220F;
	Thu, 21 Sep 2023 12:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C28C32781;
	Thu, 21 Sep 2023 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695299592;
	bh=I2wdsC3bwatwPq1wviIFhcLzP9nRh4x476U8QpzzmYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NC8H/ohiAWX3OutaLR4Cya1zHBgBXqp7c2GIxnn8JAcfcpw7xwjEjAdQaNzq0/YBS
	 FTUUhrz0vR+5jF2OmTX1zVZPdeyizSjanbALvylLLsr1qW5Ibw/JkdVBla0IMCaRwl
	 tmr+1t9d8u5l3stCZt2xmSWtBn5coDerTofphOvUytFzG3T2qkJZTGTasnW8ydIw8G
	 KsNMumgxh0LjKs8MFjhUYrBITMx88d3J0vLwsAAI/ilhVQEVOnxZq1aYlDj/v5jX6T
	 8XWNwoqKkdyMYiePha7rrNeU2+o2AkrH0FtDATXlenRLv1j0t3IJGKcXEBAXJbP1dO
	 jRrhZkKj49SXg==
Message-ID: <ab57c5d6-be1a-dca3-1629-4f81b07a3c19@kernel.org>
Date: Thu, 21 Sep 2023 06:33:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v15 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, imagedong@tencent.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-2-aaptel@nvidia.com>
 <4ae938a0-6331-f5d6-baa5-62eb8b07e63f@kernel.org>
 <253y1h0j7j6.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <253y1h0j7j6.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_053320_270091_00537A03 
X-CRM114-Status: GOOD (  11.77  )
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

On 9/21/23 1:43 AM, Aurelien Aptel wrote:
> David Ahern <dsahern@kernel.org> writes:
>> Not consolidating frags into linear is a requirement for any Rx ZC
>> solution (e.g., the gpu devmem RFC set and accompanying io_uring set for
>> userspace memory). Meaning, the bit can be more generic and less tied to
>> ulp_ddp.
> 
> In our view the ULP Direct Data Placement has a very specific design and
> avoiding skb coalescing is just one aspect of it.
> It would be hard to make it generic for any type of zero copy design. We
> can rename the bit to "ddp" or "zerocopy" if you prefer but it might end
> up being more misleading.

The number of single use case bits on sk_buff are piling up. In this
case, skb->ulp_ddp is only used to avoid skb_condense, so name it
accordingly. skb->no_condense for example.

