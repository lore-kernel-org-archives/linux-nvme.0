Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0ABC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 00:59:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE16E2067C
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 00:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE16E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ecQVqMZWLp5+/e9+7I/ATnuM+ayJcxwcmluO6SMEk8o=; b=lxMnc/pwocjIKwhQasQNQExWc
	dR/3XL959BS8N78qCUIO5H4Kqru10sbN5OOhCRsIfhRBozNAJI2MiPjsFIS7t4PeaX85rggZuFC1W
	Huh5sVtAYkpsncqzrNJ9vZFks7niZ6IHhe10cxZH1oO4zEwACe6Qrhf8GEW8C+mBcIIUK42Jndz3j
	4Ps6J0/rMsd04ZGzmM4qevpeaqdRmK6lJ3XcntT45nzEz7LhWStHBcY6FVXas3APyJeZcDWq5fwZu
	/ambOEmu4QlZ02VilYyxxqTjth1/FpJn7xMqqCcIN9E7/T1xESgko9MSaBNLf2g94t8YcOti3rrO1
	DGf5QS0fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4ZBN-00066D-7u; Wed, 27 Jan 2021 00:59:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4ZBJ-00065q-RO
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 00:59:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5571A2067C;
 Wed, 27 Jan 2021 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611709175;
 bh=XmUS0xEmHV+Dr33XBTNKA4YdHNOz5NV4OWH715bBNO8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GuYBN3itwyiPNpTHOqND46oNzhXTAvFxQtWM+0D/QOcUEQpSWZvn0kQzhOg47oOGQ
 Rk/kqksSqeIvzIOz18hv8sJmyb7aw65X6nx3Y0OfICde3uj+MxqW+SyaV5QvW/jB/i
 JJ/vNGJDOnu5uP+F4nOgamCrUbtnGFV3DOBJS+Z1ic1GnPOXOoNcH9G4/Uj89GwaL9
 6iTHw9YIeEGGIlMEojtMafO9MKQ7RrRo/9nto1hOXzBWQv0JDT9cUu6xgGLBc+tUUW
 ZAR72eYFQ7fbiZuCMlewEseyZkUfKd7YPhvODz0WKLcCzJKKKzlpUp8jCP7alq7Grk
 dl2UHMKd/Wx5A==
Date: Tue, 26 Jan 2021 16:59:33 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-pci: add write-zeores SPCC quirk
Message-ID: <20210127005933.GA1816249@dhcp-10-100-145-180.wdc.com>
References: <20210126051916.3271-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210126051916.3271-1-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_195937_947812_05C8A0D9 
X-CRM114-Status: UNSURE (   5.79  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: chapman6235@comcast.net, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks fine,

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
