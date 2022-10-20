Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9757AC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 06:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2BTaCnO0tjUhd2ZKh64rdqiAUifCZPa7StiQnkeDGQc=; b=DhZxdymxshFKxzEA+M0a1XzBNZ
	z8yJ2fMiXbGNH6oH7+dkFHOMUZVyb0fio1hRcZK2NR0teYYGDcdG0ZAGUiNzYw78QyIdO0Rq5wVVQ
	saNSz2wPe+dVxNnJZ5hld6fF5i9rTWrs76IBRtVuFdfNERbwPAqVwg/xlieHMNfE1z9L+FJVbhIXS
	kZbXitM+Z57j+xboyazyLvwMMWSc3nsNg/C0emKJ6jrkwTKLr9iKA7/6KTw5lEkynD957cXnQTWOf
	M7mXDN5H+uBp1ZnfDPfLRQEobZ467CT5oe8sv/4NUbqVle7fE2caa3/VSPSg/2qh6ryU1/igrm7Tf
	oM43Bn9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olP8v-00B5CJ-Bd; Thu, 20 Oct 2022 06:35:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olP8r-00B58g-Vt
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 06:34:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF9FF68B05; Thu, 20 Oct 2022 08:34:48 +0200 (CEST)
Date: Thu, 20 Oct 2022 08:34:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk,
	ming.lei@redhat.com, paulmck@kernel.org
Subject: Re: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
Message-ID: <20221020063448.GA6246@lst.de>
References: <20221020035348.10163-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020035348.10163-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_233458_182549_F8187AB5 
X-CRM114-Status: UNSURE (   8.71  )
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

I though the conclusion from last round was to move the srcu_struct to
the tagset?

