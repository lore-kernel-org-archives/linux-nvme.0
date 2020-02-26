Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B6C4BA24
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:35:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F271D20658
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aRJvgAPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F271D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z1fMvao11i+d0UZrbIxXcd2/3fEWA/mH8uzwOCutGXo=; b=aRJvgAPWIYIhrayBg9thoBaGq
	0SZsw1cmAYPdgWbW6Wfhz9JZpLpRH43f9EJ8RY+tfz9rPGW2HCkLlSe0W5HNhqeudL6NKPfNYBGrH
	u1rdWyeJ0GEILi3svCcNK0tXhowpkdw24WmJawZFU7VEPKMcthVf2LMNgmGQmcqrBvtetwePalXt3
	IfinsS2QejtuTSl/YeBmhll2gAOMQfS9LthtFp3a0+JG7jt0FujUIAE6qwstvPjQKjHIt6Wpvwjfa
	shsFx03NvpKu+EGlbd4mO22UcpjkC2Qtz+T/1Uy77kXODouhUihZ6k5S9gUwqHnhSvWIclTBpI94Q
	O+eYref7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j76D5-0004pp-74; Wed, 26 Feb 2020 23:35:23 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j76D2-0004pV-VJ
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 23:35:22 +0000
Received: by mail-ot1-f65.google.com with SMTP id w6so1217684otk.0
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 15:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=AQyACsKe5EGSV6MLh/nojq6J+DcKmNzg1n5TU9f+e3ZDR7sxemvWdqD6GF9aFUU+ac
 hn51BXLkcaOcTnwUTAOmYKAjs8UCcHHHqiN2z4s5O+32u2Eer21io8hpRm+8AlYpNRGe
 51Cx6g4W+5MKN6PBFdXqzYjR8kbifznqUybi3ZkH1Rxg1XJAqAHnwHR9Pq/pHkjrxlVK
 w5A6VcB5HMra6x9qLMyNLzuOzeIna7Pee8jMR2Amh6SmpBqt+QjA4UwUpjYELcFRl2xI
 taqfk+IfRKlaLUB0s7CaSF56FXcdMRqvP1bTEmdpmDeUKdud1OdQOfG/e60taTZsW79Y
 UL+g==
X-Gm-Message-State: APjAAAWfJOV80FRhXIzjR45SnjQjzqCxYbiXNAJ5g0W+qHmpRzitcRl9
 5RcX1hEcUgHfFoBW0nhF7FY=
X-Google-Smtp-Source: APXvYqw8ljv9JE3y7LZUdCo5NfX8TYCwhyuntYEgnrnwOAQXz0HIV3btvzcTz/ajttN++cyoXdT6vw==
X-Received: by 2002:a9d:7410:: with SMTP id n16mr1075882otk.23.1582760119876; 
 Wed, 26 Feb 2020 15:35:19 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 15sm1331058ois.20.2020.02.26.15.35.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 15:35:19 -0800 (PST)
Subject: Re: [PATCH v11 9/9] nvmet-configfs: Introduce passthru configfs
 interface
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-10-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <81000b3d-016f-9370-081f-d9c4cc4019ef@grimberg.me>
Date: Wed, 26 Feb 2020 15:35:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-10-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_153521_008828_8FFF4798 
X-CRM114-Status: GOOD (  10.12  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
