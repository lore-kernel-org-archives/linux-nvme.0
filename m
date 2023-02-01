Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E358EC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=BQysvqaleI6Hs7fbrSfnHkYWZj
	ir1uB5aWQ8gdJp0dVdzLATakG798QzEozLGVHomqm/3VSQthHToYN6GP6/qMpAdbj8x4J4R2tXBTQ
	gbPI2GjGa5KLyPy/wFolIh4XKIigUf65V1w7+hd9R6j8Bh9/cG/j9W1i5w2dTx2t2xBh6jmMS3REQ
	Y0t6xr21cOVthzt4JDs5sgFC8JuwNrUfZuaJnLHbLqPcUxtzASsSnvN17yQvEfe63CyMJN9ohFkbC
	EzHth//yEk+hxYu20LxJl77Nl+2LNj4q8G1S1/lMWeChr10yalGxRrOOi7EOx5yWkwdDB+gJWM95X
	IYcKndpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pND2f-00C15z-BE; Wed, 01 Feb 2023 13:20:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pND2d-00C15J-2j
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 13:20:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D48168AA6; Wed,  1 Feb 2023 14:20:44 +0100 (CET)
Date: Wed, 1 Feb 2023 14:20:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [RESEND PATCHv3 0/2] nvme effects handling updates
Message-ID: <20230201132044.GA31561@lst.de>
References: <20230127165620.3487918-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127165620.3487918-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_052047_266608_B5B0514C 
X-CRM114-Status: UNSURE (   7.89  )
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

applied to nvme-6.2.

