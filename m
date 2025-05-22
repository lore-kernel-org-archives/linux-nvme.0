Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A99C54756
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 04:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97ruOcxigrpBRwQGdKQtJ+Pl/tpRdk9Whg+hn7cxaFE=; b=A0Dziq2QOoe434FY/PXTcLOCTo
	S+Zv4hyeoTTt8UM+AeWKaWvnBt3Z5kT8zUWb3xqajygAroSGq9CP438BacvsyrxZHSisDscW7usl4
	2QNbdsJNj6W5zQa1vhSxEyLJQth3/OGO3WoR4tsFxFDP04qvkULKv547yqdaiQqAkEB052GanImpE
	SfUaMLWa62S4s5WjitfSnbxpJeki0OahiU5a4HoTi1W5In7dp2lHtpe1CyDty5B8wPk6+WF2C4aQQ
	uochqAupMUnWcjGow5sD+pP91RRBQNZAvHrHgifkxD9Mz8+gZ4kZaM3DLQbGjIZSb9pfMbzkj4jiT
	78Z+oc1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHxZF-0000000HPbl-2rMV;
	Thu, 22 May 2025 04:30:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHxZD-0000000HPbL-1HM0
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 04:30:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6DEC45C47AE;
	Thu, 22 May 2025 04:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B7AC4CEE4;
	Thu, 22 May 2025 04:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747888202;
	bh=97ruOcxigrpBRwQGdKQtJ+Pl/tpRdk9Whg+hn7cxaFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzC84e8n7qnFGZDCleQl2m0oHjiCWVStb4iis69dBCBEb/HqZ0fHXF16IZwEaFyNf
	 B3AJ29YtNOh325PswiP/byoS5PW3gPIyTHYjDCMYKjSlQ3vNjwpwoRQqNINA91Trx8
	 ygKISCTaPI6HWWSwyCWra5IS7iFet/1GL9SAuWdSQC8lCHrPSfElNlnYdGrFswFsxV
	 KVtPQa0TxRekTxnC4JnwwnGhwNVtCVr+0rOHTjTc3ACjXw1Gmh9AH2TpCWc0EOmU8c
	 XjPseF1QlL3oCbC1sliBfF5bGS5til/PysBKqrKSmHe1kthauL8UTq2L9j70R3T9wf
	 Q0tcr1DtSTI0w==
Date: Wed, 21 May 2025 22:29:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aC6oR90OFDSITndh@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
 <aC6Ymfrn1cZablbE@kbusch-mbp>
 <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_213003_386032_C7616E35 
X-CRM114-Status: GOOD (  10.38  )
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

On Wed, May 21, 2025 at 08:41:40PM -0700, Caleb Sander Mateos wrote:
> For the record, that change broke Linux hosts sending DSM commands to
> our NVMe controller, which was validating that the SGL length exactly
> matches the number of data bytes implied by the command. I'm sure
> we're in the minority of NVMe controller vendors in aggressively
> validating the NVMe command parameters, but it was unfortunate to
> discover this change in Linux's behavior.

This is a fabrics target you're talking about? I assume so because pci
would use PRP for a 4k payload, which doesn't encode transfer lengths.
All the offending controllers were pci, so maybe we could have
constrained the DSM over-allocation to that transport if we knew this
was causing problems for fabrics.

