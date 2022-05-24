Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2B9C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAzZyLiMxNolZeLEE7IvQrkvuMeCt+bBxQqvuiVyup0=; b=z+LjjQcWEIFToRFOZoN98Oh+zp
	6aZQ0XT1bxyh8dheHydkpp5fbaC4wOCKyeLhDcjEijfwruo/9/rRe6MKBd8nJvV88omnv6cP/w581
	Ff+jhEVLtnaC1oXqAnH3Ka6/AmQPWQRszz6W0Nj2WXHWkhDIkS98UGXE9MOMDUGTX8sGqVRW5Vy5n
	A/Baw6qfuoEWrmsakLXYIIrevkOcsstICgjhJnBaMeei7JlLOLVOTshDkUq6V1R4Yr3tkgVwyuKNw
	OtKf5UGNfaAv9A4KyJ/0dP3EdZufr+obqOx6OPvedFbf+Bt8cwZ0Oau/A2e7QJFbza3uhFCA3yuC7
	DgMvvHUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nta9c-0091tL-2t; Tue, 24 May 2022 19:25:16 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nta9Z-0091sr-Nc
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 19:25:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DEC34B81800;
 Tue, 24 May 2022 19:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EF4C34100;
 Tue, 24 May 2022 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653420310;
 bh=EbB5AhrEsIUb5UWRTxQa9FFhFhXJHsEfjtuno1KN0dY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NHi/6fbGNt7AFqGLEfKy06tJrfiIGhX8taxIS0Uxwt2Ljv1yY0ebUuTvlCez6ubiE
 rZGg5Fw9n2BuWTCMYrLwC6L+aGZtYo+7cJIe27IBbRiGY041iD3Yg/Gd5WUUBp4i7V
 TOcxKSbWEMjZM1ajwP9jEqHrO0ssEuaI9IRh5bq9MJHerD4hUNPJu5aJ1CAsM83vfd
 JkWqhCWdMrtIbEXYvHDZeZKA6bdio8hl9gGpBXirPFWZBYsEer6cLTyh/Hykes+tHP
 tQSBGFO+nqnyXIdUSCYg5YqfY442wkN7oNfJKq3b0Q7Rv9W2XqhtVGhxQhOXDOBBL0
 WJlZ5BAmVHvBg==
Date: Tue, 24 May 2022 13:25:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: nvme: split bios issued in reverse order
Message-ID: <Yo0xE5g3bowmF3H0@kbusch-mbp.dhcp.thefacebook.com>
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
 <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_122513_960306_7315FA0E 
X-CRM114-Status: UNSURE (   9.36  )
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

On Tue, May 24, 2022 at 12:12:29PM -0400, Jonathan Nicklin wrote:
> 
> The command lines you have are for read operations. The behavior seems
> only to appear with writes.

Huh, I'll be darn...

I think it's because the writes are plugged and the reads are not. The plug
appends requests to the head of the plug list, and unplugging will dispatch the
requests in the reverse order.

