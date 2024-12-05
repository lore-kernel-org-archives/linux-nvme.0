Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612AEE7716E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 22:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sL2ihAgysF5aJyheqYlPWta02Y2KFfiRZKyhO+vYFPI=; b=vZX0RzYlFUGyUJQWitpHwlbuF1
	txsScOTz5Dw1Zy/Ltk5P3+3gnlyh0VMeTBBNc6CgUN/1w+olAN92sBIlyBufomVfJixOpI1SUlY9p
	Zn2IIl/8oqbWqomsEm6SwlMj1iM6CWV7IECU8BLDV/yOTd75oVIeuKAxGuQEhzwmrg0cGkg0avvdU
	OWu8eqF2Jvw6hMcAUrHK99AejQ/wU29ugWrTqLRdHfYDO4RzRhJVTDDcYJvGWu9lPMiPKbXhmtX3w
	s8mI7v5v5hHueXol8ShHqa4KixB3d13Vw4nMdYFOYTYug8jC6/bBA7TetC+aBIdZzbHmcphUL4R2X
	kjQsavcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJJwB-0000000HRpc-0Qf4;
	Thu, 05 Dec 2024 22:03:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJJw7-0000000HRox-3iIf
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 22:03:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9976F5C61A1;
	Thu,  5 Dec 2024 22:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54F8C4CED1;
	Thu,  5 Dec 2024 22:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733436182;
	bh=d+UCtLSa+055hfySG3GTEQEi131xlIBPoVRMayMtx1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtwVcCObFQlNFLPp0O7igo0/oPO5GrCfFs8mYuVLIA5lzaFxxgMBEZrxIxCSefqm0
	 rn2iu1VpJd9I4dEJ9HX+6o2psGoFIV21fwKNf0F/7l4EewXFq69NXRzwx2gDU4lUMV
	 brbhXjZbqauDCKM7s5LoTDrBuNNkKmNSty+zFYRb3G2rHI8n+emelxbcy6a5AlSoOh
	 ClBtGj3B6K2awFT55HgxG7Nbz1Bdqn+5QNp0aHAEnnXF/vHSZIOV1UQ5rRc2LYxNnN
	 n5G5Cl/2mH6Lzs2FhUONXNEnJLKNd6XJ1bz+9J0UdYV8v3xz0sKsT9n5em1mBSvf5v
	 Z81PsrALbz3+Q==
Date: Thu, 5 Dec 2024 14:03:00 -0800
From: Keith Busch <kbusch@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Robert Beckett <bob.beckett@collabora.com>,
	Christoph Hellwig <hch@lst.de>, kbusch <kbusch@meta.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	sagi <sagi@grimberg.me>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Message-ID: <Z1IjFDWwAonRI30D@kbusch-mbp.dhcp.thefacebook.com>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org>
 <20241029074117.GB22316@lst.de>
 <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
 <192d9b75f76.106d874861279652.1491635971113271140@collabora.com>
 <CAPUE2utp0qOiMRNPwtn_gF45f2awa9UyNJ91zmpRbtu6zR5p9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUE2utp0qOiMRNPwtn_gF45f2awa9UyNJ91zmpRbtu6zR5p9w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_140304_026902_0FE46AAB 
X-CRM114-Status: GOOD (  10.05  )
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

On Thu, Dec 05, 2024 at 01:53:29PM -0800, Gwendal Grignou wrote:
> Since limiting the queue depth to 2 is only needed for a small subset
> of eMMC memory modules that can be connected behind the bridge, would
> it make sense to apply this patch, but add the kernel module parameter
> mentioned earlier for impacted devices?

I don't think qd2 is needed for anyone, though. The problem sounds like
it was root caused to a boundary condition, which is addressed in a
different patch. But I am not 100% sure, as the thread was left hanging
for some external confirmation:

  https://lore.kernel.org/linux-nvme/Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com/

