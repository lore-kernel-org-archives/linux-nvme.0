Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAD4C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 14:32:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEDC611CE
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 14:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEDC611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LJGr9ncJ39tUbcL7OkEFZzqNF1uSg6hoJAyaLUKFmfk=; b=pDSTtN69EJ8xNUjbs/xgMaPA0
	80smExggWbdqKMq4osAXCB5DiB+fLsKoeQHJ0KyHnCzsls3W7lPqET8Ju2lmW4p5T4cfPiiNNpEZy
	2X3QcgBeMnjflnmGqi8ZAGiOlfSV+BfDyiXIN/Y7TCxakf6sn3Lz7NfkfFpDXkJv0/0275s4AXNV+
	bd4xkyRGoooOkLNYLRqcd48VVu1lyxtxIssA9BwdOYQ3YuDt1REswbRxg7pwipbLVhiBmnTao9Xqo
	GTYMD5oIqhLOy88NzOl0A35Vvc1XcQVibDGGnQC51zrlP7EJXGZ1M1/LjCx7wknFxtY9u2ER5KFXs
	ECwtbRUKA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYUwJ-00A6vz-ML; Mon, 19 Apr 2021 14:31:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYUwH-00A6vn-9H
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 14:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=BukaGkqzntQMa+c7UOYXuyLPXisdJBi9+eUzsglGXps=; b=bHqytU4m6sY7H3nXxybE8ow3H6
 LVLEKW017O3hwnUnqvGuzP6EYVBYjk8O/3K6TBx0vwqC99YdVbSPm5TUKufW5jowe/jUBV2pMW1rA
 OP0hgfQSycMwrEzOuQvVuj8PMeHa0CoAeLnN+OhL5mZNSVbOwya1YyX43nLvKtCeJd0c/LSK1YI64
 7B3TOP9dqxVZpxlzieLgcYT1rMEG00F+eN2QAkUgrt0frnxQKyuDd7Sp2+b9Ygm41ChEuDX3A4I//
 rXkWZF43HiqG4Z7PakQHIQGtZXWJFtVgde2NQEvpBfoWp5M3bpuRhGv6FOeDfxAiMxpoH4caZ4Z2F
 vner4uyg==;
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYUwB-00BSCE-N0
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 14:31:48 +0000
Received: by mail-wm1-x332.google.com with SMTP id
 t14-20020a05600c198eb029012eeb3edfaeso8368229wmq.2
 for <linux-nvme@lists.infradead.org>; Mon, 19 Apr 2021 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BukaGkqzntQMa+c7UOYXuyLPXisdJBi9+eUzsglGXps=;
 b=OrRBCi5shSKBHUKdpnUhHjKa/wnl9rM6aPVliawCymCmBIHfeW28CJJkuCH29sj7e4
 S6hA7BjFCKqlbZhqzWZ/3my9d0OzMoF1ARfV63XALb0Oiuj0DbHg8EVXuTtrwX9rCnDo
 2qFk+iJVROw76nztDAZ4p8DfbzxK9jONKc36l5dUTTPLVHwPa2c8vN+qR7dTIPVIeg6Q
 1fBAU77gXDjcXvIGJxtku4y2/0+8B5GO7Q4KViZkk8N5PkmdstacMQKAm2b12ECO73e4
 SR8aRxXRX0Wl8CgYCiiJ9NcAKwjbDzPvViZdsQZRSpSNHYwhU817Q3OAqm/MTsO8pR2P
 dQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BukaGkqzntQMa+c7UOYXuyLPXisdJBi9+eUzsglGXps=;
 b=LoOhSaALcrttVQp3BmB1e0+ek9FMgHwwOGhrQlINaoN9SQxvMqm5kRyg7KF8xXTO5r
 9PDwNhDnzohcIeL+CJXpry2Yb69Lv57gonBiBvFF62QUvt2kzv7Lx/fw94is/oIjGTzU
 SAXbEiX3nBnTqfzGtC3sGOjri/Si751uOVENnroSuv7D3Dy9WICPtOmoJpD6Emck2aVb
 AN1dbTb0TH4EgkRVEgVDPlmPkrW1O02hCJL2DAzuZmLrbmPfT0+WftAMDZ8MY0wK6ZA1
 de/Vl0ioe11oQmlm3Wjfx3IHyeO3pC4TizzpziREMVyMgtlfuziDMRlB4fSzo7GFspYD
 jIvA==
