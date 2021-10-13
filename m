Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837CBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:50:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4DD610C9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E4DD610C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=UKnRWJBXqMuPJzOOsCxKJWtt6z
	e7PLQ3X3q/5A8wiAsinfj7K/N8wIY6AeXo3x8ZnnUFF/gDWSa1W+WXWNzLt9Q+zsG5wvBe1OWYcEN
	MEjOEh5Wecx+ZeuAsqXaH/03O20IP93hbQl2dCwbFjb4F4MmkC071cRtuncNjUyL2e3kjNDAGOQ4A
	Sfj5R14U5fKxIUFb3TqE+ktq0OHPwoCA3223zvkTBvlL6tMOxeBfXe8nJj4jHNAkMgynjqM4HDWHy
	O8ZDwOhAcmXKOUOqPxaX2FlTLirlTkJC4NKIaihWciUd5BpRmtRlA9nIXF6CsJA2AUuJs5FcxcLft
	n1qC9bDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1macm9-00GP6j-6k; Wed, 13 Oct 2021 11:50:25 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mablO-00G57p-GH
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 10:45:35 +0000
Received: by mail-wr1-f41.google.com with SMTP id k7so6698614wrd.13
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 03:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=0Ho4OvXQ4DDt/ow1twJNe2hCxMY8sDZewKV6Dcn7rUskAfvWl8KqmzQ89V2zjL4H3O
 r68XU891a7O8HufUnjW/nWqqJkWExoAgiMfXce6IkDuHxoe5EF5RYi7beEOxscrd2pdl
 JjV9D9Rhl7hbvUFEFhyHvnSpdzj0VowvBn63Dx3rBRmE9GlOjMdbLgO3VX5VcrfaXahR
 O8G/HghrclkoY/HXVmfxf9iT5fk0Dxs7A1n/GjWbgCIE4O4VgMGUQG640xaBsR5F9toA
 5g2f1NP2rNS9ksa/Av8Tw93hrieMKPQW3K1AHAUmvph8LDWknmG7Mup0DCSETtuvQwsv
 tp3g==
X-Gm-Message-State: AOAM531MXCoMAr7CtygJDKt1ENLHZB27YSx9USOLMCUP5sX4N6JY8BsS
 mBx18wuP/Gq4Kwj1ZgNN/0E=
X-Google-Smtp-Source: ABdhPJwRCPHmlALD4GINu7BfgKMAQX6ORa6ZZNYylVOKoHNRpwvmd/40Xn/R1wZ4sitG8tcwQeg8NQ==
X-Received: by 2002:a1c:21d5:: with SMTP id h204mr11799356wmh.9.1634121932624; 
 Wed, 13 Oct 2021 03:45:32 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id f6sm4660791wmj.28.2021.10.13.03.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 03:45:32 -0700 (PDT)
Subject: Re: [PATCH 11/16] block: rename REQ_HIPRI to REQ_POLLED
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-12-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <04d343e4-4c9a-7ff2-bf55-7c42fb02cc4f@grimberg.me>
Date: Wed, 13 Oct 2021 13:45:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-12-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_034534_569127_C679C58E 
X-CRM114-Status: UNSURE (   8.88  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
