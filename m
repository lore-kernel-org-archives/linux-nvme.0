Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CC2D59D99
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Dec 2025 03:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57GeelsZDMHG/yu8fM79YFz+luZM294/w5AcyTPupag=; b=Pw35huOg/2nfawKXbOVviULWME
	cuKZBTmEIHkyrtn/xA1F+KD1jGol4dPiRLmSlO+WCsV17rUbfIflt4izrSHuhc0VYJiWH2iDL0tOe
	GnMJSPDdthwDZkEJ2LYWZXIeeJMo/t233jodFTZPQqr8uIEJCbhUK85D65ciIXaXbuBUuz0RgZkng
	YR1GnLxAE+sNJqkr81UWTSka3sWNTyUYcyh6f9EsefvFwaN/qje1NOsjduJD6lulZf/umaKD52je/
	4R3235dBdoARIrUZV0F+yeb1izklSwZR/+jT4oxK4I06HkJ+Ajprqyj4asrCHz8NU5yVgJFzvnXpr
	06UVpnMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUzVm-00000002zPZ-1OAp;
	Mon, 15 Dec 2025 03:44:38 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUzVe-00000002zPA-2eRy
	for linux-nvme@lists.infradead.org;
	Mon, 15 Dec 2025 03:44:32 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2a0a95200e8so9173815ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 14 Dec 2025 19:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765770269; x=1766375069; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57GeelsZDMHG/yu8fM79YFz+luZM294/w5AcyTPupag=;
        b=JlU1Mr7IllGgv3k4YnGwdgAZSrwdTThVjKhb1E/f3MjcUf0bnWVssVUxRcxsHOSx2K
         7D2xv8ZSu/gDW9CE7cS64/RsXgNc/Ys7UDkJpbJGob/dOZSgQSltv0pxkD1/NRpAlEEq
         nenafux5ij7QVdXUVhCRymjntJgm5ekBvh/pQpE/LvSJd0YHgJVsm+GwAEOoNiW6BNta
         OncPdFxosNHAcJ6EShB6J1sZlXUvQALhQFlJG3ocn26Ki4W7jQpoGYq67IdkfCWO8/W+
         VhIsGlLQVTUUKch14MViOZNCG9FbVNDCNerB2MBip+ohiIJ9nGJYV3fY1eqkudqiF4B7
         WmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765770269; x=1766375069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57GeelsZDMHG/yu8fM79YFz+luZM294/w5AcyTPupag=;
        b=G6ufQ5AVuYBEhXF95HR+iItva3VogAzQXeOvdu5JXFKKoEYm9t60DPL6oYJ3anyM8l
         IdxNamXASBRWECmLKe8SgUXWeXgqb/m8ZHv/Rv4dIAfGIXzVhsADRyCVtZA4H9+dv75w
         GugPxw4/CcF6EYLhTSM2PPNko92SyshSBXvUfc8kcBRf7gl/IQ7mcrKoapw+yim5qI6I
         ZVLNCEBXwms9+mglVPtQd9A5ISajD3m8abX9chYhbtRJ7Zzci+lhk0/GUvat0hAh6Mot
         YO1JDON2t+zvcDraUm0qWCj6pJ2qT5hj6qWGO8XV0yzJIE4BBaQCN3iZyhhBOfxQN+ic
         UhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfg3wGtABTVCEX0b6kZPvTHU6YxC0C/thS7aBHIotK05/Ts6rvPXZtqjokch+WO4Wuf5mayppVN2Vq@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5u6Sv2Br/9/EekDUhLnQ6r/gxBtwu2dMB05n+KH1A5rauJXbk
	0fi/MQfmoyc1q7lXGTthM+y5TPGRgDhrPXrFlWjQ/eRERVJK1SNoJPLg
