Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C72CA5FA1
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EcatbeX8pT4mVPK6BtLsmrFUIWcm+3T6irC1kikWPR4=; b=nXtQF48AHu814p
	n2TA/PgmUU96rhF04LNcn7MNdUW4I2kcIe1igUVmoJWxs/WQ2z4gCTOp33h8lXibe1Nmha21q1K0Q
	djlbg5aif3OR+93jk9Dju/PPjLPB++I+gMBAPtgD70atevJaLD/dVOco4uNbZDY/9ZFlPsUfNVVCL
	lnCFJnWLaA5WXbn8w+Puf3vPCF59hTHe8dk2ezodf2x8CrZk1krB/7HbFLRyxanYjBOK0ndmxrLVe
	UmTjREd4xHKwVzBhODdPenABmEIJ/18G2aywHhJTcLwpObbVBivIAJFmE6fhVARqvYYwvDtukpLHr
	q8mdwDHs6DnT99nsTydw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBDcs-00000000wj4-21Fw;
	Mon, 28 Sep 2026 15:50:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBDcr-00000000wiR-2C1n
	for linux-nvme@bombadil.infradead.org;
	Mon, 28 Sep 2026 15:50:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EcatbeX8pT4mVPK6BtLsmrFUIWcm+3T6irC1kikWPR4=; b=YzeTe/tRpsOaNbP+M2JUqhVWbJ
	yIApHhfCWev/LvyKCqTPUNTttPFTbIXWn5lamZKvPiHK1TQ34GxZPUpMBKp1dvkXY9mDxHDt8mwlJ
	JFRw5/i9BjmhA2aqa78U+tUZuT0roT0JUupz3pw0yQavZcrCTibBG8xZ4Z5UYSEqXPRYzp/zcPpSv
	xvi8EtoOqInxpD72khQ7dCNMrAdFrHZ6tg03BuQe9qrwdVP76ru07lXS6gCRZ5J2k4Q+JfHVGm/bD
	Yl0JTBSfXjVbcDj5F20VU9P50WJiAS45scopUBNNPJYPN9JqC/Gcd3Cp+Pvu22HTG73CshKXEdh6s
	WF0WwVQw==;
Received: from ale.deltatee.com ([204.191.154.188])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBDcn-00000001e3X-24dW
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 15:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=EcatbeX8pT4mVPK6BtLsmrFUIWcm+3T6irC1kikWPR4=; b=AO5vxrXSpbuxrRe1o/Rwqoj9+l
	ZpvZj/1lkh9zWIRW26x0izwnq9XN8z/XAVRabdlg8WdIT97E3U6wo0FnI0WvtxkyU0WMDHdgMurBx
	dv+Bg39Xo+FlH+NFh9HVpqB1k6iVC0wjn9a0T4Eq72xh0tfJfiUFSaZUYsA9tiFjAXYpV9jnQSwU3
	NMBNGdodHI3Ukh16lorAVFbQMJfVDioDgaL40BZ4wO/wwiesBez0UxAnPNSlVjrCd6Gc+QIZzOF6I
	BGkWg1grtc5tbZIn6jrmXNQtR/jMq4OYVbP7gW0TscEWs+l5blvP8DxMkE9IfcPs1KtV9VAA59vZP
	x/eYP9kQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xBDcS-00000002TTV-0wIr;
	Mon, 28 Sep 2026 09:50:21 -0600
Message-ID: <62fbc3dc-421e-40f2-8f9e-d28a706cf64d@deltatee.com>
Date: Mon, 28 Sep 2026 09:50:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>, Andreas Hindborg
 <a.hindborg@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <mkp@kernel.org>, Lee Duncan <lduncan@suse.com>,
 Hannes Reinecke <hare@suse.com>, Nicholas Bellinger <nab@linux-iscsi.org>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260926092148.128937-1-runyu.xiao@seu.edu.cn>
 <20260926092148.128937-4-runyu.xiao@seu.edu.cn>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260926092148.128937-4-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: runyu.xiao@seu.edu.cn, hch@lst.de, leitao@debian.org, a.hindborg@kernel.org, sagi@grimberg.me, kch@nvidia.com, kbusch@kernel.org, mkp@kernel.org, lduncan@suse.com, hare@suse.com, nab@linux-iscsi.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 3/4] nvmet: avoid recursive configfs open for passthru
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_165041_913287_8C95BBBC 
X-CRM114-Status: GOOD (  12.86  )
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



On 2026-09-26 03:21, Runyu Xiao wrote:
> nvmet_passthru_enable_store() runs as a configfs store callback while
> configfs holds the item frag_sem. Passthru enable used filp_open() on the
> configured controller path, so a path into configfs could re-enter
> __configfs_open_file() and try to acquire the same semaphore again.
> 
> Use configfs_file_open() so the path is resolved before opening,
> configfs-backed paths are rejected, and the resolved path is opened with
> file_open_root() while retaining the normal open-time permission and
> security checks.
> 
> Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

The problem and solution make sense to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltataee.com>

