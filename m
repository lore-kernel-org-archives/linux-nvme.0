Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5008C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+qlOUBPxgXsHA0igvOH1wMM9M/jIG9Z2ri2rr/IWuSw=; b=eTNY1TwqC8wsbOldNbUMuCiYvA
	RhNfEfMT2Lxw4mhVSeczaUvkmkkzI5i/NuDWKPUQELF4600+zD1b699XmFb9e3fD5xkFvCoXCXUms
	lcy3u+3zOcUosyGyKPnRdP+5zbYV7mb8z7ZMhGxjwY4pZ6Xcv+UoTgTbdoRmcNUVur/OIfzZZlZ1m
	ezs8QD46sFCCEetrGHNJZoDbYPtBDXCjBimLzjfZ32R3xP9s3udey6fFN23ARV6xuwRfGtJbINaP2
	lV8YpZe4Mc44r8LQNrWpxUf/1ig0jCz1BbQMTDaAESnnGCPgs7awXfgzwgS0nDbDFGuKEAApR1jz5
	uGP9nKHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSIj-00DEfw-Uk; Thu, 20 Oct 2022 09:57:21 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSIh-00DEUC-Au
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 09:57:20 +0000
Received: by mail-wm1-f41.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so1784799wmq.4
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 02:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qlOUBPxgXsHA0igvOH1wMM9M/jIG9Z2ri2rr/IWuSw=;
        b=BHlGpGRa4wbf7UjoP7P+u6H91N5geuaLi0qA4lcegzbJvwgfF7w9GxpVkkHQmD/VkZ
         EKDCDdPiI+eW1nYhB+bXcLKQa5kltxAL+wXDcA/jjlMW+KgjBp/kQ9pxqKx00Ak/bDi0
         DyTsVYt75pxH7svbefzrgNs64YX1YXIsCBSGf4f7rj2Z4VYokbxsKrkh4c4KrYMLEErt
         ssTh+ftPp8LUO+17qr3zOnNQEbcVdgToZN3d2JbF4EoDVLFqGHvy93lvhyoirNHc6tMB
         eySq4/DRY4suaCfYQmp39/Hvc0kzqkEQjYaN/H5rS62GtV4rQ0j8aSSt0zg7U+ediFeG
         n8ZA==
X-Gm-Message-State: ACrzQf39G9i2UPpn8I2GsiSzK8FZ7vSc0Vck8CWZw1mpt+1I11FOG1gT
	ion6UnZk/khhFh3c//EuQ8y75hB0YqY=
X-Google-Smtp-Source: AMsMyM5UncaJ81Fi446efFqfKh3fmhioozKMEGAKq2jL9yfaOWqIFfUxVRdcL92tShDkeE52abZcyw==
X-Received: by 2002:a05:600c:34cf:b0:3c7:84d:709 with SMTP id d15-20020a05600c34cf00b003c7084d0709mr4204882wmq.37.1666259833413;
        Thu, 20 Oct 2022 02:57:13 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d4b02000000b0022ed6ff3a96sm15688000wrq.39.2022.10.20.02.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 02:57:12 -0700 (PDT)
Message-ID: <930775bf-4e8f-5580-8216-d2f28e369cb3@grimberg.me>
Date: Thu, 20 Oct 2022 12:57:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
 <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
 <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
 <20221019160147.ij3nc44n5ppmzifp@carbon.suse.asia>
 <8c564393-f5e6-57e7-c2a2-8ddd58187a0b@grimberg.me>
 <20221020081002.z2qvzlq3du7qef4b@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020081002.z2qvzlq3du7qef4b@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_025719_400607_6505B3E4 
X-CRM114-Status: GOOD (  12.28  )
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


>>>>> Still able to trigger though I figured out how I am able to
>>>>> reproduce it:
>>>>>
>>>>>     VM 4M memory, 8 vCPUs
>>>>
>>>> thats small...
>>>
>>> Just a test VM. But I think this is actually the key to reproduce the
>>> lockdep splat. The fio command is eating up a lot of ram (I guess any
>>> other memory hog would do the job as well) and forces the mm subsystem
>>> to use the swap.
>>
>> Is that 4MB of memory? or 4GB?
> 
> Ah sorry... it is 4GB indeed.

Just for the experiment, can you try with this change:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c5bea92560bd..d814be5dca1e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1519,7 +1519,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl 
*nctrl, int qid)
          * close. This is done to prevent stale data from being sent should
          * the network connection be restored before TCP times out.
          */
-       sock_no_linger(queue->sock->sk);
+       //sock_no_linger(queue->sock->sk);

         if (so_priority > 0)
                 sock_set_priority(queue->sock->sk, so_priority);

