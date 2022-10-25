Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01B2C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=2wiPHEm7LPvl+lesH9k1xjwdda
	qZdTbktJdDjJRfQshMENfL+fDR7MQuy3r/MFpoP0cQJSI1hdXs0LV9D2KBFRAf/kHosdj5Oh+MGzz
	4be3F/Iw4/PnXSJw6TDl2nrCTObPu/jvx1dGow57/gmlwDboRPLu23aCEGfd0lJ3xBe06beDP0f10
	E4eWxxFisNiiwcy9fZJtpkbrEcT8NRpz1gh2HxpMGwgD2cQcxM00yeOid5NsPqWrJB5sD/uLZ0PRo
	/spdffzxuNeSG4D3QGQCTMjbl7G+NakhTW4PGLE8zt+rGM6Pc7IWtbn0X5Lu7fgsSOvb3COY27/mQ
	9F1MnJCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLa9-0060oX-8C; Tue, 25 Oct 2022 15:11:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLa3-0060km-DE
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:11:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 538C268B05; Tue, 25 Oct 2022 17:10:52 +0200 (CEST)
Date: Tue, 25 Oct 2022 17:10:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nam Cao <namcaov@gmail.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Message-ID: <20221025151052.GA22870@lst.de>
References: <20221022174635.15643-1-namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022174635.15643-1-namcaov@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_081103_636081_D6B63851 
X-CRM114-Status: UNSURE (   8.38  )
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

Thanks,

applied to nvme-6.1.

