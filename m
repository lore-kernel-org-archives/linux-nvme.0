Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAE7ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hUilgeHP0biCxsciT92z9y8bpDsjjbeBXQD/8msdltU=; b=Iz1rs9AB8uxZzynlu+v4DN7Zm1
	NNy4v5xE2TtTZW3NMYA+GmKmgfqHt8FCqJ5jKtBXcKkPaSuX+XYJuW4hG8pjACS+nk0+ckAQ8y+gw
	LZVtSoq1pfThLAJXiUH2ehq/mgU0/hWUn5eOE96FXWX+8YhVKvtIgIk5NziwO4cQW7Jf6SmvjZT0x
	Q2at/hwWUe6AOVPsctfhpkiqAx8XTKSCOTx0fIXogfrJe6LmEhAXmo4C4aZ0yzsWohYhLuY2KUMQi
	qpwoyzczsNBSQhw5BSXq4YvNUu3H5ZMHO2/nk1y60PLarg/0ts6I77MmGUVrES6wVJx3NEMstsRpG
	WGT0FeDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVYI0-00DbHv-Ei; Tue, 06 Sep 2022 13:06:52 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVYHu-00DbCo-Qx
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 13:06:51 +0000
Received: by mail-pj1-x102a.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso6381021pjd.4
        for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hUilgeHP0biCxsciT92z9y8bpDsjjbeBXQD/8msdltU=;
        b=GNIWuM9ISomgaI/MfitDMgzaSir/kv+ZiB7ykUG2JOEKioLzlKVIKzosdx3Gr1VZNN
         FSyjgitEn0OlLuUwBj2EKYYhuA8aLqigTBk1n05agFHu9TeGsM2Oy4dxutyDDiB/Kp0q
         g/rs0M+JjhZ6KPqyCIf9xmLsAItYR8v3SejXlDNl/xUw0z3xVOH9YFEZ/PdO9X2FFFKS
         P4euUSP1/v3VHzh5WqkrA600b469pljHUiNI8QZSjczO3F1Qj8ymAh80e35446W96mOE
         urk/jacqVYb2DQ8MHSdSUIGUfDrWb1YGpO2ROSah0jbUKf4theoc5vr4uFzUe74s50Vs
         DF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hUilgeHP0biCxsciT92z9y8bpDsjjbeBXQD/8msdltU=;
        b=IgbR81lNTNilB0EsRGmXU9aRs7rxTSUk8X8A+LsU0mPd1RAXa6bXiQXg+vZjzAQKhZ
         SWUU7phmAZraaHq2xGoMd8q8N5pHfsW0tGDucWsmo1ehweVYigSFAtndIJbGkJPB2UA+
         IOVICY7bxIHnE9AAN1E7YWhln6Z4Tw4c6DQtJt15SEj9+quE7aj3eFOjCawyA2+X9c62
         R6JAcrbkjlbBr809HVTxG9Ok+UfdGWsGj9gJFDKfSn3Hf24JaamB3TExsBDpStnwWnYH
         xr/9/tWp0wjDt8Vn8UpinH99D5t4+BKjb9kXWbhZ1JgFmJ+FQIwIh2igJqdcN5vKUith
         4m0g==
X-Gm-Message-State: ACgBeo1r8Ye7gcr2wzSL/lHxYhbXfGqhaaYW2xVtEAwRpNOX7mbkInkt
	HGNPEq2J3uIJYLhxAmhYfF0Dmg==
X-Google-Smtp-Source: AA6agR65LNUY4ND6VirT9/iIW5+aJ6BogblGjGp/Ah6rCqXQ1W0A40gbtwhWH0/EwhhBy8biBCwTgA==
X-Received: by 2002:a17:90a:ac2:b0:1fd:fad1:e506 with SMTP id r2-20020a17090a0ac200b001fdfad1e506mr25026991pje.66.1662469603875;
        Tue, 06 Sep 2022 06:06:43 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b00174c1855cd9sm9819866plc.267.2022.09.06.06.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 06:06:42 -0700 (PDT)
Message-ID: <2ad36f9d-6472-f748-b013-9678ad94e8d0@kernel.dk>
Date: Tue, 6 Sep 2022 07:06:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v4 3/4] block: add helper to map bvec iterator
 for passthrough
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
References: <20220905134833.6387-1-joshi.k@samsung.com>
 <CGME20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1@epcas5p3.samsung.com>
 <20220905134833.6387-4-joshi.k@samsung.com> <20220906062522.GA1566@lst.de>
 <20220906063329.GA27127@test-zns> <20220906065122.GA2190@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220906065122.GA2190@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_060646_910672_96A77F44 
X-CRM114-Status: GOOD (  13.15  )
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

On 9/6/22 12:51 AM, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 12:03:29PM +0530, Kanchan Joshi wrote:
>>> This context looks weird?  That bio_alloc_bioset should not be there,
>>> as biosets are only used for file system I/O, which this is not.
>>
>> if you think it's a deal-breaker, maybe I can add a new bioset in nvme and
>> pass that as argument to this helper. Would you prefer that over the
>> current approach.
> 
> The whole point is that biosets exist to allow for forward progress
> guarantees required for file system I/O.  For passthrough I/O
> bio_kmalloc is perfectly fine and much simpler.  Adding yet another
> bio_set just makes things even worse.

It's a performance concern too, efficiency is much worse by using
kmalloc+kfree for passthrough. You don't get bio caching that way.

-- 
Jens Axboe



