Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CC7C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 20:28:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1868260FEB
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 20:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1868260FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8aXqz1a6mImD8Ni/P/1ca8Z40CJVbp0kEkqPa/U9f9c=; b=lSH1b93ec3xI6WnhsN/+/DQZt
	rr06MCOIiBpRC9R7F3QTxsF2NtcXWHmd7Bv2p2Beq1i8kQH/OBHguxv6MSW9cTwuHe0dsGV/84CZO
	WA4Xz3ZmtfgGpMUxtLvsXBCSzczF2Oc0VFpksasPYUTsu8ZN8QEAysnAtAOyvWZUihGaYwG22SZ/p
	3xkfuFuzauLbHu3oKwtOXKb/4bFC3GTwcfJt+KoAcT07kArxEdLXzEVPp6oHYwXMnCSdmdJnwsiB/
	izScca+64z6eifr9q8JlhMG5Tdu5lvbRV3cZR903WdOa5ySCYsv1Bs+N9ngbNT00P5/5KVCMVwMUa
	Ma4btRW5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lijqj-00G44n-Ul; Mon, 17 May 2021 20:28:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lijqf-00G43j-Sw
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 20:28:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=b0qbHJ2ODyRuALZ6HtVbAxSiO6u+bTNln/QGhcAk0EM=; b=N2YrcAJkCsWOpu7tqGRJSbSXBr
 lIDHkEMkv60UKm7NhM1cWOnztLzeHUiy214JguF+QZfndzBC2NTlx5vfYGbpAhynJVfnKFgB7XAKi
 nHgg+ON7mLXxGVWxV1RQNIxm3K93SV/Tkcg+HzjHNJrRRd+7ncVeHZhKDiNWBSOds62mkQIOVGPjI
 rDm8mFS4wlFCrMVIYZtxniO5MCJog0S5Sm8VHKp/auX82CSRyfHckCic1TEem16N99ApYVqbmgWF/
 gTIx8sjRic9KCIQOOQCLjlx8rUPg3RVTX5s28aMMhGba9PBnWp4MySWxr3JNmUOPNc9QvzFaTy8Rd
 fPKdCOXw==;
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lijqd-00E85t-GG
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 20:28:20 +0000
Received: by mail-pg1-f179.google.com with SMTP id y32so5418209pga.11
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 13:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b0qbHJ2ODyRuALZ6HtVbAxSiO6u+bTNln/QGhcAk0EM=;
 b=liIhcK77jg+ZyBEYUHwyD+Dv2zhOEEc45UNekh9UkHaYgUh3nYpuNp7e8P02x/dkKW
 p0sa7eVYIj/5A+M0yWschW5yo1VGMCeyFZWF2ue9EfbkK+eWvH6lBaiZZDL5q7XmulAt
 VMluZkcykN5l/vYza7B/2jiZJpY2Y2pcGJKaIuBeWfqYMEckfCgeeMqxjhHdWwESwQ17
 ewcPY/Pd9TBl1oMJMP8lE51UyYe5AuKV3E7rm7PsdQa/bZN6h3uIyC5KdLoqtQKq3hm6
 lUnlOj4qWbWqM+pR5pzWw5J3FNSIUtnKdEWGvlTtzhYqNmqS1MTQsowO0DQgxAz5rlvi
 JffQ==
X-Gm-Message-State: AOAM53084Qi3wRq/dpG93LGOGkluBxOD4J7RPYlprU0kSNZSMGfri6WC
 1apjepJJdJjX2pl2NBod3Us=
X-Google-Smtp-Source: ABdhPJxJe2WT7EwbkT4B9DYHpkApFxcP3UX+LTpBhIOJD2B35oSQNboPKAigwyhOvn+r2919L9zM4A==
X-Received: by 2002:a63:145e:: with SMTP id 30mr1311524pgu.174.1621283298648; 
 Mon, 17 May 2021 13:28:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8224:c0d6:d9dd:57b3?
 ([2601:647:4000:d7:8224:c0d6:d9dd:57b3])
 by smtp.gmail.com with ESMTPSA id z22sm7549687pfa.157.2021.05.17.13.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 13:28:18 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
 <0bd3f659-9691-4f25-6d3b-bdd19546186c@acm.org>
 <20210517194613.GA2709569@dhcp-10-100-145-180.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <64e3ad99-8435-22c0-bb11-cb9ad08eb52e@acm.org>
Date: Mon, 17 May 2021 13:28:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517194613.GA2709569@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_132819_573095_A4FC9263 
X-CRM114-Status: GOOD (  13.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/17/21 12:46 PM, Keith Busch wrote:
> On Mon, May 17, 2021 at 12:09:46PM -0700, Bart Van Assche wrote:
>> Additionally, I do not agree with the statement "we never create such
>> long queues anyways". I have already done this myself.
> 
> Why? That won't improve bandwidth, and will increase latency. We already
> have timeout problems with the current default 1k qdepth on some
> devices.

For testing FPGA or ASIC solutions that support offloading NVMe it is
more convenient to use a single queue pair with a high queue depth than
creating multiple queue pairs that each have a lower queue depth.

Bart.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
