Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C35CD98E2
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kvFAel3hT2aCpodG8ZLF82cEweXUConelsw4C01uKcs=; b=LmyvXeZyr8RMKN6BPRklM0aUiC
	lc83h7m9wRB99l+BntlrVre5GETWo+1hAdXiQxvrMcEsSpxkvllQJyxFfDXnL9Rc1ALm0VuONpqdo
	yOGFoPOzKfQa6USbaDpjEQ4pL/xJC8WszUl48GeaJNVJLilZGhth4xBxtNeofRkMW2HjFIWKfS/Ik
	dMcc6iB11rG/T/UC/Zuy/jsPYnpOGlwgrPNtzKlNULswXEnMDZlPNZ/9n2pLAhrTuZ5ONLrc2lc51
	O+F3qAJSYNAUVx1B1QblN++NKMd4nI/I26vFwbotIRWOnjIgDykbL6Xt+C+MMzUfd7eOi1jtCLk4r
	Ho52xxew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZuHD-000000007iJ-1xhw;
	Wed, 17 Jun 2026 17:42:11 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZuHA-000000007gj-0i9j
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 17:42:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=kvFAel3hT2aCpo
	dG8ZLF82cEweXUConelsw4C01uKcs=; h=in-reply-to:references:cc:to:from:
	subject:date; d=arkamax.eu; b=bXoC4Q/+g8Q3M+9xsufKiMepSkRrdEDbRettbEIo
	oajAncUGQUldjtbTqy8AhgaD+HzaJ8QAADRQLRGqczE7okLXDvig4Lz48/IDg02y89IFTn
	aTC1piz2s2ajSiFnh3J6Uh04E6UkdMVY3aAY/f0eViV1SAUmSuFSkyI51WBtjCEcArizU6
	Indz+Zmt8umniFjDZwXlzbVabHvL5eQl/dIbD35xX5+nzG7/wTIUg6yIJOK6m779E0ggwU
	MTPmbT21rydTl7O6YryJVEvIA8szKEy2Cw0XS1TxVmkemKpOysUEmNO4nEug2IAp4bjEMD
	32RESfS9GtpbnrzxVpIVAQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 52c4389b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 19:41:58 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 19:41:58 +0200
Message-Id: <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Hannes Reinecke" <hare@suse.de>
Cc: "John Meneghini" <jmeneghi@redhat.com>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>, "Maurizio Lombardi" <mlombard@redhat.com>,
 <hch@lst.de>, <chaitanyak@nvidia.com>, <bvanassche@acm.org>,
 <linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <James.Bottomley@hansenpartnership.com>, <emilne@redhat.com>,
 <bgurney@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp> <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp>
 <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp>
In-Reply-To: <aaXE4s3AT45UIAN8@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_104208_848253_5E94E1E6 
X-CRM114-Status: GOOD (  11.90  )
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

Hello Keith,

On Mon Mar 2, 2026 at 6:12 PM CET, Keith Busch wrote:
> On Mon, Mar 02, 2026 at 08:16:19AM +0100, Hannes Reinecke wrote:
>> I really would like to go with the nsid based solution from Keith.
>> That would avoid quite some cumbersome code here.
>
> I've seen various documentation that assumes the current naming
> indicates the nsid, so the scheme follows at least some people's
> expectations. I don't know if we can make everyone happy here, though.
> :(
>
> I've fixed up most of the multipath races that get us closer to allowing
> nsid suffix, but there's one left: nvme_remove_head is called outside
> the subsys lock after detaching the head from the subsystem list. That
> could cause a subsequent add event to call nvme_alloc_ns() before the
> mpath side has completed del_gendisk() for the old nsid.

Did you manage to find a solution for this race?
I just wanted to check whether you had any patches ready for testing since
this discussion.

Thanks,
Maurizio

