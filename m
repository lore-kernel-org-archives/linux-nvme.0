Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5ABC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+rF3hytQ4UZJy/2+oorpCJC3cqiNuivwh/Lp5xUmSMI=; b=g6c3ir57vYmFVKNOzHdzAnm6m+
	nZisU6F1LqAqMK0zYEKYdc/Y8rhnC8ts7Ivm8XQG3EJn8+63RQkuSz7z73ulDT7OarPcZjvOV/67O
	A7+5TQCMUXHLH13EuP1F2d02Nvg5sXnNg2KtrjaiPxbE0kSeSFqWbgRjaeR88EIcXZ87Ugs6j9WJl
	tZFXgTr2ynwnesyZI6Kugi0FCaugZF1wglyWdhX+q0w/FCEAsyT7Etq3TI4zt38PbY7h3LyE1mpHO
	R2YmGcljSsE0SwgyCj5gE8VYJqbC6nhTKFHcmGpeHz3eThJk4NXWrrJh0HSu0+2dLlUGx1e57oyuX
	2d3hDgpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okobD-007jFZ-PJ; Tue, 18 Oct 2022 15:33:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoZ7-007gsi-Gr
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:31:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 33A3B68C7B; Tue, 18 Oct 2022 17:31:33 +0200 (CEST)
Date: Tue, 18 Oct 2022 17:31:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	fancer.lancer@gmail.com, linux@roeck-us.net,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018153132.GC23173@lst.de>
References: <20221018145808.681327-1-hch@lst.de> <Y07C/FdD3mpKgBjN@kbusch-mbp.dhcp.thefacebook.com> <20221018152309.GB22639@lst.de> <Y07FoBKCrJibFOY5@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07FoBKCrJibFOY5@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_083137_734107_7A7512DC 
X-CRM114-Status: UNSURE (   9.64  )
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

On Tue, Oct 18, 2022 at 09:26:24AM -0600, Keith Busch wrote:
> Yep, this looks fine. You'll just need to initialize 'int err = 0;' at
> the beginning.

Grr, stupid lack of uninitialized variable tracking in gcc..

