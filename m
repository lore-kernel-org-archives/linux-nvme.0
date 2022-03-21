Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74990C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VQQ+KlOOnrLM/du+TmR4nLav7zEu/ca3hcikeuCO5QA=; b=RwWXTlDmSijhHnBNUwEFVNkiwr
	B1JGHrS12SJwW+V3AaZl9NxAQR1ePiFyCTKzHZujbgLjKVI+CayXLC4+vCDFkPJZZNuuPCBaQUvib
	ix/210yTNl4uo0k3C98XDc69juKGV79HDmalnhahfxW9v+ueRrYj0YIo5HcZLtJpnnqMEsur6d/HG
	u+aTpky10UvwA/s30OeKS4uYaeoSpaPDMP9GCfcTdsjlImAq23y9kmifnesRFW82FRaeArvMMpjQU
	YFWSxlXad9w5RIsrY+KDSo4chTVnz4fCyvOr9NbaG8WBAoo+Y6ElX3432uF2HdA7KvpuBYuU6kAbw
	K2XKb57A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWEIY-0079Ef-7A; Mon, 21 Mar 2022 09:25:58 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWEIT-0079C0-B8
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 09:25:54 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 bi13-20020a05600c3d8d00b0038c2c33d8f3so7284362wmb.4
 for <linux-nvme@lists.infradead.org>; Mon, 21 Mar 2022 02:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VQQ+KlOOnrLM/du+TmR4nLav7zEu/ca3hcikeuCO5QA=;
 b=UaVwalzsNVU5mM4+mXBygjIOI6XeYenjcc5bQVqfnDf88HPkkVn5uz42pit9/VRepu
 S84M9xTD/eaE2uQcw6agHRDZT2n1XOMNCjKeMYW2nPpx7/FdRULpxOWoLrb8lzqdR+tO
 /DeLJPS9HBt+e177lih+HxH9uHqQc3i9MOwTx/VAeRIPpZvkSMgHRrzZ/pCFuUCCsbCq
 JVvK2fzDlI6sr4xC+bEJT/lPO1644GsDLgikDPh/PykVXT9wcSFIn5K+uzAxcm9/zT2/
 vRA7xIKV9Z0WTdqsJFh1L+jIHOrzOGOBjJAwXXigybaKqZKWFuqwSbTvXvH/H3TUU02L
 YAvg==
X-Gm-Message-State: AOAM531LjN08l04t3hZ8zU20Khupi8FSk9QKFHqkjPwOWt//FD/QZsvJ
 EXOaDWsb4j9HCUfhM0Tu9Cs=
X-Google-Smtp-Source: ABdhPJyWGw7fBs/UstS01IgddaGlIWMcCEeHDy2ZBWm7IC1RXkZa+0f2WnzuFrn+Vtcwedip9+2F4g==
X-Received: by 2002:a05:600c:3ac3:b0:38c:8b84:52ee with SMTP id
 d3-20020a05600c3ac300b0038c8b8452eemr12774274wms.93.1647854748032; 
 Mon, 21 Mar 2022 02:25:48 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 k40-20020a05600c1ca800b0038c6c8b7fa8sm14630988wms.25.2022.03.21.02.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 02:25:47 -0700 (PDT)
Message-ID: <f5394785-aafa-784c-9ac0-b4abe19f65be@grimberg.me>
Date: Mon, 21 Mar 2022 11:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Nitzan Carmi <nitzanc@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
 <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
 <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
 <9ba8bfae-2363-e331-83c7-317a9456da31@grimberg.me>
 <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs9cmOt=9++wuqJ1ehLPDJcaXJGyTKcHSjU-avWxr1CBrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_022553_424078_E2EEC20D 
X-CRM114-Status: GOOD (  12.58  )
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


>>>>> # nvme connect to target
>>>>> # nvme reset /dev/nvme0
>>>>> # nvme disconnect-all
>>>>> # sleep 10
>>>>> # echo scan > /sys/kernel/debug/kmemleak
>>>>> # sleep 60
>>>>> # cat /sys/kernel/debug/kmemleak
>>>>>
>>>> Thanks I was able to repro it with the above commands.
>>>>
>>>> Still not clear where is the leak is, but I do see some non-symmetric
>>>> code in the error flows that we need to fix. Plus the keep-alive timing
>>>> movement.
>>>>
>>>> It will take some time for me to debug this.
>>>>
>>>> Can you repro it with tcp transport as well ?
>>>
>>> Yes, nvme/tcp also can reproduce it, here is the log:

Looks like the offending commit was 8e141f9eb803 ("block: drain file 
system I/O on del_gendisk") which moved the call-site for a reason.

However rq_qos_exit() should be reentrant safe, so can you verify
that this change eliminates the issue as well?
--
diff --git a/block/blk-core.c b/block/blk-core.c
index 94bf37f8e61d..6ccc02a41f25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -323,6 +323,7 @@ void blk_cleanup_queue(struct request_queue *q)

         blk_queue_flag_set(QUEUE_FLAG_DEAD, q);

+       rq_qos_exit(q);
         blk_sync_queue(q);
         if (queue_is_mq(q)) {
                 blk_mq_cancel_work_sync(q);
--

