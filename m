Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2CCEB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKPR35bFhfyeenSLoFSjzG4nRDzQtHzYkkzYMlMm9/Q=; b=djHFsUqYWL7PeHNDZ64QFDK1aM
	vnu3WQkuL9dAf8U7emNDUrnM/DH4R3bEvNYmqnIh0eXMOzR43Pie7NEtM8hi3ZfEdpPXwVxGCY1kP
	MT1GkiVhMBq13HOrPXcBv0nSN4Fqyu2BaVt1kyEL//ecbHqG7i4eo1Kx05t1eO4WIH9HElwAgqPWE
	mlMIkbR5+fk5mqS5+qbGoHh6y1MEXetRUAkdHPcnt64KZKZFckGGVBpwnvO4/vrEN1RE6OZwPQ7/Y
	czvmJkbKHl6RlhQFLg+bZ/YcZFtyakLqAR/7S7qVvPPqarLG6t5DAXbABydz7kpJnvI6f7tI2zCUx
	mifdNtng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEBHJ-00Dbf8-2q;
	Tue, 27 Jun 2023 16:10:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEBHG-00Dbdm-2a
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 16:10:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 275C2611D2;
	Tue, 27 Jun 2023 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4024C433C0;
	Tue, 27 Jun 2023 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687882249;
	bh=2aOnkNNVe6yhqp19uUA0sWVcSn4XTIaNZ6lJ4idUO/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ni4544vdzZ9f+x8R3vSLZBcmkDQhC8cvvIPCUPilWV2BPAKNdrMEzIQKM1hQFZtJ8
	 Upkpdc6tVA3WJDyh2hg1hvWFtr+94TxKb33s6lHxCZNoGIO3SXeddpkgFHUCdHzBk+
	 PJhK/tw/eLWeiIWAqTWMfO0ikVuzk8JN5ARd0vFKpvmdp116CNjA/6CRiiALDxYeVF
	 4SUzObr6CK5oJ/aUJFa00lExqjOrqJNPsxfnv5AT1rw6XUusRA70tLmvWeKfpvSF3B
	 anObYKVsdfZbv8/CMHvbIVjm8iHVDrDlFXdCL5BekgN0LNHuick2x60k+Gz7r0is3t
	 1jKV4oQHSuQEQ==
Date: Tue, 27 Jun 2023 10:10:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Clemens S." <cspringsguth@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_091050_878431_A4286123 
X-CRM114-Status: GOOD (  13.81  )
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

On Mon, Jun 26, 2023 at 08:15:49AM +0700, Bagas Sanjaya wrote:
> See Bugzilla for the full thread.
> 
> The reporter had a quirk (see above) that fixed this regression,
> nevertheless I'm adding it to regzbot to make sure it doesn't fall
> through cracks unnoticed:
> 
> #regzbot introduced: 86c2457a8e8112f https://bugzilla.kernel.org/show_bug.cgi?id=217593
> #regzbot title: NVME_QUIRK_BOGUS_NID is needed for SAMSUNG MZ1WV480HCGL-000MV

These bug reports really should go to the vendors that created the
broken device with non-unique "unique" fields. It's easy enough for me
to write the quirk patch, but it's not the ideal solution and may harm
devices/firmwares with the same VID:DID that don't have this problem.
Not being the vendor, I'm not in a postition to know that, so CC'ing
some Samsung folks.

