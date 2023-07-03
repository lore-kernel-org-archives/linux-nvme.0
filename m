Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55DBEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 06:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUoBaQDxjkZi1Sem7EpqwhIMMA5Ih8do3OoTKvP4LWw=; b=0XL1eyHdRS/hx1ZZHu9eXH+C1e
	2q7mLEthHH+JW4AgmfdZIR1MecmN4eDBWLfQ6kk+0oGim2AfOr+nRiJZPMH4XWBBvtHUOLZZ4IuBc
	MQXPBdy+xKDXwdAyOwmNqBMJUGGwDgQsOEENrgjICCo6f2kuK6HfRXUvMYKlU/Ixa/hU/2yP3YFDH
	Og5LR1o/WJaBs8NTxxuEfaiNf8FqJpchPdoex4Fr5PK8UkrwdcHVo7f4N2HQLZSQjKupsuelVGiGi
	Lg7zakfDDpF9QUn9xjo6REI9czIeWqlwdlgQz+Q2b9wb2B+/xZ6evGuhWVOsUWrZ8SUF8CJW45zvj
	B7Outx9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGCtZ-009RSY-1H;
	Mon, 03 Jul 2023 06:18:45 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGCtW-009RRm-2q
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 06:18:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3BD31FD70;
	Mon,  3 Jul 2023 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688365117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GUoBaQDxjkZi1Sem7EpqwhIMMA5Ih8do3OoTKvP4LWw=;
	b=MtQcbPcdhzin7AFReIh58w+BF26CTYT8jrPqHE+Rm845NDzAQzwbPCvgiFHBPOzGAH6QNE
	KYl8ANZ7hlETd+MP0AqPJ55A0Tjwb/UsHztNkgEVWinsbLlJiVIVhzkSPT5SC5x4wqG6UA
	iMY2V/q1flzCFuw9K5pBNKA4WzpcWVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688365117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GUoBaQDxjkZi1Sem7EpqwhIMMA5Ih8do3OoTKvP4LWw=;
	b=DD0ZzlPyk8Vzs7/j6rh7vTx8Sfq+Yi2XW8geOrAO5zjz+LClrftyp0ZK47ls78snspzfSw
	3nKxMKiuwxIz+eDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94FCE138FC;
	Mon,  3 Jul 2023 06:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fbtTJD1oomSpMwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 03 Jul 2023 06:18:37 +0000
Date: Mon, 3 Jul 2023 08:18:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v2 0/3] More fixes for FC enabling
Message-ID: <exbq2w5c2ny24pxjprhiozbcaftqwumq6o4cvq2sjy6bqi4lvi@nqkeh2vs5seu>
References: <20230628151623.11340-1-dwagner@suse.de>
 <aji2laz4lypl4lspduoeef4uviuoysl5rweu25zmzplj3psg7f@ryxrnjorfsr2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aji2laz4lypl4lspduoeef4uviuoysl5rweu25zmzplj3psg7f@ryxrnjorfsr2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_231843_088613_BD9B884B 
X-CRM114-Status: GOOD (  16.10  )
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

On Mon, Jul 03, 2023 at 05:43:01AM +0000, Shinichiro Kawasaki wrote:
> On Jun 28, 2023 / 17:16, Daniel Wagner wrote:
> > I (think) address all the feedback I got from Sagi and Shinichiro except one.
> > The _have_nvme_cli_context() (previously _nvme_cli_support_context()) function
> > is still there. I didn't find any other good way to achieve this and I found in
> > blktests another function doing the same: _have_fio_zbd_zonemode().
> 
> I found that the latest blktests fix for the hostnqn/hostid issue created
> conflict with the 2nd patch in this series. Sorry about that. (Actually, I guess
> this series could be enough for the issue...)

No problem.

> Daniel, I can fix the conflict and repost the series to the list. Or you can fix
> the conflict by yourself. Please let me know your preference.

I'll rebase and fixup the conflict. Also give it another quick test run just to
make sure all still works.

> Other than that, I think the three patches are good enough to apply.

Great!

