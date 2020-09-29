Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106D2C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:55:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F8F20789
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d1W4S8ER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F8F20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rE14AudSA9qvo76f3Sg+pos0aKz0einUtC8YTzZlFLk=; b=d1W4S8ERB62RSqg1EycV3KWtK
	EYMJJSbhiDzyM1AJ6IpcPpAWZwITi1RBZ9toJmVdXA5i83HGHHKBRtYwuY7N173Xs8BidF9lacuRr
	7b9UbGwww/AZyXO9hjuOnZhhlyXvHe8PqMphCxFghBUk4ma+Dc8l8Di9sDuTxi7DnpS6l8pbta5sK
	nqbEVaBmFCO0E5sJTpGUsg0NYWrGYoNZVlXrTJ/cw5hQdn8GTXp4MGZmDdlZYvCORNokXyjrbEv2Y
	622aH/82gabD/5jUyx1iqtSnGk2zjgQMZGaEAy/t3sCsPfDhAJyHVLlQ8SgrJyUJf7JMKLIjrV0bQ
	5rEL1KqMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBPU-00039A-MQ; Tue, 29 Sep 2020 08:54:56 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBPS-00038a-GY
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:54:55 +0000
Received: by mail-pf1-f176.google.com with SMTP id d6so3841803pfn.9
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RDe94Tz2S3weSUg0hG17EYpeKEsqD5gZewCPrslriB0=;
 b=UesDeIlkwn9ozlztEX13zfwq/g33RROm7wdvqTWTXimyoQs9JLuYxKEjYKbqaUyJtd
 rk+Wb9exQ2wTBjAry6MbTN1ZZZjbqZo7+gtFs38n1d1bg54Y78MJMjelppY8KFAIGWiI
 EhDL7gRT1bExYhDdF01TY9cSyU2qt3kBJusf76yDbGlpbXo9P2Hb9E/QxBCt6PvGRaMy
 dheJoWCA+u9qHBAQLchDYBOLHMRzaiiwDKWBRFMej9MHkp9LA2bmd7ChPtPIWwCpgPnH
 1Z+PbYpSvrUhcUe1JY7pEr1C6q0k53xGABMgHn+eKhwkOzzbS2TG/uDni10jN1+tiJGE
 bN0g==
X-Gm-Message-State: AOAM531SxpJ6dIqhQ69x9SwSKBB9qLC2c3eTXKOkzWMFKK/14Jv0Y4cg
 jNJit6jDTP7qCBi7R3hAUSZJL0S8HIA=
X-Google-Smtp-Source: ABdhPJyBWgDEUwv53hAJpXS5Hq/L6u7DOMOtioI6qAPLXv9skgWPVKMjZcsC72Eyl8QwYykH9+oq0A==
X-Received: by 2002:a17:902:ee0c:b029:d1:8c50:aa63 with SMTP id
 z12-20020a170902ee0cb02900d18c50aa63mr3532456plb.21.1601369693466; 
 Tue, 29 Sep 2020 01:54:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id 22sm4517675pfw.17.2020.09.29.01.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:54:52 -0700 (PDT)
Subject: Re: [PATCH 13/20] nvme: set the queue limits in nvme_update_ns_info
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-14-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5bf40629-1655-41bd-1106-2f26b7f717f4@grimberg.me>
Date: Tue, 29 Sep 2020 01:54:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-14-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_045454_568556_42DB708F 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
