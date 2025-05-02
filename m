Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD10C3ABA3
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUj6YGkGuNUDSm/zdvmfAaL0Vw6CNWt+2J2QiDLlijk=; b=aL+N+Wi+R8nfCGwfRSWZNUy2Fr
	8+OjgShqUoDrWEmoyK+jTUSygzpz+TkTTYRlbofi41g2dHfJxCaj8X9pQ/+NbDQt01kBFfJacAQUQ
	n1b+jz3fNugRW1lxv3J477q+hGgqkPaF2KlepnagHeLHnXgTGfNeLkB3o18VzsSHhtIcMj2Tw6IwY
	BscczC/lUeW5pQggML+VsHwVA5A4uNXh8ArMNSg9lYZowz8MfB9S3l0TgOtUC71/tpRwgHRQCv9HG
	/TpeHo8twJQ6LylfyGOKyKyJvUTlAuAjbJlpJNVXqob1y0DVqTriEWtALnSLTPdz5lhb66rKaFj3r
	xxwjz1Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAoYR-00000001mMV-3d1K;
	Fri, 02 May 2025 11:27:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAoGN-00000001jld-1jJt;
	Fri, 02 May 2025 11:09:03 +0000
Date: Fri, 2 May 2025 04:09:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Laurence Oberman <loberman@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
	"Lombardi, Maurizio" <mlombard@redhat.com>, bgurney@redhat.com
Subject: Re: Samsung  PM1733 MZXL53T2HBLS-00AH3 and duplicate id's may need a
 quirk
Message-ID: <aBSnz1r3NsoUya4b@infradead.org>
References: <b368dde2186500caf71464bc966cf22953c5124a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b368dde2186500caf71464bc966cf22953c5124a.camel@redhat.com>
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

Please ask the vendor (or OEM) for a fix instead.  This is gravely
broken behavior.


