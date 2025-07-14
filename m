Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CB0C83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0pR5PbT33styjbaGX+U4uv2AExspH9mUZoz5EmXegpQ=; b=sjx1Koka+5sIC7k+Cem79UJL8I
	DLk4MNlnj+nYQInN6nDS8ek9wtdhcamaTDI8BJzSYDCRYuOaabLgwLv2r7z/ZKNVLGvTacH8dEcSw
	FDKESQWnkxi4YBKyQzsCVp7CfroTSWjvet/292IE1FtILu3XRP2p2QsG88N/qody5C3xWrNgP5po+
	M0iCO8wF4HB9QH/MnRchwpVJEUFwAOpRVLtUQJe2n3B85Z/nXEcWV4J0nJxGtj3UBHBZQLPCUkkAJ
	IfqyBbirq2MJyAbTqnhcBr0sPv6c6O81VPdeuE/j93pdjHc4EYpd4MbWJ+yFZL70q1BoUN75V3xFR
	i1x/q0jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJDs-00000002IBz-2oEn;
	Mon, 14 Jul 2025 13:28:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJ3d-00000002Fe8-0bmb
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 13:17:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A17A227A88; Mon, 14 Jul 2025 15:17:14 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:17:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250714131713.GA8742@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_061725_325278_A67AE447 
X-CRM114-Status: UNSURE (   8.90  )
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

Hi all,

I'm currently trying to sort out the nvme atomics limits mess, and
between that, the lack of a atomic write command in nvme, and the
overall degrading quality of cheap consumer nvme devices I'm starting
to free really uneasy about XFS using hardware atomics by default without
an explicit opt-in, as broken atomics implementations will lead to
really subtle data corruption.

Is is just me, or would it be a good idea to require an explicit
opt-in to user hardware atomics?

