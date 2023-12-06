Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DFBC4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z/dah7mjRBbfDLfn1kOrnaJ/D2wX2NkTjttOGk959V0=; b=i8sWLXLtKrhJTXBpnBMFon3MBg
	ks4jwUJvXFI/mjPiW7RC+0W77nein8sdUAfzImxH8YusU1RjTiXgHI5B5Yr9S2sL+WOqIsvkKW9H2
	vRNxv05/sb8h6G/NxHRTu3pVkKmftIip+uNp6yup64ube2rXikkAANt5I0bcZqWoar7FtGXvvue8Y
	E7sjmcnO1Mi9yQ5yLWBx/9X7Lm2z4yEb/jL9Vjl9T4eYUBgPkDOc8QD2KWAfjDHhNaYkMZRVDBdhz
	aRPA/9EiWPaSOEyROZSWZj+5lz47YhajLBDXQ6tWMqEzm1Jm3r8YlCjpQ5U7I0ZoShnNGj5zJKKcI
	IXpVwMSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB1Dx-00BTKw-0r;
	Wed, 06 Dec 2023 23:22:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB1Dv-00BTKM-0m
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 23:22:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DD865619B6;
	Wed,  6 Dec 2023 23:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A4BC433C8;
	Wed,  6 Dec 2023 23:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701904953;
	bh=Z/dah7mjRBbfDLfn1kOrnaJ/D2wX2NkTjttOGk959V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5c66RbcagyFjqBN7MOgcdts41ewYkvrkD0fm+4VUGBVieE3euGk/AFuIGselQdu+
	 dh1DP5X51/swufMwZHosHYgRIvthzXyVCMaFl3px1HSapT8nqHXinkXCzQ59IEU3/6
	 wwwmR+4x+djSLX/RDcoOJOILHEQMwmZTH22m8L3ZvW1nIDT+jPyy4eNet+GNA3S4Tu
	 6RUnOH2Xugh+3eaRWFq+Cf2eck/U5VS+tAsjQNLJTH9rSTYFsEUcq71VVpvTjFu28R
	 Y21324R18Sse1Zz/Z8pcACHPX6145SWWv+IiFMuS0BcMLHoixISGrnjyMG7WYxYOl/
	 aIcTM5T+xq79A==
Date: Wed, 6 Dec 2023 16:22:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: introduce nvme_check_ctrl_fabric_info helper
Message-ID: <ZXECNqxv6Vd7ttl8@kbusch-mbp>
References: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_152235_325739_CEBBDD3F 
X-CRM114-Status: UNSURE (   5.70  )
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

Thanks, series applied for nvme-6.8 with the minor style suggestions for
patch 2.

