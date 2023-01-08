Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78599C54EBE
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 18:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SAn8b7OKoMNAjzpl1ISdYKU78cP3QrReMKNVLvk1wWY=; b=I8zEvwZ43hNc0+V2kTs0z5knsU
	iYDuk10EPOVi8QFo/hygXnKbMQBwhazjU21N3HIwE/hgjOrqarXwZ0ABx5pUqZAVDxFoJhkAe+r0k
	NcCwJm5QArS3s7eunfAj8wZP3dC7XZSBar9bkEdpfxcMasH1TWfTeDd83/NyLAz6DtLBQEj/gF3GD
	pPCX6Q0lx77DiZeYtxSWitdsrklw/pvN4oCk1eeY6eMpEuSkwqJJkc7l1QEz4ck21UCh/yoOcTUUd
	3/DAKJkcaT+GJTfFdvQEK5EHrxsA33otmf0HyXJnzX3/C+otWZDYwoZwoDW0c0x/L6QW5fK7FXGJa
	FURI08cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEaIC-00F957-07; Sun, 08 Jan 2023 18:21:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEaI5-00F8vu-6E
	for linux-nvme@lists.infradead.org; Sun, 08 Jan 2023 18:21:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E353F68D06; Sun,  8 Jan 2023 19:21:00 +0100 (CET)
Date: Sun, 8 Jan 2023 19:21:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/4] nvme: always initialize known command effects
Message-ID: <20230108182100.GA25544@lst.de>
References: <20230105202833.3225645-1-kbusch@meta.com> <20230105202833.3225645-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105202833.3225645-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_102105_393104_E8533710 
X-CRM114-Status: UNSURE (   9.13  )
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


> +static int nvme_init_effects(struct nvme_ctrl *ctrl, bool read_log)

.. this read_log argument really confused me ...

> +	ret = nvme_init_effects(ctrl, id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG);

.. until I saw this.

Any reason to not pass the nvme_id_ctrl to nvme_init_effects and
check the actual flag there?  That avoids losing the context through
that bool parameter.

The rest of this looks good to me.

