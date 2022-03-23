Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55418C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=IvlfYbwuvVhdWGFlIHJqJRxYnU
	cP828ZdW+s0HhfVe5+qhFRf9UYVhtpuzok0YBrzu+BnwiJVdmeYLtTaaAXPdCKWfToNDHF08GkTs6
	m0l2h+yyqEruKKBjmas5FV9fBoD3ee/zRCeKUmCMRzpWyFiJ7GONWLar8w2qRaDfLmXeSpqGTXNJS
	BLPkBR8I/vgoO0c8PBSmQKZHdrO4uB4taudeLy2OX0qlXajlRZ+L4c0p2yy+ZKc3Q3UYUT/RSEeoC
	EBTQ+8AredUqQ24PBEwkW21wTjIUiNrEqsNfJG8Lk3dofgj6h6ggtFzFUybXMX1GyG6uHCY4pd29l
	l1zO6Z0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX2od-00E4TJ-Cr; Wed, 23 Mar 2022 15:22:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX2oX-00E4QR-WA
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 15:22:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D34AE68B05; Wed, 23 Mar 2022 16:22:12 +0100 (CET)
Date: Wed, 23 Mar 2022 16:22:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, ushankar@purestorage.com,
 Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH v3 1/1] nvme/mpath: fix hang when disk goes live over
 reconnect
Message-ID: <20220323152212.GA325@lst.de>
References: <20220323035551.1524128-2-anton@lightbitslabs.com>
 <20220323144504.1557518-1-anton@lightbitslabs.com>
 <20220323144504.1557518-2-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323144504.1557518-2-anton@lightbitslabs.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_082222_232155_915371BD 
X-CRM114-Status: UNSURE (   7.82  )
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

applied to nvme-5.18.

