Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD45C88E53
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ObYyVlI1H6pHIe8uiwi5J0cMhM
	BrhDme/fi/uNEemvui56Nz0n1eRECWBxOEziseJtFsjIE6S+v8y49N/iG6YdTTfG1ZX9fOGWpgVu/
	DyGbhBebxcUgCxf0B7TJWRVHJNbzKjYSv/KC9mGh+g+ZeG5+YrIGHYFGFgVALOELEmMsBb8JdQFhR
	rHfjKNdXUXEB3ai4E/MvIObnQf92/aqQZ8t5d68xxHQYUAwN7Vqj9gXBXk1Bt4FNd/DP4lCGq8486
	n7uEyUFTmX03xKgKcGwsOc1ulAy0+8qn07nlxHYoAGnJF2DqWkoHf8Q+R/stSU9EVBJJI17thip7g
	nXCGLs8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58ix-00000000Ani-49sj;
	Fri, 11 Sep 2026 21:23:55 +0000
Received: from mail-wm2-f12.google.com ([74.125.225.140])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58iv-00000000Ami-1eWx
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:23:54 +0000
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b94fce6e8so2691075e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161832; x=1789766632;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=pi5UgVljIyIB2QtgTPL+UhUEPkZxn46i+JizSxXDZtlTDLI/cHh6+se160qc9WphO8
         md1gdFQC55dO8Uqrh/+KLxv9cA+QsAxPNovO2WKNBsbzBX533gX8RkUZpEQQeh1oMQas
         M4dfwq5hgcG2vw6rXBI2bCLELWR6SEJ9BvnR+I+Q9aDesIc3RxeM76imXWQMELizTuQc
         is0rz8z6e/QZNsG+B4H4vj55LPsSOMJJjywSjODG8Ii4VCToTilcdGta7BU7rDj7PNds
         VpFjCfMS/d7iQrMKA+OANMHEoPufTISbzC+oUoivHEycIvhI/13MKj0mBE8R4dNSjWJH
         A3hg==
X-Forwarded-Encrypted: i=1; AKwUvBya9qeXZk4RclR5Dtm3HhXQcMJSI715qOd5kJ489kVOT+UFvTcGtJ3U8v25teF5IHYuU4xd21TH7kgT@lists.infradead.org
X-Gm-Message-State: AFuF++k4eaNCfqKPrQRWuilitUuj5EueKxMKITBQ8xZqo4VJtBXA0Y7f
	JIvTEjgWle45CX9BUDkOZarFVIjvb2/IbdKY6nRlRugXIaNMc5h0hQHp
X-Gm-Gg: AYBFou2Ut1kx3wOSwowjEAvl+KCmcqPIAuR2nzsFnHTZCq+YsbShhagTw9PDMMea9TF
	gt/o44Wa+jj8nguv946XbfYoK0z+B0Cr6Npw4NElpNRROuxaV146lvSH98QkRdqgt15Qo9q8TN6
	7uMaBgOSrEtZGPXNUi/e0BVaozPrMi4HpwoOSHPk/9vOLNYBVPwKVOcrrB6oAxBj/cMPQuaV8c0
	SWSSL0vaDEp0GF1L+2F71kgycTmyYnmdAljho28AJ0yiAbq+RGf7RrM4+No8/UxDZWjV+Zb5cGG
	8tkYgGP1VjZCvVJ9A7xrTLeXPLUbvyGQ9sIB5tpa5OVIdKUBSvPs9W0VGONZl6yGvwbtfguW46D
	dxm9RZGLg3sCsSEH8QuJMAf4mp8nS1f1QMVUE0lnCWZxVcFfeGthUtdtJqPnk8ZfMW7u1yLm8xk
	AuRe5g9M6VrzxY8WgAo7mECptTa7CdcT+VPWrIcRyn08kS4Odjro9347p8eUF80kNBPr6Lx3QRH
	30repN8pWwurSFBCiR1OvTyXBieW41+
X-Received: by 2002:a05:600c:4e0e:b0:49d:7f5:4cdd with SMTP id 5b1f17b1804b1-49e619d4d30mr76427485e9.27.1789161831728;
        Fri, 11 Sep 2026 14:23:51 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35c071sm8699507f8f.33.2026.09.11.14.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:23:51 -0700 (PDT)
Message-ID: <3e38523d-9934-4b2b-915a-549647e78be2@grimberg.me>
Date: Sat, 12 Sep 2026 00:23:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme-tcp: refactor I/O queue setup path
To: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Solganik Alexander <sashas@lightbitslabs.com>,
 Roy Shterman <roys@lightbitslabs.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, mkhalfella@purestorage.com,
 randyj@purestorage.com, adailey@purestorage.com
References: <20260910202812.1642832-1-sgogte@purestorage.com>
 <20260910202812.1642832-3-sgogte@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260910202812.1642832-3-sgogte@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_142353_429766_F0EAC7F0 
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

