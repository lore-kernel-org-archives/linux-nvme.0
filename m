Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21215C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 18:18:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938FE6147E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 18:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938FE6147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mfA7zKKnrqedKadKo2BCdbLcRrclkv0nCpX+7XSxYmk=; b=pTloLwA6LuSZvgZp29yaFaNxR
	WujI3cP1CinBIoWxkldQ8G+BCGe8c6oFVFkCTkrMgEDtyzmzTz7RiLKGCauSUl/cBbjggXiiL8vVx
	x2qoKwYbPy4oKrn6GcQlUdcTc4ornVXFCziqvqWP2GgxzTcPOZCOqgBUPcdfnBjVkd68mVofu5cjt
	iUJEWxJPEaRWZfouWZS16hMPPhRwf/XW0Bc0Y/bCol3x7DTcOIieYgkoS48WpmjjAVPr/SXWcXEkQ
	Zr0yabo5+xBWGP38+MWVDUVK3iuNpPR52uwXHjm605bClHkuf124bp7sM7vthRR3DOo1KICUE5bqL
	NXncWROOA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgAUF-00FPW2-Nl; Mon, 10 May 2021 18:18:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgAUC-00FPVX-Ti
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 18:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=8Pqrgo6XVj9zJ5DPEE5XMUXZauio5SFo38EUB9QDD38=; b=dOHLirnPCNmwh6pI5edBrxDhkn
 IbZhoXJyaGkPZ6jGaqwoCuaALlOkAmORUm+skj/AjwmpXlPEFQFv/szRps0OnZB6BryOy05tK/AiW
 Y+Tt8ETMaHKgA0UcD1LGtgg/gf+/nHtp+JhJ0MUHWQXy8Eexk4DGPslZFgC+bwcxI9RngrPvQMYjG
 IILkf5elqfNdcW7/89L+aIA5/kPRnakgaFIoiXMJPfA27l2LYjMxxNg+qUQN89UtNaE0qE2gLs8/k
 St6d+WOk7bQ3jRxYMKaj1KJ7XG1rGctl+XOwahunqNFuaSLHkWp6trpiwDJhT1QePP2Ds0BVB7XeS
 IJNHVnJA==;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgAU9-0091tt-TR
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 18:18:31 +0000
Received: by mail-wr1-f45.google.com with SMTP id v12so17577453wrq.6
 for <linux-nvme@lists.infradead.org>; Mon, 10 May 2021 11:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Pqrgo6XVj9zJ5DPEE5XMUXZauio5SFo38EUB9QDD38=;
 b=JvjJYbwJZHUf2cOFmMMN5Uo82lj6QhpHOEZ523EqMNMwtkcURjt88YiF4llOKosucv
 CGc5uKAYH2l9bV9PLNGE4bQGt+dIvbo3BNiJUbpKa+El4O2KdQkR79B2kDLbSmt74Ifk
 qcuVyvc7VQpcMqKkPhyet7OxZ1bXzIJ4mF2oThfcbjW/QifnQgPUO7RAZRTRgjClloFS
 c0WjcVuGSynBgfUF5SpcDcgliKVSsbavCBInA03UZ8FMuAgRkoM06tx4H4G8TfG90Tw5
 CLdBK+eko3Ro9i/6FFW+wHq66jwPz76nKb7pct/mAea23Yh9JNG5K3kf+tcbM7wioz62
 wc3A==
X-Gm-Message-State: AOAM531vge9UDvawMSgtTCbawKBTPH8zdcPmy7LGZWgC+jubJCY453xC
 5bmQ1iB1YIHG00RApAE6XBQ=
X-Google-Smtp-Source: ABdhPJy5OzOOQ2PJnYvw90Ym/Oy4T/tV7RZGQs9ZjLMVF4ZOXEmEgEa6CZlnOKsGIKvqJoVoU6uzsA==
X-Received: by 2002:adf:f043:: with SMTP id t3mr32345611wro.344.1620670708403; 
 Mon, 10 May 2021 11:18:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1522:1d2e:7c9d:185c?
 ([2601:647:4802:9070:1522:1d2e:7c9d:185c])
 by smtp.gmail.com with ESMTPSA id z19sm284402wmf.47.2021.05.10.11.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 11:18:27 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
 <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
Date: Mon, 10 May 2021 11:18:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_111829_984834_CAAE29EB 
X-CRM114-Status: GOOD (  18.66  )
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


> Sagi,
> 
> Just wanted to give you an update on where we're at with this.
> 
> All tests run with your earlier patch removing the inline dispatch from
> nvme_tcp_queue_request() are successful. At this point, I am leaning to
> remove that optimization from mainline.

Thanks Keith,

Did you run it with the extra information debug patch I sent you? What
I'm concerned about is that given that you have the only environment
where this reproduces, and this is removed it will be very difficult
to add it back in.

Also, what about the read issue? that one is still unresolved from
my PoV.

> I added additional tracing to see what is going on, but we eventually
> hit a memory issue after some hours of runtime. I've never seen an issue
> like this before, It triggers in nvme_tcp_advance_req() when tracing the
> rq->tag and req->data_sent:
> 
>    WARNING: CPU: 1 PID: 3428 at arch/x86/include/asm/kfence.h:44 kfence_protect_page+0x33/0xa0
> 
> I think the above is a distraction, but I can provide the full stack
> trace and patch adding the tracepoing if you think it's helpful.

That is... odd..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
