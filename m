Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F00EC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Jul 2022 08:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VKItlKqeQzUeLjsSOboxbZBwuf6Jv/NlZDlxQtu9aBY=; b=vTR4URKFVY78cGbcpVpDCelDN/
	azAQflwiK+tR070/Nuy+YObRckp+fOo3iQGWNvkBgO/eAUC4MV1hS+1za5elgs6dY22yuXaLxUMrd
	7KNowoazZBGBe4bxw2cZMMLMejWGKgjMipa3mI+FfKlc/5kLpp2kzyTOx/adJH2/VyhVRmLUlRQ4K
	vm4ovXR1V44NvP5SFc5vaiMZNFW6ZJGc4n78YIoSVJ2Rl+swC5jHXhkWoByVrodu3NlvvrbiIr3DA
	BE+nJI6IVWsporCrYW8G0fBbLte+JkvvDXQtGl41tfuzT0Z/kh9PrZK1QtEm/ieLfaJifQmcOV60M
	0pXqp+6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFWrn-000A6r-1g; Sun, 24 Jul 2022 08:21:35 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFWrl-000A3O-6B
	for linux-nvme@lists.infradead.org; Sun, 24 Jul 2022 08:21:34 +0000
Received: by mail-wm1-f52.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so7542786wmb.5
        for <linux-nvme@lists.infradead.org>; Sun, 24 Jul 2022 01:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VKItlKqeQzUeLjsSOboxbZBwuf6Jv/NlZDlxQtu9aBY=;
        b=L4w8znXRetOZ2iCcU9c6vCkpxLN9K5V82obPltZAgqsDPd/7Ll4TcCokks1KFiCwZH
         oocJ3SziTpviCZ/8iqDy/yeKvnpJDY+aAjG9EkpkrbMHmXWPUtypzqSUOjaCROHbWhpq
         lF0cjqorNjbNOkY/GkL4PRtQVfIoKj2kiu8HltocKXtfL2gJce36NMVuOVhXFtZ9xcrl
         4MsjU9l4rzU11Fag8q3sG99qx/i+58Pf2v2lsvHs2ysAAD2atvHG/6MxlTKKd7k4Enj8
         6nOlg4rbMBLd9r4eHBO3lpB6KPtdJ2ZE5S+nnjNsonSzFCIsCV6MB5wWklE5N6lb0pr4
         wzfA==
X-Gm-Message-State: AJIora8DpPVvVX6pG1pzAi3qZXh4RBVJi5bRUvRLYZ1PDvrii7Rdc0VS
	xBOLsqPU8K/oVp8/IBUqgkk=
X-Google-Smtp-Source: AGRyM1vkJHWKG/flWuUgZLrFPARge0QuHbIawiWSLWyzfzm3ZkH7TuRJKNn5TWS0oZkewMVe+YPuwA==
X-Received: by 2002:a05:600c:4e88:b0:3a3:1bdc:cb72 with SMTP id f8-20020a05600c4e8800b003a31bdccb72mr17784171wmq.59.1658650882597;
        Sun, 24 Jul 2022 01:21:22 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b003976fbfbf00sm11119183wmq.30.2022.07.24.01.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 01:21:22 -0700 (PDT)
Message-ID: <472156f4-ff58-aeba-64eb-b8e5815e9c29@grimberg.me>
Date: Sun, 24 Jul 2022 11:21:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
 <YteeHq8TJBncRvZu@infradead.org>
 <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me>
 <YtoriAQGW8+p4pFe@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YtoriAQGW8+p4pFe@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220724_012133_258652_0991BBED 
X-CRM114-Status: GOOD (  13.36  )
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


>> The problem is that nvme_wq is MEM_RECLAIM, and nvme_tcp_wq is
>> for the socket threads, that does not need to be MEM_RECLAIM workqueue.
> 
> Why don't we need MEM_RECLAIM for the socket threads?
> 
>> But reset/error-recovery that take place on nvme_wq, stop nvme-tcp
>> queues, and that must involve flushing queue->io_work in order to
>> fence concurrent execution.
>>
>> So what is the solution? make nvme_tcp_wq MEM_RECLAIM?
> 
> I think so.

OK.

Yi, does this patch makes the issue go away?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 0a9542599ad1..dc3b4dc8fe08 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1839,7 +1839,8 @@ static int __init nvmet_tcp_init(void)
  {
         int ret;

-       nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI, 0);
+       nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
+                               WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
         if (!nvmet_tcp_wq)
                 return -ENOMEM;
--

