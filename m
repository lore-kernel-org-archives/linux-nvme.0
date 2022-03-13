Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C7EC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vCaA+Wh+Wx7Ta4aeT/ck2tjXVf6Mb0nC0oCuYVcQ0C8=; b=m/71kEfIJggbV4fCZ//c43Vfoc
	TNceBCTKFyMpsw9k7Moe+jsgWLQFr/nZej+62NvjawFupzv2MuA6Ex8Yc4lhABh7qzXt2GUpZBKHS
	jywVLbCidt5hPTUi2WSs8Od00sTFl0aSEVrViePP/E1dRqtq0D6XU9cvbpLWuC4afNnAOk/wfTfeY
	ptEuyCJDZQGnT8RRONsue32+dadIFSCJ+nbajsxYFLeaR5AiFhS/ULYls/6FdI0Kck2jM8bzeRoYt
	0QtFnMZqWRTSBb2hd9OwPpp7yK+fkuFqzksyRyu5uGB9Xm+t/x5SGb3t09d1ZIrikb4SeURiDaMv6
	NbK5y3+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTMe4-002i2d-64; Sun, 13 Mar 2022 11:44:20 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTMe1-002i25-Na
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 11:44:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id r64so13375wmr.4
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 04:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vCaA+Wh+Wx7Ta4aeT/ck2tjXVf6Mb0nC0oCuYVcQ0C8=;
 b=t7Iw4sDgDotj0sVlB4PkGVLwT22gRe9ARIgy+yH6sVZKkkJiy4mCuIRtMAx4Llt2Re
 aN0zH7NZwnW+OtmYHcbMmvZixdgUDxT3HV3GDWCGQEaWQyhl9i4sncOQa2M+UQwWfAgq
 VGm+vCAec92CtSxFv6b4Y8pJj0RCACVbX92E5EQn7vgyb1rmhjyoDYhqBFmckPaCR1Wl
 OfQ3sS2EaoGyF+oGPM9eEJgB73RGuQkWKHGjchRgtQddvnMOWGWRTKKvkWP9EKsL4ltu
 2EXrVlCwIB0OtEaSG7p4Dr4SgQb1iKopp/o8ie9jma7W7ZlSMFoFbw4//p1e42iibdle
 f/7Q==
X-Gm-Message-State: AOAM532eVJXO+TCJlnQmgXohLZliROn46zcVzkiqaw54NZcuFlTn3+kt
 hZtmHCWLLZbvywkMpSfQUMM=
X-Google-Smtp-Source: ABdhPJwYFHTtRQ4qBgNnAqWunEUgx1z6UPldJ6h9s9YVPKEFa+nET2P2MzLYmrs6Wg7w4IUb7Zi8EQ==
X-Received: by 2002:a05:600c:3506:b0:389:d567:e9fa with SMTP id
 h6-20020a05600c350600b00389d567e9famr13800144wmq.74.1647171854534; 
 Sun, 13 Mar 2022 04:44:14 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 c124-20020a1c3582000000b00384d42a9638sm12616244wma.2.2022.03.13.04.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 04:44:14 -0700 (PDT)
Message-ID: <45aed896-ab6a-90f5-9676-e27a7d0128fd@grimberg.me>
Date: Sun, 13 Mar 2022 13:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] nvmet-tcp: support specifying the
 congestion-control
Content-Language: en-US
To: Mingbao Sun <sunmingbao@tom.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-3-sunmingbao@tom.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220311103414.8255-3-sunmingbao@tom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_044417_809463_E0E90944 
X-CRM114-Status: GOOD (  16.88  )
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


> From: Mingbao Sun <tyler.sun@dell.com>

Hey Mingbao,

> congestion-control could have a noticeable impaction on the
> performance of TCP-based communications. This is of course true
> to NVMe_over_TCP.
> 
> Different congestion-controls (e.g., cubic, dctcp) are suitable for
> different scenarios. Proper adoption of congestion control would benefit
> the performance. On the contrary, the performance could be destroyed.
> 
> Though we can specify the congestion-control of NVMe_over_TCP via
> writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
> changes the congestion-control of all the future TCP sockets that
> have not been explicitly assigned the congestion-control, thus bringing
> potential impaction on their performance.
> 
> So it makes sense to make NVMe_over_TCP support specifying the
> congestion-control. And this commit addresses the target side.
> 
> Implementation approach:
> the following new file entry was created for user to specify the
> congestion-control of each nvmet port.
> '/sys/kernel/config/nvmet/ports/X/tcp_congestion'
> Then later in nvmet_tcp_add_port, the specified congestion-control
> would be applied to the listening socket of the nvmet port.

Please see my comments on the host side patch.

In addition, specifically on the chosen interface, why should this
be port specific? What is the use-case to configure this per-port?

