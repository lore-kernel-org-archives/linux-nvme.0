Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AF2C25B0C
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gk5a3EW3Ph2WpipU/WTzFfbiIRaAAQHx8pFA4GCIzmM=; b=vHAKUP8yk5qUt3J+SiOgwDkJ7D
	qc8itv69Qhjut/V3e23Hl9PGngPVerhMp+x+caJalK8Lq7jMOVRkWM8zr4slsDLyKtb8TOi8QFBjS
	6rmYCApV5PbYaJjWzIGvAJWmqiWw8ht9uXd99d7ZjGAMjZeiF9iT49PFhg8jQp7tkeHyedZ9dilNP
	eRfACA+3Am31KvqHiJ6/o9vPEOdUmtWFYCaG9CJyE6eoOCgtzoLY3XdS+LAU4LHlJudj5zzm2huBq
	vt/zG1SFm/SgPYiD5O+c1N6VAwiBqsGCHEJRCeY84mjcwMxe0wpvlvivGl/6HE0ulWegSxYmgN0OU
	26Dvg+Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK1rB-00HNFA-1x; Fri, 05 Aug 2022 18:15:33 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK1r8-00HNCU-0A
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 18:15:31 +0000
Received: by mail-il1-x131.google.com with SMTP id z8so432160ile.0
        for <linux-nvme@lists.infradead.org>; Fri, 05 Aug 2022 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gk5a3EW3Ph2WpipU/WTzFfbiIRaAAQHx8pFA4GCIzmM=;
        b=Ovo1jaM1jNoHeGymgKW/S1O7IKGi8JTPl5wusmqk8/QBRF0qiX8qIYEaMlg49Sl6Rr
         igkabJRDKfi9kiE1gR5fJY2rQ0hT1TPbzwYZUm7Ag8OAgk+fqNh3ToNqm0xLd3yPE7Qk
         Oi+E3a6qVxwXfb6sn9O7EyH2AQ7JrOylgEAAMFuLNjQ37Q5neXLDZ+diBpC5OcIt3D7t
         rZo5T+VO8cs60ogBloKJ5BTksHzrA3sDlUxyhu4v0zQQvfkhHePD3Fp+ZfsosnGSSHsQ
         gTqaJ6IHuP0xsYQqHxILei7R/i3Wkw0FDR2KqwAcL1fFkTonHyy9zueR8jDiRC6vwmiZ
         hKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gk5a3EW3Ph2WpipU/WTzFfbiIRaAAQHx8pFA4GCIzmM=;
        b=V/M97HG3xGLQQlYr+i7F4Cy6LSHwkMK6XN6o98Vl52i+uNFSO+hy9p2BRzjV8hTKjO
         bZ9AeR7j7Sni9tiu2P1XpozOl83pS6p+c09/HmmnYO4wff9oxaByfEhatWk2HyZ61ByX
         kq4MdqQFutpqJvzQlNl8dwFEaSL2vhoHmxResx6uj7g8x7joofp7tUVjk4wayILeTKPw
         YPYZQh05069Pt4sjbbq0x1Rp3uS3kYBG4gSk/+e42o/uOrggrHLlVKifhRvPo0vOyEOu
         i5a/LmDBBTBlFcsBNiBYNTdXmazjT0lZXUfpbiE6293U3QymISaX2Tm1EdzbYSUwR+I1
         Pv8A==
X-Gm-Message-State: ACgBeo3i2OSoeBJZgtYqv2ZlwEuc+ZHyvcyl1tl8825iuwwUe58x/lMd
	WDVbvFQFiNq1ImSa4rjE/TxRJg==
X-Google-Smtp-Source: AA6agR4dF96Re7MRCaE8lp8UNdD9uMORcpeztS2fubhGx5Y8gqqOZCibghCeLMzaWGWAub0D17UjOg==
X-Received: by 2002:a05:6e02:152b:b0:2de:e632:ca6b with SMTP id i11-20020a056e02152b00b002dee632ca6bmr3703645ilu.296.1659723326973;
        Fri, 05 Aug 2022 11:15:26 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r16-20020a056e02109000b002dcf927087asm1896938ilj.65.2022.08.05.11.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:15:26 -0700 (PDT)
Message-ID: <6bd091d6-e0e6-3095-fc6b-d32ec89db054@kernel.dk>
Date: Fri, 5 Aug 2022 12:15:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] iopoll support for io_uring/nvme passthrough
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, ming.lei@redhat.com, joshiiitr@gmail.com,
 gost.dev@samsung.com
References: <CGME20220805155300epcas5p1b98722e20990d0095238964e2be9db34@epcas5p1.samsung.com>
 <20220805154226.155008-1-joshi.k@samsung.com>
 <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
 <a2a5184d-f3ab-0941-6cc4-87cf231d5333@kernel.dk>
 <Yu1dTRhrcOSXmYoN@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yu1dTRhrcOSXmYoN@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_111530_298683_BF410420 
X-CRM114-Status: GOOD (  19.11  )
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

On 8/5/22 12:11 PM, Keith Busch wrote:
> On Fri, Aug 05, 2022 at 11:18:38AM -0600, Jens Axboe wrote:
>> On 8/5/22 11:04 AM, Jens Axboe wrote:
>>> On 8/5/22 9:42 AM, Kanchan Joshi wrote:
>>>> Hi,
>>>>
>>>> Series enables async polling on io_uring command, and nvme passthrough
>>>> (for io-commands) is wired up to leverage that.
>>>>
>>>> 512b randread performance (KIOP) below:
>>>>
>>>> QD_batch    block    passthru    passthru-poll   block-poll
>>>> 1_1          80        81          158            157
>>>> 8_2         406       470          680            700
>>>> 16_4        620       656          931            920
>>>> 128_32      879       1056        1120            1132
>>>
>>> Curious on why passthru is slower than block-poll? Are we missing
>>> something here?
>>
>> I took a quick peek, running it here. List of items making it slower:
>>
>> - No fixedbufs support for passthru, each each request will go through
>>   get_user_pages() and put_pages() on completion. This is about a 10%
>>   change for me, by itself.
> 
> Enabling fixed buffer support through here looks like it will take a
> little bit of work. The driver needs an opcode or flag to tell it the
> user address is a fixed buffer, and io_uring needs to export its
> registered buffer for a driver like nvme to get to.

Yeah, it's not a straight forward thing. But if this will be used with
recycled buffers, then it'll definitely be worthwhile to look into.

>> - nvme_uring_cmd_io() -> nvme_alloc_user_request() -> blk_rq_map_user()
>>   -> blk_rq_map_user_iov() -> memset() is another ~4% for me.
> 
> Where's the memset() coming from? That should only happen if we need
> to bounce, right? This type of request shouldn't need that unless
> you're using odd user address alignment.

Not sure, need to double check! Hacking up a patch to get rid of the
frivolous alloc+free, we'll see how it stands after that and I'll find
it.

-- 
Jens Axboe


