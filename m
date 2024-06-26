Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91285C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hqulUeyKMsCSSbxBuSF+9CjD3SHpnF7o5elX8OB5duk=; b=1Zy16EL7570b3nkvpicp/nWd/2
	/ton2xRTB+9AUz27vu9f4yoi2dcM3otyGOxIvP+Z+qeGEb/LhjsosA+U12mkc4Ii+yRWg95vfSiP/
	3cNg7VNhfdB06P7Nh9W2Wbpbk2HBTOtwng+mKk6ScNAjY4aS7TOuz5i0selTixkf1eHuyfX8gqTSh
	mHg0J/sD8TlfNfKc5hodCalYo/2Iw2Mn0il34zhjJk5dGQJXAYrq/4qlTs5qYsB6kiF9hdsNzYBMY
	7CCPb1k2/pmHVftgR7ax4t0uYuCvfMidu0FRoM236BgpulG9a1MvApSo7Z6aFWQtEKxrDIhsxVmS0
	30K+JRlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYXv-000000085Dn-3GVG;
	Wed, 26 Jun 2024 19:43:11 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYXs-000000085BM-1cxN
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:43:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CE8BACE2C30;
	Wed, 26 Jun 2024 19:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB36C116B1;
	Wed, 26 Jun 2024 19:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719430983;
	bh=P/nl1ipyrOE5lH7R9h9GlnF1puud6X3wdyGqW2EOewg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZH+ZJd8wQB++hXvGdO0w6CYIG0rGIjDr8iCS+6p8F1+nJz9Mg1Ykb8g0GEYvwz+r1
	 nwNyHL4twDmz7Ar4z6WjBkWkHOghTzXevefyNypzJOGFOcJ1WXSwmqWCDcSdEk3T7b
	 +88xo2frLrTAGSniK0VHG31wiUAc20haYprrkfWG1f9SGusrehTtx251SKsG2/ygNN
	 ejI7nyt/7U5c9+G4L2vacSkHjkxuYULX5VKuhWvnCTRf8SlmcR59KobbIthQxTbo+A
	 YWKn3B60/RXPyngJHJPwGNSS6Y0TfI8RboC4d33DbM454Yba0yfADaZiTUGykyLT25
	 0V9JVjURkc9fA==
Date: Wed, 26 Jun 2024 12:43:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "davem@davemloft.net"
 <davem@davemloft.net>, Shai Malin <smalin@nvidia.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>, Yoray Zack
 <yorayz@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Gal Shalom
 <galshalom@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Aurelien Aptel <aaptel@nvidia.com>
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240626124301.38bfa047@kernel.org>
In-Reply-To: <d23e80c9-1109-4c1a-b013-552986892d40@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
	<20240530183906.4534c029@kernel.org>
	<9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
	<SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
	<253v81vpw4t.fsf@nvidia.com>
	<20240626085017.553f793f@kernel.org>
	<d23e80c9-1109-4c1a-b013-552986892d40@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_124308_674529_D69C6E7E 
X-CRM114-Status: GOOD (  14.43  )
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

On Wed, 26 Jun 2024 19:34:50 +0000 Chaitanya Kulkarni wrote:
> > I'm not sure we're on the same page. The ask is to run the tests on
> > the netdev testing branch, at 12h cadence, and generate a simple JSON
> > file with results we can ingest into our reporting. Extra points to
> > reporting it to KCIDB. You mention "framework that is focused on
> > netdev", IDK what you mean. =20
>=20
> just to clarify are you saying that you are want us to :-
>=20
> 1. Pull the latest changes from netdev current development branch
>  =C2=A0=C2=A0 every 12 hours.

Small but important difference - testing branch, not development branch.
There may be malicious code in that branch, since its not fully
reviewed.

> 2. Run blktests on the HEAD of that branch.

Or some subset of blktest, if the whole run takes too long.

> 3. Gather those results into JASON file.
> 4. Post it publicly accessible to you.

Yes.

> I didn't understand the "ingest into our reporting part", can you
> please clarify ?

You just need to publish the JSON files with results, periodically
(publish =3D expose somewhere we can fetch from over HTTP).
The ingestion part is on our end.

