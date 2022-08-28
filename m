Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C75C0502A
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9EOgwKIT6cqhzLZngLEBedU8SPQc3EWeHxKdhG2OKg=; b=ASJtKBjY507I4HP2DPzNa9T0cU
	ItmkMP2RRXVvuqaHfmONFByr4OTewh+esxURAxynq+l6BMzsqhfcptSmbZWrr6IlttQ2N6PpwD9mu
	VSonaZcmBIEigq+zLyNIHOg4le+eMavyCcpVlBFUz3Ctx8NU0mkn7Tir0+fAGPjjYtDrY7uKeMmQ7
	yfXCI/Roea2TdQKmUlS6GeULAsyqYCJTqoxsNfDonrvcNcE7PB4kjMrs8I8VDPUARMaMOvNYUqiY0
	B+xGw6qxNt9Nw+TQaC668Nj4GrvK7JcxDr0s9rxVlLqF3xHq1KGBC6YdHB1podXW8nmkP9yOS4DkN
	4CI+dumQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSH78-00Gg8Q-J0; Sun, 28 Aug 2022 12:10:06 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSH71-00Gg6S-Cm
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 12:10:01 +0000
Received: by mail-wm1-f53.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso3086980wmb.2
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 05:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=t9EOgwKIT6cqhzLZngLEBedU8SPQc3EWeHxKdhG2OKg=;
        b=zPM6e6DtdQdmEQ7y7QoH+BH69P6DoEO0lL0lnP+iTtKDKsXJ6IbMi3uZkO2bmvh52r
         rE2oLEOD7Mw9Sz7uZc0RfGwTk46sgDN5kiy9K4YxKq6siyddkne43FO0MA9p9m8Jh3kN
         XUyRrbZQp1H7YA3gKI3VyAf+s6NxPAfiZu+yKp5TvgAbBy2v2zD5y1R9yiGSmHpudjKR
         8xqsA/oAWp1U53XPj3h4yBRCYH5+MMMBuLJS8c7yBQpQPcqATAiuSzwXX1PrqDIVLms3
         +Zw2ywG9Wj+iPMaC+XaoBi34pyBpEKpPaqcMtJx+9MbWxMU6KKN+8zzJ+LIOaAdwfs/p
         DIHw==
X-Gm-Message-State: ACgBeo2T+qPpzZiDFGrM4l4kFLHzkq+iW1clgJjwM1Y4mcSRoAEWG4eu
	ESA7c1z/ljEdP3mX6m+PpOBVVRcZPac7vA==
X-Google-Smtp-Source: AA6agR5WpianW6hghVmZl0LDx1NV3WK6nEFdxhZTZsMIEvbDoDnOvkYI4tw3BD+3/RGUd46jh98BwA==
X-Received: by 2002:a7b:ca4c:0:b0:3a5:bbf1:9e3e with SMTP id m12-20020a7bca4c000000b003a5bbf19e3emr4532421wml.5.1661688596275;
        Sun, 28 Aug 2022 05:09:56 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003a83d5f3678sm4866131wmq.7.2022.08.28.05.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 05:09:55 -0700 (PDT)
Message-ID: <9a0bc2f1-b1d0-a34d-2e9f-926da3fc2ab4@grimberg.me>
Date: Sun, 28 Aug 2022 15:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: crash at nvme_tcp_init_iter with header digest enabled
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220819075117.rzvbecyvh2wuwokj@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220819075117.rzvbecyvh2wuwokj@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_051000_162200_0E8B495E 
X-CRM114-Status: GOOD (  22.78  )
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


> Hi,
> 
> we got a customer bug report against our downstream kernel
> when doing fail over tests with header digest enabled.
> 
> The whole crash looks like an user after free bug but
> so far we were not able to figure out where it happens.
> 
>    nvme nvme13: queue 1: header digest flag is cleared
>    nvme nvme13: receive failed:  -71
>    nvme nvme13: starting error recovery
>    nvme nvme7: Reconnecting in 10 seconds...
> 
>    RIP: nvme_tcp_init_iter
> 
>    nvme_tcp_recv_skb
>    ? tcp_mstamp_refresh
>    ? nvme_tcp_submit_async_event
>    tcp_read_sock
>    nvme_tcp_try_recv
>    nvme_tcp_io_work
>    process_one_work
>    ? process_one_work
>    worker_thread
>    ? process_one_work
>    kthread
>    ? set_kthread_struct
>    ret_from_fork
> 
> In order to rule out that this caused by an reuse of a command id, I
> added a test patch which always clears the request pointer (see below)
> and hoped to see
> 
>     "got bad cqe.command_id %#x on queue %d\n"
> 
> but there was none. Instead the crash disappeared. It looks like we are
> not clearing the request in the error path, but so far I haven't figured
> out how this is related to the header digest enabled.
> 
> Anyway, this is just a FYI and in case anyone has an idea where to poke
> at; I am listening.

I think I see the problem. The stream is corrupted, and we keep
processing it.

The current logic says that once we hit a header-digest problem, we
immediately stop reading from the socket (rd_enabled=false) and trigger
error recovery.

When rd_enabled=false, we don't act on data_ready callbacks, as we know
we are tearing down the socket. However we may keep reading from the
socket if the io_work continues and calls try_recv again (mainly because
our error from nvme_tcp_recv_skb is not propagated back).

I think that this will make the issue go away:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e82dcfcda29b..3e3ebde4eff5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1229,7 +1229,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
                 else if (unlikely(result < 0))
                         return;

-               if (!pending)
+               if (!pending || !queue->rd_enabled)
                         return;

         } while (!time_after(jiffies, deadline)); /* quota is exhausted */
--

