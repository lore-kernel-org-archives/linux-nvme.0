Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44E6C61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 22:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hzk0xWA5kc0eyhtCbD/ciFmaZy
	EjogmRxuqAOQdR1vdXcWcKXOACJCGgmOWMgYpCkOMdKK2Umo5wv3rlLVDGkg9AdHdkv18V3snsq7Z
	WMFTjoc7olPJB26AdzCXflHHqE/MrqXUexQ+JZFa7wR4iZa83kJDsG9b6Eyc/6hsOs88Y2WfqUszn
	FC9X36xrJqRylNxg/jJOKhCBFmXEb0CVOs5R2UFzRTmDh7Ww3sJeTrZa/397LL0J/C/rRdukp3Nak
	9aRbn2UY7nqklZQYDc5i301Hlr1Sfeg4n+QYBFjo8DIbIBZoQaR1F9Q54qFKkiGBvaUx465j4JBWr
	C5Romv7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0o76-00000008By4-1Kxm;
	Sun, 30 Aug 2026 22:34:56 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0o74-00000008Bxl-0R0Z
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 22:34:55 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so20354855e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 15:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788129292; x=1788734092;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=eh6xAZcut/HuBttZWWU7pbBdIoMlAYQ0+TBZ5plRCtfjsO6xMMFWXNL5f5ommxFPjD
         whRAslgsVwtfqLWCQZJZV6znLtiOo/qu8JIGPxoc/386FdbF0EBXicgi/xfD6LXEXy2i
         mgQ3/Sinqw3qd7GLcoEPGYPqtFb1Sna8mFzN7BkR20asH3BH5y8scldvV5WEDhti40Pb
         r+4imeQqHTxM0QXSt72RupZTKmw3W8L3XLdaLYh1I7meRF+gqFSZovq88/bSFBgUaU65
         2/pt/DdHoEm8cStVZe9q0YYrac4yU+S2gz0Ne76t4dU4CuphcjbcCL+vRMDoEPL+56XU
         SD7w==
X-Forwarded-Encrypted: i=1; AHgh+RrHunFB6KI8Jv2Gt+JaUDpvtSt6Y9b/MYkoLMpHWcrcmsm+ja4G3OoZlu3p8GcreoInLxqcAerMq0gK@lists.infradead.org
X-Gm-Message-State: AFuF++m4lQdR+g8FVCeQZYUKVwUm8ReR+kd6svFCYzQpuv8nZuFFkdcc
	4gO8ruMAucaviIt4+/Jmqk2AbDIrfXp5vaJqbbbtd0hysN8YtYVsqXYs
X-Gm-Gg: AR+sD1279pqZX+cOLuUA6XlPRAYj/tnjfMgBC5jsYzjJMeyF3gQW0xDMHGp4inPXMdn
	8GEAKJ0k+2SE8CoaGiGfNqUu9wKLUNbX4jM0M9/Z1I8uIGeScb7+DxvhIOV5XpXsFX6ye69jsbu
	q/eECJVWwfM0HfR6hNfL+0KyAcurAxY4Q0uaBBNlDdSs0Bic6qj4xPNsYzRZwIrspDd7uyk9bvl
	ZLXDDIzOHCAdq2eTqi9J7lMm271O+uMgREK7kNaV2iYr+mpdLPJ8KMuAXhyGjD53RxtTZCGYUmH
	c1e6cni4cANy/fQf+U05DEFsgof+sKbaAAzsKQ3ALPE5fE2uaDMoFvubEoQaWb2j0jB9keiRH/a
	h7uxzbr4G2L5uUwFT90qhaPsWrfxYA3bzcayWm/Um4d4eDq0dSaLurC4LhCQz2zx0wgBTNf48rF
	HwZyiStYGVz3TrA7A0IRjpjWGCmjjJ5+2VyXnWLZOcalre4rVCFvyeLLThSXwT1sZXBlTcqUvgn
	02DyhltQVqeUwsiwgn+1Q==
X-Received: by 2002:a05:600c:314f:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49b91c38bcfmr320610475e9.6.1788129292295;
        Sun, 30 Aug 2026 15:34:52 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b961820ffsm107119715e9.3.2026.08.30.15.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 15:34:51 -0700 (PDT)
Message-ID: <2487d630-59b9-47f4-8f63-bf252e52ba0e@grimberg.me>
Date: Mon, 31 Aug 2026 01:34:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: introduce parameter to clamp io queues
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, tglx@linutronix.de, Keith Busch <kbusch@kernel.org>,
 santhosh kumar <santhu.linux@gmail.com>
References: <20260730162056.1421564-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260730162056.1421564-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_153454_140238_3698CA3E 
X-CRM114-Status: UNSURE (   4.37  )
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


