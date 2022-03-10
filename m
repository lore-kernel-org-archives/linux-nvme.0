Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D983FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ly/7R1dyeodP/XTlGXxB9+k9BxNfK7vhmY6EnN8Ccv8=; b=LLa4sLxS4jjFU63TGPIp9owdRv
	GBLYmMvju0mphR+VR99uFuceOVGeabT0OTfUHZXJ3q16jEy/VN8jTJOkG/vVE4Ir40KPCA8grkzdN
	RrnG0+8LaJbA5WIKyqp1J+S3pAr68+oMTrDVczTMNeuXNKOWSWo2xuuQnKrqIOcgE2BNuCYS4T9tb
	A2xBFz8SUu8QOlflwoSSXtvuc0Nf9o3x8VgEXo3qnVb7v6heumCaHweG/Z8TNexkIV49lYcrp0wKh
	EJ6CbFoxxSuHMznFL+dTelx6KN++sa63pOp31hThjgcJroHbHaMcqcwrIzmSdUAzQCSehMDr5uVUj
	xtt4KMIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSKTz-00DIhk-Sh; Thu, 10 Mar 2022 15:13:39 +0000
Received: from smtprz01.163.net ([106.3.154.234] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSKTv-00DIeS-Il
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 15:13:37 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id DCD7C4400AE
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 23:13:32 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646925212; bh=doCJDH1zWUod9q6whn+dh+jk6wzxYxXQrH/FUdQRXcc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NZKPcxyA6m4BJOPGh6i4liCsk6zLDf0JWSzaW92qjk4FVs95Lhi3hk9GG5RbQTRA+
 3+ht+ccyC4r4eM+UulDJfo4VaxrXSVAAr6ojFRidPBREmfiaZiAEDDMFazByA8WrrC
 Al81vLn3130dJjDHsVJlDmfnEdFeZgMeZyKszqcM=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID -593754466
 for <linux-nvme@lists.infradead.org>;
 Thu, 10 Mar 2022 23:13:32 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646925212; bh=doCJDH1zWUod9q6whn+dh+jk6wzxYxXQrH/FUdQRXcc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NZKPcxyA6m4BJOPGh6i4liCsk6zLDf0JWSzaW92qjk4FVs95Lhi3hk9GG5RbQTRA+
 3+ht+ccyC4r4eM+UulDJfo4VaxrXSVAAr6ojFRidPBREmfiaZiAEDDMFazByA8WrrC
 Al81vLn3130dJjDHsVJlDmfnEdFeZgMeZyKszqcM=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 9669215414BB;
 Thu, 10 Mar 2022 23:13:26 +0800 (CST)
Date: Thu, 10 Mar 2022 23:13:25 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220310231325.00000232@tom.com>
In-Reply-To: <20220310142034.GA1038@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
 <20220309061541.GB31316@lst.de> <20220309175203.00006ee2@tom.com>
 <20220310083811.GA26953@lst.de> <20220310190636.00001695@tom.com>
 <20220310142034.GA1038@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_071336_053013_B52D26EC 
X-CRM114-Status: GOOD (  13.03  )
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

On Thu, 10 Mar 2022 15:20:34 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Mar 10, 2022 at 07:06:36PM +0800, Mingbao Sun wrote:
> > I feel it=E2=80=99s not proper to create a sysfs entry for each socket.
> > And for those sockets that do not have the exception of
> > congestion-control, it=E2=80=99s merely a waste of resources.
> >=20
> > Also, since these sockets generate and die dynamically, the info
> > exported via fs may even do not have the opportunity to be seen by
> > the user.
> >=20
> > Anyway, if you insist that the checking and warning here is not proper,
> > I can remove it.  =20
>=20
> Something that can happen during normal operation is per definition no
> something that should be warned about.

Got.
Will remove this checking and warning in the next version.

