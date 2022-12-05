Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818C0C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hN16r2JqgO0aUt9hEV33NLw/555dF70HALoTZ9f98ns=; b=VT5oQz+gZcO7Bnp15vg7mfVdEc
	wVm/LRUGHMHBMYTlQInc9FvjIukCU1H/ud5e0kgzoLcaW1U85v56CcqXNOiFrf3OUp1OFo4cYT7rl
	vSNp8L9RMJqObwF7rmJIjZAcxAIgvL8AsnB/z/qZufuu5PfK5HcflKxXQj4cVHs6auEUPjQH0hU7N
	YgR01LRkDO3HFIx+ZOolBlaF9RcTKvdf78fxUCiWsyGDKCgqlmOd8HD0iFbtp2CP+NME2isGN7u8g
	s/JhYdJ12M1DeFBvTuwcEFXG5ilB+II8P0q95fROloCSOXlxxTzNWZlrXluJV9ciTeYLdRqVwP5kU
	c8zktTiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2GbJ-008p5R-RM; Mon, 05 Dec 2022 18:54:01 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2GbG-008opU-Ug
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 18:54:00 +0000
Received: by mail-pj1-x1032.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so12372061pjd.5
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 10:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hN16r2JqgO0aUt9hEV33NLw/555dF70HALoTZ9f98ns=;
        b=Fm9dfwrFeIHNqJDczZ8ygOt/Uha01dMRWprhcIoeUWieIM4pkz1xky0EJcPnQBQWe0
         m7GUZoU0/2aCb+0E0+M6kltGs6hlEENaCX5gfWhRnXRd0rye5mK3KgRvIyM/2Oob5UlE
         38SmhTUgfCQay5hI4WIf3FEGQSsP7+pCWGiu3ohS05iL+h2v7+4MM6ftNKTC3q+ULBws
         nL39f0K0e/CH9ck/0WnWtdA3yoVKa3Ds36+G8AkqXJGYa6Ma+P2vAgd/4nl8Sjjj7ig4
         xXJQXoxqZJQ1eNNeKYHnnOqVcnXQ7tDUkUNigzrEsoOXLZHKOOwqgr2IQdgxEPpBBKfc
         HsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN16r2JqgO0aUt9hEV33NLw/555dF70HALoTZ9f98ns=;
        b=xkPdgi6+9ECb7H7DmWl5jXK1Upo4igOVs26MAsE6Kyx9b0r1NGL+Zg6r9d5cfTv7xv
         kQeGUXjEphddiDCykpBP0I6y7VmEtzq/TMi/dc0SuZSX+wU60caPGziUA6hVi7sYMTlM
         wasLHY5WsR9+BT+avTngZovoSetCA3piJp6APKGcz6lN+jT5mwJCV0mwh1ABB07B3PGM
         8Rxyh7yhQ5TVlEY3h2Q4f8vt+NfnI4+hwGaRjeFua6jqUau5gY6pcWVnm1QYGvgs34wt
         kZozcHQYiNkiONrMhIGdIscCRjRS+dqyrfz8f/kuLH1ZMc9ioZuQ7JI7mu6k0qfW6aCD
         +XGA==
X-Gm-Message-State: ANoB5pk6zYx609ijOriNHvjURpLxGOxtjN+qj0d4pAtag8eps+mD9LyE
	HFCNJ9kAb2daj2BTglq1JAOYgQ==
X-Google-Smtp-Source: AA0mqf4PO6AFHe2UJAtP+NKsy/VfRk3d594BgBjTrOZGH8U7h8+eNxk2+VLeleDwTNhV8wJgpjSYkQ==
X-Received: by 2002:a17:902:e411:b0:189:8796:7813 with SMTP id m17-20020a170902e41100b0018987967813mr40667373ple.110.1670266434300;
        Mon, 05 Dec 2022 10:53:54 -0800 (PST)
Received: from ?IPV6:2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a? ([2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902778800b00189a7fbff33sm10880935pll.170.2022.12.05.10.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:53:53 -0800 (PST)
Message-ID: <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
Date: Mon, 5 Dec 2022 11:53:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
 <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_105359_011001_7D897F5F 
X-CRM114-Status: GOOD (  10.22  )
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

On 12/5/22 11:36 AM, Alvaro Karsz wrote:
> Hi,
> 
>> Is this based on some spec? Because it looks pretty odd to me. There
>> can be a pretty wide range of two/three/etc level cells with wildly
>> different ranges of durability. And there's really not a lot of slc
>> for generic devices these days, if any.
> 
> Yes, this is based on the virtio spec
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
> section  5.2.6

And where did this come from?

-- 
Jens Axboe