X-Gm-Message-State: AOAM530Eq1kFPNKfZTlIF6wQcxP/ibeH18kw3vZjZSHJrFGcV6bxSGWM
 MWfBo0d99xylGxsX1Kh1dsY=
X-Google-Smtp-Source: ABdhPJyXzJCtNjiK/RNOQVsENTX2/B34lzG8uvXlRcKqHCUuTavrzJjbLayUoY/kcz51nLnQH0BiPQ==
X-Received: by 2002:a05:600c:4ed1:: with SMTP id
 g17mr21963702wmq.67.1618842701452; 
 Mon, 19 Apr 2021 07:31:41 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
 by smtp.gmail.com with ESMTPSA id x17sm19334170wmi.46.2021.04.19.07.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Apr 2021 07:31:40 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH v2 0/3] Fix dm-crypt zoned block device support
To: Mikulas Patocka <mpatocka@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Mike Snitzer <snitzer@redhat.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <alpine.LRH.2.02.2104190840310.9677@file01.intranet.prod.int.rdu2.redhat.com>
 <BL0PR04MB65147D94E7E30C3E1063A282E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
 <alpine.LRH.2.02.2104190951070.17565@file01.intranet.prod.int.rdu2.redhat.com>
From: Milan Broz <gmazyland@gmail.com>
Message-ID: <896ab66c-525a-749f-bf74-42299e028d77@gmail.com>
Date: Mon, 19 Apr 2021 16:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2104190951070.17565@file01.intranet.prod.int.rdu2.redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_073143_802668_0CD13BD6 
X-CRM114-Status: GOOD (  27.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 19/04/2021 15:55, Mikulas Patocka wrote:
> 
> 
> On Mon, 19 Apr 2021, Damien Le Moal wrote:
> 
>>> I would say that it is incompatible with all dm targets - even the linear 
>>> target is changing the sector number and so it may redirect the write 
>>> outside of the range specified in dm-table and cause corruption.
>>
>> DM remapping of BIO sectors is zone compatible because target entries must be
>> zone aligned. In the case of zone append, the BIO sector always point to the
>> start sector of the target zone. DM sector remapping will remap that to another
>> zone start as all zones are the same size. No issue here. We extensively use
>> dm-linear for various test environment to reduce the size of the device tested
>> (to speed up tests). I am confident there are no problems there.
>>
>>> Instead of complicating device mapper with imperfect support, I would just 
>>> disable REQ_OP_ZONE_APPEND on device mapper at all.
>>
>> That was my initial approach, but for dm-crypt only since other targets that
>> support zoned devices are fine. However, this breaks zoned block device
>> requirement that zone append be supported so that users are presented with a
>> uniform interface for different devices. So while simple to do, disabling zone
>> append is far from ideal.
> 
> So, we could enable it for the linear target and disable for all other 
> targets?
> 
> I talked with Milan about it and he doesn't want to add more bloat to the 
> crypt target. I agree with him.

This is all fine even for dm-crypt IF the tweaking is unique for the sector position
(it can be something just derived from the sector offset in principle).

For FDE, we must never allow writing sectors to different positions with the same
tweak (IV) and key - there are real attacks based on this issue.

So zones can do any recalculation and reshuffling it wants if sector tweak
in dm-crypt is unique.
(Another solution would be to use different keys for different areas, but that
is not possible with dm-crypt or FDE in general, but fs encryption can do that.)

If you want dm-crypt to support zones properly, there is a need for emulation
of the real sector offset - because that is what IV expects now.

And I think such emulation should be in DM core, not in dm-crypt itself, because other
targets can need the same functionality (I guess that dm-integrity journal
has a problem with that already, Mikulas will know more).

For online reencryption we also use multiple targets in the table that dynamically moves
(linear combined with dm-crypt), so dm-crypt must support all commands as
dm-linear to make this work.

I hope I understand the problem correctly; all I want is to so avoid patching
the wrong place (dmcrypt crypto) because that problem will appear elsewhere later.
Also for security it would be nice to not add exceptions to encryption
code - it is always recipe for disaster.

Milan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
