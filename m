Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE2C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 00:42:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB1861369
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 00:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB1861369
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/0LA8iHaXUisdB7AXSH8ZSw7rvsRmJeXkR4EokNYWNQ=; b=mewzIVBuIjI+Tje+zLa2/j6ZL
	UZYH3xy0rizkYAUvrp6I3lZNTewfQAsChqeLy1ylqS6MrZRvftIevFiteDbx7QuHRMl7XVSE3duDM
	ENihqBp2osfoyynj5eotxzvq5MwOpQ5BqD7m3D8ubFOYh+ZZuVFFDs8iaP8YAm8U2b7Hnl7NSwitc
	qt0ZPJbP2KuOLBI+3BCaTYsNoNxiVZTBbnl3UPKHXBb9XovrksU74t+SpGIRZFFSiTdHqpEsc1IxQ
	6LP87I18Cq2TafqjyEbNvMENV/ZR5rOkVi3+2UkMJeq7tV2R+ryc96AoUka6R+hUso4D3AQWcIQtG
	FwEMPggMg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1linoZ-00GXrk-1U; Tue, 18 May 2021 00:42:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1linoW-00GXr1-3L
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 00:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=qFu+p9qTBhLB9c451fi8ivYAT96us50ZgU75QH6UDPA=; b=LSMJ6zxOJ87m4eMthLBHZa/j5M
 oYroKfeM+JXkWYPtgOEDlZRB3i9T0WBzBV6sNw1mL6mz9c09eCwwy2SYEbtqJpxGW+6yj3pZImCoh
 f0avRsb/GEizxeIFYnccttxTdKMc5/6LzxWAWE26ry4CcFztvXzJSKnrTI4FYc1zTJJZzoJGccpUL
 CDSi7V/DvtkXxWNJ3HOPbgydgpdfhiXSyJQfAD9ZKmOMd1uIDYabxbP9L0FXObbSBrJKBz4pRv3+B
 KzStJB80LAA/vZ6hZ3Mh0B2J83DFiv5TWOVezYQ51hQDmPGFRrhEuS8WYBtgkiA8jxqlSRsOXIvaS
 dDdVVOuA==;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1linoT-00EEik-4a
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 00:42:22 +0000
Received: by mail-pj1-f46.google.com with SMTP id k5so4596235pjj.1
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 17:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qFu+p9qTBhLB9c451fi8ivYAT96us50ZgU75QH6UDPA=;
 b=ivOYIRrQZsKESaCLzCbZ1TjH+k+daMpXgzLz1oOdljVzSyMeciqUnHdo3C2oEO+Rb3
 DRVrc8Xm9uuVnh83gfg85X2OlXRI5K6xO8zj43PxEg3JOLowmm1rVjmS2INpAEy3q4SP
 9swB7VRpUljIEGHFyu3Ra96yureZu32W+bxOT+Ff/HX9Wbvh+C9olAbtKFPncN1R56gq
 vB0pzabwIz1McyW6GBbUp0GT+7u3j454S70VLJoaiwP7+5i1zoq+00o+RVbTiXV7cg7O
 oSrkgmMw6Dm2xhXUIMUxPljVN2Tquv+KI7eiYtGDun8iK59A+5AalfOR3ljoD4e+quXi
 rYxw==
X-Gm-Message-State: AOAM533nT4UqzXipNCtgSqNJlNOMHW3g+bx0n24H7QWNgFHQCqU5ZCGw
 gbhcUMuFEw0+M33gFknpLElX8dCAxA8=
X-Google-Smtp-Source: ABdhPJz0LO4ss8oQnbNaIW6f3kMET2hrGaaD9wnO+aojy/T5lDLEWjsajNEZWjaRFcqIKXBB3CReeg==
X-Received: by 2002:a17:902:7601:b029:f0:b297:7c38 with SMTP id
 k1-20020a1709027601b02900f0b2977c38mr1448934pll.18.1621298540240; 
 Mon, 17 May 2021 17:42:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id q23sm11623487pgt.42.2021.05.17.17.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 17:42:19 -0700 (PDT)
Subject: Re: [RFC PATCH] nvme-tcp: rerun io_work if req_list is not empty
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210517223643.2934196-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2479237f-ed41-6de0-6ffc-bed66046b2c2@grimberg.me>
Date: Mon, 17 May 2021 17:42:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517223643.2934196-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_174221_214774_AFD0D55A 
X-CRM114-Status: GOOD (  29.76  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> A possible race condition exists where the request to send data is
> enqueued from nvme_tcp_handle_r2t()'s will not be observed by
> nvme_tcp_send_all() if it happens to be running. The driver relies on
> io_work to send the enqueued request when it is runs again, but the
> concurrently running nvme_tcp_send_all() may not have released the
> send_mutex at that time. If no future commands are enqueued to re-kick
> the io_work, the request will timeout in the SEND_H2C state, resulting
> in a timeout error like:
> 
>    nvme nvme0: queue 1: timeout request 0x3 type 6
> 
> Ensure the io_work continues to run as long as the req_list is not
> empty.

There is a version of this patch that I personally suggested before,
however I couldn't explain why that should happen...

nvme_tcp_send_all tries to send everything it has queues, it means
should either be able to send everything, or it should see a full socket
buffer. But in case the socket buffer is full, there should be a
.write_space() sk callback triggering when the socket buffer evacuates
space... Maybe there is a chance that write_space triggered, started
execution, and that the send_mutex is still taken?

Can we maybe try to catch if that is the case?

> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> Marking this RFC because the timeout is difficult to recreate, so
> difficult to verify the patch. The patch was created purely from code
> inspection, so I'm just hoping for feedback on my analysis right now.
> 
>   drivers/nvme/host/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0222e23f5936..d07eb13d8713 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1140,7 +1140,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   				pending = true;
>   			else if (unlikely(result < 0))
>   				break;
> -		}
> +		} else
> +			pending = !llist_empty(&queue->req_list);

In my version, pending was unconditionally set to true...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
