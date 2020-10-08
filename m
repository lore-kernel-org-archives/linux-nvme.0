Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237DC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 21:56:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454CE22241
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 21:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gvnM1tEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454CE22241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=gvnM1tEmTwFmmb7aY4i/JTWy3
	vLjAevNBpPxRklGH2KUC4QgthLA7NLBJJ/qZ3YVPKojaNGX9JTkeZCDzTJUKUphBAxnxrL/gzUJnO
	7AGVYEa4RatcUYKN02G/74JEiaUT2vGARqq+bIgoxjOpTmsgBO0E/2gM8F2Zb9bSYlUQFIoxqZFwK
	hjTKH5E9ZNRIO/n8Ep9qMgUoNjewV3dR/KJRv72N+NHHknRIM1pAsPYX/c+hvPqoP21nEwe0XDkto
	hp5cVV3Kg8ZU5Upf7gk64an5P5e/Vx47DbU+KjToehVJb28IL5cRwSnCCRFWvx+5LHXBU0JbAZ8ZV
	xSDXP5Jiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQdtz-0000zB-Rf; Thu, 08 Oct 2020 21:56:43 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQdtx-0000yQ-Gf
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 21:56:42 +0000
Received: by mail-wr1-f66.google.com with SMTP id h7so8208919wre.4
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 14:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=PnjsbytqquuNaaUqwtHBw7KcWEouoQo2MDxif1Cm3nytRkAp/oZoo+HWgg+cUat/Ky
 HYPExbMSftFEuoX6LRElbbSCmmx+vr0yVkZHQWJDeDuq2TUzuHtstOGVeFJMrOAqsGrV
 l5Kql7Tx78G+XMM+cIKYENzBzqvIVUQjD/ojMrZt2CRfAGOjMxp7wlS9WZ6KnJsw5Sli
 Hnlzqe+ZqsJ+aXKX5qLr1EYQtA5GhOU4GSHZDuYAOyyl4XKQUrvBzS2aGzeDlKQbLG0V
 H8YIKPK8NPaqI/VxEZDc+UbTkBCMxfrC48S8I+rLHCflvoJrqpw51qJIeCKGO80wcCY+
 SVvg==
X-Gm-Message-State: AOAM533nweAgHlCz3L/vqKVIjaHPw8ClgsVmiLjWGC7EK96qgL9kk3k1
 IGr65WEUUJQcoEemKgd9hl0=
X-Google-Smtp-Source: ABdhPJxV23Xx1Sw0KsKJOJQcfKGm5MeAAZ3Hw9JrRC+P7TtyrfjTw36NwoAFLqaVC2u426ijeIiB5w==
X-Received: by 2002:adf:fd47:: with SMTP id h7mr5539700wrs.245.1602194200500; 
 Thu, 08 Oct 2020 14:56:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id q10sm9166602wrp.83.2020.10.08.14.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 14:56:40 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 04/10] net/tls: expose get_netdev_for_sock
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-5-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c7f5fa38-7629-1bd6-63eb-c463daae0ef9@grimberg.me>
Date: Thu, 8 Oct 2020 14:56:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-5-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_175641_690601_9EADD476 
X-CRM114-Status: GOOD (  10.00  )
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
Cc: boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
