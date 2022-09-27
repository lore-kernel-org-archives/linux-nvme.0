Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F14C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 07:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=lzjkLaujqKyos0cQgUFkgSA+ah
	QVxpimDOT8/L78q1ih67n5ljI3fFHNg60lX3ZNgh/nyQEfcVN6ArQdQLN4d9CDAmH7ExEy1McpPED
	WI+CCL5M4GkaL8mf0SAwabnTTjUk2OnVHjorpOZBaQ2dbn2MS8UM8jDRflTeMJZOs6bR0pNcWhZyp
	YCGqtIp4ABQAeMaPcUdoRbPB5KSm2ZHeeVXgsPnmYu1VuigcP32ineDjTpJouYosZ5gcsStC2GVRw
	JtYxPCwD1NOZ+55DloLvLYRLgGjN17LsFVq4tQtWjJoI+EPOHkRUFN58msJkqnIEzz1myhgk9R5ZT
	mnEY3F4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od4tm-008kjq-NM; Tue, 27 Sep 2022 07:20:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od4tj-008kii-RH
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 07:20:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C58068AA6; Tue, 27 Sep 2022 09:20:53 +0200 (CEST)
Date: Tue, 27 Sep 2022 09:20:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: ensure subsystem reset is single threaded
Message-ID: <20220927072053.GB16285@lst.de>
References: <20220922151347.764639-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922151347.764639-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_002056_030514_023E8B5A 
X-CRM114-Status: UNSURE (   7.93  )
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

