Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39434C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fL8NUM0qoqK/NY/6MJqA/LhqHXKTAOB7I2xlrqmP72s=; b=faabWURfcIyV57gwwLdZspZIVq
	/JFJU3y+OJHb+5mrOT0Fj5hmThDubKRE5UCWynZZ2ZfR3UgFNdkCAG0/wpV0xxoYT+NE2mDwmXwsQ
	fVXgZoRL0nPHwXDJVt+gb9e9DDkRRsVvwjpBttkIOUiRcLk9MsVQKGw3RTkSHQ/wHYz1qilNedgg6
	tJADDNLInzWCNOhz0kpW6RhAdstlPJpYqLr7b6nfr04SDI3JneiaWN/+KCIsp7MrjL5mcg4uI0RkA
	zgbSIq1z7qpf2oNwUrvf6qJp9GDDnoeIbmEYfbm1FnK8b5vFEvGessCU+WO7FVHeIT2baXfLbWqFM
	n3/Ag0CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Rhe-000000034tE-2Wou;
	Mon, 29 Apr 2024 14:09:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Rhc-000000034sM-09yc
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 14:09:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E310160D57;
	Mon, 29 Apr 2024 14:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB0BC113CD;
	Mon, 29 Apr 2024 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714399793;
	bh=fL8NUM0qoqK/NY/6MJqA/LhqHXKTAOB7I2xlrqmP72s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SD2rNNTfxK1O/2y4y9ZMq9iOx3oXBSnHtGMmUCp2ffN0NvwMfTFpcCV8uoDvsWfab
	 duyinTEd6yBIuoN53QrZPAKP5jwJv9Hfiq58NmPVUVk2S01oHUyF+9zAyhgoZKMUoE
	 LThbcfJz5wd5spuEXQ1Yctgi/mRi8FN655rdjjXYA8l7sCDx2xGvMQvwDFLpVp5iBl
	 YtXZFEx2degxCi9YCcgSPI31NhOsZx1nC3+q3McNMj/eLKXn1p53fXcv+7yyA23Hju
	 IfVXGv6JRDlH8/r1HWaSMTXan0YCLKp1+KR5rpxUIh9uugNpRWwd5Z53ikWGGu1QSV
	 E238hV61wcY0w==
Date: Mon, 29 Apr 2024 15:09:49 +0100
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
Message-ID: <Zi-qLa4LMvRhQFWD@kbusch-mbp.mynextlight.net>
References: <20240418103945.140664-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418103945.140664-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_070956_137954_7C37461D 
X-CRM114-Status: GOOD (  13.34  )
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

On Thu, Apr 18, 2024 at 12:39:45PM +0200, Hannes Reinecke wrote:
> TLS requires a strict pdu pacing via MSG_EOR to signal the end
> of a record and subsequent encryption. If we do not set MSG_EOR
> at the end of a sequence the record won't be closed, encryption
> doesn't start, and we end up with a send stall as the message
> will never be passed on to the TCP layer.
> So do not check for the queue status when TLS is enabled but
> rather make the MSG_MORE setting dependent on the current
> request only.

Thanks, applied to nvme-6.9.

