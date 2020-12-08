Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29564C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 00:42:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC15238EB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 00:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC15238EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rJFahMtGuDzKHzwVZqhBfxxUJI6zysQr00QbdMo7oag=; b=Gpu630nOLcq2A5Oh2m+Mzmr41
	HUC5vDLw/wYPfJRG8Qq9X7HFIeSiTerQHvWXDBeHfbmRqk8wnoZUUzpH6eh1D99GeBD+84xlSSqUk
	3QwNt6CwiO032tp7hottOgglc12h8TH89eYdLQfYudlXawB+9uDLsEZnZd7xvgAZmDSEDj4A7gu6u
	Q9CCXWqKyjtcGhTb99ugK7EL0o9MiEsbFL+eHwtkfV5hZHCrbOzUtzDMp+T42UqyYA+fDTJX0umMr
	QggLggIMnzo0HCg4kArM25O/pZSKCRi7NMBN+0aJJam51axtArgY92i7zzLQI8iB79NN6Nts3xQ1O
	7PAwQPhsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmR5E-0007ub-6d; Tue, 08 Dec 2020 00:42:24 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmR5B-0007u4-Tj
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 00:42:22 +0000
Received: by mail-ot1-x342.google.com with SMTP id w3so13747165otp.13
 for <linux-nvme@lists.infradead.org>; Mon, 07 Dec 2020 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZYYj64iOJHuX/xMvVRv3ZXW74hgbsDQts9uFztE8vxU=;
 b=mhJOpXUGZhTUU7AcHlTdW98b1GB3AGcLBXUf2HD/TrqkWJIp60mvwZ0lghNWMFlgnv
 IIxmvJNVr1PUa9mDs5gdnNVNLytg6KngttDEYraSbZpNTmInnQHde4nPHkEslEUOqYdh
 TSPfVtOvD38FBEF7bTjBW0AL/6Sj9z2ZUaseeZW3Cs73ZoR4leHciuVFwl42/UHHgERb
 RTzCuQuIaP2mFaG937ZnYINaNLnLIm7m6Qv5NrkcOLCTHPX4PWvZS5aOFw7Q0egYb/tt
 exXtY5oLB5UTH93Hdx2NmzwlA2xvZNx8DL6eAGZdqc/NG7vGoyQRMJbF6qHVg5dOjgrQ
 HGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZYYj64iOJHuX/xMvVRv3ZXW74hgbsDQts9uFztE8vxU=;
 b=Ww7XCCJbU6jZgZPCLjuF9fo7bx8nS8z/LF4ncWgkFn6Tj+p++AOCqczvqU77KIMDs3
 TK/C2f31bnb6+/Bwod3k4oXAnNZF2evY010N+izuV+V+mVHf9mf7EXKlqvox/1jVNJae
 lmxIqoyqYuTnLR+UH1o5RAJYGRWsKmDvx8JUdHS+dXA0ukzLIp9yvU4Kn274C5VdzFfw
 S/nx2309I6/qvPIq2w7aucpJVdYHG4KB3zmWRct239GwJ91Ev28GkoLJJDwcuOKqSSRc
 eUwTTx7cKNDmIR3hfyfzgmukQaJe5iZ87nwF/QFf289X/sf7WcOj5wM7P5beJdmEQKGP
 dZgw==
X-Gm-Message-State: AOAM531otkvmqUfs8jbwx1NYtmkh6KEKM5P8GBUZdRzm9EyERsCFlz+I
 qMnMDOPYAUNeYCzYL9tctU4=
X-Google-Smtp-Source: ABdhPJwm4OctedO/dz22kdPnSZtfmeyJoO5kTh1gOZgT6QX6t7RmShIuEaZGVqnk9lW7wj9QuI6beA==
X-Received: by 2002:a9d:261:: with SMTP id 88mr14686997otb.202.1607388139095; 
 Mon, 07 Dec 2020 16:42:19 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.51])
 by smtp.googlemail.com with ESMTPSA id l12sm3148666ooe.27.2020.12.07.16.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Dec 2020 16:42:18 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
Date: Mon, 7 Dec 2020 17:42:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207210649.19194-3-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_194221_992831_F010C21A 
X-CRM114-Status: GOOD (  20.17  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/7/20 2:06 PM, Boris Pismenny wrote:
> This commit introduces direct data placement offload for TCP.
> This capability is accompanied by new net_device operations that
> configure
> hardware contexts. There is a context per socket, and a context per DDP
> opreation. Additionally, a resynchronization routine is used to assist
> hardware handle TCP OOO, and continue the offload.
> Furthermore, we let the offloading driver advertise what is the max hw
> sectors/segments.
> 
> Using this interface, the NIC hardware will scatter TCP payload directly
> to the BIO pages according to the command_id.
> To maintain the correctness of the network stack, the driver is expected
> to construct SKBs that point to the BIO pages.
> 
> This, the SKB represents the data on the wire, while it is pointing
> to data that is already placed in the destination buffer.
> As a result, data from page frags should not be copied out to
> the linear part.
> 
> As SKBs that use DDP are already very memory efficient, we modify
> skb_condence to avoid copying data from fragments to the linear
> part of SKBs that belong to a socket that uses DDP offload.
> 
> A follow-up patch will use this interface for DDP in NVMe-TCP.
> 

You call this Direct Data Placement - which sounds like a marketing name.

Fundamentally, this starts with offloading TCP socket buffers for a
specific flow, so generically a TCP Rx zerocopy for kernel stack managed
sockets (as opposed to AF_XDP's zerocopy). Why is this not building in
that level of infrastructure first and adding ULPs like NVME on top?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
