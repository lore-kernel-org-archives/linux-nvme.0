Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540BDECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7kmweO+309UeilNVazgcoeO59uTu8XFTJRE3CshKVb4=; b=Mux4LfGVJChxd69LRCXs23aySJ
	6e8ECYxBGNLBrvDQb6V523RzXWEZ7wB5o7XsPmQ8IKvnsNvFULiCc986BLcEVSS4JJg5AvClTFHBs
	+t4qQUuxvkMFUrWltHnfrQSO40HQlutdlADRwifc+Tiwwh/ysNagJ0AjZUSzcPyg0+p8JC/pbxIQC
	nrCVxRvc8R0ezgTYpiUWf8qbobnwQ+nIn+iuoDwyN2ftA3VVEo47EBSFS3BlCp/Ztroq3e//Qpkp9
	X827RZaIoUSWcPUfOGO0F5i7m1OWUtPpFeeNK0JskTm6xHrHVeyts4Ljz0yHq7i86gZjKiKmzLmxS
	D9BZObhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCmB-004AoJ-HW; Mon, 05 Sep 2022 14:08:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9sT-000oYM-6p
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 11:02:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43A5F68BEB; Mon,  5 Sep 2022 13:02:50 +0200 (CEST)
Date: Mon, 5 Sep 2022 13:02:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jackie Liu <liu.yun@linux.dev>
Cc: sagi@grimberg.me, hch@lst.de, hare@suse.de,
	linux-nvme@lists.infradead.org, kch@nvidia.com
Subject: Re: [PATCH 1/2] nvmet-auth: clean up with done_kfree
Message-ID: <20220905110249.GC21823@lst.de>
References: <20220812031231.3386953-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812031231.3386953-1-liu.yun@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_040258_173116_70B2B273 
X-CRM114-Status: UNSURE (   7.67  )
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

Thanks,

applied both to nvme-6.1.

