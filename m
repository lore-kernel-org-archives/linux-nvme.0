Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6939C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X3fwVyhmQijKnPKjg+TtByLrqQ4wgOIOlGdCWkEmSsE=; b=TABq/Z12y1btDa7QMzuzwRsQDl
	7Behik6lUis8MVuSUi7/3V9LRFlPf7/UH0KAqWWWovpHAAQxfBUvwcUWFtQj7h2MZYGmDAeP8R2os
	IBJHmSTGp9jX+hEukDyKnDTBubSz5YqzQgg9FYGwSO81uOb/cNjMmeXgwvn/nvnAQJv72j1tpTCTR
	N7tZapx93MMaCxrcn09QDdBi1s3t0GsMCFbwcSF3TkvddRrjr211iPYEhJxTPDUnIkl1DlcspQp+o
	YnmSXP7GV6gT11GhDyZWsonoWrc709Pa2gf2Ye8tOVNosYZ8PtCjtS9O8fRDOSm3+mWIZ+L/4Bqkf
	VDUoMjGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1UTd-00F5l3-8G; Wed, 15 Jun 2022 14:58:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1UTa-00F5kN-Td
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 14:58:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 237216121E;
	Wed, 15 Jun 2022 14:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7DEC34115;
	Wed, 15 Jun 2022 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655305113;
	bh=X3fwVyhmQijKnPKjg+TtByLrqQ4wgOIOlGdCWkEmSsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVGUG77O5qnGKtvfCRolI5RTtnbuhRrdFjJvz57WQl5wIQmetZbzNYNNjciU39kKX
	 x7zWNHHDkBortx7cyEHer1/YqaYeEsz9zU5iFQqG+LRySnDiJVEa/0BbuCdyYyESm+
	 ajSHCS/RkEzD3shIi7DLd0tbFojvPF0lE1C3XLfcrY/ZZZyZZ9p96eETdzgPYbTdzz
	 JAKavnw4yFjN8fAcvf05pycx6chqdmOp6RjCX7O58xbN2VwORfRmqnEMKw2QeW5ehn
	 m0GU/aMU4TGgzuqfJvXMm2cjTkOVR92pM8lGJM4LQhDkol5EMQX8xoanljyPIHv4cK
	 K5QMnTTjtDxyg==
Date: Wed, 15 Jun 2022 08:58:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Karsten Elfenbein <karsten.elfenbein@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Phison E16
Message-ID: <YqnzlugKe9QLWf0Z@kbusch-mbp>
References: <CADzy1LZqrb0HOX5jaDOet7nMK=X5tJ9XfO9jtk=XZg54t9nOtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADzy1LZqrb0HOX5jaDOet7nMK=X5tJ9XfO9jtk=XZg54t9nOtA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_075835_028382_5C1AEF26 
X-CRM114-Status: UNSURE (   8.74  )
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

On Tue, Jun 14, 2022 at 10:22:15PM +0200, Karsten Elfenbein wrote:
> My two devices report identical eui64 values (looks random) and
> identical ngui values (all 0).

Do you want to send the attachment as an actual patch with changelog and
sign-off?

