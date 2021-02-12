Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B38C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 22:22:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BB064E8E
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 22:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BB064E8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w38c2+TRbQwDajobnRM/ixpMEWC3wP1ZfQIAaTU1uSU=; b=tNRwBK+/h8aUVe0V6xD0dY4UH
	6cUamiA7ykyVOw+JkLWVoJATMxq/RX3C2d2X+hCwzn85Zc53r1o+z8fXzmfn98QmqS/uFNwxrYOE9
	Fr+bal/koAZ9aPoYi2htOuZ5djvc3HaevS3hxbjSW056e7VJoVFy4rjNe3kWpD+vPqz9anhloKvXy
	0TEzXysyHNFukGSbqrQD++HtretBhIEIi2HU7gjjh3QrKksXumgYW2DehlU86WIMxBUXlbODNowyN
	6dbSuCVfWOp+0niXDxWkjaDRH7W6qw9u7fqZHwxjzQugDDttoUuteA06aYUT0ILKZAFMmqiHUzCyt
	+eY+uMlqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAgpQ-0008Ha-Nk; Fri, 12 Feb 2021 22:22:20 +0000
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAgpN-0008H1-8v
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 22:22:18 +0000
Received: by mail-pl1-f179.google.com with SMTP id ba1so583817plb.1
 for <linux-nvme@lists.infradead.org>; Fri, 12 Feb 2021 14:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AoAo73gmWvK/tftbsC7GgUTH6a3WF/arRUdN7kZ1r3g=;
 b=VoVzxGH8itA4uM73/u2DdvjE4IK8ASgOlM05/Il9StOAek+h7wOuAY6k/a2xrAEWdU
 wuBHWqW9rdBDWJ29UlQ1cnwf0GcwmEZ3tug/+eku+38YEdzGpCE0/07wQyISMCSt9h9Z
 OHldKTBasNcW27O191kOGSQGyte5Vh6tRhFbINPbFM4cbpa6Rk7ndeLEkL96yT1FHZGg
 EoKfC1GlJr47RDhLGxB/NdvU7FM0rVd8iXk8Tx7E4KP48UzUbAMQUwOZky7aHXy9G0dr
 cRktFeTH/75j1XhQBhaeKdoOH3UB+FrkQr9FT0HmT2omdTf2VIG2QHo7+LMjiL8pqOK/
 4tUQ==
X-Gm-Message-State: AOAM531uI1lktlka5PHqkRbU3KZSTW34zsw8axy6VyfypIPCO94jpERU
 Abma8efyiohZvr2lUR7KTRTG6cTz184=
X-Google-Smtp-Source: ABdhPJzzgm+IBUQq+D091hywwCpp0UXkVNbBlP4gu8xUIbKCfgVwBvzow2Wjh3vXpKBIJSwi5KynIw==
X-Received: by 2002:a17:90b:1090:: with SMTP id
 gj16mr4429058pjb.63.1613168536287; 
 Fri, 12 Feb 2021 14:22:16 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:65a3:c687:b052:ed7b?
 ([2601:647:4802:9070:65a3:c687:b052:ed7b])
 by smtp.gmail.com with ESMTPSA id u31sm11324062pgl.9.2021.02.12.14.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Feb 2021 14:22:15 -0800 (PST)
Subject: Re: [PATCH] nvmet-tcp: fix potential race of tcp socket closing
 accept_work
To: "Grupi, Elad" <Elad.Grupi@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210205194725.625035-1-sagi@grimberg.me>
 <DM6PR19MB4011C3BCABE1663D864ECB67EF8B9@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d26978a7-b9a4-8925-1a34-c5e194eb342b@grimberg.me>
Date: Fri, 12 Feb 2021 14:22:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB4011C3BCABE1663D864ECB67EF8B9@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_172217_660372_D89AA755 
X-CRM114-Status: GOOD (  19.13  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Sagi,
> 
> I think there is another race in that solution.
> 
> Please consider following flow:
> 
> Thread 1 taking sk_callback_lock and goes into the else block (state is TCP_ESTABLISHED), going to line:
> 	sock->sk->sk_user_data = queue;
> 
> at that point, thread 2 invokes sk_state_change, but this is still the original state_change callback because we didn't set yet to nvmet_tcp_state_change.
> 
> Thread 1 continues and set the callback to nvmet_tcp_state_change, but the sk_state_change was already called and nvmet_tcp_state_change will be never called.
> 
> In that case, there is a leak, and the queue will never be removed.

Are you saying that this is needed?
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ac2d9ed23cea..d82df6cca801 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1486,6 +1486,7 @@ static int nvmet_tcp_set_queue_sock(struct 
nvmet_tcp_queue *queue)

         ret = 0;
         write_lock_bh(&sock->sk->sk_callback_lock);
+       lock_sock(sock->sk);
         if (sock->sk->sk_state != TCP_ESTABLISHED) {
                 /*
                  * If the socket is already closing, don't even start
@@ -1502,6 +1503,7 @@ static int nvmet_tcp_set_queue_sock(struct 
nvmet_tcp_queue *queue)
                 sock->sk->sk_write_space = nvmet_tcp_write_space;
                 queue_work_on(queue_cpu(queue), nvmet_tcp_wq, 
&queue->io_work);
         }
+       release_sock(sock->sk);
         write_unlock_bh(&sock->sk->sk_callback_lock);

         return ret;
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
