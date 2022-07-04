Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51872C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 23:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iPb1uwa1fPfHppzvLU9rHvh0oUB4hSiMAfifeyLX24=; b=KeiPKkub+SKBKKxgHD06vumM3W
	yRJuMDCyCwC7rPvec+WfW3iWNUnbe2rEJFxnYxXANgvcWedYVrAUntiEGWd7FzgWzrJb5xf0d2RKS
	5vxoKRIvH0qO5CnXptQkA+MtaRwrr56hcUKUF3y4bYWjw1yxKZnHnBwj4hnA+w6XikxlgM7xOQHvz
	0ZewXX24B4nUB6/qdoixxo0nKkswtbN3G6c2xgL8EkR4XhUZ/Q1GrO3mkckxSJHAFh4gTxxk4ONx5
	7kquGYG4UyZxdlkXIhCX1ZhUXub7xoNwrYy8wECY/gwQF69AqWgixSq2ZR7mWuqZtaHQV5blGFUQR
	uGoOfBDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8V7l-00D1kh-7z; Mon, 04 Jul 2022 23:05:01 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8V7i-00D1iL-U7
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 23:05:00 +0000
Received: by mail-wr1-f44.google.com with SMTP id bk26so80134wrb.11
        for <linux-nvme@lists.infradead.org>; Mon, 04 Jul 2022 16:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3iPb1uwa1fPfHppzvLU9rHvh0oUB4hSiMAfifeyLX24=;
        b=aM+VSmHyHUY24UDsE+4KNAVg6w/VMqtsdGbsN62zV2naNExK5c+36wnnotqsi6uFxi
         PQW1KiehEToi7l/AL7LAoUeGiyEYfAxyLDjNKSofZs5RYsRGx5kHIM8AhAnrwLhO9uu+
         k7RKFKBg3ibQBe369BN3sxUObYG71KJp8AALZwRifgO0WPz3tHMXWyJ3VdCLugSiHt8K
         q2qScxgH8mBTzhSO0S/n0+zGpbbFxv/c54C8u5wSFOP4bmnRvVCMH3Vf2WZzqZnavVin
         rJoYq9ji9CSZTLTtayJiqQTo+gNpNpd8v48pG0eWxNJlmWPNDNaBn3ACOKg5dxw21dqZ
         LHgQ==
X-Gm-Message-State: AJIora9Qye8Km2eq0bQEubeflHTC3LLiEJ77Q/1nd3GbbUhJ9MuwgxwQ
	D9DVD0c/bnYxgoW99mraO7w=
X-Google-Smtp-Source: AGRyM1vpSmj7Wkc4yoYCw/LOEo7TDl1/XOsTN1ySnSXCzObyaIfDpJxYLCBDixArytk+F9NvaSaC5w==
X-Received: by 2002:adf:fb49:0:b0:21a:3ccc:fb77 with SMTP id c9-20020adffb49000000b0021a3cccfb77mr28242775wrs.280.1656975895818;
        Mon, 04 Jul 2022 16:04:55 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id b6-20020adff906000000b0021d6a23fdf3sm4104231wrr.15.2022.07.04.16.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 16:04:55 -0700 (PDT)
Message-ID: <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me>
Date: Tue, 5 Jul 2022 02:04:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one cpu
 on host side
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
 <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_160459_016406_28337938 
X-CRM114-Status: GOOD (  12.73  )
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


> update the subject to better describe the issue:
> 
> So I tried this issue on one nvme/rdma environment, and it was also
> reproducible, here are the steps:
> 
> # echo 0 >/sys/devices/system/cpu/cpu0/online
> # dmesg | tail -10
> [  781.577235] smpboot: CPU 0 is now offline
> # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
> Failed to write to /dev/nvme-fabrics: Invalid cross-device link
> no controller found: failed to write to nvme-fabrics device
> 
> # dmesg
> [  781.577235] smpboot: CPU 0 is now offline
> [  799.471627] nvme nvme0: creating 39 I/O queues.
> [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
> [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
> [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18

This is because of blk_mq_alloc_request_hctx() and was raised before.

IIRC there was reluctance to make it allocate a request for an hctx even
if its associated mapped cpu is offline.

The latest attempt was from Ming:
[PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx

Don't know where that went tho...

