Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CAAC5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 06:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HLKQ79p3olN3bsdwYX34V1he+9DMMXG9cYCRoYajaQk=; b=RJj/LjZW/3L1t095h9/0uIN17B
	glfY4Ey88QOENUH+vp5xd17tqyR4f1EmDkdZ4Xx9SBclhn9j95XxoK05DkntABVE7dtm6Eg/DC41U
	3pier6gCq255d1cFLqXY+aAv7c2l8R7SQw4+MPUGsiuIb/lpSCeK6KbF4gxtdluZzRh8y1DAhISl+
	hY+kanNh00tkM3ryKORlIcQbksnrXMAyUf36iTRu5FX2JsD5+y4f2Jcs/JlDIugfXeOKHZXxyC1xT
	+wznFjhHHO9nXvZ4SQuflHGGlZo07wFGi7/PmqUbCXGsIg7h0cWndvZhMV6hzpwnU+yLEvQ/XzFF0
	ZVNQetsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrIj-00000005VbV-3kCF;
	Mon, 17 Aug 2026 06:58:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrIh-00000005Vag-3HAw
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 06:58:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D5F6B68D07; Mon, 17 Aug 2026 08:58:23 +0200 (CEST)
Date: Mon, 17 Aug 2026 08:58:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, security@kernel.org,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix NULL pointer dereference in
 nvmet_execute_identify_nslist()
Message-ID: <20260817065823.GD16255@lst.de>
References: <2026081423-enlarged-dribble-10bb@gregkh> <20260814190022.1531236-1-kumar.shivam43666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814190022.1531236-1-kumar.shivam43666@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_235827_969069_3E3862B7 
X-CRM114-Status: UNSURE (   8.46  )
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

This was already fixed by Guixin Liu.


