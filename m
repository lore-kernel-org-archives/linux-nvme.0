Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED1606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wJrdWa62;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PagCPc1K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Unsubscribe-Post:List-Owner;
	bh=7xOA7/MFtPGvMkCRzH2IZM+Zp+q2YHj/nln8ZoTRBwY=; b=wJrdWa622F3BYsFnl9XN7rlzqR
	O/sEZmNnGtcIKJEQEH0wvdQA73TgmqBxrbTzhwIp/yUSUA2BD067aG2tnwRexyTFYwEKk8s714CHC
	bcBGJSbs5HZ+IHYR7UNfvgTeCO63RZedK1Z+mq35SBDXZMPhQT3BOnejCjT9VTGuGM0HPJKeQF9PM
	rQzIu6bQmzaF/RSpCnwlw/Q+kLUAYuqTYY9d8qMbhF/uiHowNDczIS+J10Y+f7fasroxRSbBvSB0y
	THG4ipfkLWJjSYYXdEcRu1G1fg2e6AuVBo20J6XUQjrmR1G5EoeeTax3zDoA8rOs2rJyKNCrtzASt
	cP0XewbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Kr-0000000AOOJ-3hwF;
	Thu, 05 Nov 2026 19:41:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Ko-0000000AONl-0KBu
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 19:41:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D1E741293;
	Thu,  5 Nov 2026 19:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CD61F0089F;
	Thu,  5 Nov 2026 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907677;
	bh=7xOA7/MFtPGvMkCRzH2IZM+Zp+q2YHj/nln8ZoTRBwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PagCPc1KLJLvqSP1ak2XTtOPSr3K9Q5Ap2/nOehIHIEciNiB8UdpA5afRCvNwzLH+
	 9EgbfaeT61Yqk6r+hWYx7RTy5aa35aam1ySzOL6dKjUN1CicPkZFkQC0ognTOsud0/
	 4MM1q5mqwz+5na33Q5pThHnO6dPG5NT2b80JCa7/qHdLEIde0gdnEqZQh/rWIVioRP
	 1NzPcag3YCPc66Mxx95xh4VjFI4uS0+80hwkVqvj8V4u7IuJgk7vtAEA9p/loGt5qi
	 kszJsuHBMOqZrPhPL/yA8DsE04t1jXsuF+dqDe9tuGl4Ha5HFZtgGrGnsCeFmVPxBq
	 SowR5BhKazQSQ==
Date: Thu, 5 Nov 2026 13:41:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: tglx@kernel.org, bhelgaas@google.com, maz@kernel.org, lrizzo@google.com,
	hch@lst.de, changfengnan@bytedance.com, namjain@linux.microsoft.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Message-ID: <20261105194116.GA1553387@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105182706.3700908-3-kbusch@meta.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 10:27:06AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Skip the read-back that flushes the MSI-x mask write. Parent domains
> that mask on behalf of PCI/MSI keep using their own irq_mask().

When you respin it,

s/MSI-x/MSI-X/ to match spec usage

