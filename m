Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A2EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJf+zqoVPm9HbCA5FeT4yjE/v4jzRZhL63iSHZ6XqAw=; b=PrTWBmLiJi9p/AGn9P2LOLwzUt
	6gQxsREaHka3xD1W3sVkLJ7c8fABdQNNGWLEprWuz9iYuXSL5niBpfUOhkzi3YT89g2B952F6RIto
	ZP50Onct4UMaCH+dFUNyqI/DmJgyc0vsaWsoLzP1nh+Hcg5mOuQhD3fnQKydvOgfLMlJ75x8OovIj
	3DWqE9Vi3fZDxMKetIUS9Dky/pp7GFdp5fxJjWZRGoJqsvQ91OwpTQe6uwPt/RekXs8DlRwyDaI3d
	pVoXGvbEaJkyagKjXyKugOq9044/7kSWNwKJq51IOm4qAaYP0Xb6fP4wny2KLZKogtGzIk0F39ewC
	mGREO3YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwfa0-00258R-Ho; Thu, 02 Jun 2022 07:49:16 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwfZy-00256Q-7V
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 07:49:15 +0000
Received: by mail-wr1-x42b.google.com with SMTP id e2so5367457wrc.1
        for <linux-nvme@lists.infradead.org>; Thu, 02 Jun 2022 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oJf+zqoVPm9HbCA5FeT4yjE/v4jzRZhL63iSHZ6XqAw=;
        b=nyMsuMnEP12ieVqTx8r0EwS5gypEy5jHizmBT0oUWmYxlMN+Uatwq8KWpsQ8ckde4W
         j0P2asodKFOmqyh8tADanYLrwwDE0QL43MyCZCNkhQZpd/lPNg/yCx5d5aS9Rpodz+SC
         GTZZFYKt0Z/wBYLN/ifp6p2LrD48oRYPrh5Eh1E+G/KlGVkpLLw8mkR9Jlkzn0IlDoN4
         7drz7iiVhwLddXwwCWSedNfpBtA+3opUwODBSo+kMcjiCCgtA7KbaaRUshghVMUC4iKW
         NyPlObj4hGYdNK9F+4IoJ8E99PAXmNq0scRusfrRoplu89bFVY29KuXkSl5ppbR3yQxm
         tBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oJf+zqoVPm9HbCA5FeT4yjE/v4jzRZhL63iSHZ6XqAw=;
        b=SGpRuCOTA81cB3gNmDJQhsTBINZyQJKEdGhrKeskNLwUYpM2OI2VOBi6vwu53YKeDo
         Dba0SGDmsvL2ZyLneOpuf93ODPhx18xOLiRErcFMcqxEevOzx+Y31d87f/CoFnIj0ntd
         hazFmLwBRPbYYgMLqsnA7Lvmt9adN4b+VtZZOJzlcRkjwTP6W2BcQdOvDubi2azDzQIf
         6Y1KDZgUQfkFXrXvGlFO5Lf0NrXVzq0IgVtxbzUVw+nqSZT7GjSHbQFbT+5DcgDF8MkX
         cFXxJJwpbAhx7MlirkW3bPYZxjL2MIyApyqquJf9x2Sd4ujPkDVY1jc1nQquyFm5dR76
         8IzQ==
X-Gm-Message-State: AOAM530J4tW5IBj3x7en9JUjDU226xTieJCHMprb+ZC5ksjB3WF+MP+w
	5z32AYjpBw/JzU9w9g2gN1cbPg==
X-Google-Smtp-Source: ABdhPJxREbHpGZIVLRhL5vYhnl4+E+L67zd2HvjFj/K/eyddhiy3qAFeyU+kKR0OLkpRbJhRlaaqdQ==
X-Received: by 2002:a05:6000:1a87:b0:20f:ecc0:3686 with SMTP id f7-20020a0560001a8700b0020fecc03686mr2491156wry.708.1654156150160;
        Thu, 02 Jun 2022 00:49:10 -0700 (PDT)
Received: from [10.40.36.78] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d61d0000000b0020d110bc39esm3523356wrv.64.2022.06.02.00.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 00:49:09 -0700 (PDT)
Message-ID: <2ae24afc-6474-60f3-ece0-fb5a1d19f8c5@kernel.dk>
Date: Thu, 2 Jun 2022 01:49:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YphKZBtmtKFRNIPL@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YphKZBtmtKFRNIPL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_004914_331008_6D7BECE9 
X-CRM114-Status: GOOD (  10.23  )
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

On 6/1/22 11:28 PM, Christoph Hellwig wrote:
> The following changes since commit a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559:
> 
>   bcache: avoid unnecessary soft lockup in kworker update_writeback_rate() (2022-05-28 06:48:26 -0600)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-5.19-2022-06-02

Eh, I can't pull from that... I used the usual git url with this tag.

-- 
Jens Axboe


