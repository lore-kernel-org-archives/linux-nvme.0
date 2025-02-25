Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F437C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CZI2gzOBB0xJ5jkNLy+GmteL5L1iI7Kqn7pTf+x7Cc0=; b=4yJP3UuouneeEETHMtC1weVqe+
	4Rt2r71J7v3nw7GwQ5Vnj05eWnxtP0Hermmco5iu3CSbvlyK5tlpLyd3ktDl7IHJw/9BYfkgiGgUD
	yDc6jpPcsft5K5EV1MIedr9Hlv/Kk2EUIV0OqYqn1ZUu3229cr1qeu8Jm+KGd1Af801Kh7zDwMr/O
	dSEUTRBeIEjYxlEmyphaThshR7/oWBXU52MqAbGGqFooxeerBwvIXxRoWX4Ax9tJ6P6T9y5dH8bsu
	dEm6viSZ4RBU4mNknivvTLHLi/y70kF/VEWwhFOhpVJwkh33qGQwrj0q91RlWn9ties7xUVnnkD8s
	hXqTgIog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmsal-0000000Guej-3JTN;
	Tue, 25 Feb 2025 10:55:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmrvG-0000000Glr2-1jrI
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 10:12:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740478337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZI2gzOBB0xJ5jkNLy+GmteL5L1iI7Kqn7pTf+x7Cc0=;
	b=FWuC+/UBeYsz2czjNWuXl4UMoeNhNHtdv23FzX0s4r81C3V3KE+kRhtuDG62KQfiNDxpRa
	tXTgFBWB/+L9S+5atxKrj6+nM7eusFi7hOp/9QCtMNaiNQiXxh27dwPgOZqjUX4a4RJAov
	YAT5kdBnkd8DEfyzq4gyRxqlklI+eQQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-8CNMDOt6NTuxF_aUamDi6A-1; Tue, 25 Feb 2025 05:12:15 -0500
X-MC-Unique: 8CNMDOt6NTuxF_aUamDi6A-1
X-Mimecast-MFC-AGG-ID: 8CNMDOt6NTuxF_aUamDi6A_1740478334
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-439a5c4dfb2so24526615e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 02:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478334; x=1741083134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZI2gzOBB0xJ5jkNLy+GmteL5L1iI7Kqn7pTf+x7Cc0=;
        b=UMFOghdD+fCI9eDavnus7ZYu3hOBhiZ3q5UWcMvpy98JMCPkUaYeOpOVmqZuL5hysp
         m0roseYHA+xyYE86SlukEVpSFDbMVfz27i+lAkBvBasheUrsm/s8yBompYZxULOUnAr3
         0w0vZysW5jgT/8SWvShQEVEw4JNnaB1YS3OTJghoEw8z1xM4iKEHOrRHbHmEiL8byM9t
         6HYzdbZ7k7e5TVB2GGGvekAjwvCS2de4DDn1CsrhyeH9/CA++DrL+KCdqZH8nZAn0iHh
         EBOGF5gaffp4fWe3EAuizFkFuufdimcU/6vjJWvKKWaiQ/X0wQqfLSoJiJiGwjOdBJxW
         DgwA==
X-Forwarded-Encrypted: i=1; AJvYcCXaJqZoEVYoXqAKZcRuZJOBF+Vml1phcK+Gc/18P72FelsPpmEGI8PwjQ/jWzQEJlWqtjYw1MgLyszp@lists.infradead.org
X-Gm-Message-State: AOJu0YzHrA0dpYrITiNgvpGj/hMzFgMTyp4thyTU7q9/Cxsa097pbNUL
	JY+/D4h4R/YXR/AcGMR0+V/fL/fjyZklIlJrufydZSpPTk6Mt/6p0PytGUNqe6K9YnCjjkcK2Gr
	k/bP+TkSxCeDkzSvndzyHSHIfGk0WszMIZHNkT/TvHQTZIMMgvwofOcjM/ABI4CVE
X-Gm-Gg: ASbGnctEajMNc5Hl3bhhiWn96STE3gkN/I7VCPiXjtIwxTKwqYwf8Pb70C/0fVUm81O
	VjZlVABO8NRlDjYZjxESk9Rp1RXlIQTHp3eajI8etAo8yUy+wYSLIfy/8K2tl0Ry502Hr8Vy86e
	lLljtpXNYEqgSYxG94OZzR0HGy/YzZlRMWMG+h+EobN+mwx4DhKynkppF20EX/SEndy23tcPcKL
	vPNNWvZir5gJqotso9XntvspbdbnO9Sl/2kVc0sF7uWipH26GgOxA4PWCs6wAxAMEVKqf7SE/b4
	wIsnquf5akDswsVmpvmd4GJY2xkLPL5ym6/Gv2Lq7WU=
X-Received: by 2002:a05:600c:1d1a:b0:439:94f8:fc68 with SMTP id 5b1f17b1804b1-439ba0b391dmr108465535e9.0.1740478334211;
        Tue, 25 Feb 2025 02:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiHtQb5hxUTUOWs8xAwnTVhAiAYLd0pv51f4bf2sD27cc5lb1TBJ+Vtress/OEMZlCb1ZWKg==
X-Received: by 2002:a05:600c:1d1a:b0:439:94f8:fc68 with SMTP id 5b1f17b1804b1-439ba0b391dmr108465065e9.0.1740478333874;
        Tue, 25 Feb 2025 02:12:13 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce615sm135773035e9.5.2025.02.25.02.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:12:13 -0800 (PST)
Message-ID: <63ede1de-1ee3-4872-84b7-d65ec2f68856@redhat.com>
Date: Tue, 25 Feb 2025 11:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 00/20] nvme-tcp receive offloads
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com
References: <20250221095225.2159-1-aaptel@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UKyly01JyUG0KSGMxSXr4F12DQmnKqWlgDTnN1NFTCk_1740478334
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_021218_571488_A20FF8E2 
X-CRM114-Status: UNSURE (   8.79  )
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

On 2/21/25 10:52 AM, Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series, rebased on top of yesterdays
> net-next 671819852118 ("Merge branch 'selftests-drv-net-add-a-simple-tso-test'")
> 
> We are pleased to announce that -as requested by Jakub- we now have
> continuous integration (via NIPA) testing running for this feature.

I'm sorry for the dumb question, but can you please share more details
on this point?

I don't see any self-test included here, nor any test result feeded to
the CI:

https://netdev.bots.linux.dev/devices.html

Thanks,

Paolo


