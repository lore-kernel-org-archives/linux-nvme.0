Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C882C47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NNJSR5WEhC6LrLGrxpi9YwVPzAVRx7ErajBcMIzdRGk=; b=TVJv7PRMenF+i21D86zLfxW+iI
	OBeLbFCPtHYvC5jQ0z9ZzsFvi9zRHp8komUudf3HKIwgMG5pdAeO2vL5ef2N9ag0Zl2wDuNLZMJq8
	3DNG93cCyGUkj11EXdsA91Hyw6fIfDCOldIyMGH3N/6sL6p8OIIzfMepxzrW5xnLfqTOdL1ACEf82
	KMf3FogKnwgdnH+bLobo6pemB5xuwPa4Eumx9o9SrHPgnv4cnkoH/0eZzR4/eVkgNGE/FIObHLzKp
	dMUyJoJ8nFJSnTzEnbDA22h9lOxafl7vwU2flVaOyObMX+Xby72ORTa1ffLcFXQIN09SrMxLgAs6/
	FtPygQaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTPqb-00000004r9e-21MH;
	Fri, 26 Jan 2024 17:18:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTPqW-00000004r6o-47v1
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 17:18:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 27CA462490;
	Fri, 26 Jan 2024 17:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52142C433C7;
	Fri, 26 Jan 2024 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706289507;
	bh=NNJSR5WEhC6LrLGrxpi9YwVPzAVRx7ErajBcMIzdRGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnLMSFnj3vTXlROqoMmgS8Z6Et3CrgOZijy6b3fryHSezRD021oKBym/iwl9BMgZ1
	 ecGg3EEjHB4Y3gJNsMPcuT8zg3G2o0NWNXRVrhSq/tosMoif8Rd81Zg0UMfJM0vC8A
	 gtEhyVqJc3lLgHlosTcyALl4Mt6c3BmLC65NiVzlVrQdiAw9QzwxiuAB66/+/X/Ejf
	 he0QmpNUF1nmHCKc9rPJiTr6pneSWESsG3POVFviW7FRu2UZKVOTa0Ipg78vc4mLQD
	 RaFOzlzXx/rEFMgrJXdFEWAPDCOBOffMGkkObJgcgNSU0DpGdCc+vnObiG2TZIf10u
	 dW+prZ36CZy2A==
Date: Fri, 26 Jan 2024 10:18:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix nvme tcp ida memory leak
Message-ID: <ZbPpYHDYV8guAwOb@kbusch-mbp.dhcp.thefacebook.com>
References: <20240126082643.37656-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126082643.37656-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_091829_329925_F3F71F51 
X-CRM114-Status: UNSURE (   7.71  )
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

On Fri, Jan 26, 2024 at 04:26:43PM +0800, Guixin Liu wrote:
> The nvmet_tcp_queue_ida should be destroy when the nvmet-tcp module
> exit.

Thanks, applied to nvme-6.8.

