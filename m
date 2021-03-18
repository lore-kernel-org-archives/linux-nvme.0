Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D56C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 19:31:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DC764ECF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 19:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DC764ECF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xtWpaH9sGv7nOllIuTY62N9xE0TGpQ72XCYcACME+/g=; b=L4eW3L2gqV2LMmTbOHKsP4LzR
	6+EX1GrkjmVX28yHoHuPI5GJY1YJ2/5pil0RAw+5qGio6LPZj96e9b9JyzeUkzcNF+YhWlB5eR78V
	nlejhBEBL4mKyzWGESKrizJ3lVO+b6pAqEhGkgLUYFNNdsNfxyb7FCqibezY2BUgTnOeH7CP5keuT
	19CD2Br5Aa/4oc89aC3oWdd/8JKAdTmlG6LxaYB7FX62L7Unlq4nwf6y+43kCI2FDuq8WIN0RKBrY
	bXicobzymXS9w4rTVCQNgu9C9NRzVPgZH5+0w3dXWOc51yDBBybPKuNpSLHKG/RoKlqJEPXaJfOni
	jjtUmAafA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMyMv-005wPG-T8; Thu, 18 Mar 2021 19:31:42 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMyMs-005wOr-7W
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 19:31:40 +0000
Received: by mail-pl1-f169.google.com with SMTP id w11so1810392ply.6
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 12:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CdcPLVHCd5iaN1rxBXL3t4fl395541tzLU56fs9+qG0=;
 b=UJfmeEd/yO10ySb8/24DgmbvZYLQ1d+RFAD1IMAuPD2QJ9OU/c9QJ8GDlsiNk+9xuU
 DNULXHk0w8HCYmqPQBBZGVUS69sdlG/ydPq/CazvTh+TD82RGjyTr6vHOnytM7DUnFRK
 nPhs+lbxXEUMZmIwXmhPPmePnDslxWszcgEefpby5+MIuX+MhwY3DeaFsqRCIQLhBNGP
 Cow1o4CQZmzxhbvodsg9/NJkzzScCcy4ImYYeiVn3PAyM/aHwsKmtvJFY80P52KHF6rP
 3GD3J0kx/pWmGKPMRf0FmZquTWb2PCQHdK+HClifzsTEF3IkWABBxjCRGtaw+8imGI1Z
 gbAQ==
X-Gm-Message-State: AOAM532Dn+YW/NAKLqIdC7qSkuyzNWyQIznjM/dDcpv2fV+2rJ1BSc3+
 OGet9zS9OOQNKUJRddFh84g=
X-Google-Smtp-Source: ABdhPJzedtSCVrhlGlE84ozE8t7dKq58A9TxeUs1JS7TrJk6lhJ+mgCmxSUIsyINyneQY0GVLHt4AQ==
X-Received: by 2002:a17:902:d694:b029:e6:bc94:4931 with SMTP id
 v20-20020a170902d694b02900e6bc944931mr11291064ply.6.1616095896803; 
 Thu, 18 Mar 2021 12:31:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ce5f:588:9ba1:3bac?
 ([2601:647:4802:9070:ce5f:588:9ba1:3bac])
 by smtp.gmail.com with ESMTPSA id 202sm3115526pfu.46.2021.03.18.12.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 12:31:36 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
Date: Thu, 18 Mar 2021 12:31:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_193138_564860_04862CE2 
X-CRM114-Status: GOOD (  19.55  )
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


>> Placing the request on the requeue_list is fine, but the question is
>> when to kick the requeue_work, nothing guarantees that an alternate path
>> exist or will in a sane period. So constantly requeue+kick sounds like
>> a really bad practice to me.
> 
> nvme_mpath_set_live(), where you reported the deadlock, kicks the
> requeue_list. The difference that NOWAIT provides is that
> nvme_mpath_set_live's schronize_srcu() is no longer blocked forever
> because the .submit_bio() isn't waiting for entery on a frozen queue, so
> now it's free to schedule the dispatch.
> 
> There's probably an optimization to kick it sooner if there's a viable
> alternate path, but that could be a follow on.

That would be mandatory I think, otherwise this would introduce
a regression...

> If there's no immediate viable path, then the requests would remain on
> the requeue list. That currently happens as long as there's a potential
> controller in a reset or connecting state.

Well, also worth to keep in mind that now we'll need to clone the bio
because we need to override bi_end_io which adds us some overhead
in the data path. Unless we make submit_bio return a status which
is a much bigger scope of a change I would expect...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
