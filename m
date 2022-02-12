Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC3AC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Feb 2022 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fhVf8+Lia2/Xs3BEIvYba5FT8+bR5eiB5GFGNVUkP3U=; b=PjWL4KA4afU9JQuYLxTFxBIWZ/
	qSkkIlEN76l19NWPkdWrEfRvNN2VBmKw2HeJkHgTJhxjSe9szY/43PRpqFyduJP9Zet0bzeRHmXMw
	3AXYCHZuXdzhTtoWGh2wFyeTZuS6SnogdJFAStAjao4fMIuvbfNK559TGPqDMC3BFT9f7vAOarMh5
	9Yr9/sL3DptiacMgx8py+1sJzasp5rwmaTiOlqvyRzogewDRGRz6QM/a4EkThC9BGy9Dxcidkw7I/
	uFYBLc1jCaquWX9dGaijcm6zQuBCiStzFG6un1xlGhTJAU9LtRGvRDmABAtCnkkX3ITNiU5ioUM8L
	82R1sF7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIzqg-00AZWQ-NY; Sat, 12 Feb 2022 21:22:30 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIzqc-00AZVy-Ur
 for linux-nvme@lists.infradead.org; Sat, 12 Feb 2022 21:22:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 401B1B8015B;
 Sat, 12 Feb 2022 21:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8974FC340E7;
 Sat, 12 Feb 2022 21:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644700944;
 bh=T9jihpyLX361fDMFkQmgE9KTfhDxXKFQkgmCfKAD8GY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e2NDlEBOnGWupDACb4a2vjapjSj4sPs0jL4EJYKO+29YtA3v+wNbXi2vu/UbNokBl
 pp1zrP+ROjcV0dHT5kgxyq3SmVqiJXtFtO2uS9NuS2CADhy8DA4Kxoo4hQgZhn07T2
 VrcUffv7NUJ/yQd3XcHKeLhcz6eW6YDjTebmCUk/HtFIL6QPleFO/PGx6sXF4f8XsD
 HK0Ls02P/8JJxPY044HZ2TZXuPuXLQSsZJVVhML4TFlCpTQk4j38/n7Ulhk6gftOgw
 iDYx9IAnGGS3WA/gEGG5NMB9vXwc+LoUIGA19EkWgQhdMm9hUI67o5DbV00mdKOFbl
 xBH9e5tgceUSQ==
Date: Sat, 12 Feb 2022 13:22:21 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-nvme@lists.infradead.org,
 Prabhath Sajeepa <psajeepa@purestorage.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Native multipath across multiple subsystem NQNs
Message-ID: <20220212212221.GB1660900@dhcp-10-100-145-180.wdc.com>
References: <20220211220714.GA370236@dev-ushankar.dev.purestorage.com>
 <20220212063422.GA16561@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212063422.GA16561@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220212_132227_184514_70E8BA31 
X-CRM114-Status: GOOD (  11.27  )
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

On Sat, Feb 12, 2022 at 07:34:22AM +0100, Christoph Hellwig wrote:
> The answer is neither.  The fact that NVMe with ANA required namespaces
> to be be attached to the same subsystem is good and important.
> TPE 4034 is retrograde and completely broken in this respect and should
> have never been ratifier.  Please fix your storage system to export
> virtual subsystems like everyone else and don't break the nice NVMe
> architecture.

If anything, the driver could check for duplicate namespace identifiers
across subsystems so that we could warn about or prevent exposing them.

