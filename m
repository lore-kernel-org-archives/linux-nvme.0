Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832B3CA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yBFA3VaflFCB/0mxQujeTtIC8a5zlVaFTRMRmtMhlI4=; b=AbspSY+f9HWaaQijjNom/yty93
	3SuTga3mra4Iz2k2Nh3V9IEOTJdT7OGeo526wFJVGWkhYHlvwU76U97EIM30rSGv4RfkJ3tCGZdoJ
	ta/0BoAVuFdB5nFnriaLaiJhRMbiC5oC2T/lDrr0uUHCyVPnz76Pp77ZuqGiZoUP4F4L3sybQPNfz
	gYXxHf00nFXPJnNVMCPyTBdAJ9bL8knld72gvOmjrAk8h9qCIp0TghyKqb5t1lUUtsfABc/svFx7V
	A3W4lZEJmMuLMfQdO7CRx/uE+dhrk8o/EuEG/DZKNEJlLmb81Dojb2gHZRsB7bZP8M1LNUUmVu5T/
	wUQi0Dwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDvB-00000000nEK-34Ag;
	Thu, 21 Aug 2025 22:38:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7VS-0000000HS2k-3yNP;
	Thu, 21 Aug 2025 15:47:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A690740B81;
	Thu, 21 Aug 2025 15:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE6C4CEEB;
	Thu, 21 Aug 2025 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755791234;
	bh=uNxeyEwJIeMK7I5aTTxuR+vdsb3qwZbdDF0YXJk1RIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rN8zKzgp4yY1voOqoROdgerZ9G1i2qnm8LvSCvoQbREV5fiFUUrdfSQkijzzZGK9K
	 eMx1VUkbCT6icHNGU1CVRx5uGfJ+Iwnfpu5LnF1xjCME9tKu/3wfPRqQ4Ur/0TQOsG
	 dJS/PEnPlooiO14dYeLvg+q7qWkKgQP0ONkxHEXXGQqoNH7dZ2ZIzpp8x78sJAWOaL
	 KhotH3qDPY6GfKflqOx8R3E2exeA3E9MYrPN+gptA1NitmvK2YfhXPeFhbl9BofOGM
	 q0xVbTLowkKIgvdm7Vq4UojAJm7TKObMCqsVvnDKRKn/8RDcOkJeh/36HcKAv+hQOs
	 H0DH/GKS46kOQ==
Message-ID: <54aacd00-8c18-4dfb-a1fa-d600eb9733a4@kernel.org>
Date: Thu, 21 Aug 2025 17:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
To: Krzysztof Kozlowski <krzk@kernel.org>, Nick Chan <towinchenmi@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
 <20250819-polite-papaya-catfish-1a9d1a@kuoka>
 <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
 <b3cd1b3f-fa0e-4a98-84c7-e4271f262795@kernel.org>
 <8279536d-c4f4-477a-9823-3e7b452c3c33@kernel.org>
 <12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_084715_020283_18588CC5 
X-CRM114-Status: GOOD (  13.35  )
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

On 21.08.25 15:09, Krzysztof Kozlowski wrote:
> On 21/08/2025 12:25, Sven Peter wrote:
>> 2) We keep using the ones that are already upstream and just accept that
>> the situation is a mess and add comment above all the bindings that we
>> messed up and that this should not be used as pattern.
>> In this case that means it'll just be "apple,t8015-nvme-ans2" for A11
>> without any fallback and we keep everything else the way it is.
>>
>> I prefer option (2) but if you really want to get rid of all this mess
> 
> 
> I also prefer option (2). That's the least disruptive option for users
> and inconsistency in bindings naming is just inconsistency, no big deal.
> You just need to remember not to grow the old items/pattern with generic
> compatible.

Okay, thanks. I'll make sure we keep those old items/patterns frozen and 
essentially start over for any new hardware.


Best,


Sven



