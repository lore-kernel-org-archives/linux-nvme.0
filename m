Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687C1C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uvw7Hy61EAO3vUK0yWnm/P6Dg5qqO/VMOaL84LW8RRg=; b=gLQTCjCbq45RweuHDWtwrEqb4h
	b1NdSOE1uNw08kZU05BbneHAmi/q/hXbxqk2Beq2WlKzi2QwPyW2RMOb8M3IDjCaxJ7cC8DABmcST
	CD3kb76aAB6GMiAOd/IrRVpoI7vPwF/5CMqjpDfQzqosK2C7f96O4sTObuTG84OvOO8yP+Lrakett
	Iqsdi6Pbys3hi/tjoKWzDSAEKkao9RALj5MgVS6tWIsBXfORWO90VBt8VnnLgEvp7YfVfcExx6+RU
	r0palQuKHbOFW4WIctMeI2iHvH7bdD3JTDqdNpOL7aAubpZ0fmwlz5Gbi7GS7rKvAfMDh/UUtIuU/
	UxTJ7Glw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpYZq-002rHS-9J; Tue, 23 Nov 2021 16:23:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpYZn-002rG4-7X
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 16:23:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7502C68AFE; Tue, 23 Nov 2021 17:23:20 +0100 (CET)
Date: Tue, 23 Nov 2021 17:23:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org
Subject: Re: [PATCH] nvme-host: prevent nvme-cli from setting invalid
 fast_io_fail_tmo values
Message-ID: <20211123162320.GC23957@lst.de>
References: <20211112141612.201297-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211112141612.201297-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_082323_451396_6C2A8E0B 
X-CRM114-Status: UNSURE (   7.33  )
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

applіed to nvme-5.16.

