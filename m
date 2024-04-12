Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED2AC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 00:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pJYlG2d7mNQ6RgImOKsE+1PKFs7Su2lKgouYn8rxupQ=; b=LCIEkkHTn76ncu30jLCPc7PKrJ
	GNmU87xUIfkRVSsSfF9gMYIkXAVKS63aHfmw5M3wMtpLXTG6ZssauCA6ui98zdr1f9oH5fw0A0c9E
	iLAAiiW0/ch4LNmQTPSuGS8hgUcEjxSpNeXywchJUrjhCO0sjgyDzsx6rO2GS3l+7u0FbCia/+Y5B
	ClEvFvjLjg+a4COJbhBEUuAPcPRJ865lfoaDpTFwjn7BrmoP4VmFtBP1D3bywcaITS2qymqWX4DiS
	Kr1KNvyYFPOOLHLkdKIUnsa55bbSTntJubMv/6app5TMNpii2pZKlrKl8sn8MxiNb2apmr0+vQ46i
	MRRC8Pdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv4tE-0000000EeNi-2bVv;
	Fri, 12 Apr 2024 00:35:36 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv4tB-0000000EeMo-0Zs0
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 00:35:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 607C5CE0F30;
	Fri, 12 Apr 2024 00:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14897C072AA;
	Fri, 12 Apr 2024 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712882128;
	bh=Zd0UnFAEVBYqLc+J6a48EFFUgrWUs/hzCkKQ2PDZS2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYIhgFQIiT4iU75zL3wCYTbWNWJ/nSFuIdTCPwelmcdDqb+wV5nzItJAoy2tC0M2T
	 66atD6/HhXNVH47sP29ioke+bUdnd6piQqIZMA5G5LxA6VaJ6xjxq8k/Pb+PR2b7bI
	 ptVq2tMkZiURcQA3QKMeXnO1bQ535zAilkMduhbwffK7KaZM05XEnFBKlx+2sx0eXc
	 I4KukZFIuNi5BQn8phHt2clbN6hKs9jPyO5AsfenqsVBsTz93A7q6PgJvbk9i8O6uJ
	 Pfr3cS2+vgh5NVqQQHG5Dnt7pP2dT1xl+BSYN/Ibzj/z6XX5yL9jI1dnfQZN6arLwd
	 9F2Wym3OmgHQA==
Date: Thu, 11 Apr 2024 18:35:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6]  nvme-fabrics: short-circuit connect retries
Message-ID: <ZhiBzXBvjTeDuHbS@kbusch-mbp.dhcp.thefacebook.com>
References: <20240409093510.12321-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_173533_385222_0A5B507F 
X-CRM114-Status: GOOD (  14.71  )
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

On Tue, Apr 09, 2024 at 11:35:04AM +0200, Daniel Wagner wrote:
> The first patch returns only kernel error codes now and avoids overwriting error
> codes later. Thje newly introduced helper for deciding if a reconnect should be
> attempted is the only place where we have the logic (and documentation).
> 
> On the target side I've separate the nvme status from the dhchap status handling
> which made it a bit clearer. I was tempted to refactor the code in
> nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
> with something nice yet. So let's keep this change at a minimum before any
> refactoring attempts.
> 
> I've tested with blktests and also an real hardware for nvme-fc.

Thanks, series applied to nvme-6.9.

