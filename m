Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA581CA0EED
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 01:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/A6vfnDj7wFUUnWczWrJvhkdD9wNZtDdtaVVMVfjN24=; b=DDpVPqicT5mnEvoTI8a0B69oyo
	ZYsCDLXltXo0wrScQAXVI2XQCcuKvjh77FkkW1XKBWAR8rxmk0cEL30Tx0SxhHwkHX+7BywhbGQHO
	MuuU5KD4+mtYUAly5PQ2z6ropvF6doYQLFAaJqJQTxmxv7SJuS3niOzLbWXR7GTggeEp1T/ED/I3Y
	ZCsIiZXL9YT0q98XoZHuFGEojwYHIG35C9q6O7tqv8P6x10MfaYx9WtrQp0t4vMl2GDMJGAdfr7DN
	ek4hLaOuCpkWbdRtJek2bk4xDYsHj6IqpuHDFaZtiU7szHCjdoAmNyIr1w6He/30hCt+BA2VD4t5n
	NIiCn2hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uouC3-0000000FSd0-19k4;
	Thu, 21 Aug 2025 01:34:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uor8L-0000000F4cm-0xpq;
	Wed, 20 Aug 2025 22:18:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 97A6F5C6880;
	Wed, 20 Aug 2025 22:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D540C4CEE7;
	Wed, 20 Aug 2025 22:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728296;
	bh=/JY0iqrp4JSe7nyCZ7qTFtuYchueOQZRK2oCJASh9jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTfP7tgNNAP8bsZydX8VBSDKuM65d5RZP+Iy/o8rQIXB+6ff+6A3oxKAo7SV2WUhO
	 Rv0yhlu4Pwr4auKLXw3xrIU0TwPgazkTmKPJgRO+vZ6o/bIThAXoylOqfipxn8mYlA
	 RXOWfcTfrKttn/5yb8TQMNllxa3pxkkRSZjuNt/sT+UGLyNcclUd30VklOjZTHOGhU
	 GQEMiIFf0PgnSiGPnloPDPhCrZlfcCI81BxzQbY050J/nocZgM/BUSENAO1Mdo6pQ1
	 R1UbpoPV3UjcpFL/UeUDgSkDUDGGRJDp7vHyHF6KhxEPtAp7BhQVlQsjG5v+h1HJwm
	 HG1gM6rgmCWfw==
Date: Wed, 20 Aug 2025 17:18:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>, Hector Martin <marcan@marcan.st>,
	Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@kernel.org>, iommu@lists.linux.dev,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC
 mailboxes on Apple A11 and T2
Message-ID: <175572829424.1511541.14649448626507633958.robh@kernel.org>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-1-65648cd189e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-1-65648cd189e0@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_151817_304223_E9CD5B71 
X-CRM114-Status: GOOD (  10.13  )
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


On Mon, 18 Aug 2025 16:42:54 +0800, Nick Chan wrote:
> Add bindings for ASC mailboxes as found on Apple A11 and T2 SoCs. These
> mailboxes are used for coprocessors including Secure Enclave Processor
> (SEP), the NVMe coprocessor and the system management controller.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


