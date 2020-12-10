Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC6EC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 21:47:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9C423DE3
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 21:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9C423DE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k1BS+IU6ZvWSy8sfxatn9Y5qxS2A4E0LMRFqrY2IyjU=; b=KCHvLG7hZbRU/+RfCz1MEQTW7
	9U6FoybdtFKKhsmffYaTW6Qk1JD4uSp7myUtoGZAUJ269qFR5Cm13Ibj33QeKHR1NxwO0Ng38s619
	YiJEpZ6NBqjZhalfO3YnpSObN6yinhNZ4oh2u6PTZV5cBJLBZcUf7cLlzcqej/AFGfrFXGSkN4tqB
	vwwtQsMtu/YbdZrX4B9RsfAqMpT7zfPZvJ/baMc3VEL/fTzQCbuIwc3uNHNDMsH/niZ0TSxKZrzCa
	uX9SjuGrL8TkMiEhpTOpBCA85O+AcZ/JIPWjJwY5YJOZf1ttN2qkba2iRj0exPdKwDvvkCiU9KrUa
	zEHT7TqJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knTmP-0001Zo-TD; Thu, 10 Dec 2020 21:47:18 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knTmN-0001Z9-9j
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 21:47:16 +0000
Received: by mail-pf1-f196.google.com with SMTP id b26so5415263pfi.3
 for <linux-nvme@lists.infradead.org>; Thu, 10 Dec 2020 13:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h1CInxwyi2qSlKqTOizCZEkiJE8PVJHqmY/E5+SPaEM=;
 b=c7t6caXrtCscmQHJbyomy3SIt+J4Q0NXkCTjBod2XaH1Q31jZ4qlaOsx0252Qx6qHe
 IlI1y4dPnziSwZ4o45XHh7wuYNEWAh5oiCtiuhw5Hh5dy6wtHM0u7D4jNjWK4kYf77I6
 7433iFY08y/5A2BLTOENY0/0SUEaoNI+PntftraBTA+egx9VZucUBZLvQ6IuGmouoBxu
 Xa1H872v2m5kcO0Vkj//GsOGPin/v2DKBRff38XuXPwPlURJ3+5j8KYkEj6zI0q5/k1M
 nk0XX7bOEsXnxfq7zS6/am61x0lq5TYOybqigYcrtNZkqV5eFLHW0OB9Pbui/GUxNk+l
 AeAA==
X-Gm-Message-State: AOAM531deuAJPyvziqf8U3cRtjT8ftuj9Q9rDccvUeLmNKWPxM14dNFc
 /6U2ljWJ/on1kJxALbevVRTO8bblnfk=
X-Google-Smtp-Source: ABdhPJz73PZf+kUz6o5WCL4ZjhnWu5OJVQIrhn+dOLUHMrjgnq3pAjaYDz6gsyyOxFrWAJxTW4vqyw==
X-Received: by 2002:aa7:9af4:0:b029:19d:975a:3ef2 with SMTP id
 y20-20020aa79af40000b029019d975a3ef2mr8424829pfp.5.1607636833875; 
 Thu, 10 Dec 2020 13:47:13 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e186:2b8a:d435:6746?
 ([2601:647:4802:9070:e186:2b8a:d435:6746])
 by smtp.gmail.com with ESMTPSA id 17sm2546309pfj.91.2020.12.10.13.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Dec 2020 13:47:13 -0800 (PST)
Subject: Re: Request timeout seen with NVMEoF TCP
To: Potnuri Bharat Teja <bharat@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
Date: Thu, 10 Dec 2020 13:47:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9JVp9mjtC1p0iLS@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_164715_374607_315560A3 
X-CRM114-Status: GOOD (  16.77  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>>> Hi All,
>>> I am seeing the following timeouts and reconnects on NVMF TCP initiator with latest v5.10-rc5
>>> kernel.
>>> I see the same behavior with nvme tree too (branch:nvme-5.11)
>>> I last ran this with 5.8, where it was running fine.
>>>
>>> Target configuration is, 1 target with 1gb ramdisk namespace. On intiator,
>>> discover, connect and run fio or Iozone. Traces are seen within couple of minutes
>>> after starting the test.
>>
>> Hey Potnuri,
>>
>> Can you also attach the target side logs? it seems like an I/O times out
>> for no apparent reason..
> 
> I see nothing much logged on target.

Hey Potnuri,

This issue is consistent with what Baharat reported.

Can you please check if the below solves the issue?
-- 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ba659927442..9193b05d7bda 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1122,6 +1122,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
                                 pending = true;
                         else if (unlikely(result < 0))
                                 break;
+               } else {
+                       /*
+                        * submission path is sending, we need to
+                        * continue or resched because the submission
+                        * path direct send is not concerned with
+                        * rescheduling...
+                        */
+                       pending = true;
                 }

                 result = nvme_tcp_try_recv(queue);
-- 

Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
