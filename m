Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0168C072A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLZYvTpofVozE78Vf4RCc2PB9rKUFxk/1zbWtvSMpLI=; b=beRfJ5f02f2iQplo/h09QdLtHZ
	/bRf3/9uelr8Q9MvPA38NqS/Jbxe0uf3wQnWr7MX3//2tU2OAzN8EtTegW57IYwf4jAUzj7vIcrAL
	6v1g7Qn4YlKaYxBCU3DIiHGGwcFQ15MHT/lBCZjzdzP26QqsQIv9KE0REyXOlPHblFh6Ux9eNAY3+
	pRthd+Ap8S13bCeZGzliTceVncEk0PTAtssdOtfVj9r8XweqajcoELGIJybLcQu1eWzhwTadt8874
	kiBzXHxaYJFIyU5/dFeKMj7gorRkJMq2cLOWCpPlgODekpUMYZhg9o+by/e3XP8u+q9/03KvIo5u4
	wcYdRkuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r428c-006yng-1W;
	Fri, 17 Nov 2023 16:56:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r428Z-006ynH-22
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 16:56:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 03E8BCE246D;
	Fri, 17 Nov 2023 16:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C16C433C7;
	Fri, 17 Nov 2023 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700240168;
	bh=iXWU5jW65riQyP+nobR/SIooCAIn2PVXa5nkmQKRMaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W15PIWS16Pq2X+zzA7KDmWcDg4tfWMM/5roRs/DqktsKRotJKNOxE22SkCZomB7jy
	 TBXZ4dE/wVI+tWCAbFe8lY27dnxdI6WqGTZ0NfJVsz/grmjbESeTW/4NCz4rzZ0cPv
	 dOD7jfvC+VITP3AvfXTXHra3NCGZp3rIbX4R9K4On1987kxcr12EzqBbanOFBMpBv2
	 2IPMCKJszY12Q06gNL6VPjfT8fKCtxCg18m5ZfYP1r6fVCbgyNgGbQay2UTOAKfFTd
	 XLe3oSMBYIZCEo8h7S9nrxRNDufRxZ88kEGXxqBHtZkWvXb3HDg8R+YgHQ2ZEq7pEl
	 eFMnB0QcD2zgQ==
Date: Fri, 17 Nov 2023 09:56:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, zahavi.alon@gmail.com, csander@purestorage.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: nul-terminate the NQNs passed in the connect
 command
Message-ID: <ZVebJdEkFRnwdRZW@kbusch-mbp.dhcp.thefacebook.com>
References: <20231117131336.126505-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117131336.126505-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_085611_901373_5B37D4B8 
X-CRM114-Status: UNSURE (   9.79  )
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

On Fri, Nov 17, 2023 at 08:13:36AM -0500, Christoph Hellwig wrote:
> The host and subsystem NQNs are passed in the connect command payload and
> interpreted as nul-terminated strings.  Ensure they actually are
> nul-terminated before using them.
> 
> Fixes: a07b4970f464 "nvmet: add a generic NVMe target")
> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied for nvme-6.7, thanks!

