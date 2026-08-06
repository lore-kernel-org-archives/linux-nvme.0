Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72952C55ABF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DfDlnjwEjqQiBft6//i9aWDA7+Wxp9IrqsB/3Fhaw40=; b=iy56U//43EUpcAh5sylwnIoNo3
	JqH0ah4dfDKXyjR5BaqP/gtO/1WNCe6kZJXgmJ7Gn0OFJI6Q1x1mwYoFKjZzO5dj9nXH2GnGa5G5q
	fM6YBvtASdTkT5eTKLWBb6rk6wmXOlTXH/kzTOMifLfEdnni9n/7UJo1My4gcPZcUCNM12C+22HRM
	tQ2HUF1G/lCv8YrbzKR9LoqSywHTyew0ZyoZUWqb4fBCAcLkDaUZ7OsSvXu0kTj0yYPXW66PVd1Ul
	MZ9C3KS7LHPep5TlvOXOG6tQJ3v9/4WCv0E2DkgslXEzP/9PIxHN2ucaeHxtKXCa5Mo8tnBcSKQf2
	pZJ72LOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wry73-00000005tbO-0PvW;
	Thu, 06 Aug 2026 13:26:21 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrx6Q-00000005l56-1efu
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 12:21:39 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1084708f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2026 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786018896; x=1786623696; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfDlnjwEjqQiBft6//i9aWDA7+Wxp9IrqsB/3Fhaw40=;
        b=nDfJqs0eelk3yfdQ1lG98bZUZ1mHw9CiXNQ2b1hCZi2H8ZAOk0N2pOj/GB5Ha+1gBS
         B8UDc9vBryfLBYhya2CBLucCRsP/acKutN6sUKlCcO+WjvJZ21lqNs8fqxq2GKF778eM
         AtGez+rpO11F4WumhXV5E/hr+z53a9rVxHgcvkKWg55ibiQVZfps3shnD8/F/bigQKS0
         rfy9USK84yw2D1WBecOq7HZnuN3JiCTrjgkWJigST1uU52HvKZLcHOQeSZC7us30/6Ff
         VCr5tqHxBvfDnyb7F+k+x2jHDUaz5367uhWeFfyILEjH/FFsLhZVuISmvVQI6Mvr9Tkc
         Rubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018896; x=1786623696;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DfDlnjwEjqQiBft6//i9aWDA7+Wxp9IrqsB/3Fhaw40=;
        b=XdEmMAjB6UvpzXOjQzAhHNCMBx5Uul09dlVOJc5hagSNSfVJdDQqNKp5ityUkoCtU0
         d7SvW660NbANRTnDt7Zjlhx9YxDe4erbFvxbvbRn2NqZ4SscrQ1/eI2qCAOGOLfjETqg
         d99NvMBk8MyNRz0L5kkmLVvPvnk6eNobaQrBa9WXrNbabfAHu3i6SH7NX8KsfpfIkJfs
         S/pZlcgQFFPECvXoQz1R4kwRsk1JS+Sa784otwxxWDuUEi7u8fCo6OrQfeaCUfPOwWP4
         Hm0OaDXMi/MxpCAWZQQXXBgMIKCWQyrhHD4sPms32uKODemmniwOCzh7EH38cmaaVEK0
         /I7w==
X-Forwarded-Encrypted: i=1; AHgh+RpoE8DcLnSzLbnAF5tDEFteDvA10vO6cCuFRLfYZidu5cpgopjvX9mUSTfw6PKgTLTY1AtRgoTQhgJy@lists.infradead.org
X-Gm-Message-State: AOJu0YwEAlXtJ1HXj3gjGBhUb3ItSNEwl4Pj72ceruLb03Lpj3AYjF5S
	x2geQnpGhH5k2w32JrZurYixnO0myWYwZwuahCdzBDWs8G1msfpZekJL
X-Gm-Gg: AR+sD11OTsfWsaxUwu+h24JHUDH0eBlOr6eAko8to0H6tenU8a9mtgrKg4e0B0gDrTs
	4/NM0UzVII4vJXy55D0r3jBKhsz0cQdfhF6xL1+JXW5cpBOwVB1bumt16jphwfsU9IGnrzpQinT
	V67J3F59nHW6wmbDfW861Y11k5bhZ0WRGuyqmNoh9FS87ViVkVh/K9MqOueukT/PhUm45isrt10
	aqJbL021nZx7OoPGmjLBMwW1ObTicjUwo2OzclF2AzpZ6hXxFGA7uAKYWNZIvZ81Vu5sJsH2XVo
	YeolazrLm01MRTVlxljmxFISrfcGEZRqYXD4N562DXvbvuOtklEUbuqIvKsojk9LarFi4nU/zLR
	LnTLxlpc1SDNeOiXPxGOSD/ZMtFPuKSWFwB3Q53k7iwPneVxJAUPDRm/bqyx5UGjboqwqGkkYrD
	/k2Did6V37dS2YXJD5AQaBpdIRRZON/Fx1DCqy2aoJJCH2TnQPOhWNlbwIN48bY9U3DZoNFCXEp
	witq12Op3zCE47ZFbgCahx1XPZsopMUnvgHLDmXh15n60FWM3enJ9qU2OkRU1Qm55Y/9Dwfd1ez
	vK2Ai69j6wpPBkPeZB5JuCOUpYnUTPkp+aDwYQ==
X-Received: by 2002:a05:6000:290d:b0:47f:f42e:9715 with SMTP id ffacd0b85a97d-47ff42e974fmr10864047f8f.12.1786018896398;
        Thu, 06 Aug 2026 05:21:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b32492sm5927425f8f.35.2026.08.06.05.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 05:21:35 -0700 (PDT)
Message-ID: <f47ed617-5ee7-4259-9f5f-a6fd0f5aab24@gmail.com>
Date: Thu, 6 Aug 2026 13:21:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: rename bi_bvec_done
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Hannes Reinecke <hare@kernel.org>,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <4e4c21858705a200bd8848ffe4080522e3eb5c1c.1786018753.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_052138_449767_A60C4876 
X-CRM114-Status: GOOD (  12.47  )
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:26:18 -0700
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

On 8/6/26 13:19, Pavel Begunkov wrote:
> struct bvec_iter::bi_bvec_done is used an offset in the current bvec,
> let's rename it accordingly for better clarity. I also plan to use it
> for non-bvec based iteration in the future like dma-buf, so drop the
> "bvec" part.

I have this patch for the dma-buf patch set, but it's a very noisy
one, and I've got an impression that it'd be a good thing to do
regardless. Hence sending separately hoping it'd get into 7.3

-- 
Pavel Begunkov


