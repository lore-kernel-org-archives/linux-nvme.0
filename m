Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC0DCD128A
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 22:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBcb1ap0n3wfkMdktfctqcMOmOejsMT/AbczyTGbBrc=; b=UMNN1lY7yMKPstfDDI2Hj5pYt+
	DhNC91Ckw589rZIS5DagmCjNLXRI8bsvQEXBPSDwkj/sxlqadzHkVtJI4x6vBlcVmtfVWov8bqEzC
	fbV8k0AP1ZovuO2Yi5I02ObZ7CZTHRgle5nT8R68R/BtYX/yZ4kAiusDiW1mnrwh3JMkHItC9Yzjf
	R1odMVx5zjE7h2WdTrpF5i6e6m1agGm4IIUpRkPnMlQ4nPMkv4qYPHLHCsp19DZBRQREcShKv75Ze
	XcdDfD/l9t8CKTX9OXp0JjVSPKMbk5COxNODbwc1ewPewFjZ9B/cjldnb+TuWvg8T6h0p4Y8sLn0x
	q4051BAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruKQu-000000047yG-081C;
	Tue, 09 Apr 2024 22:59:16 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruKQp-000000047xR-3WXq
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 22:59:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EF3FBCE2454;
	Tue,  9 Apr 2024 22:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51146C433C7;
	Tue,  9 Apr 2024 22:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712703549;
	bh=SBcb1ap0n3wfkMdktfctqcMOmOejsMT/AbczyTGbBrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h2keEnzRu99yug9bKZaijm8nYqHMUA8VLsCxuIVhp0guqhswHUoBAeWhVJSIQwV4A
	 nxsYAQXjdHWTQp1RFR8mqYbnGvzgxCPSZh5/Z0SYqeOckLBFnKHN9c4KfiMZxXOoAK
	 kIy1uNhonwnG/FrBgOF9ukXOHofrZqEQDRDG0bHbjRxzYd103v8PmGW/BDaEpDZJN7
	 xN1FJ6o6SNb7mpRxxWs2TK3NqigNGp1A/sPUJLzIyatZptMLMfx94HehudtQkqyeLf
	 elLCRKenVBJ77wIH0oJq6eCCN+qTImdEHKfB0nPGLYMZRPTe1CH8hgGRLGf9dAI0RD
	 eqD4MFFZv48Fg==
Date: Tue, 9 Apr 2024 15:59:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Aurelien Aptel <aaptel@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hch@lst.de"
 <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com"
 <axboe@fb.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>, Shai Malin
 <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Or
 Gerlitz <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
Message-ID: <20240409155907.2726de60@kernel.org>
In-Reply-To: <838605ca-3071-4158-b271-1073500cbbd7@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
	<20240405224504.4cb620de@kernel.org>
	<1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
	<838605ca-3071-4158-b271-1073500cbbd7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_155912_087301_DBD25C63 
X-CRM114-Status: GOOD (  15.77  )
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

On Tue, 9 Apr 2024 22:35:51 +0000 Chaitanya Kulkarni wrote:
> blktests seems to be the right framework to add all the testcases to=20
> cover the targeted subsystem(s) for this patchset. Daniel from Suse has=20
> already posted an RFC (see [1]) to add support for blktests so we can=C2=
=A0=20
> use real controllers for better test coverage. We will be discussing=C2=
=A0=20
> that at LSFMM session this year in detail.

No preference on the framework or where the tests live, FWIW.

> With this support in the blktest framework, we can definitely generate=C2=
=A0=20
> right test-coverage for the tcp-offload that can be run by anyone who=C2=
=A0=20
> has this H/W. Just like I run NVMe tests on the code going from NVMe=C2=
=A0=20
> tree to block tree for every pull request, we are planning to run new=C2=
=A0=20
> nvme tcp offload specific tests regularly on NVMe tree. We will be happy=
=20
> to provide the H/W to distros=C2=A0who are supporting this feature in ord=
er=20
> to make testing easier for=C2=A0others as well.

You're not sending these patches to the distros, you're sending them
to the upstream Linux kernel. And unfortunately we don't have a test
lab where we could put your HW, so it's on you. To be clear all you
need to do is periodically build and test certain upstream branches=20
and report results. By "report" all I mean is put a JSON file with the
result somewhere we can HTTP GET. KernelCI has been around for a while,
I don't think this is a crazy ask.

