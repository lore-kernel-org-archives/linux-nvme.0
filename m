Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD0D31A3A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jan 2026 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5epN4Olmcgde2sHt4b6a5cHNd4DZdXcjefcV1m6RVu4=; b=3BtYAEvIDz5eIDI2raeLSK5IxB
	a5ZHdlZPA1OzpqQCW503k6E2fnGX8xqTMBS8jnT3J2Y87J6VeyLykKLRpjByskUMasAE6KHQXIOXv
	F1UndXI6RZCm+HBttvLZjFl0FCGwVCadZ9eIqeIDlhqqT9ujcaVgsPSe7i8DFHtDBbiLF6UqC9Owp
	gEQZmgw+c0LVraOmMkNa6Vr3K6PDCiVjCeLWkredRn8qobooiuZz/1BPEHZRKPLcnJh0qN3929Myc
	VzyTxgvby0EVR4FBEUSrvfmXEuCuzJcOplsh2ebUG+dCHS2ozg+uC5/kFjO2xGJ1Jql+P1zxFA4aA
	AXiCUegQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfxJo-00000008b1D-1Bk1;
	Wed, 14 Jan 2026 09:37:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfxJl-00000008b0p-1qna
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jan 2026 09:37:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 860D64021C;
	Wed, 14 Jan 2026 09:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE9C4CEF7;
	Wed, 14 Jan 2026 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768383452;
	bh=xUb0AaNBZhtaOhM/WB69SKt21sFJjoaIShVfPxmD6mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYqaekyOYD4Xvb4gWEY6Cd6MG7/PwimcmFM8UWNVc3/32RfZSUU+ZdPAmpWFIcSo9
	 n6TbSY/grIBnXq7UPHQ6biR9b9hwSugeXQ8Z8eE9quEAoNpp/UWY/b4v77Fx9Dlz1/
	 WMoFYVREm+iZ90YPOWB6egdQt1zJvs2deagPaQtvypsigg21MI47zf8NG0Gao8eN/B
	 fMak22IMs3d9tjAAV//sPaaCtCtdjuC17Agzugh7XXmk1VN1L+t2qu40/ci4mP3Ngj
	 Pd2W0gDozfbj82OWERJs0+4T6cHLPJeEP2e7YaQ4paDlxkKg4lPgbLU1FDaolNvo5z
	 jMTQgUGzRjlHg==
From: Daniel Wagner <wagi@kernel.org>
To: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	martinus.gpy@gmail.com
Subject: Re: [PATCH 0/2] nvme-cli: limit printing iopolicy in subsystem header
Date: Wed, 14 Jan 2026 10:37:21 +0100
Message-ID: <176838342296.13428.8512743411331926855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112111731.1631091-1-nilay@linux.ibm.com>
References: <20260112111731.1631091-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_013733_506725_AF4B54F7 
X-CRM114-Status: GOOD (  10.72  )
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


On Mon, 12 Jan 2026 16:45:59 +0530, Nilay Shroff wrote:
> The nvme-cli currently prints the iopolicy value in the subsystem header
> for both the show-topology and list-subsys commands. This behavior was
> introduced by commit d0b4c6cf0006 (“nvme: extend show-topology command
> to add support for multipath”).
> 
> Printing the iopolicy value in the output of the show-topology command is
> intentional and useful. The command also displays additional columns such
> as Nodes or queue-depth, depending on the configured I/O policy. Including
> the iopolicy in the header makes it easier to correlate the output with the
> active policy and understand the resulting I/O path behavior.
> 
> [...]

Applied, thanks!

[1/2] nvme: avoid printing iopolicy in list-subsys output
      commit: 230bc9d4924b99635ae29e2208271c0ee4e39a0e
[2/2] nvme: add iopolicy field in JSON output
      commit: f5b985fabd6d03871161b3a6c4a585888dace801

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>

