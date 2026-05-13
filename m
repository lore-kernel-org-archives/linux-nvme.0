Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12DDCD4851
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OMVKavNQ+aDtnGCFJqcfJUHkorNxXoe8d5O4QR1XlhM=; b=pBrc06JX9orXQBVTZJ7dQmP87p
	cSCmdjK6mH0OdQQDH9lhQPA6l9dsH0EJmebWKt/U+MCbIPE9qlXM0hSAqfA3s54n/09821tUPuc+Q
	ZO7F+C9B9nceZiCx+1QCRQBRq/TvKJfg5J+Cf2IBN+U0zK9cZSAVCUdvQkQFjRMXJMQNkPvy0AmSx
	DIOwid9X7MkMSOV2vAQTX7xLwfTswAJOSwXIsrzvErFdAt/A/QdHI2jGaIEHuE486+EHdYoFaTdjo
	pMeMvYj/UKpOLgeVBuMBdgnLtMM3jUD5v8VR6BswI7spCZdJnTNhSXcljX0RFWm8WsrqKdJOvYPfl
	J6vMpi7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNATs-00000002u0l-00qJ;
	Wed, 13 May 2026 14:22:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNATq-00000002u0T-062v
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 14:22:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E5A4F404B4;
	Wed, 13 May 2026 14:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDFBC19425;
	Wed, 13 May 2026 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778682152;
	bh=cRbYVTPM48ZpNPo2qZ5EmNnoRUCtlxwJmYRR5tttF+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpE5mWdL9W4eHxD26ML0rIa4/JnecHPDTTU19sHrs08JDLQd8CILk884aqolJMtP8
	 Bg0RW6BI9HpqQa3K0IJrBKz01wnscjGe9W8kcRyBuU+SZB4t7lYBCfxPJvCU/bwViB
	 34cu/MKbatW43e3k9MVUiEtXs77m8v1rmGWseUyz/cMWGQqWeEiMtV6+V2u8Bx/xfC
	 f6QkW2e9Hq7Qr9xGcvIXd13CWxp74e7NeW8ulbIqvOHydpfLQdb5a4KxS8Xg1aw7u7
	 +cdlThd7U382pLFu0lbAjD69uY0D11Jx/9cIvj79ojcBIjimTVOZPh3jV6fwrgn0nP
	 rTHzW07CS7WPA==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	dwagner@suse.de,
	hare@suse.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	gjoyce@linux.ibm.com,
	wenxiong@linux.ibm.com
Subject: Re: [PATCHv3 0/7] nvme-cli: add nvme top command for real-time monitoring
Date: Wed, 13 May 2026 16:22:27 +0200
Message-ID: <177868214030.534117.16332367160346228129.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512201559.3057514-1-nilay@linux.ibm.com>
References: <20260512201559.3057514-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_072234_082550_EFB06862 
X-CRM114-Status: UNSURE (   8.11  )
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


On Wed, 13 May 2026 01:45:45 +0530, Nilay Shroff wrote:
> Monitoring NVMe devices and paths in production is currently limited to
> static snapshots via nvme-cli. While this is sufficient for basic
> inspection, it is not ideal for NVMe-oF (fabrics) deployments where path
> conditions can change dynamically due to varying network latency,
> congestion, or link failures.
> 
> In multipath environments, administrators often need continuous
> visibility into path state, ANA status, queue depth, link speed, and
> error counters. Today, this typically requires repeatedly invoking
> commands or relying on ad-hoc tooling, making it harder to quickly
> identify issues.
> 
> [...]

Applied, thanks!

[1/7] nvme: add support for unsigned and long types in table_get_value_width()
      commit: 229ad8d5d36b2cf96cba8a253ddf8f2339031c93
[2/7] nvme: use table_get_value_width() in table_print_centered()
      commit: ba1c04d69ebbeda85be5dba4f093e004ec154433
[3/7] nvme: add support for float and double types in table_print_XXX()
      commit: 768dee650681a1910be652b5b31eec13ce21a470
[4/7] nvme: allow table output to be directed to a FILE stream
      commit: 7b8033d3edb12a9a364e02aa493e7466980a774f
[5/7] nvme: add sigaction for SIGWINCH
      commit: 6fc756f2122b09d4f454fc80cb9413c7f4897040
[6/7] nvme: add generic top-like dashboard framework
      commit: f17625d0346571f46560e05433ad1e782d84245e
[7/7] nvme: add nvme top command
      commit: 75c7217f9dae5285ec17978a05d643f95fc5aec0

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

