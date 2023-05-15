Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AB7C7EE23
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=; b=GaWOjowHuCQufcRvNt9T/wOroW
	sKr7oalXmxCOoCsqTe4F/RQWdU2j0UcbM0RGqz1ummnbEqpuqlCc5xcvb8TQ5xRw5t6/wT2RrX6ST
	D+FeVP99utlpnpJDFsDEmEhfWfKHH/Dsw8ejjCujAen5oWNeqJTkBp6b/czq0OrDcWiosx+/poH8s
	CWubi1xnh+KM+0GzR530WrXjr03UiZ1EdTylQX7piGIyr/58MDbIHeYjYbXPeAfmZkombkBIDlRAp
	t+bc8ciZCd+hpm1Z+8r+ufkPoFSWvH0G9HJeTxn31c9Pyu+T5/NM7ZUV2BckzQK7HHWDgrj1JuUGo
	kbJWoV+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyblY-002tIc-22;
	Mon, 15 May 2023 17:13:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyblW-002tHj-1j
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 17:13:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8438A62B5C;
	Mon, 15 May 2023 17:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A25AC433D2;
	Mon, 15 May 2023 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684170821;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiFUPjwCsrBq5EsXTIkDjjbfZKAu20PJh9ZsTAmkAjSLmgJH45TUPkpH7EwJqKQgu
	 Mzx5H4Pk/uDnLtrcqgJcmA8VMZgsbU8Wl4ZNw770hasEBisiNrElMF4oiRbJx3/cZF
	 Y6qCt8GeyCPqpgtYUPaPsO7iz0IVf3pEgFZe1drQbvEFo40MttvDV72KXlanOieKTI
	 sr5rNqsHKQldG5KnUK3Yx+cz/Qj64iyWZzOjk7wYSovamhNH+bjE1CtVVYKQPlQ2oV
	 zegXcPayxNXJEVgcc2BnnnYytgYaJvN6sXx2vEWPyi5VdfhbZSIEPGHT1eNsuhfwwm
	 F7GMxnj1Hm9JA==
Date: Mon, 15 May 2023 11:13:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH V2 0/4] nvme: init ctrl memleak and debugfs fix
Message-ID: <ZGJoQmHNXmXwAqHN@kbusch-mbp>
References: <20230428073115.22987-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428073115.22987-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_101342_608402_9B7FBBB9 
X-CRM114-Status: UNSURE (   6.67  )
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

Thanks, applied to nvme-6.5.

