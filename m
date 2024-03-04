Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B56C48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=; b=SxEKabSRR543SDq1GoSNCmXMIb
	dJu6Evgewr/GRH+VDj8hjndt5BfSbNPNQ1Ghap1mMDOfJXTdEHVfAQuiOLAic+YT9VTVh6VaiWYhM
	uefuwIInuTzm2uj+vxMuCAsZRFhFQJwq013cSZQUq4x+tyXT9oDT0WznaPgk3Myp8fdbEOOudPNvE
	xb+hUnaRFuZDRwST4S1NVKj4dSnzADS+8+klsPbAy5KadbAWb6hDS2GQz/YG3fFWFvTFy+ifMHcCb
	4xHicIORVuMI/CZeOCjPSDVZBH+ESMTf3dQXDOTB5DtvB+pP6r0FhJKLwgOCxFDNPbbRrsL00lzzF
	Po0c5aAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhBAI-00000009pZ1-32wC;
	Mon, 04 Mar 2024 16:27:46 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhBAF-00000009pXN-2aqP
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 16:27:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 53EC9CE0A27;
	Mon,  4 Mar 2024 16:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8620C433F1;
	Mon,  4 Mar 2024 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569660;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/nwn9cQfmkoewWXmnWsIMp/UwRQcvCtKIXpUxU+/8LNmGzYSUOmxH1nKnJC3IMTb
	 2oIpIqzB9xKp+qF/oHxzsV6PeI588pEdOkzrssvH4QbKOseONm+FkOz489N0PgKbfH
	 CMwYc8vLZMnU8WQcfJIWxKArKNj+8q7n6ckQKov0uhoi/9lHyk9Hdna87Up0o+G1Ka
	 Ow2jR8LFFWLFj61I4f2+feaL2nFj7lkOjodmVzw3+tZEG5ip8xx1sid9WCytor4AM2
	 yYyyOJGLwqJZ+2sHytn5EpRJYRWCILwVl/WoOARLaMYTLILafuvsKPUh+qntKEfxsR
	 +AeILfxpRV6sQ==
Date: Mon, 4 Mar 2024 09:27:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: convert nvme to atomic queue limits updates v2
Message-ID: <ZeX2eSKE5OSAgbGh@kbusch-mbp.mynextlight.net>
References: <20240304140500.78583-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304140500.78583-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_082743_855056_B95B1CE0 
X-CRM114-Status: UNSURE (   6.75  )
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

Thanks, applied to nvme-6.9.

