Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B98CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUI5UO2tsUl4RTTXkHWwvjoSvDZJLKL4A5KNtnNdJ3w=; b=TZjnWPgOtaLp3cYvweCBGW/ckX
	Ub7elaUZB6F1HH/5gKCTfipFgIQSOC9wx7Mt8D45rzze0BlxnhziJpuXQXaball6wJSFK95QlDXPA
	NcXLdDeHQs7LqaQ/swN4VPr6X8gqvZpCVRxfbSOquOD70H4fuMyxeZZY1ATUu3gsMihSVQaAyyGGY
	ee2OxAKNEu9TK5+R3mGKdnY2GeP4WjMCgxCkMRBFWyW2lhc9H/UtgTZvf8bz2A+eWhgNXxqpwRudz
	+Z3mZ7UAV63cOleIJswUFNgMh3iq/ODKu0U+gC1IypFqmnXKBWbTNrxv2+VBm29B3uspqSIinEaGB
	FQPBMuvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPUU-00000003MMG-0j09;
	Thu, 04 Apr 2024 15:59:02 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsPUQ-00000003MLD-29of
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 15:59:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 96F7DCE32E3;
	Thu,  4 Apr 2024 15:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89366C433F1;
	Thu,  4 Apr 2024 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246334;
	bh=kUI5UO2tsUl4RTTXkHWwvjoSvDZJLKL4A5KNtnNdJ3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnacZ6smp/seoTpT6+y9TWbCgAj7+XkgaVmEGKSBwTRAGFNyjbvlThsZ8Jjh4XODs
	 O2lVm07khEQlg4kI3wQ1Eh7Kh25yw9p7IY8DDfrs+rXFwV/gFprVwmAulLrNdVfv5h
	 sRPFQx1cA8dwipuVrAagxqE1Yfd4n/A+AS7oIwW5Nh4QOIWfqFQuOrcmLy/5uhZfPA
	 g9RpqwLGLPhG/M4ZlFOdFb7fQOUf+EDjRoDJGhXa6gymVg60Fb0DdOWAuVyau3HDYD
	 9zJVUBDNhQ5T0u2962InErfbz6fzKRV4gbDyD4N2+MDsid8Haddzu5xQSKZzUVT3yO
	 1EOerA8y7COkA==
Date: Thu, 4 Apr 2024 09:58:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv5] nvmet: implement unique discovery NQN
Message-ID: <Zg7OPNrrFSxMCnMR@kbusch-mbp.dhcp.thefacebook.com>
References: <20240403113114.76342-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403113114.76342-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_085858_837980_B7FD1CC6 
X-CRM114-Status: UNSURE (   8.64  )
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

On Wed, Apr 03, 2024 at 01:31:14PM +0200, Hannes Reinecke wrote:
> Unique discovery NQNs allow to differentiate between discovery
> services from (typically physically separate) NVMe-oF subsystems.
> This is required for establishing secured connections as otherwise
> the credentials won't be unique and the integrity of the connection
> cannot be guaranteed.
> This patch adds a configfs attribute 'discovery_nqn' in the 'nvmet'
> configfs directory to specify the unique discovery NQN.

Thanks, applied to nvme-6.9.

