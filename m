Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF00C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=AEAmxfRp9cbU173B24BbtHRun3
	75yIY/maJleelHMlMmvyfeBDGrDQP0/q/nL8eu5ycaane+/EbxJ3cD34SkDT/HaAMjjnbM5Cgs/8L
	gBuupd6inrKe/oFwTBoPSsIlPqHlv9fKB03agExY+L3IFq6UERtngBK0f6YZZjgQe25wlkUPnKHPD
	2Rygp+POJ1lIcLcNBk4AU9tRJz4bl3K6Ln5Qr0+VzBM317ABwvuNwC9aHTsgV/wmztp8xGnLnPsDO
	96eIpgshv/r92xW59RxJ5ENREpAMNI87PPzkHYiteLKY+kz7bnodn+hjOTYn2U/bH69W3t2C8er1k
	6o1zTvrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxw1n-0000000EvUg-2MgN;
	Sun, 23 Aug 2026 00:25:35 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxw1l-0000000EvU3-21Zg
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:25:34 +0000
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a378f90555so3816590a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444732; x=1788049532;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iBmO+b/ZR6KbaRpHli+q0xUKXbxnVIufvHcnkgHUSAykrb0e3PPAnjTlmdlJunlWiN
         nMSu3Oq2znOxfaQe8tcthFb5PhjXBXzTyq2AE80N/8Kfwif+c2FPxIP94GzVtx6d0uvY
         5CYQ9VRwIxbU4btLIqU5uC0c/u5OKjafxbiI7dLsyv0ShKWkot8sIQ0NPQmT56JdcXUR
         NaHWS3Bmh+xSX1kT/dHM5XNAyly1Mbjae1IDdlAruapMbXo//l6XfHOg4PE4lLLxlEAn
         jX7EwasGlkyMJ25U5+KzcoBkOBruKLiUul/nQguinedSCnw+E7ghnWF0a3ojbrCHbBPD
         dphQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLPEFoZtFC1t8cOUJhKdZ0fFqOZRi6aiKEBbd5OzYqgBKdgOBZFYp4cQqP84S+uhSFX+ZgToB2driQ@lists.infradead.org
X-Gm-Message-State: AFuF++mooO3TBonpc3Tqks7runvK1KA/VKZXNIsrtrBXtvRFf8cbrQQW
	jvlfrciWHx2LGQw5O9xExBFG8LDqOVD7LJDamGpwmUvlWSy5dLXPvXxL
X-Gm-Gg: AR+sD10etvR9N/yusON/dqcjddm6N19r3tAdninQot8Bzg5xIVwK5edZP3wVGOxZY1W
	ljFLN09bzo60OYlWd9e7zacgK/e+xO9mdz3vt0po9zhvsmvs8Php9w9dVfiVI4BkEOtegFfgNTN
	9uZNMLMI6i0hb2Dw7ybh7cnKKtvBBKgyAsURxWS9oc1tG86onSSRXZiohkv0JmYAjjOkvDGQLHi
	SzJjCU6IXys6Gu3vZC0CC/B/5mFceVG8RtklDgfwTSvfi5A+OVQYHE5qk8nKQxXSOQVNUCElfET
	gvWgwBy0NQrhvarn7SgYrFHmDKRhSrh9WPeO4FvkiNFWCV1Jcb/WxSPT3xgum+EiiXriYa2ifMd
	571XcIY8KZjt1zapj6C3vFyI5TOtkFeSP+mnGFQhtMG858VWqzre2T9EA5hBVwy52g5FnCnjYnw
	xgI5hoMk9I3AqexnSA07iREF76dAHqJKhWSHX1vzR1eF1crfyn78MATIezlS0L5kt3IWrCS70xL
	MCQJSXDtCCUloHqJsrjIUI=
X-Received: by 2002:a05:6402:321a:b0:69a:a4cb:2882 with SMTP id 4fb4d7f45d1cf-6a42f216beamr20077425a12.9.1787444731671;
        Sat, 22 Aug 2026 17:25:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199c4asm386394a12.14.2026.08.22.17.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:25:31 -0700 (PDT)
Message-ID: <bd8b4763-c9e2-439a-a6e4-558f963ab311@grimberg.me>
Date: Sun, 23 Aug 2026 03:25:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add missing SRCU grace period in error path
To: Tristan Madani <tristmd@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander <csander@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
References: <20260815001427.3148050-1-tristmd@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260815001427.3148050-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_172533_788529_EF80DE15 
X-CRM114-Status: UNSURE (   5.83  )
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

