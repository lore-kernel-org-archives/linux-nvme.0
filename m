Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFDFE71D4F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WBg17QlwP1XG7gsvtIT4DFsO7NOqEybJYfLcinSGv2Y=; b=AIKP49rPJ0n/ltw/B/lPjKUPzs
	R/MCtf/wmmhSGjNWNZRYdz9uPSZ8fSy8TDVxj3KzNVDKG+Jymu4I7I80EBvQ06LCoKykPjkxlRc/b
	TcLY5nTmbWkiWun35nOmCPkJL7PBH9QnjbattDTAi5QTm5QBf0ga5ah6IYcVWStnjtgP6/eBK1SE5
	n5U/W2ylxNxCTbxSqxiMvq4BkV42ycqjdkv7F748qoAaiRZJw81UChFMOSlGBdgRv50gsLEI/+Uy7
	MXcZ6Nvx8AGR3S3zhOdnhHBzoMt0A8im2j2lj69xdB43dnqrg2H/jwXxTExuwxo61NosEZhmksDW1
	Qohs7UBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoRYq-00482f-2G;
	Thu, 05 Oct 2023 16:50:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoRYl-004812-02
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 16:50:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CAB1F61A1E;
	Thu,  5 Oct 2023 16:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA01BC433C8;
	Thu,  5 Oct 2023 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696524645;
	bh=WBg17QlwP1XG7gsvtIT4DFsO7NOqEybJYfLcinSGv2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iM3vk+xNCvXyqybfEp8H5I+NbN6ViQsDGGGEQgOJsqIch+B/6ETlkMiGOFiMT64ZU
	 fU/iWlkmG2LZWl4GUomKQCSRaTxr9tN1ysh5vCVn9Sp3TBE81EJdDCs6PqxlagK7CY
	 5BKCHZNPdBkDJTrSom/t0P1C2fA2k0vRb/++2y+w78QHwpTKS5SJYtUQAquingCaxV
	 LN8bt9A2fcJsdMipasgb1NCDoJZGn4VcXThPLS9L4Ehdq1v3nreTKxypkozyk8QaWb
	 rQoIeCom3gOtbzctuFszMJh21fakDQazGARzyzZGcbOvvtAK9W6L0rQ3Pq5R1S5GHk
	 BrvGpsZDYq8YA==
Date: Thu, 5 Oct 2023 10:50:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	zahavi.alon@gmail.com
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Message-ID: <ZR7pX78cnhIa3zT9@kbusch-mbp.dhcp.thefacebook.com>
References: <20231002105428.226515-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002105428.226515-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_095047_089126_B1D24A05 
X-CRM114-Status: UNSURE (   6.36  )
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

Applied for nvme-6.6.

