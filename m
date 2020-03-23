Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88354C4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 20:52:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821320719
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mC9AU3F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821320719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VwRJpc4oGTu3HpdPQYhoWe3c+OxFfqgsrgzryeeZu40=; b=mC9AU3F8BcCaZ5791pz9Vw8Hc
	RmXqEbptYTYEuiL0N3nD+SSwy5X/Dx4PMNfmeF55w8FhjAWQLpRk/xstS2gwYqFoE14M7Pz/9vxnk
	ctEJE6PVBAXCdKB7kpQ6D93qUHOAdeCb4VMZeIAoL4efFzWe1MO//rTCwjpNf+H0J7n94JTocBV8D
	3lvrs72pLxr2lArUjX/L6mLU9madjlJwqAi7CfOVZSjMJKRMMqUPNPg/WiACxzVTpHVtyZqsABzA5
	xRwBuaoWkEDS767O0qWi9fmsmfzm+HZjU3a8QJl0H26U6fzq3LPI8ldqZsL27cjGoaFYX+KLNeohM
	gbsC4rn9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGU3p-0006wx-6B; Mon, 23 Mar 2020 20:52:37 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGU3m-0006wX-0X
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 20:52:35 +0000
Received: by mail-wm1-f68.google.com with SMTP id g62so1162713wme.1
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 13:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S8qz/wCZ9QAMwOk1MzRjwkOqymH3UEHTq7x4tV1viAc=;
 b=YzHsK2Q03jkiZkJQGoP7+Rqd+JwHI6srPgaWV/m7kPXRbsXd1eey3Lgx2hG7zvFhKa
 h6268I5PRUETyY1NqLoUwrsPhL3+id38wBapjXoC0EGjfNapCelfit+aPnQv0suxNcB0
 pJqMroH8V9ChSWlFl7L0u/MQVtw+od5PRA79jEW92j5zarrAXlcP2Bo/wfteLFeKKKiy
 XyPP0JzxHWvU/5Z8vwUCocqD9ip7Gzpp1dADBv5si3S3jGynVARtSCLLVm2j/30lJAec
 8Skjzuvul/PuApPB/F8ZKPmey92UuAluiAGm4SVyJg88W8xzB9+Vq7I/FfkR+T2e+1a0
 JZ3g==
X-Gm-Message-State: ANhLgQ2B0mWTcFp8t8j9VEO86HnDeO8kqOQXcIo24HHiGfyDmcudENMA
 YRdIawkx/joQ5gbNvpkFPhcFWe/V
X-Google-Smtp-Source: ADFU+vt2Dwt/VHanS1J0vjnVMda5aL0JVSKzXXXbjgOA53nTFBl9K10vL9Lm7B7hS3pzBOp8s6wNhg==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr1348175wmc.33.1584996751954; 
 Mon, 23 Mar 2020 13:52:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id k204sm1085895wma.17.2020.03.23.13.52.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 13:52:31 -0700 (PDT)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "tasleson@redhat.com" <tasleson@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <e16baf6a-c9e0-2249-6d7a-4e8d58f8e9b6@redhat.com>
 <f390f5a1-a80f-44d7-5d69-642119eef9b8@grimberg.me>
 <c8fce5f3-a01b-da38-820f-cf6caaa377ab@redhat.com>
 <d5e056ca-05b5-c91b-6ed7-668d28b1fe62@grimberg.me>
 <BYAPR04MB496517B2AF9555819C4A684086F00@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1d6fd91f-8442-515f-fe20-5a7a6157ab2e@grimberg.me>
Date: Mon, 23 Mar 2020 13:52:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496517B2AF9555819C4A684086F00@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_135234_059295_6B5E3E24 
X-CRM114-Status: GOOD (  18.38  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> FYI, not a tcp fabrics expert.
> 
> I remember a following fix for write-zeroes target/loop.c.
> 
> commit eb464833a2e787996474ad33dafa2c5336d4c477
> Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date:   Fri May 11 02:38:15 2018 -0400
> 
>       nvmet-loop: use nr_phys_segments when map rq to sgl
> 
>       Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to
> check
>       if a command contains data to me mapped.  This fixes the case where
>       a struct requests contains LBAs, but no data will actually be send,
>       e.g. the pending Write Zeroes support.
> 
>       Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>       Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> 
> I can see that :-
> nvme_tcp_queue_rq()
>    nvme_tcp_setup_cmd_pdu()
> 
>     req->data_len = blk_rq_payload_bytes(rq); <--

The analysis looks correct, the only problem is why I cannot reproduce
this. If this is the case, I need to understand why this does not
reproduce.

> Based on the above fix maybe something like following fix the problem ?
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 814ea2317f4e..f9aac34c87ac 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2187,7 +2187,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct
> nvme_ns *ns,
>           req->data_sent = 0;
>           req->pdu_len = 0;
>           req->pdu_sent = 0;
> -       req->data_len = blk_rq_payload_bytes(rq);
> +       req->data_len = blk_rq_nr_phys_segments(rq);

data_len is length in bytes, but the inline_data call should
perhaps take it into account.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
