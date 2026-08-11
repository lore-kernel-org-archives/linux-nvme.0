Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C661C5AD7B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tyXmp+nyruHB5drxUnjhN/lNDgAHg9Jkey37bDFf6+0=; b=a2GAyVPMuZCip21euUoLcei9Yf
	Y7pC5yj6CQga336kVHx1IRxEXOgjF96YmKUGoj7hunngq8gi8zgMKmmjfVyrOLsf3S7zXAzbViLZ6
	XGd1Sg1qM9RNO6aWzcfCU/2KScYZh+HBp+8SnJLn+mgcsttZMlvQqrDSvefu4B2v/befXREZpywTI
	JMmn8KJfwzdMV4tbswWXt1F85rHyrx1ZNXWQkITBK86Y6E4w1Wb6lvtFQA3LCWXorfWBmMj80m/BS
	1Db6PZY7/ZDvWggtVuzeFj44K4pCEX1Gt7/zf7IMgMSk+I0niJYEAB78js4UDMCf3UQAO7oMhJp1P
	AeN0HZFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtaQu-0000000D4rn-2HhZ;
	Tue, 11 Aug 2026 00:33:32 +0000
Received: from mail-pj2-x02.google.com ([2607:f8b0:4864:39::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtaQp-0000000D4rQ-0QqD
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 00:33:28 +0000
Received: by mail-pj2-x02.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so1016571a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 10 Aug 2026 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786408406; x=1787013206; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tyXmp+nyruHB5drxUnjhN/lNDgAHg9Jkey37bDFf6+0=;
        b=c+J1shUlM05akw0tn6xGp1CDvyhoFJNaC3DMhNFZcM3nEniz2haVgneGCfg/tSMayQ
         l+v420tdqHqKlRyUtUI7tTRxxW9AV8c6AN7X1CyNfC8MutOkUEOGCZtNkP8ooOymGaUH
         Wl6ph9yToZMHSj/YI6J1GvjiH2oRaNTh/VMkCy8/LRVO6rcWQfktnv2dzJhV5n67pMX6
         lgm+J41dvFSBhk00s6lPELTp+6rp4faN0uaGcVyK+/hkERTiS3osfwPY8Cs8GRFGEkla
         maNeI5Lmv9DdXf4FH/Ri7t0biTiESZtgPhcjmm5COJIN1Uebl1FaWm67VvStc+uyZMnp
         5wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408406; x=1787013206;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyXmp+nyruHB5drxUnjhN/lNDgAHg9Jkey37bDFf6+0=;
        b=kEjXQJjFJEpNrJl49WKYFCucagtCceT2r9i1nN74YQh7NpTcQBallqYHGP9UPPv4NM
         1/w8GtDoUvLeqL9LOkSCkzb1WPdAbt9Oxo0D64UxBZQITDQQ4aJR7YKfgeXAqZVm17+Y
         YKCyWw4FdYG/aDyF4APVAQv8lvtdC4fdNT6+7gNQ8V39T1Fey5UvjTPdrUcBsUiIahtM
         GNkD5UsUucTX0aItlSivBle5InnShk5a+J1y62b2Ye0rnDjzZJpD1Pmy78FB4+OACluD
         fdIyjMS1ufEC+So/ECpfAC6n5qI7DadZOJpd6Uw6S1WMWeDoaONO7icdvbpo++Xx2yi5
         tM+Q==
X-Forwarded-Encrypted: i=1; AHgh+RorJg+EogHGr26PJ8ca2K/FbccxXn7STFMnSM9/d/vdXMPMevxtuSXlZ8HKG+7jNc9gjp2FwG/lUz03@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0mNyJhVf/QApWN1EGGnwwhFteg9ZZIOHEx4uWY0rD01g/4HgV
	If/5ozlQKL0GZ77IKiDrBGC240rTQ4qVIroa+VAWlGl6z241+UBN3zJM
X-Gm-Gg: AR+sD121GEMnbC0GvKjk8UZWajO6XmMg3iZuy1FFFO6Dqgvep/RRWfJE+qKT8gMUO8o
	m0sgjin0AROlqltIEmuruE7W/KOBNH/6w8ATtJxme5kOtQl0XH/l5hBAXM1de2T6CpjxmmPtgjG
	HfMoIfZwFtl/GWPxwBB99+Gd9YMsJaaJErSOAF8M6ZWS6dvNOSwVSGVFrFKGW5DS4RfpUyjg0++
	DUik4q+RA/QszUDzHp7FGc6D6QhwDYt2DN90XAp0x6ibbUAqGTD92FPgY+sTgrbRpHsJhQmGRZD
	rFkMm4w3yQeO+FomzYVAHoYwngqKGsyHf1Y4arCPafDe794hBluVwgytkGvKdOfIHt3XcDYyoFm
	RHN59nkQHNEy4Zw4EEMNkCezAjK6P7sc3C1ZLfMuuAwexzrhZL2lgrDKcpV9GM4pM3ghta0lsI9
	tPJUc2jtwORepPck4cr47Rxhmrca0PenKcmpeF7oSzz/ng56unC5zHSl/vaBu1SQkV
X-Received: by 2002:a17:90b:3847:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-3909d89bd69mr25756524a91.10.1786408406008;
        Mon, 10 Aug 2026 17:33:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050736sm1312465a91.4.2026.08.10.17.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:33:25 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:32:36 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Subject: Re: [PATCH v2 2/3] nvme-tcp: support IPv6 traffic class
Message-ID: <anptYps5IoeGDCnt@devvm7509.cco0.facebook.com>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
 <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_173327_146524_5366E4FE 
X-CRM114-Status: GOOD (  23.27  )
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

On 08/08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The NVMe/TCP transport needs to configure the IPv6 traffic class on its
> queue sockets, but the fabrics option parser currently has no corresponding
> option.
> 
> Add the tclass option to the fabrics parser and store the validated value
> in struct nvmf_ctrl_options. Negative values are rejected, while values
> greater than 255 are clamped to 255, matching the valid range of the IPv6
> traffic class field.
> 
> Keep -1 as the default value to let the transport use its default traffic
> class.
> 
> The fabrics layer now supports parsing the tclass option, but the NVMe/TCP
> transport does not currently advertise or apply it.
> 
> Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each queue
> socket via ip6_sock_set_tclass() when a traffic class is specified, keeping
> the existing IPv4 TOS handling unchanged.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
>  drivers/nvme/host/fabrics.h |  3 +++
>  drivers/nvme/host/tcp.c     |  8 +++++++-
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ac3d4f400601..643c03dc7bcb 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
>  	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>  	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>  	{ NVMF_OPT_TOS,			"tos=%d"		},
> +	{ NVMF_OPT_TCLASS,		"tclass=%d"		},

Do you really need new UAPI for v6? Any reason not to apply existing
NVMF_OPT_TOS to ipv6 sockets?

