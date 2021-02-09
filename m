Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C6C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:26:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A8864E6F
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A8864E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SEAptVghapq6AGUs/kmD28I1qDn6Evg4umznDQHVZ30=; b=FxD5cSLMsENQUcqIOFfQEVNQh
	MZLE04hAavmhS0ervQVXpIMaUcodB09vxkuUZL1hvWC8tpOxmOBSya1Q/WHPYQw7NLIqr6Ftzcpj5
	/vmE7qOgqbn/lMfKP70/M5MRJDxIFPbvKHRsDEW6z3smN+l6zwxmmnmCA9j4sUMR5SdmbO5lo2RNd
	55vr8YO7ysleuhj8+SdozB0JLQxinO2rJKz+WMxWPgJ9KuAncQmTr6Cq+7JBV4FN1ak3fxOr8GmXf
	tHVrxw58IDgKYHSEft9d7AsOmQ3nsosSmWQNlLCEtIK3wrnf5aXwiFKhsBUYbG3XzNjT1r7xn5AGg
	3Km5MuIhw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9QDd-0006rx-Eo; Tue, 09 Feb 2021 10:26:05 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9QDa-0006rI-AE
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 10:26:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id 190so2576770wmz.0
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 02:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ibV/jLkBrn87E5CW6kJR0CKTV/LoaHX30Sh+5d0LRZA=;
 b=pRnYOTthgS6c1x7gRNgCZAq6DBMaIZrjE4batOaXEqRWIDc7P7bZXnjWM0cBAqYSI1
 2lyfgNVmpZLxhq6iSvLWH/V7Pt2R6TW2YKVmXvwHNgCFzfTiTnebSDejL8ZXqk4N2wMi
 RnY4JAkZZTRQPbiUxhg/FyKPIUaEOMCSM65vsjxjZTgnuDGBzeQyTTHR5puYMOvLDoPP
 wcD2JQmvQKNDWsC2XzmziGEsq1vjAHKVHLqVbxRqRzBkgI87U+4paMYVS3+HvtTnzpUU
 XmOOnBQMfId/1c+YxA++kjgAZO0nNg7eToHcRnSDMfWALAZje82ofwFqWUXlf938kT2u
 w88w==
X-Gm-Message-State: AOAM531sMBFhDrklBbCr/LjoOl9N4noD1VpW+PhZMVW/TMU4NU5mFHci
 ANhbx/X+PVKwQhWWfGM2Cww=
X-Google-Smtp-Source: ABdhPJwQ+cVQLW3Ht0As419gQ0XUQrXNHud+lSTx41ToJ41y0uyo86ZxMiOcq3S+N2Lb/gMkU5C1Rw==
X-Received: by 2002:a1c:4483:: with SMTP id r125mr2679863wma.80.1612866360943; 
 Tue, 09 Feb 2021 02:26:00 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id m131sm4012557wmf.41.2021.02.09.02.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Feb 2021 02:26:00 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
Date: Tue, 9 Feb 2021 02:25:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_052602_381152_A1CCCB87 
X-CRM114-Status: GOOD (  17.31  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi
> 
> On 2/8/21 5:46 PM, Sagi Grimberg wrote:
>>
>>> Hello
>>>
>>> We found this kernel NULL pointer issue with latest 
>>> linux-block/for-next and it's 100% reproduced, let me know if you 
>>> need more info/testing, thanks
>>>
>>> Kernel repo: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
>>>
>>> Reproducer: blktests nvme-tcp/012
>>
>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>> but did not succeed. Given that you have it 100% reproducible,
>> can you try to revert commit:
>>
>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>
> 
> Revert this commit fixed the issue and I've attached the config. :)

Hey Ming,

Instead of revert, does this patch makes the issue go away?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 619b0d8f6e38..69f59d2c5799 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2271,7 +2271,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct 
nvme_ns *ns,
         req->data_len = blk_rq_nr_phys_segments(rq) ?
                                 blk_rq_payload_bytes(rq) : 0;
         req->curr_bio = rq->bio;
-       if (req->curr_bio)
+       if (req->curr_bio && req->data_len)
                 nvme_tcp_init_iter(req, rq_data_dir(rq));

         if (rq_data_dir(rq) == WRITE &&
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
