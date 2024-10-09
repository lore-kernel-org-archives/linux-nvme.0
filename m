Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10811CED61D
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VYCHOIKiTxR89g5JXOertAQ0i/chhdKphmWsN7pL8cY=; b=ToziTxqn9bhzPEa588StaOO4Py
	3dvGlnw7Rin+bBdH5XNwSSk8iy8R1u2SUOcyLSsZWwTKcJviafRaQp79Tp5lwC22/+gR6AeppdPHw
	jWbDpl9V0jiQEM6OIFkpr/pGJ4Izl4BkeuuEz4A4b51cNVZ6HLiesjMUeNuUOygZPlsbpZX7dQggM
	vadv/GHPgkjpS+vE5+IYdZieYGqqy44xkRJu6A9MKLTgLMx1sMXdC3disHKRa1dZiVYultxLyyvN7
	Vl5p2htQvZaKqttON7H5zlutc6XLTZ2geOFpBdmcI6h7WdISZlX5xnH5Il+YjUun2K4WkYxYxmSqd
	gUEsdJCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syRaC-00000008L8Q-0tSg;
	Wed, 09 Oct 2024 07:58:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syRUD-00000008Jg0-2wPH
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 07:51:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07147227AAA; Wed,  9 Oct 2024 09:51:53 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:51:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: gjoyce@linux.ibm.com, linux-nvme@lists.infradead.org, axboe@fb.com,
	hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
	msuchanek@suse.de, jonathan.derrick@linux.dev, okozina@redhat.com,
	nilay@linux.ibm.com
Subject: Re: [PATCH v2 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Message-ID: <20241009075152.GA16494@lst.de>
References: <20241007193324.5846-1-gjoyce@linux.ibm.com> <20241007193324.5846-2-gjoyce@linux.ibm.com> <ZwVtf52gL1Zg_YYQ@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwVtf52gL1Zg_YYQ@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_005157_902572_94380542 
X-CRM114-Status: GOOD (  14.91  )
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

On Tue, Oct 08, 2024 at 11:35:59AM -0600, Keith Busch wrote:
> > Disable NVME_CC_CRIME so that CSTS.RDY indicates that the media
> > is ready and able to handle commands without returning
> > NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY.
> 
> I'm okay with this. We just need to see if Christoph wants to chime in
> since he added the without media ready support. I never saw the value in
> having Linux use it, but maybe there's a good reason to do it.

It think it is useful not to block bringing the admin queue up on
the media timeout.  But given how fucked up implementations are we
might as well remove the support for now.

