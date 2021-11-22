Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91ECC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=4jRb+/AaAyTl4r7iyrnE5tIPb9
	D1WlFnP+wZK5DI4NcOsJOylkrxRU4UQpO4fiVyocqJ4cjV4D3FNMR8wn05lhN6L5HBiL8NEZhBU/O
	xIWvrE5+U8w1jiYGbXIfxVlwIa9c0EZC0c2U9OdaCE9J7nH60Q7Y1D6O0akA4EQ189LWX/vLmMENC
	M54nbxITY0iDccXXJdZa8n3DVoxhXa+ZuwqW9tSinJ83JF5cTsHyYd5FwlRsVcAy7Dc5hYYvtsZlJ
	aP4fZlWZSmTGmlRuDzNm735CxSttMWyQw7gErGnCDvpREByheykZb9/2H7AsI+8nr1+TU7RA9MOKr
	VhLLzsKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp8H8-00GJ6D-VM; Mon, 22 Nov 2021 12:18:23 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp82Y-00GECY-64
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 12:03:19 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 77-20020a1c0450000000b0033123de3425so16553851wme.0
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 04:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=uFQsBKjLLNXYU/cmlgOeiV1e7maslOV795cLw/MmQSD6OdE8yk1ni6Ib2tj6Ez3Bf/
 bE4JkJfqJCWBYWzlwCQfrGH9ngD0ZGjxkgnsagUtjg5USEpJifZd9DWKaVJTgx13jmrr
 KNDIVxG9ZM7xmplYXLHrxaH3wfY9WgE127hXt+kpI9OvZT9FFzEYfK70g4XxoK9WiIUB
 +j3+yNx/UOKDeyMJoGK+6KmJFuIzUhLWvUPrA6mUYcu4KIWcjzEZqwDF40pnc+O6Hx1Z
 qwLBzBABxLSxyHkay819QlOBRP4WbcFSnrYnCClG/pDerKIQ7MJxPlmgZAWy4Sef4dN6
 dpMg==
X-Gm-Message-State: AOAM532qsJqEduCQT+F3TSdw646HR7oSEPgLZRAqkG6NcgndrWQVExBb
 NspdokGGMOHaYNaJZq1nqDQ=
X-Google-Smtp-Source: ABdhPJyupoS1CSiNI91xI7f0MPG7MWRhNtDsiQ+SQY6mxluY+ZtdMXsQ0JryEkb1nVuj3h3rYpF7hQ==
X-Received: by 2002:a05:600c:21c3:: with SMTP id
 x3mr28175396wmj.13.1637582596198; 
 Mon, 22 Nov 2021 04:03:16 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id y6sm9123974wrh.18.2021.11.22.04.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 04:03:15 -0800 (PST)
Subject: Re: [PATCH 12/12] nvmet-auth: expire authentication sessions
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <20211122074727.25988-13-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c7a597fa-67c2-ba9f-8a2e-12120ed80f1a@grimberg.me>
Date: Mon, 22 Nov 2021 14:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122074727.25988-13-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_040318_271380_14843B7D 
X-CRM114-Status: UNSURE (   9.28  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

