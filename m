Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29551EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuMGlNdQ60JfISdBrpdtZs69hZBTm0iAAFTxUbR5vrc=; b=RMfgf15BkFy/3vrM8ovkLEsTtG
	6Tmr/8d2PMXi1EVDvVyNXRNDj0ps2Ui0rI1D2MzNshiJJs7DID7nH5akH43c+e9hZuYVmThqTTJAa
	9E5pgnSoW4ddaXpJcDQtzyr+N8mqXv8ecapQdbibj6Lopfr2oXanY6g0hUJe6vaclOCgASwzmHYj3
	Q4bJRJfBgl5nFX6nl7be4Dv4PP85O2DiHNxLQ5LZEU1Gpfv5Lu96Jwuy2Ehdwgt2rYGTOwEagmqVy
	Hp5sPBVj6Sq/7B9PWbNHgujMKBePkt7b8UlPCGqVjo559MZUpacTZpT6uNq1mtmeqJgmMfi5nSgYd
	aiypDMbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEAYj-00DVfT-1F;
	Tue, 27 Jun 2023 15:24:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEAYg-00DVeQ-2l
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 15:24:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 295DB6116D;
	Tue, 27 Jun 2023 15:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364A1C433C8;
	Tue, 27 Jun 2023 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687879485;
	bh=enwcVdJk5HN4aKLma7yJDXKxBhINfq5vAJYAMl4ZR54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wl+toTAl53C0XGWyAcVdXSYBK2ZvKTqBvt/rVSGLAMMnZy8a9Y9ZuvUHADPKe/gEZ
	 Ov+nmEq0R0zLUUUDnsctxK/4+b3aDfVdE45AeNT8RyRY7nScS2AUWI5iAGr4/iocqK
	 tcomgJvK9VSM5/AZDKD1g4U1ctQ3Bt7uTimq7F+DQ2Ve60ut4yldAx8Di3+XFA1gAm
	 rBJRe0SpuP7Cj5059+ncfAF8T01kbmb4T9dbka6aJ/vlwpK+7DJRVlMOKdUYNBDq9C
	 h4sj3a6K8NugCDeObEo0mQO+jx2IesDUMxv/c9BrHuh9M9ZL0jKglRpYtp4rJbGWmA
	 XH8jfUEMDnUsA==
Date: Tue, 27 Jun 2023 09:24:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-core: checking nlbaf when retrieving lbaf index
Message-ID: <ZJr/O8m7xx7LA+Tm@kbusch-mbp.dhcp.thefacebook.com>
References: <20230621092258.34678-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092258.34678-1-irvincoteg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_082446_933288_43D8D9BD 
X-CRM114-Status: UNSURE (   9.30  )
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

On Wed, Jun 21, 2023 at 11:22:58AM +0200, Irvin Cote wrote:
> As per NVM-Express-NVM-Command-Set-Specification-1.0c
> ignore the two most significant bits of flbas if nlbaf
> is inferior or equal to 16

They're reserved bits in 1.0 and:

 "A reserved bit, byte, word, field, property, or register shall be
  cleared to 0h"

So we don't need to validate prior to using these bits unless a
controller is breaking spec.

