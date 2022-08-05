Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F12EC25B08
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 17:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VqPDDSBpBwddRfow0SAFRaLdgUCxAuI8BMm1SRvWNRk=; b=XcEZZsrwXsJWFEgmzlfGn6nL4u
	pVJHHjcwvXFcExijHQANosin3zn56mLUUztc/r77GmUXkT3fMhcxtXJcSuykkrdapQuxPo1E16cMj
	x691kB6HdKuIVvMYpdQR4V/H8t/p2slbOtscm6yLzbWqipSjEmGSzMJqHwsACPYIk+XCpcHu6USlX
	NDNJtm5Gg/U2lw31ChwbYY9kbL3LWgr3mvDKZPn8IzF++8Sx7l0UNCSj5PnBtuYo6Pyr5ZN26bKI0
	g8l0yKCTdZSmz8mJpSk49Bnecy7K0S/3+r47uGIlHSLI/dEMzfExVa48GByaHuXin6+fVz8ZH7f10
	B7iv4yFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK16g-00H3Jy-1v; Fri, 05 Aug 2022 17:27:30 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK16d-00H3I7-1s
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 17:27:28 +0000
Received: by mail-il1-x12e.google.com with SMTP id d4so1672528ilc.8
        for <linux-nvme@lists.infradead.org>; Fri, 05 Aug 2022 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VqPDDSBpBwddRfow0SAFRaLdgUCxAuI8BMm1SRvWNRk=;
        b=TZQQewvoRD5hBKdOFT3s+LdXE6ljyWX+TGuw1pck94i1Yg9d8sLvu5ohMTLAkfgkSK
         DdYTPuhfzrG0orVYarV9B1J9erWTFt1M/slHB2OceJH2plf06thpVIgretSBwOeoVcyr
         69FDQOkWTaZHm+DYtAMNzy4tE/2DoIW6ki/di1A9Su1VgrwacDKtigkXsuvm+S4JR3DH
         YnIj0ldXTO598cfAy7hNTZdKcLLA0xnWEBmfiLI+eKlFugpMcC+Wsq8jjGHRn/e6s6iX
         bxqNntiegM7fp2rkC8q/SPnBIx0ypTH5xiVikBAooejU/Do9CG8Fzge5VEPQRzfvRUWk
         RLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VqPDDSBpBwddRfow0SAFRaLdgUCxAuI8BMm1SRvWNRk=;
        b=aXocIuxQjNq1Je/92+RpdXAb6D5R4u8ou0qj/Gr7f6yIDIjRx5iZdc0L5CZ/mxScgr
         H6YqYE4fOAUzRtzv8smVRn4DM60KT6bz9/Y6fNcDnVseuR3SU3yOYEQ5jhhiN/Cq3sj9
         WwFwFIKunUeE2+08aLPV83nV4WntLxCpg3gAsTJPTwHdJ92VE368eIi+ECvtYl/QMNpq
         WXYZzdtryb3onpyit0lHH4JWbF24FYHZLqliHU8P0VQiRPM15N7q5+07Z0hQk1nLSXfK
         lGkj5D/Ga6Vzj+NaB2KgrRnPXnJdbG7RdvRx4uYG1A3z0uAxf9kWRBISNc3HOrjfQX4w
         FIzw==
X-Gm-Message-State: ACgBeo3DKIxbKQu4v5CwWiZ8mXh3ZUimYEjMqb05SIJWtR2YUXLRenpM
	Rel2+oj8HzNZL1qSkgA/se3c3A==
X-Google-Smtp-Source: AA6agR7cmuoL/H2+7nHy2Mtu5czVX+KNmjmi5wl0z5jXuF13b3SZ+G0WaxTwgDUKt1vsaEHi65C1jA==
X-Received: by 2002:a92:cda9:0:b0:2df:a725:6491 with SMTP id g9-20020a92cda9000000b002dfa7256491mr789331ild.12.1659720445894;
        Fri, 05 Aug 2022 10:27:25 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j9-20020a02cb09000000b0033f1953b15esm1865177jap.60.2022.08.05.10.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:27:24 -0700 (PDT)
Message-ID: <dcd80d2f-417e-da50-e600-b44942986699@kernel.dk>
Date: Fri, 5 Aug 2022 11:27:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] iopoll support for io_uring/nvme passthrough
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, ming.lei@redhat.com, joshiiitr@gmail.com,
 gost.dev@samsung.com
References: <CGME20220805155300epcas5p1b98722e20990d0095238964e2be9db34@epcas5p1.samsung.com>
 <20220805154226.155008-1-joshi.k@samsung.com>
 <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
 <20220805171331.GD17011@test-zns>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220805171331.GD17011@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_102727_193611_E08A3BB4 
X-CRM114-Status: GOOD (  12.67  )
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

On 8/5/22 11:13 AM, Kanchan Joshi wrote:
> On Fri, Aug 05, 2022 at 11:04:22AM -0600, Jens Axboe wrote:
>> On 8/5/22 9:42 AM, Kanchan Joshi wrote:
>>> Hi,
>>>
>>> Series enables async polling on io_uring command, and nvme passthrough
>>> (for io-commands) is wired up to leverage that.
>>>
>>> 512b randread performance (KIOP) below:
>>>
>>> QD_batch    block    passthru    passthru-poll   block-poll
>>> 1_1          80        81          158            157
>>> 8_2         406       470          680            700
>>> 16_4        620       656          931            920
>>> 128_32      879       1056        1120            1132
>>
>> Curious on why passthru is slower than block-poll? Are we missing
>> something here?
> passthru-poll vs block-poll you mean?
> passthru does not have bio-cache, while block path is running with that.
> Maybe completion-batching is also playing some role, not too sure about that
> at the moment.

Yeah, see other email on a quick rundown. We should make
bio_map_user_iov() use the bio caching, that'd make a big difference.
Won't fully close the gap, but will be close if we exclude the lack of
fixedbufs.

-- 
Jens Axboe


