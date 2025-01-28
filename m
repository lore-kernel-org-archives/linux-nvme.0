Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217D8C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 07:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yj34cYo863+RJaPkG/UOHs0SUzSCmAwHQEvZ8tTEM1g=; b=4tU2XDrjOe3NA8Hassqsx1tJka
	aQ6rh1W+p7z78gR7OozDTasfX8ZenqMidojlMx5gVZxCim598sboGR4RRCgXh6jm3x9IFLqXVu5OF
	RZiw4YMWbvEIBJM7cUEXIybxG8ZmnWOAi6G5kpKg4USt7xH8t3V9KKOGuchOGnyQ6JXuDR0pPTdXB
	j7MxLzNO2qEfVcs58odrFNTqbH7GooRXwVALgmHnM/gtZE4ctoMqZQVN15zA9qH5VuoqyxeKr0gli
	oyno/+76Nfz5QATcnJzp6nHGnTW0bpgREKR7Um4NMRRQzEYpDzcLEFoVfwdBzWFfm1RQ2TSEZxPx3
	+XvAhHuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgRk-00000004JCp-1XFv;
	Tue, 28 Jan 2025 07:55:44 +0000
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgRi-00000004JCc-0bSW;
	Tue, 28 Jan 2025 07:55:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: endian fixes for nvmet
Date: Tue, 28 Jan 2025 08:55:32 +0100
Message-ID: <20250128075539.693870-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this fixes two endian issues in the nvmet code that were added as part
of adding the PCIe endpoint support.

