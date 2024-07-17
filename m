Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DE3C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYpSw3TFSCXxm4MqPusDYYNG7e+dlVi6gjyrTEdPMHc=; b=CrVUx9AUAV17h9PRQz7mgA5Uu5
	awPOezA6n0nP4ysdpavzVeWp+FXBXVy1X49obQq7Glf/WYw2E81spCjPwr1LCLsrrC0dLn857Tyws
	SWupYu3WvmSWLzeHSEkDqewBPudqrMOfBudeWjZpvqgrlT7btUY938aEtv0qi9HkbYhEUghStV8zH
	gKaGBRjJyy6t5i4mTpmHfmH1xcC7ZJo7Ebh9ayTczjEimSpV20NRXGifimjtNJjw4KTx6foCWDz0D
	5QfQpY7S3j0HTd/t6l/4ai0CNmcYDJU4xRAYW3Aefo7FWScK3SRjs1OOqdd5fp5Ve4rNqezasVtUi
	OmzP89Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUC9D-0000000ExkG-3E4j;
	Wed, 17 Jul 2024 21:25:15 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUC7S-0000000ExaV-1OQa
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:25:13 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42671c659e4so84145e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251405; x=1721856205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYpSw3TFSCXxm4MqPusDYYNG7e+dlVi6gjyrTEdPMHc=;
        b=wnibPqtOcXvZ4eyqk3vLj6AwP95giPTaJhZT8D8CUtGS+JZcGhE+q03+qRxOG2kIxT
         SOp0kP3n3XRrihk9sXcivIu/UaVa01VM5p/CM+ElqLk0nNBMF5wxfy7zdQlpDpDnfdr1
         W4AHsVImz4MdXoMXhlgGAQcrO6Owj4bUn2S+NF8JxZfFjtJluUmk5cR2Y34YiX6DR5UX
         sqdHoT9YtfKzHrwpOzLvMX7Fm7hx0jYM5vYeIQCThkKOK+pc7IkigtGo5WjajhvhSmSq
         zw+qzgSN9+WschcisD6sJrUDP2kOA7aeMxfgqf7gk+mxzKmaNTwLe2QMHpqKLE5S1SGJ
         Jgeg==
X-Forwarded-Encrypted: i=1; AJvYcCWmQ9juaqy2e8vz9yPnuZguorPKokIL2nasd/byWisaB/wzcOgJ9RTmWL7ObWi6zLJjuH+z0KrsrcyOfj2ju+8qDgyj3Avo2ZbRNu8vwWs=
X-Gm-Message-State: AOJu0Yw8vogs9tvabOuMG7YPs0+vN2ZiXBwoRKWwT2SZznn5nENx1QsS
	yt2Rg5tvS3UzgbjTRlGegY2HfYLTNv1ZTKHI+0L1LU6vQF8ZHquy
X-Google-Smtp-Source: AGHT+IEbB6m+3EpA8WmbWYcvi/rxkCCyjMFPmnOGkHuUE0rnhLnkFaW9wdAkOQj/M/IV4f/gc3cPGQ==
X-Received: by 2002:a05:600c:3111:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-427c2cb175fmr12835705e9.2.1721251404701;
        Wed, 17 Jul 2024 14:23:24 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77ea2e1sm11062465e9.26.2024.07.17.14.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:23:24 -0700 (PDT)
Message-ID: <48d353df-bc93-443b-aba6-5504be451bc2@grimberg.me>
Date: Thu, 18 Jul 2024 00:23:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] nvme-tcp: re-init request list entries
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240716073616.84417-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_142326_404329_762A0652 
X-CRM114-Status: UNSURE (   8.24  )
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



On 16/07/2024 10:36, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> When removing entries from a list we should re-init the list entries
> to allow for checking if the entries are still on the list.

Where is the check? it should be squashed to this patch.

