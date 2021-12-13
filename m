Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70458C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6VUWP1kw+5opi3lOui4JoTMjQGPyYrs3NFAuhld7YFs=; b=XjxgCMoOTuhuOrREraEaZ+fF9x
	XFz2rInfP+YWj0gFBJ/ZaK8VNt/nd08eAyXCscbOfXojgDsTnC8bX5F04+tW+tC2aLIlZPeWHED4T
	Lg98GhCtdIbp7P+aHt4v0DpF5I2JGrOGu6eTFp8JPx1z2JsRwnSDknPbPxyTLTXklioEUr7w0uIgi
	uKWHyQlkySTnLJCYemXx7vhksN/UTEULAGaxKxFpnhrMmz2FX1QfmaV0sMbSw0Z+QGik5WmF0GxCn
	aWJBA996RvbSEWv9dAtT8y6rSbSbD6GzxQu6cyjLwMUzb2KJIxrDfqDM/yyTRM4/YxJXUGaxiIUuM
	NnrIlkdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwhSd-008ZlL-TA; Mon, 13 Dec 2021 09:17:32 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwhKP-008WXI-B7
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 09:09:02 +0000
Received: by mail-ed1-f45.google.com with SMTP id w1so49529623edc.6
 for <linux-nvme@lists.infradead.org>; Mon, 13 Dec 2021 01:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6VUWP1kw+5opi3lOui4JoTMjQGPyYrs3NFAuhld7YFs=;
 b=k0m0zIkbebx270sExoLJhsy7+5xCunmpB5lqJ2IIM43BTepXH0k7C6sJP+IvpLn/Jk
 cnc6GNoWBaz0+x59euLT9aQoc6S6n3HgrFVhV97JCSuWfZgGMto6OdnvRGePEF+iPDNX
 N1P2xbB7CEkrhYYHOVEkIYwl0Q9oLkWffHqYRhM5XNBJ1Deae34I6SvAifsNiwJIoInh
 LNYtbCubRE4YCxeGz9qsD+ZloTEGv7RhjZA5OBVwdSNSgZW7Vf7pJPZcqjeFMAqJZoMm
 Nr6JhQ0TpiVOIwtsq9BFXb55aKX5Vjt5KGbeCmW75uwPE4UFT4Y35rn7wAt0l7hiwOe7
 setg==
X-Gm-Message-State: AOAM531ArysizidzFln9mffThmFvAiRoLD/6pueMP6X0ErzZnrnDQTDo
 rxptMPSoivCdm8m6k99lQlk=
X-Google-Smtp-Source: ABdhPJyRtW6mFQpW6OMsRD3QdbWkXpushNKOwD+vhMI6suNpsZszqOX/G1Ahz3VOtVHrAz8U/8g7hQ==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr61787530eds.386.1639386539782; 
 Mon, 13 Dec 2021 01:08:59 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id cy26sm5964800edb.7.2021.12.13.01.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Dec 2021 01:08:59 -0800 (PST)
Subject: Re: nvme-tcp host potential bugs
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Anner, Ran" <Ran.Anner@dell.com>
References: <PH0PR19MB4889C321978DC541DD83A939EE6E9@PH0PR19MB4889.namprd19.prod.outlook.com>
 <9f6e47bd-e604-790e-b6a1-13ed8fd111b1@grimberg.me>
 <CO1PR19MB488518C215ACFF0B53812FC0EE749@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5cfb6d6e-8633-9481-614a-8677b39bef25@grimberg.me>
Date: Mon, 13 Dec 2021 11:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CO1PR19MB488518C215ACFF0B53812FC0EE749@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_010901_444385_510DBEF9 
X-CRM114-Status: GOOD (  15.89  )
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

> Hi Sagi,
> 
> Regarding the first issue, you are right.
> we missed that ctrl->queues array allocation is capped by opts->nr_io_queues,
> 
> However, we do believe that the second issue does exist:
> As part of create_ctrl
> queue_count == nr_io_queues + 1 == 49 (in our example 48 = num_online_cpus())
> 
> As part of nvme_tcp_setup_ctrl,
> alloc_io_queues calls set_queue_count where nr_io_queues is set to 8 (in our case, target ctrl supports up to 8 io queues)
> ctrl->queue_count == 8 + 1
> 
> Timeout occurs and reconnect:
> After reconnect, target ctrl is able to support up to 128 queues.
> alloc_io_queues set nr_io_queues to 48  and ctrl->queue_count == 49
> 
> after 8 iterations, start_io_queues  calls nvme_tcp_start_queue with qid 9
> nvmf_connect_io_queue is being called with qid 9
> __nvme_submit_sync_cmd is calling the block layer (blk_mq_alloc_request_hctx) with qid 9 which returns with an error

Yes, blk_mq_update_nr_hw_queues used to be before nvme_start_queues and
that changed in commit 2875b0aecabe2 which addressed a reset hang in
case the queue map changes across resets (as the queue is frozen
inside).

What I think we may need to do, is first start the older queues (or
less if the new count is smaller) and if the new count is bigger,
need to later, after we connect, update the nr_hw_queues and then
start the new set of queues (ouch).

