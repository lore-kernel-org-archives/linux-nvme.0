Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AE8EB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9/U4lCcwfc3gXIh04vO6p0Rpd4PHgZdLXcW1XMblGSg=; b=odpteDJSI9Dnef9RQJZ0C4uMSg
	FF7a/d1a56kFqplzIMGxEVgi+9Bw4y8wZbmQsAKixogXLivlHxhGL4eqOI0WHfVWQFDjPyhsoYbrg
	TwvsxxH4c3mI4BNPZJ+AOH3ts3s9bV8T3P9XlLPZvPyBHmo3bEeuc8CR4O3E4YtDIoFSzqrXHra7j
	YV2A666J5fpPYId2jW7CdbcjELvvo/EK2J1W/HQUEC/gHudKEO7FTAAigVQH+2gIF23YAMvjYgN1B
	kEYiHcEmVf6oB4MlINfnf3/zr9IXuJOkj7vz36ncSGeGseRrrxkZc2xCZHAQmBl7Sc9uZSfjfGMkN
	s8R69rWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEAUF-00DV08-0r;
	Tue, 27 Jun 2023 15:20:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEAUC-00DUzW-2k
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 15:20:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 59F8D611BE;
	Tue, 27 Jun 2023 15:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6273FC433C8;
	Tue, 27 Jun 2023 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687879207;
	bh=9/U4lCcwfc3gXIh04vO6p0Rpd4PHgZdLXcW1XMblGSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E23f7uIwO9donfug8cLdndhja0qwNT3TqDKyUsjXAENWZK9SU7izUpDIQVbu+VHeR
	 WdxKnzm0LiBSLvhU/jCxSLn4NJfdMr40jaQ22BX4wIhqZan/uZlanDObWk59biSDyq
	 nFL+YPmQ280sRgTUeusBNx9TeZDHjsJyLlLedbYMab7iQJn3nJsLABaLtTBUSfIXik
	 1talpZjUFgkMj9ccDUB7qrTiRCUZjwh7QBpKuLWJ9oQkjYrzuwZJ071yLyZ5Y2l1wb
	 3IVthr/zmJdN+B5PSlwsrrzRNGPqWYZ2ZujZlWxHXfaLlgdK48SDqVHwVPktjdp7Ng
	 3YX82usYXkY0g==
Date: Tue, 27 Jun 2023 09:20:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: host: fix command name spelling
Message-ID: <ZJr+JYqqgxfw15P3@kbusch-mbp.dhcp.thefacebook.com>
References: <20230622075307.692950-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622075307.692950-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_082008_935101_C6FE711A 
X-CRM114-Status: UNSURE (   6.13  )
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

Applied for nvme-6.5, thanks!

