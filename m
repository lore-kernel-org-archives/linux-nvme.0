Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA88CC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V71Oze9xRXdgCQfJ2I91XFtHy8/NOLBmQdmWWqpkxi0=; b=kebeKKnbOIrPqwiuK8DXuJmYYK
	xxWw6CYCGcnRSQODBk6eTUVKxRUE6eplV+fkUBOygm4IEUXXDpiqZG7e/IFPxMCFznrAY6FS1xIaY
	QaIGz0+nBzTp1ybsATzm+V3XK4kbvI5iktYawwkK39gxJvc4N1qZRrYQ+cEEOeYssEIbdb6YmXHPD
	HraxrQPz4RnhceBajhfwSuwK2lGm0vBKaaaEap/c29jv6biYsdI/Jwln9RVvMqD/3indeT4GZAi9i
	3qMQ3no+Y0rrGXHj+U1gPQ5w2OKBWFTm9qB94XA6Q/Pn/Idheb01fG9WgP9zPo0UMFGCFoM2xtZxU
	mrwy2tQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nznRZ-00AGls-Mw; Fri, 10 Jun 2022 22:49:29 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nznRW-00AGjB-Az
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 22:49:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D34D8B837C5;
	Fri, 10 Jun 2022 22:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D2CC34114;
	Fri, 10 Jun 2022 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654901363;
	bh=ysZsnii6xhY9O1pEcnafQIZTGdQ3YtpgIMVXMA2OLXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5AKc0hlXxTI49X1I2KVZzybi3vPwOrcr15Ti5DOrAFUmWG2J0QZGwYGy1ERDOJJA
	 0gNQTi9ssI1qjBS/+yqdj3GzQBU9hGUWncrAO6hx341JRVDkPDg2ED2oKbwrjokxOq
	 RQ3R+ObT8RulZvQIU1MJPR71l2KniYsk7OHI41Rh+bfWr/ALl0netvowm8vnYGp1DZ
	 z3YtWJx93on2w5TvSaXWQ5KwDCTvoxHJrmwJIOz0IRunHHfp6TBuzIqxDD2AmbZYj2
	 5A3bSwBZ68KNObYgZjBiHQKRmhACk44It531rS3OjfVtrNxaZYd1oNH3n/x9wGi4Nb
	 pyoEym3xFqZ7Q==
Date: Fri, 10 Jun 2022 16:49:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kamil Cukrowski <kamilcukrowski@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: bug report: one of /dev/nvme*n1 is not created on 5.18.1
 "globally duplicate IDs for nsid"
Message-ID: <YqPKcGaB/GIeZxDX@kbusch-mbp.dhcp.thefacebook.com>
References: <20220603114303.GA14056@lst.de>
 <c2c1d203-2bb8-9959-02fd-7e8db65d5446@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c1d203-2bb8-9959-02fd-7e8db65d5446@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_154926_557259_FA8D805E 
X-CRM114-Status: GOOD (  11.32  )
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

On Sat, Jun 11, 2022 at 12:41:59AM +0200, Kamil Cukrowski wrote:
> Is the identifier part of the nvme discs or part of the pcie<->nvme
> converter? I.e. does buying a different converter will workaround the issue?
> Should I complain to the vendor of the disc (Goodram) or of the pcie<->nvme
> converter or the chip from lspci (Silicon Motion)?

I think it's SMI's bug. It was also independently reported here for the same
device id's.

  https://bugzilla.kernel.org/show_bug.cgi?id=216096

> 02:00.0 Non-Volatile memory controller [0108]: Silicon Motion, Inc. SM2263EN/SM2263XT SSD Controller [126f:2263] (rev 03)
> 03:00.0 Non-Volatile memory controller [0108]: Silicon Motion, Inc. SM2264EN/SM2263XT SSD Controller [126f:2263] (rev 03)

