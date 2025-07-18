Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56FEC87FC6
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jul 2025 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BaMNlicxw19Tn8iKcW5cgrTkMXZiKb8cGF4skENQg4Q=; b=wsnGkkkU79u9tPdISfE+YgBD2I
	04XiNVsYiEuP0ToKSAvdvI6vAoEftHDo4hBAorONJ8BgTAtMhYfYixkc1iKaey9+Qf0vl/ZaoUNU9
	4Hm6ibG/7T76lufFUlK3J/1PjdtxsSlQuIT5m4unYZ8HCvnDYmubAMc+uztlaHTocDtvPKt7qsZoE
	votroPPWGZiCcA6ALgojrggq70AnSOB1A34Yyyxcf+7aRP9em4+28lEhXemNh+3mBoz6Hh5nZya4S
	gX4bxcSgACOgZ/+5bTM9aExySJIl/gCSuHjDQJnw2M9zTW5Dnxz6Mnha4rParTuN6v/VUioyRiLeq
	AV/3VjEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucgT0-0000000C28T-2Rh5;
	Fri, 18 Jul 2025 08:29:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucgFY-0000000BzvO-07Om
	for linux-nvme@lists.infradead.org;
	Fri, 18 Jul 2025 08:15:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 77188601DE;
	Fri, 18 Jul 2025 08:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1B1C4CEEB;
	Fri, 18 Jul 2025 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752826523;
	bh=BaMNlicxw19Tn8iKcW5cgrTkMXZiKb8cGF4skENQg4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H65CFXGi7SLFZxOZhXW8Sj/0xMdMxuRKbR2Oql3/dOvKbJVCsiFi5kRwLIVDkeb/p
	 L7r27AX9+WtmRXFTmvW0zhZq9wLKg+y1LtmeJxQsRtaeq2zuFJC+n7KqLhwo4UWejl
	 B25ezgwUOIyaly1v96CYt9tEtRQZ5MpizzhJvUfKN32H2aMbriUqkUs3GQzKsv9pT5
	 ZEgyWgbZM2Ws5uJOgYD3ns6wXp6pux7RmlDRdJ9D5N8KJJABEln4CdhLPoSVNWv4bP
	 O96CIqcmzfVjmGKknO1orjggxdE4klCBFRjNIXqcJ6UMllLo1cQRFqZNJrsHL/k97g
	 IfhHWs7SSIfeA==
Date: Fri, 18 Jul 2025 10:15:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Kamaljit Singh <kamaljit.singh1@wdc.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	dlemoal@kernel.org
Subject: Re: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
Message-ID: <aHoClrMYgaZwzfeL@ryzen>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
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

Hello Kamaljit,

I think that the patch looks good.

That said, the Suggested-by trailer should go together with all other
trailers at the end of the commit log, see e.g.:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?id=a4daf088a77323154514eb1f8626bbdf9329cfd4


Kind regards,
Niklas

