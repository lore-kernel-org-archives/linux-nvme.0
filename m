Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AC7C54F55
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QlPatibx3g8XfK6S5eprVRseiFbSJCNNQ3hXCye36cc=; b=4NtbuXzFS1QkgWitYdZ1UWkqQC
	OjL59RRRpyZtIO6+9nfcLUZEKeiIeNVqKN7w7YZaOy+FUFF+HADx9i61+PJvGiidq9EplkONnmWv6
	5a4wCFyIbXKBXm2bKncvV86CyXhztN6CYOMPXvHMgODV5gZ65fXLACF2MOBYe2iLTTVafwahhPpkc
	nID3MeysMDr8dTaFsERyyvZK+3dE5ixeSClwLZJJaIiPykGdi+Nu4t+VPERNxv5uF/jFwEV6mNkq3
	wlQt1JzbINn0nUkvFXoKAzTJCo6FM3n5obxQNDBVCj8gsJUw098jzNdr6DutjhOLjjbzTVyVfa1Fz
	NBt9NOwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5mO-00000008KRK-10Io;
	Wed, 29 Jul 2026 15:01:08 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp44J-000000082JP-2BeG
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 13:11:32 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so9691045e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785330690; x=1785935490; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlPatibx3g8XfK6S5eprVRseiFbSJCNNQ3hXCye36cc=;
        b=ZX+jLI8oCl8LSAONnAeLVo9CZ69kv1nxRrHU0IUIsP5tjOYKw6MDLWsxboabCC4GGD
         eGM/o9WibamhYqhG1VyXhMOUAmRrRWfzggBI4H3LdTC8jJLBIOFTbZvxZfet0lxy1TPq
         D5YCPsGa8YM+jeCkZuC4iPegiDFC2ZPKTs/ix/Tu781+wIiQKnOrXDiE5eyP/Ng5Vbwr
         l2+prPpeGGBrjrC5DeyAPHZLRkYuO9ohpTDwcZW9RSI5ihYqyUNZy04Aq3ZZqm/K6yYp
         Ut4K85TyL0xkXm2w5fw4wgfbaiIHkUp9y0dCb3t7L46rX9uaJFVQ3lBMPpLQZiwQ8U5H
         TmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330690; x=1785935490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlPatibx3g8XfK6S5eprVRseiFbSJCNNQ3hXCye36cc=;
        b=A+JZMSowEKG/dyMk3otVrcN3nHUt5pFPQ2yojSG0eHbtEyrcQ+diXy3FJtYnfxW0u6
         vavjzHudB+Y2keiZWScsSa1SjV+3iCy+WFkN7r0mKyX1z/N8HRw26btDbpjkkfhXpucg
         A0YMSD7+WmWuwXGtmYKyBICRZVJMBmu2sxMRraFXvE7vOsHeHHKvAiR44/pxd0BsCdh9
         k3u16YOSXlb34wI86PmiDnSO2DMP/Ih8yxc8W13HWU5QdgWw2OoPsCg0jdpCHuBi0ulj
         teyQEzj29j+1DK9zO/ZjRw9XADzfGG9IO1D0uIbHfVdtICFyVnpRcJuG7aPcVgpxPqt5
         XUsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrroBjsk7htVSh7EMOCDm4HwYRiMMqB8VwI1MU/9yNUzXAz/Wq4mUnAYYAH149vI/CbMBZ9/kdGQKbR@lists.infradead.org
X-Gm-Message-State: AOJu0Yxi3fxWWotPQD+yCAkCgIaAU0dpHk7WW3J3FkL7nPmwUllyZ2KQ
	b6ATZrabW97NbobidO+/hMlFv5oxvST+J1fxjFYBrkqRYFMdkmvTcS/i
X-Gm-Gg: AR+sD11JT7LaNVdcLBy/RL1Fv2C3O3RNf4UgyeI7Bo9TavRljXWoyBP9syw4wp+7Nrf
	XZ+IOxuQBnkaV+62Lgpo2S8boQxDxnzB3cXqt5J/mmWVdf0S4jKuJbXf4xS6P0MLs8gAL1QwvHA
	CDR27zROhJNO6I5Hl6KS65Bnyo/rDEsswdfoCaUuaAZ4Gnc6wlU3q8ZshQXbq3iorpftLf6JuA/
	SruRuuqvjX6kJu6exd5bpYzJaJ3BCZ6Xt8r/RnhezSt10keDw1XzfrtdURQD7X3zHgqx8hxNjLl
	t+7UmZJtSCqmkV+kRKv9ylXyGtGh4LO1rUOPYcz4+9KZ9VZ+0xjctrXbM78Kbycwjp8ZTu9e2DZ
	PssSYC2uIpK2nRm1QxD7glcSbT0TQNyv1131hhlGEKBhQJkToQ9oP3SMu7o0tjA4AfWKjH95f4+
	WEN7IboIJPBiDRTWaAWGJD9G477CMSPySgjqiYO/NMR0okUFaapfmM8SmX/cW0VZtioXGvng/pc
	7HxhaOHTJgXGCKhaslRaUWIbV0g42y61q/1pB4edSnFqiKzDoTgQN0eSeockApz/0hVRpUs8da/
	c0Ct/3vHVLK+1/eDEcs=
X-Received: by 2002:a05:600c:3485:b0:493:b243:8ffc with SMTP id 5b1f17b1804b1-496c6586bbcmr69846215e9.35.1785330689440;
        Wed, 29 Jul 2026 06:11:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45c338fsm157280305e9.8.2026.07.29.06.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:11:28 -0700 (PDT)
Message-ID: <60df6af0-3bf0-4954-8181-a0acca7c21c4@gmail.com>
Date: Wed, 29 Jul 2026 14:11:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <20260729065927.GA9534@lst.de>
 <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
 <20260729112808.GA30851@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729112808.GA30851@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_061131_579606_04A22A8A 
X-CRM114-Status: GOOD (  18.12  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:01:06 -0700
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

On 7/29/26 12:28, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 11:37:19AM +0100, Pavel Begunkov wrote:
>> On 7/29/26 07:59, Christoph Hellwig wrote:
>>> The method name feels a bit convoluted, but given all the
>>> previous discussions I don't care too strongly.  I'll leave
>>> the dma-buf side review to those who understand it.
>>
>> I assume you mean this:
> 
> Yes.
> 
>>
>> +	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);
>>
>> I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
>> see what I can drop out of the name. Suggestions? Maybe I at least
>> should make the fs op sth like "register_dma_buf".
> 
> I just remember scares from the last discussion :)
> 
> register_dma_buf sounds fine to be, but unless I misremember there
> were objections to that before.
I'm going to respin the set in a couple of days, just going to
leave it as is unless we find better options.

-- 
Pavel Begunkov


