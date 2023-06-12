Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C009FC7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VeAAhXR1xgTNr8sTXQR8w1S8v/ugsZMLe1e1vpYI0bk=; b=Y5EC5SWmyMasXkBZXnQJt1C27w
	32LXrmayfKEGJ46C3zNUJNnnI+/aME0GqxbVbOiuSiaVeAC4az6KBYBI4YURKQgDQUwbqW/vFOtfg
	v4QN6e3kYHuPyeA9Nl15eGWOcSSQ3x15N5e3rNrMCXjWuGi7ZuQvs5e8hai8pws3TCCeQZPMfWYxV
	ieDKlJOxerSHFFAEcM1SnjPLAboryF5KjwcbHJSOAc5DX0A6BlQdRZaMz5PHxfYzFEP0kdFeWLGxc
	d8qABt3oecb2fPEUMCMC9bx44zF5WWW8N153SbWO0t9GT+Uas7KVSItQi6ZZZUCJxn+DqBdr7dXU+
	hY2KFy1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8lpn-004rcL-2C;
	Mon, 12 Jun 2023 18:00:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8lpl-004rbm-02
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 18:00:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 46EF561DAA;
	Mon, 12 Jun 2023 18:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3C8C433EF;
	Mon, 12 Jun 2023 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686592801;
	bh=VeAAhXR1xgTNr8sTXQR8w1S8v/ugsZMLe1e1vpYI0bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/vhuoBDOafN/aJsYoLubEVtugaYuEM/ZM7DfcDaESctUjn2/iYaBObqUx5hNTGd8
	 fh13wbuayh13z3hd47uq+Te4fKLUSJx4PlCvu7pr+AC1Dkh5rlnyOMtUGjTuakJ+iJ
	 OmSsSvBdLKDZWIlQRmZf1hhdip1Y/i65RweSpGJ63/LpPre4gJBB9d4ijHKWlxdfe5
	 y7FGb2utwcq3o3FWxN46DGMQeKqCazymxDpk5jxaFVLJNHEwWHS8Hkj+DSvsrHbnff
	 A0FOlDYUgUGqPbJeL0nItySR1y8nEYqBHhfLIBJKq+WvTFTKsaq1dickKrvu2f/m2d
	 b3iSKabNkJwjw==
Date: Mon, 12 Jun 2023 11:59:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-core: use nvme_ns_head_multipath instead of
 ns->head->disk
Message-ID: <ZIddHn1Nz4wAu87R@kbusch-mbp.dhcp.thefacebook.com>
References: <20230518221054.56378-1-irvincoteg@gmail.com>
 <20230518221054.56378-3-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518221054.56378-3-irvincoteg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_110005_117087_7F898A54 
X-CRM114-Status: UNSURE (   7.49  )
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

Thanks, applied to nvme-6.5, skipping patch 1/2.

