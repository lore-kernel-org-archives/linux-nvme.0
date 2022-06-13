Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6AFC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCguPfhBjRDX4UmTJq9ti6SGKm9MJcaBx3aO1wE0zJI=; b=BrfpR0ycgOO4CkcREsi+384UEL
	MbHXEyEYXQYqgUZPTKJYFm+UY0FvuoKJvVePw8wVLxDXUkADXne8PQ3xCx3N8SdRTSwqtMoYK5O5V
	wkrTVahvaloptXxbw64Qp3qRuyYxBbCO4VSg3mohrCX00WBNTERvNoGKY1WkpRGwdUuhfoVRf3DGQ
	X+nMHeJplpe4XbKYb6mzfZuPFFqvrOw133eCiRVA0t82VNCJ9cmw19DFQIuzlmoGEbI4L2nSdEe6e
	WPhUCRP/o5LC3xgInUvmS+K7GsWBaaUKl68c51ZU/239PglxW/VeKiCa8CMcZ4SdASyOFUk/XmcRF
	Wjlc3McQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0j4G-003UZW-0z; Mon, 13 Jun 2022 12:21:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0j4D-003UXW-5V
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 12:21:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8D5BB61220;
	Mon, 13 Jun 2022 12:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E6CC34114;
	Mon, 13 Jun 2022 12:21:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OudDLBOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1655122865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCguPfhBjRDX4UmTJq9ti6SGKm9MJcaBx3aO1wE0zJI=;
	b=OudDLBOf2DDzDoHX8qr0r/1jVrOBp7yu9hoOynhMQTo2tkxBCXZBNgDqkwj4i0X3sh+9P3
	8/0BdxEpddr3D+A5nFlzj2vLe9aPL3Et+qUsFC2JeXJOLx8HV/ByqrZfP72zi8296ynVhj
	36OeAc2QA26zTXoW8E30cs/6HEdJMN0=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 748efec9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
	Mon, 13 Jun 2022 12:21:04 +0000 (UTC)
Date: Mon, 13 Jun 2022 14:20:59 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "R, Monish Kumar" <monish.kumar.r@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <Yqcrq2ewmqhflAYw@zx2c4.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com>
 <20220610061449.GD24331@lst.de>
 <YqMMo2Dv9SZRtR7B@zx2c4.com>
 <SA2PR11MB5115C9D7AE1DF332B29625B0C3AB9@SA2PR11MB5115.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA2PR11MB5115C9D7AE1DF332B29625B0C3AB9@SA2PR11MB5115.namprd11.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_052113_283725_7BC2254E 
X-CRM114-Status: UNSURE (   8.73  )
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

On Mon, Jun 13, 2022 at 06:36:44AM +0000, R, Monish Kumar wrote:
> mn        : Samsung Portable SSD X5
> fr        : 1P3QEXE7

Isn't the latest firmware for the QEXE7 line 2B2QEXE7?

Jason

