Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C346EE49A4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Aug 2023 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IfJrA5Tn6w+vdt3XiqV2QN8XMtDbKOAYVmHZEZoc+rM=; b=3qFcVKekfxV9k5VsG+ciYsLL/n
	C6EtiIQLUInhNymJBaIwBE9bfgcX6Lf9K2fShj4zfb0yOH+aNVXx81lt0woWgD8uR4O4i6IFnpM7U
	l+WbYqROu/dO7uUAo/gyQYUyYHVT/v+GX/FDUg5uJy/2YUYAXmdi4sgEXbInABOSMbJJpN1xpPY+t
	wolxKWI0MQPS4v5sl7NPZY/Zsz45rLcAmh2x5/TPyCTqfMUSgC2vqMrAkuKEwMzE3kyO0ftqlBvWZ
	HGs01hC9ZS2udRVZud4PiB9CYmLUOLlTAMi7O3vUY6B5ehOpz+2J/eZ68CYar2AS0hjn8luJdoJyR
	d4Pqe2uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYTVi-00GNyd-1e;
	Tue, 22 Aug 2023 15:41:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYTVf-00GNxu-1G
	for linux-nvme@lists.infradead.org;
	Tue, 22 Aug 2023 15:41:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6A55C65B18;
	Tue, 22 Aug 2023 15:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481F4C433C7;
	Tue, 22 Aug 2023 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692718893;
	bh=IfJrA5Tn6w+vdt3XiqV2QN8XMtDbKOAYVmHZEZoc+rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAZGtmR3BE5k7K64Bubld3soCPKMdbwxLne53Y7qUUDTrlP4ZfVII3LFW8nlS+RDg
	 MVnvwOvyenG55h26/GcksFAc9g1vUDZCbZSulWEvrgb1KHKw+TNWvs7yzwlHUGnIPH
	 A8a8Mx1VH5ZRW/ixDEL63nNs76O3BEX+sce9aCGlKDMfhXewCKb0eC57MwJ0RPrYSQ
	 zTcrdkO0Xixzwyj7ykbx7mtzTYejvoXwpoSgydyGMJL3VpB90AW3jE9ZG8mkowj7g7
	 0Zf785wcOKV7z/EBx71jPYePigaMR+CHcejEyACG8IPrOCVLyMX7EZjfwtccuidE1g
	 37V29zKbR+3Fg==
Date: Tue, 22 Aug 2023 09:41:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nigel Kirkland <nkirkland2304@gmail.com>
Cc: linux-nvme@lists.infradead.org, jsmart2021@gmail.com
Subject: Re: [PATCH] nvme-fc: Prevent null pointer dereference in
 nvme_fc_io_getuuid()
Message-ID: <ZOTXKg17/oC2u8kB@kbusch-mbp.dhcp.thefacebook.com>
References: <CACnqm78ssvRVay=Q5mPhsZaWvu5-LxASKs2Dv86NiVgGXytWoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACnqm78ssvRVay=Q5mPhsZaWvu5-LxASKs2Dv86NiVgGXytWoA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230822_084135_494156_1E7D4162 
X-CRM114-Status: UNSURE (   6.78  )
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

Thanks, applied for nvme-6.6.

