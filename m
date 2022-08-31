Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11408ECAAD4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 23:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PAKB8jhmEF/GRWdf3uTU2kfzS6KcGIJ8MzfMRxjhBJE=; b=0N2wPCZa6DEVtt82OQIUdY6wFx
	SYSM4XQYFSiCAk5arhaWwDBrJzqEv4vqNbmbivZOMgVOIWpXTm2SQQbOvpIXlRVLPPPIgj9J8qfqM
	BgSdMAhvxibCbcNdImcqnzcaV9UBNlrHMsVfty+9aN0rNOYbNs1HSByafcOQGmt2yJwYJTAYtwcox
	QXZcSOOuMpVqp0PH8C/0zvy/AGCXisdQysHIUtXr8JhNCi0CV5lQXHPqfmFmEpqudmIOA/q2XO3Jr
	bpU8XbEVTSMV2q1x9103n+6lkvBtL4CMmdm74wxbM9q60AUxZrDMTxl1rxl1wlW4Q/PGBiLv3G9RW
	BW5QgcAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTXLa-008efe-5U; Wed, 31 Aug 2022 23:42:14 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTXLX-008efH-MY
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 23:42:13 +0000
Received: by mail-wr1-f46.google.com with SMTP id b16so12556097wru.7
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 16:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PAKB8jhmEF/GRWdf3uTU2kfzS6KcGIJ8MzfMRxjhBJE=;
        b=ZdtFrxpuhC66+kCqxtcFZIsPg8q6cQtVwrHb/h86VpE6khIzTZDk/1JTfgxWlyX9eN
         ruucOL132ld2I0pkSWYw+kD/qGUUjrBcdcryvnNAuE9evgoo9uAPUM7OmtRyPOE60jbN
         3e3iG9Kb3FGsct41PTC3m+uRKLr+CJwmv1gNAiJnJBr7+Nr22AaMDtuyuOOwqIUfSWB0
         dtvpWuH0YNkhB+OKToT5e2PhiSLIcCBAPElttd8USSGcQNeE0TGkXW2IzjV/ON+Y1G6b
         EMxXkrHD1Vo2fdtkZJRftj1fzgAU3D1ETC/dR/fTeTdk8M+EYPT0Mq8YNcrnbSDr8S/M
         nnlg==
X-Gm-Message-State: ACgBeo2s8MeOE8Ja9YczXzESAvQQ/jqgcfhtAJ+Ky+FvmhE7a8Ksua5l
	G1xlvNQtwPq6yGXfMCilRLSbcFeqZc4=
X-Google-Smtp-Source: AA6agR7a04DjBgxrpqdaPY1LPi8xqVH14VOfhlorPbDAGVHf7b2HBU9CoKMDpFJIdcaiXNB3u+BS0A==
X-Received: by 2002:adf:f387:0:b0:225:3d19:adf1 with SMTP id m7-20020adff387000000b002253d19adf1mr12511572wro.520.1661989327971;
        Wed, 31 Aug 2022 16:42:07 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c1c9b00b003a845fa1edfsm9167828wms.3.2022.08.31.16.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 16:42:07 -0700 (PDT)
Message-ID: <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me>
Date: Thu, 1 Sep 2022 02:42:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: linux-nvme@lists.infradead.org
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <eb6b09b6-c899-e3b8-3217-02f8833818cd@grimberg.me>
 <CAHex0coajr37Xe_XE3sx+kgNosOD_d8N_SQcK=hT4NDAM8suBg@mail.gmail.com>
 <ca7d5545-4630-59eb-3e50-6ca0594ba7c7@grimberg.me>
 <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_164211_786950_AB15A906 
X-CRM114-Status: GOOD (  11.83  )
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


> 
> Here's a trace including state from nvme_tcp_try_send_cmd_pdu(), like so.
> 
> req->dbg.send = 1;
> ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset, len, flags);
> req->dbg.sendpage = ret;
> 
> 
> nvme-trace.out
> 
> tar-1785    [005] .....   232.768892:nvme_tcp_queue_rq:
>   nvme1: qid=6 tag=18 op=0 data_len=20480
> tar-1785    [005] .....   232.768894: nvme_tcp_queue_rq:
>   nvme1: qid=6 tag=17 op=0 data_len=32768
> tar-1785    [005] .N...   232.768895: nvme_tcp_queue_rq:
>   nvme1: qid=6 tag=14 op=0 data_len=32768
> kworker/5:1H-475     [005] .....   232.768923: nvme_tcp_queue_rq:
>   nvme1: qid=6 tag=13 op=0 data_len=32768
> kworker/5:1H-475     [005] .....   232.768924: nvme_tcp_queue_rq:
>   nvme1: qid=6 tag=12 op=0 data_len=12288
> tar-1785    [007] .....   232.769141: nvme_tcp_queue_rq:
>   nvme1: qid=8 tag=69 op=0 data_len=20480
> 
> 
> dmesg.out (reordered to match nvme-trace.out)
> 
> [  262.889536] nvme nvme1: state: tag 0x18 io_cpu 5 smp_id 5 smp_id2 5 sync 1
>   empty 1 lock 1 last 0 more 0 send 0 sendpage -1

Something is not adding up...
lock=1, means that we get into nvme_tcp_send_all(), but somehow we are 
not able to send it to the wire?

I'd look into this and add indication that it is pulled from the
req_list, and in turn from the send_list. It looks like it is somehow
picked out and silteny dropped, because as long as it is on the list(s)
another context should have picked it up at some point...

> [  262.889337] nvme nvme1: state: tag 0x17 io_cpu 5 smp_id 5 smp_id2 5 sync 1
>   empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> [  262.889110] nvme nvme1: state: tag 0x14 io_cpu 5 smp_id 5 smp_id2 7 sync 1
>   empty 1 lock 1 last 0 more 0 send 0 sendpage -1
> [  262.888864] nvme nvme1: state: tag 0x13 io_cpu 5 smp_id 5 smp_id2 5 sync 1
>   empty 0 lock 0 last 0 more 1 send 1 sendpage 72
> [  262.888727] nvme nvme1: state: tag 0x12 io_cpu 5 smp_id 5 smp_id2 5 sync 1
>   empty 0 lock 0 last 1 more 1 send 1 sendpage 72

