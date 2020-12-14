Return-Path: <SRS0=G3e6=FS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9FCC4361B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 20:13:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C091E207A0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 20:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C091E207A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mi71SjCXj8nCZx0R/DlpdWgou8HlmQ3opjJ9/ao23ZU=; b=eKUqflEPEg/MWFeQuKBXoXiN+
	BRfUhpLPl4vk/9n3E3+M3/WvhKJ6sJFcmyFmMHZUZGjtJZIsvcnGoH6bTDm5FENNx9y9nn7eN/8jg
	04+Kzw4wNQ8f7YwupyxRkn2Zfl4jvQDY2MYoTVTvWnc+d/kOdMNaFXXAavLpRNjfQNinzeiwEW8b4
	DDGELD7LsNrrffz5vtF3gDwIjeZmIv1pG3JTdcvZ30vGUhFLZi9zr9YpkFYBkq3CTg9QyowEYpHXe
	pibYwlADHxcUzgZ87LWXze5cNydy+TsAmtoC+6YoYPobtM/aWpNIu88Zxb/4Bb00VUtaF6TIUvq05
	2ghAbNGJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kouDf-0001db-U8; Mon, 14 Dec 2020 20:13:19 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kouDd-0001d2-0k
 for linux-nvme@lists.infradead.org; Mon, 14 Dec 2020 20:13:18 +0000
Received: by mail-pl1-f181.google.com with SMTP id g20so8582293plo.2
 for <linux-nvme@lists.infradead.org>; Mon, 14 Dec 2020 12:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n5YZp13rsFgAt27IYdP25M+AvoCMH0mI7GUdV9gIp1I=;
 b=lzHhpp8COWPV3nVoB1BpHhqKbllRYUrsSjDZT4Hwc9cR5Vz5ENmhzUZNMEEH5d4Ax9
 67CorUSj/yAIWnBUOQ9VCEkF8UzIYF7KWBeIOGGwLZqwLEX9cLMTYHWJdWtRlINljR68
 9L/SLApAI8/xlc6HGIgCPFsrZdezNTZJfnF2ce4A867yfEA404PyrSU7oK6sKaUsrvOF
 Bz2hUbJ64viTiRriGW6leODYSbYixGLjjf5lMO1PtMaoiB7DwZkB4UN4Q/Czd8TBhFLf
 i+PmL2doYAr/AupqfZqvjPeJLqkntJ4kFS6ItzSfpwO0aBAZRphrYACI4Kfjgej5wE7R
 qz4g==
X-Gm-Message-State: AOAM5324ibAMxdsM0O/briMEbowhLZ5aTVCVw34DIM4IyJh33eh2GdeD
 cIVsHGTkFeAsA2DLyeYqp1M3PZufzrI=
X-Google-Smtp-Source: ABdhPJwNV8OdLMNUUE7uPYKXioP4D6TiubNHUDRTZNYLmpg0fImXcJkffNswAcM2eMYF4/vym8m1+g==
X-Received: by 2002:a17:90a:f3c5:: with SMTP id
 ha5mr15361006pjb.61.1607976795501; 
 Mon, 14 Dec 2020 12:13:15 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:b6ef:7a90:5c54:72f9?
 ([2601:647:4802:9070:b6ef:7a90:5c54:72f9])
 by smtp.gmail.com with ESMTPSA id b37sm20827044pgl.31.2020.12.14.12.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Dec 2020 12:13:14 -0800 (PST)
Subject: Re: Request timeout seen with NVMEoF TCP
To: Samuel Jones <sjones@kalrayinc.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
 <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
 <X9epa3PPORdBKZ71@chelsio.com>
 <1186883669.22294090.1607974060434.JavaMail.zimbra@kalray.eu>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <269f3e56-f6da-1125-2cea-a29862f904dd@grimberg.me>
Date: Mon, 14 Dec 2020 12:13:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1186883669.22294090.1607974060434.JavaMail.zimbra@kalray.eu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_151317_086653_B7C1FB27 
X-CRM114-Status: GOOD (  18.27  )
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
Cc: Potnuri Bharat Teja <bharat@chelsio.com>, hch@lst.de,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,

Hey Sam,

> Without instrumenting the driver it's hard to say what might be happening here.

Yes, that would be the next step.

  But I did make a few comments at the end of my initial email which 
might be relevant:
> 
> 1. It seems abnormal to me that the direct send path does not check the return value of nvme_tcp_try_send(), given that this routine at least claims to be able to fail transiently. nvme_tcp_queue_request should reschedule the workqueue if nvme_tcp_try_send() does not return 1, IMHO.
> 
> 2. If, for whatever reason, kernel_sendpage or sock_no_sendpage returns -EAGAIN, the nvme_tcp_try_send() returns 0. This will be interpreted by nvme_tcp_io_work() as meaning there is nothing more to do. This is wrong, because in fact there is more work to do and nvme_tcp_io_work() should reschedule itself in this case. Unfortunately, as the system is coded, nvme_tcp_io_work() has no way of distinguishing between "nvme_tcp_try_send returned 0 because there is nothing to do" and "nvme_tcp_try_send returned 0 because of a transient failure".
> 
> Not sure how possible these cases are in practice but theoretically they can occur..

The design is that if sendpage fails with a transient error (e.g.
EAGAIN) the socket buffer is full and we're guaranteed to be called
with nvme_tcp_write_space when the socket makes additional room, when
write_space is called, we schedule io_work to resume its work, hence
the direct send path is not rescheduling the io_work in this case.

It may be possible that write_space is called when the socket buffer has
some more room, but it immediately gets filled with the direct send path
but then the io_work should be triggered and with the proposed fix it
should reschedule itself if it wasn't able to acquire the send_mutex.

But apparently there is a different race here that we're not seeing
at the moment...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
