Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3A8C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:39:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9542F20854
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 23:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HUOgMXZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9542F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=HUOgMXZ61xGMYz7fwqPVpH25f
	kqmAOzUtfI4dMYzs15QSiFjXqyjLTTPb+aUF8PyVvxZwfxUjch+o2n2zH2jF3IE3AJtFzdxx2rjun
	utj54wsQ3Mt4lrXwUHjaLBqCetySWE8koxXDHvvq4fZ2euFwcrB/zBYYXYSKZSLL8xxulV513hsEk
	WiF3rdUTS9/EKVwgWTEnHVBDaBskBrWsTV7uUjl0upBpB2sP6Sof9eJHQhzLXFq2MqMfvgu76dwCK
	pS5MD5uB9VnLCtYcflifSixHr2SBlJOx4TD2UcaaNlMhdzWaia/jTOwQm/zNzdQLNJCfGil4YYkqd
	j0g2QW2yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6NpB-00067F-La; Fri, 06 Sep 2019 23:39:29 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Np9-00066s-Ln
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 23:39:28 +0000
Received: by mail-oi1-f194.google.com with SMTP id w144so6426146oia.6
 for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2019 16:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=hF5sq8RPhF2diDllBO/UUhHow+9HtIEYNpLTivcN10GXDlxXU//OEt9DK74jPT3FhJ
 R5bZvkeQHGh8ayF78VQYOOzYWgv9q/hCJg44clXeOWsGOJAe+rCEA3YXFrCNEp+stLO7
 dITwt4g6Czblhszr7SEqF4YXSfTmFRm/UT90N1HPiUckPbf7DsQTo0uv2XP7jpr6TKVQ
 Qn6eHdbHH3Vj9CtpH1e5c/Fw1h5ypY3bc+fame6vnX4Gcl7RM/5k1jMPvkIqJ/3oEGTF
 Kb1E/M3VymL8B72VKRNKiIJa160d37p9SAGm5dOAu95C5elLNR/CBbmY9f1w4/HY7XBy
 IBrA==
X-Gm-Message-State: APjAAAWlMBvHl473OVVQWgqExcMsoQzL60cN6Gw12WJYKV6sHmkRpvwU
 1nx8vChX1JgAKfrBhBVBQxw=
X-Google-Smtp-Source: APXvYqzNcwbq2IAArQ0RYZjyEopuCwa0cV1pBH/IT6x1kbP8REq8/oh7oBCjIR1FCIqKwTDHxjAqzw==
X-Received: by 2002:aca:4715:: with SMTP id u21mr9545906oia.106.1567813166612; 
 Fri, 06 Sep 2019 16:39:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id k2sm2330413oih.38.2019.09.06.16.39.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 16:39:25 -0700 (PDT)
Subject: Re: [PATCH v8 09/13] nvmet-tcp: don't check data_len in
 nvmet_tcp_map_data()
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-10-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <85d9b571-4b02-54c0-a42a-744f87316f6d@grimberg.me>
Date: Fri, 6 Sep 2019 16:39:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-10-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_163927_718761_792578C2 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
