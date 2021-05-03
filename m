Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E46C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 19:58:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3BE61159
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 19:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3BE61159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cdigrYAFfhWSfT8fezX1aJsXDCzor3Wb6OK/6h+Ypn8=; b=qpmrn5H9ZAKXwGnnfyXZXTybs
	+1o80/yT3WHvp0m2fdg4f7W/7ph9KkFIFlb+8X9A65O70ph5Bsq8Q98tBrKVfTWpkBVpK2vkm47B9
	seD8nzcrqK9y+al7wTUBpsECzEa8HNXjZPcyVTbrSaL9d0PM/o0Uh0IYAboMpn/2WyloOrUMlWegN
	0diLRFqPSbLewoQw3cLJsqEa115+A008KH/+QcX3rbqVotjb+4zk+IyOj+3Yk7gGk18FZk0PJSGFo
	TLLOYfXwZcc2ABisEUQKuGyDK56FfoQQq5ugay7z0L5a+nPMZyQK8C37SsvMzIAQEgc1NlITTXHou
	koQT7HuOQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldei8-00EmKV-3D; Mon, 03 May 2021 19:58:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldei6-00EmKM-50
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 19:58:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=cz9HHDZUCvPfVoV41JFvc7zSjIf2L+AopR5KBzwiyt8=; b=raJseNBO+af9MbLVoQal0OHCVh
 w/dC5OA3LnnLz+/ZRCKNUb0qVGXT45HH4si35/YjndF8Mu6z20CQjQGwySo6/l/Sg61BhrQgUhNWG
 KZP6lNBFzuG+Ivpb736AulPN447wDjq4nsZG2N0QyH6ucQXV9CJQWcfeMdxGMton8OTvmCaKpH2W/
 w4m280e7PSVlBl4ANuMZmWaE+fZ3SQtAGDYccXwAzkCGX36rePGfMivPi2Prl89PSHqV48lRu/WXE
 fKj80nocrLTXTuh5oVCH60VeDf8HVrP4pYhMupit15Q8tTHUGRKFdecWS/2lfKFvvNdWvnPn89S3S
 HCP9wC0Q==;
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldei3-003RtC-Hb
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 19:58:28 +0000
Received: by mail-pg1-f171.google.com with SMTP id y32so4495005pga.11
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 12:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cz9HHDZUCvPfVoV41JFvc7zSjIf2L+AopR5KBzwiyt8=;
 b=KU+Jz6LwxLMv3j4LenrNyULIY9Nk9hZN5FGmyNepjAtWQnyFhABLDqfA7ZsVFnvrcD
 cJS+T+i2CGV5PHebdVH47nuo+zJ43YPjl4BNxV8qLThdckhey5496zVzipdpdG7G2Nys
 izX5DwG5AtPdcqSS/L2v8ZVvJzCPIvAnsNjh0sE7JF582doaWmQcMGtucsgeqQ6TwN5G
 ksNW0lDfcUAvG5z40cFStX1NPnSifFc1mfjokX0d7Fvlp5Mk+3P4zvOvVbyeObXi9C4j
 iU0sDckOOmfRYVe3ZclfujjZQLyF5hGayoV8V7zOgsRr1e/bs+DxgGrRI9Yb9nz/xFDb
 fAcg==
X-Gm-Message-State: AOAM531WB5oAxXu/VpEHtx7hGtG827RYTmN/Ov2/ptbkg0Ty0grYcVDl
 4aklSNDubY6t4aaQ4SAxEXo=
X-Google-Smtp-Source: ABdhPJwYRzKmk86hmFDgdJ1xDSjRUfOKIKm3qo+drDNBcmratlWAtKtC0l5nkkUdtFscjAoGdEVO9g==
X-Received: by 2002:a63:190b:: with SMTP id z11mr19586986pgl.314.1620071905206; 
 Mon, 03 May 2021 12:58:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4840:6f98:816c:4241?
 ([2601:647:4802:9070:4840:6f98:816c:4241])
 by smtp.gmail.com with ESMTPSA id i14sm456724pgk.77.2021.05.03.12.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 12:58:24 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
 <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
 <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
 <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
 <500074cf-c0e8-807b-5b30-a3474d37700f@grimberg.me>
 <20210429033328.GC24074@redsun51.ssa.fujisawa.hgst.com>
 <bd3c39f9-3768-7494-e63b-7baf9ad9b615@grimberg.me>
 <20210503185121.GD910137@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <96afc178-f5db-dd56-59a6-467e032c619a@grimberg.me>
Date: Mon, 3 May 2021 12:58:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210503185121.GD910137@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_125827_620312_22BD0824 
X-CRM114-Status: GOOD (  21.69  )
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


>>> The driver tracepoints captured millions of IO's where everything
>>> happened as expected, so I really think something got confused and
>>> mucked with the wrong request. I've added more trace points to increase
>>> visibility because I frankly didn't find how that could happen just from
>>> code inspection. We will also incorporate your patch below for the next
>>> recreate.
>>
>> Keith, does the issue still happen with eliminating the network send
>> from .queue_rq() ?
> 
> This patch is successful at resolving the observed r2t issues after the
> weekend test run, which is much longer than it could have run
> previously. I'm happy we're narrowing this down, but I'm not seeing how
> this addresses the problem. It looks like the mutex single threads the
> critical parts, but maybe I'm missing something. Any ideas?

Not yet, but note that the send part is mutually exclusive but the
receive context is where we handle the r2t, validate length/offset
and (re)queue the request for sending a h2cdata pdu back to the
controller.

The network send was an optimization for latency, and then I modified
the queueing in the driver such that a request would first go to llist
and then the sending context (either io_work or .queue_rq) would reap it
to a local send_list. This helps the driver get better understanding of
what is inflight such that it better set network msg flags for EOR/MORE.

My assumption is that maybe somehow we send the the initial command
pdu to the controller from queue_rq, receive the r2t back before the
.queue_rq context has completed and something may not be coherent.

Side question, are you running with a fully preemptible kernel? or
less NVMe queues than cpus?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
