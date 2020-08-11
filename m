Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3901AC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 22:16:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE7B206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 22:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2+wZoLQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE7B206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g21TvHgdwRk1RPe2Pp8vKLGwy+VbK5TRq6hxWQOZIIc=; b=2+wZoLQCGO0W310ruIKm5ZDq7
	ZcjETMuMpGl9Kt3W/z6nYKRpczI+iE+8x2q9mwcoyrNSlibXvYABuRRHJOeeHC4FAap8Xq9VepcVW
	kKiex1H4QObwX+wt7tlkMWXiNjY5stHbfGQZxoCk7kdnVzLgVlbUtzssp1GEdlQh5k/vnkwydWotn
	yJoRQOBrsAyayfFaewWUtrLy+nmwhnau/dByRUyKbZe5E7iSehnR9np4X08/sU0cFxl9E6uMvQaQv
	R27i/+6DKOkfMZkavL85kakKi6CuNXct8sSafUfgYDuo3C72OHy6adgTUIALmSR4MJtxEWuApHfCZ
	dXoPKXZaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5cYz-0005It-H3; Tue, 11 Aug 2020 22:16:09 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5cYv-0005IV-Bu
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 22:16:06 +0000
Received: by mail-wr1-f54.google.com with SMTP id a5so219201wrm.6
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 15:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L3mcHCtZIPXwGKj4NrU41Kx59GOT+TLPAbUV5Leqo9A=;
 b=feC9U3GSR76ZMSR9hqLt07Br8kjlQsq1/0fFNLeA+4kOpQuVdipFaTkqxdcX9CthWT
 b/ZyupN10p2aRQJwGpVU9C2ZC2yeuFRsNx0/yUzXeH4N8/xtBRUbTlG3t33RKo1GquvN
 uo7+MJ3+2Af42VSbhTGGmFtQU50+a4tXklPQkcrvsgW2ciE6Ys386/bmtuwBtKrM7Da9
 s4812F2NNmPRw8Vr17GpKFLwIp8TYwrWAidkaVHGCfI4Y+Rz1CZhptxHVblUpbrb7j5I
 tL5yuii98gnmmywvaLY+KpN+Eb9L35d2jZHW4ePUzLjm/HqwfqwRot0gXvEtaPp6DsHa
 hLRQ==
X-Gm-Message-State: AOAM532SfIDCUKu69iFIfZ17mP67o+pVlZgae3VeDmljmLVus8EWWtAp
 Dlz8ZzCjajn+rSZV7q282qg=
X-Google-Smtp-Source: ABdhPJwNoH7bn2THkIREtbTC8dXSe0bIavVHW0gaFHfm1g3OFhMz4LI/8mcMJGDBsD5uZ8CUycnDJA==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr30265855wrq.407.1597184163942; 
 Tue, 11 Aug 2020 15:16:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b58b:5460:6ed2:8ff9?
 ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id 31sm329901wrj.94.2020.08.11.15.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 15:16:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] fix possible controller reset hangs in
 nvme-tcp/nvme-rdma
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
References: <20200806191127.592062-1-sagi@grimberg.me>
Message-ID: <0eefe204-c37b-29f3-2e21-6b8167725dd8@grimberg.me>
Date: Tue, 11 Aug 2020 15:16:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806191127.592062-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_181605_451556_11ABBC31 
X-CRM114-Status: GOOD (  11.23  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
