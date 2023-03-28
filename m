Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B7C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 00:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=isz6ItFqXBDQF2XE9Nzuq/ZBXNVJ9Zioq4Afkfa0JHs=; b=LdadpO0RCEYydOmPA3Dd1ze/fL
	23SYb/dtECP6UXC9HhNvZsb7mdJ9pbejVghCmEI8OcrTezefu/uKmWGxdIu0BMiU0KZj4lfH4gJQ3
	iUyBfsdvlks71IzdCACDeA/plq/qITaw+HIOOP9+0DPOqBA8d4XeyI4rS8fTYMRVi2GomBeVtV+JZ
	IouXa8MLbu0KMAWVtgvR0Ubf7euwGAxdLo2smVjjG3JLqhRFXcIBiMHtj6nFvYZBCO0VYKIElhCr3
	kU3yQWsOU3TfQrsMHX4CArtMuux2NoJpFMOACmoyvZAofw2/yt6wL7rXZLqmS7ugb/7SwH5VQo/XA
	Ce7d7bUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxce-00CkP1-1B;
	Tue, 28 Mar 2023 00:55:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxcb-00CkOf-0I
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 00:55:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 58B2B68AA6; Tue, 28 Mar 2023 02:55:29 +0200 (CEST)
Date: Tue, 28 Mar 2023 02:55:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, p.raghav@samsung.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [RFC v2 3/3] nvme: ignore starting sector while error logging
 for passthrough requests
Message-ID: <20230328005529.GA21497@lst.de>
References: <20230323230316.2914077-1-alan.adamson@oracle.com> <20230323230316.2914077-4-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323230316.2914077-4-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_175533_275949_ECAB8335 
X-CRM114-Status: UNSURE (   8.91  )
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

Yikes, no.  Anything that needs to poke into details of passthrough
commands is fundamentally wrong.  Maybe we need a separate log
message for passthrough that is just based on the cdw values instead
of trying to decode it.

