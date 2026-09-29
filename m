Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEB8C9832A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u85DHQjzFjhjJwGM5qYe2m+Wu3+JBRzNXyLVLc7SDKQ=; b=lXLQsu9RxdJ6fhvC8CfUinG6uo
	hi9x05Unp3j4CpyMbzVO4MtvmW8tVAY/aosnuYcLYliXcZUKzMwQKV0HtwbZVokZqAuhbVy1QDNjO
	iko+aqDcGza7kyjIbbQl0ZkFkgt6J/w4f9DoEvH0EOlohhKkkuyVULYkyB+//M3Z9kSQ6MGuHTWqY
	PLRf0nmPtF1lOb7dQUUv4cXjgh8hAcmaIs6yYgzzRPWZGvAAm3eSAKV+ZyC/9eTAuxxB5dVHDwuEo
	LV8vJPrpUeO0kk8I9LVuPJIUMQMr3K1ZjxbcwWymNYvQhPHMf32Ycl3s9d1vWibl6ipLUYFaFm5Lz
	2Ue1L/fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT0h-00000002hvW-1GiP;
	Tue, 29 Sep 2026 08:16:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT0b-00000002hus-0EHZ;
	Tue, 29 Sep 2026 08:16:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 811E240E42;
	Tue, 29 Sep 2026 08:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665DD1F000FF;
	Tue, 29 Sep 2026 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669776;
	bh=u85DHQjzFjhjJwGM5qYe2m+Wu3+JBRzNXyLVLc7SDKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FB1NVZv6x3IyrLnfD9QkqxVp+v39HFsLNCR/yEaV9MTzxg1D+S9IF31eEhnh9QIGh
	 EPjeUJt5QWFa/+fL46Y6mbxuFMCE2Vnmqd0U8fV2sdhlDLz2M2x0qYDoop4cyJgRCg
	 3lj5ImVnZ41dAPNPPBP2QYfYCgA4u/q2FpqfBdUtUVv5iCne7oiI2Q2NGVIa5+p8CC
	 oX+JmZwQajW7NFfcaOmUTLRAnBToqghXGZ5UPvX1q2lyHub/7KMdDHhzonCYKQSFIt
	 kJq1tS0Xhiqnue7d2sUvYJnqZj0Vahl2PoZKnxcaF48Nnp+20eZMNS2xEbInUgnH4X
	 SNt7abk6wfIIw==
Date: Tue, 29 Sep 2026 10:16:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/7] dt-bindings: mailbox: Add Apple M3 compatibles
Message-ID: <20260929-debonair-busy-hamster-be2fda@quoll>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net>
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

On Fri, Sep 25, 2026 at 10:22:49AM +0200, Janne Grunau wrote:
> The ASC mailbox on Apple M3, M3 Pro and M3 Max/Ultra is compatible to
> the mailbox on M1 ("apple,asc-mailbox-v4"). Add their per-SoC
> compatibles "apple,t8122-asc-mailbox", "apple,t6030-asc-mailbox" and
> "apple,t6031-asc-mailbox" to its dt-bindings.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


