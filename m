Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC7AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tz98sccFxvbjWDJciH1zpeayD1ruRNaTozLwXtiPZlo=; b=f4a6Ze/5bK61RyWLb2j60TmMg8
	/hGcVyngJDjq3oAxNy7YAJRhBI+nvWc+44Kd3bFd9wsfBPb4BBM5rhIg4a5PEIL5vY+8FADkBIcwi
	3U5fDBccYmcIbggw/QgvbkU1SA43+FxkGARLj5mkebLjAI4INllxVF0Sze0Azux9fh1M7FvdOGe85
	1G1LFnj8O/nWke72HG8D8UXjGCCiKa+8ulUztGY/1BTmbTbF4KHa1M2HU6QEDSdE8WryzxCmsyRF/
	Akd7uf0EzvMSYZHP41ew2Vh/waVFtkbjimc5qt+xNSOM+DNsU3dIeOCKf19S7v0/GoCNPD1ypnKwn
	Lt/0DIGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSED8-00BufP-Bh; Thu, 10 Mar 2022 08:31:50 +0000
Received: from smtprz01.163.net ([106.3.154.234] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSED5-00Budh-8j
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 08:31:49 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id C15754400F5
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 16:31:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646901104; bh=tz98sccFxvbjWDJciH1zpeayD1ruRNaTozLwXtiPZlo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=z1NoqZMZbJxNQ7smgStMG566vTnVc+jNJpaEG3Dip8PYjenY0rZjr8aSMQpD+Xi/0
 hVvxlhL5cTydHKuao29zjWtbDKIxa/MFeVixmbX/FeBQcjv2AsnuERiAtT44TLLdxT
 3wXse1wpa+mGH5WzcC8tzAZjPGKY/i/Fxv0QOLik=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID -588916669
 for <linux-nvme@lists.infradead.org>;
 Thu, 10 Mar 2022 16:31:44 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646901104; bh=tz98sccFxvbjWDJciH1zpeayD1ruRNaTozLwXtiPZlo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=z1NoqZMZbJxNQ7smgStMG566vTnVc+jNJpaEG3Dip8PYjenY0rZjr8aSMQpD+Xi/0
 hVvxlhL5cTydHKuao29zjWtbDKIxa/MFeVixmbX/FeBQcjv2AsnuERiAtT44TLLdxT
 3wXse1wpa+mGH5WzcC8tzAZjPGKY/i/Fxv0QOLik=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 3BC62154153A;
 Thu, 10 Mar 2022 16:31:40 +0800 (CST)
Date: Thu, 10 Mar 2022 16:31:39 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220310163139.00003d87@tom.com>
In-Reply-To: <20220310081908.GA26477@lst.de>
References: <20220308151606.2563-1-sunmingbao@tom.com>
 <20220309061442.GA31316@lst.de> <20220309153136.000048e1@tom.com>
 <20220309212852.00007828@tom.com> <20220310081908.GA26477@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_003147_687180_27DCD027 
X-CRM114-Status: GOOD (  14.07  )
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

On Thu, 10 Mar 2022 09:19:08 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Mar 09, 2022 at 09:41:59PM +0800, Mingbao Sun wrote:
> > So I tried with 'tcp_set_congestion_control'.
> > But then I found this symbol is not exported yet.
> > Then I applied =E2=80=98EXPORT_SYMBOL_GPL(tcp_set_congestion_control);=
=E2=80=99
> > in my local source, and it works well in the testing.
> >=20
> > Then what should I do with this? =20
>=20
> Add the export in a separate, clearly documented, patch, and Cc the
> netdev list and maintainers to get their opinion on all list.

Got it.
Will do that soon.

