Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B94C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 19:42:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0157F20738
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 19:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0rQsuy8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0157F20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=0rQsuy8P18rPF8OzdxFlP7zq/
	vjn4myscyfTpODPQQIXyIfSX2naSqaeRmX6DobcmsFmKquTTKH2KXvVuF91Fomlr+3Zo6ULSgS/gl
	K59RbUutAh29uRwgjkWORdoCoEDQx/6bgRcTg2OXZ4p2/jj/ZMSokvjg2J2a7375LxX6RwMYl5AVc
	asOuHs8Bm1XArOQivSh2BEOnxOOI+znEON8VQJa8Q12htlZr4ZOniFM563xmsy6M1OUFZuSEIl1wM
	W5ascIDStDen2Mmm/Xq+MWakHNnS0Ddpidv8a00jB5JekRqksgS60UoKMBLp+2CnIo5umhENVYmO/
	c88TcrC5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k091B-0007cb-5a; Mon, 27 Jul 2020 19:42:37 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0919-0007cA-0q
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 19:42:35 +0000
Received: by mail-pj1-f67.google.com with SMTP id k71so10240481pje.0
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 12:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=jK7a8eQnt1PLfdUOhL6VKLoFgumfSdCXAvyC2An5kbr4R6sUlJ0BXnEf/nurmBJ6zZ
 RpbP96DSmHvlCtqZCNncQl5CxLD96Mebm8NG66u0fajjDUvPj96PhHPkdCqHQhf34mZP
 t4Vxahn26AbGbm7EhXGtcl1SnMHYLpfnT9YAVZa/SwLjzBp7lKvzbzQ21DCP1kh9j29g
 3f/p+6Wgc4zKFSHli7fpuXIrcW+K0vzRf2C5kPC2NLJCN7Q5Li0ZyC8KZAsy1UqpIG0S
 FFHwpQM+U24AaG0UdIut6A/UxRFnfUkkxV1iIwa6dlziz23TQnrl/0RZMu4zzpW3v5pw
 RGtg==
X-Gm-Message-State: AOAM532vQYwLp411dMXS8kdgwLtu3FJPlEMhl+VCXVt0IytY1X3X7hpW
 2LXa8F+U6eh+qNvViykMNY3sA6IT
X-Google-Smtp-Source: ABdhPJwtyYGToPeLH87NwrXvdn4M3EQJb6MeP4weCK1vBCpztBlt1ZF2ZqCkuRqv0RzjFysj1s5a6A==
X-Received: by 2002:a17:90a:6b02:: with SMTP id
 v2mr749896pjj.163.1595878952249; 
 Mon, 27 Jul 2020 12:42:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id w142sm5937941pfc.175.2020.07.27.12.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 12:42:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-multipath: fix logic for non-optimized paths
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200727160803.55683-1-hare@suse.de>
 <20200727160803.55683-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <08f35928-a5c0-0dc6-62b7-c3ea6bfc2892@grimberg.me>
Date: Mon, 27 Jul 2020 12:42:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727160803.55683-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_154235_092004_0668F32B 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
