Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A3AC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LTLtv45DEC9lzEx07RZPlpj4i/93QslQujKP/HWTMI=; b=g5Jj6b20tpdmk0t4sjNU9UeC1G
	pgvkfEf/NMYFIzcI+LnwcDbGs1tpmwJiZ7DOOLe5c2vWrEywD9x6FR9M56E+NpqdXI8Sv5WtUJjoN
	9lkkHdDUtY3BgGZXRqm82E2lP8l4XcCAQxSKRB5/6Fl1lfFccFEBlGgfQ0aG/qpmH97gla8cov0vo
	D/VU/3YIeCsDn840vIOegPAVFNVYkyD/ZOFhQRF4TCGcsAP/g1sC6NUeOPFezrd6AdsTQmKO98f4K
	UJSdZBDOdJaGzr8apMIBaLwisb1M/AhYUhYOEU36FRPVPP+/Z4vxA5mTMymWpbtoYvGkGajXt0gvM
	Da5eyXkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxTh6-00000002n9w-47AP;
	Thu, 18 Apr 2024 15:29:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxTh3-00000002n9T-2Ups
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 15:28:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4E8CD61890;
	Thu, 18 Apr 2024 15:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C83CC113CC;
	Thu, 18 Apr 2024 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454136;
	bh=5jW+uUnwhrvCXx0fYT6Qo68D1DmncWy9nhmFLVw8Nak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5XCK/d6SQBMPnddECTwJerWBS92z8iOsPIdocgPxvQHLUNWyqCk5YiRC29kAhFXv
	 B92uGwrUtShnWM8Rff5unIl7HfBjKffsZwyEa+flSB9s2BQ5v6df13yMVEprw2IIZV
	 6ykQTt09iPM55T69ePNiP5St35Mx4n9WtgyQOsLzkP+CRw8Qdlw4doTOiruExQLWX8
	 gPCw0acZ5HpbWHsj7OvQFh5DDoAuxNVtWSx6iK3DUzfzxwyEZPLPkdPnKBQTAtAJbX
	 OS7WMCldGUSrNymNlLp4lKcKYFkNlPtawqHgvRWJnOAMUqyDR4xWzG5CFwxmR13a8E
	 5X5TS/jYfjHTg==
Date: Thu, 18 Apr 2024 08:28:54 -0700
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
Message-ID: <20240418082854.7bca40cf@kernel.org>
In-Reply-To: <27e21214-7523-43e2-a3a4-0b6327190fec@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
	<20240405224504.4cb620de@kernel.org>
	<1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
	<838605ca-3071-4158-b271-1073500cbbd7@nvidia.com>
	<20240409155907.2726de60@kernel.org>
	<27e21214-7523-43e2-a3a4-0b6327190fec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_082857_713276_A9D74CB8 
X-CRM114-Status: GOOD (  16.22  )
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

On Thu, 18 Apr 2024 08:29:27 +0000 Chaitanya Kulkarni wrote:
> > You're not sending these patches to the distros, you're sending them
> > to the upstream Linux kernel. And unfortunately we don't have a test
> > lab where we could put your HW, so it's on you. To be clear all you
> > need to do is periodically build and test certain upstream branches
> > and report results. By "report" all I mean is put a JSON file with the
> > result somewhere we can HTTP GET. KernelCI has been around for a while,
> > I don't think this is a crazy ask.  
> 
> That should be doable, we can run the tests and make the results
> available for others to access in JASON format. Just to
> clarify what you mean by the Kernel CI ? what I understood you want
> our tests to run and provide the results, still not clear about the
> Kernel CI involvement in this process, can you please elaborate ?

Kernel CI was just an example of CI being a thing upstream.
For us you'd need to generate a much simplified JSON which netdev CI
can consume. Could you reach out to Petr Machata or Ido Schimmel 
internally at nVidia? They are involved.