X-Gm-Gg: AY/fxX78/kj2J1xEsgP3AzbMR6pbx57XqG2hucSQxjv+rXh2E04V7gJAXLVcQanzNoG
	kjTrdh0T3xllbMXz4haObGpmMMQB30n8cN8x+xZREQz80JDuz7jPaxsXnPuQtHJqFEVyJ3Xa2dA
	/7Dg4noGbd+KnFjWIIiPz1CRH7F/hfypw6axQTeW20CLgoSq2nTE2esAORrcPYAtv/j1pr0B7X0
	v8tPFf8kxrELcSQ7pWbRpJZ/cl1RZaLaaMdDFEjN6uFAL/gHIJZ5nRLftJNk3gZqkl4eSOH9s0v
	qz7HYjDjAZ6+wpT4DgtWxd3YSWFvg2HzRLGo6XKJ598fVJ2tqH9mXuYyzg+zlpQ0xsDOJhLzjcP
	3OV2Sp6x6ABS0NUs5F8DRg9b3HrdESKB0KAQ3TZ5fAPka7us2W7nMfC05eR27sACbyKDU8DgHza
	gAaB4QySREBG8eaLP+hxrMc+WSt+2ixZRXK14HLACUxTuvMlJClpn2myr4ejLQffQz
X-Google-Smtp-Source: AGHT+IHtX257iwl90uElpBrUJZRVMjG2XPgwkYlJRTHebfpWp69rDMIJUAS9W36qS9uR/lfZo5dQsA==
X-Received: by 2002:a05:701b:2612:b0:11b:9386:a38c with SMTP id a92af1059eb24-11f34c71819mr4989481c88.47.1765770268909;
        Sun, 14 Dec 2025 19:44:28 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:a625:a605:cb9a:d5e1? ([2600:8802:b00:9ce0:a625:a605:cb9a:d5e1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb45csm42007893c88.1.2025.12.14.19.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 19:44:28 -0800 (PST)
Message-ID: <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com>
Date: Sun, 14 Dec 2025 19:44:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>, Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_194430_726995_F0CFE55C 
X-CRM114-Status: GOOD (  12.19  )
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

On 12/11/25 07:40, Yi Zhang wrote:
> Hi
> The following kmemleak was observed during blktests nvme/fc, please
> help check it and let me know if you need any info/test for it,
> thanks.
>
> commit d678712ead7318d5650158aa00113f63ccd4e210
> Merge: 95ed689e9f30 a0750fae73c5
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Dec 10 13:41:17 2025 -0700
>
>      Merge branch 'block-6.19' into for-next
>
>      * block-6.19:
>        blk-mq-dma: always initialize dma state
>
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff88826cab51c0 (size 2488):
>    comm "nvme", pid 84134, jiffies 4304631753
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      60 1a be c1 ff ff ff ff c0 2b 05 73 77 60 00 00  `........+.sw`..
>    backtrace (crc 155ec6c5):
>      kmem_cache_alloc_node_noprof+0x5e4/0x830
>      blk_alloc_queue+0x30/0x700
>      blk_mq_alloc_queue+0x14b/0x230
>      nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
>      0xffffffffc11de07f
>      0xffffffffc11dfc28
>      nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
>      nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
>      vfs_write+0x1d0/0xfd0
>      ksys_write+0xf9/0x1d0
>      do_syscall_64+0x95/0x520
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e


Can you try following ? FYI : - Potential fix, only compile tested.

 From b3c2e350ae741b18c04abe489dcf9d325537c01c Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date: Sun, 14 Dec 2025 19:29:24 -0800
Subject: [PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset if init fails

nvme_fabrics creates an NVMe/FC controller in following path:

     nvmf_dev_write()
       -> nvmf_create_ctrl()
         -> nvme_fc_create_ctrl()
           -> nvme_fc_init_ctrl()

Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
nvme_remove_admin_tag_set() to release the resources.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
  drivers/nvme/host/fc.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index bc455fa98246..6948de3f438a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3587,6 +3587,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
  
  	ctrl->ctrl.opts = NULL;
  
+	if (ctrl->ctrl.admin_tagset)
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
  	/* initiate nvme ctrl ref counting teardown */
  	nvme_uninit_ctrl(&ctrl->ctrl);
  
-- 
2.40.0

-ck



