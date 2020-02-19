Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A9C34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:43:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C16524654
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GfZAe80+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw9DVZZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C16524654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j5ui948loGP3J1LZXj7pJlogUAK+8y8N+T519zmD2I0=; b=GfZAe80+5PSc76
	Kjn7N9r3i1R1p12EP+3Alf6eQxqOlGiJLNg9yn/w4BNcOheTgsx65TpFSNqS84oxmniFfhmCaZATL
	weSXdnf2YAlqDlXctEYAFWmWugBdUW3MAuVI1wI5ZLncuw2+js5Z0ZJN3czWKVn/64HUbjfUxQkuX
	fGs+ryOuGPYod6JjSLozgRN+ZHzTjHd350oAJqu8YO5jhknhySTj8wUqSmDe2ZFianR8xuQTt2Ta+
	H42y0ymWnuLqZrt87bqi1/dNplx0v5YtPfF3Awf6Z/Gj+YLQchNxPL92IB7ymjLLw6BIIcIquQdca
	TXd9qq2C9dgDHylizYLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4RVX-00082r-K8; Wed, 19 Feb 2020 15:43:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4RVU-00082X-Py
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 15:43:25 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4174124654;
 Wed, 19 Feb 2020 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582127004;
 bh=qyRTQnbymGz7JvcdQ93OUybu3ysd0cS126TW1W5wvm4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rw9DVZZMAE/BiKxG/BdjJUwngU+kk3/GFwcIZAjNAfOb5NwmdklzTWHdriUeKAFdR
 Cs/B2QT7cB1AyIuH+nPaTuU03AqvyOzeh960+Ay35Vndu5xxXo2KIqFMsM4jBnRpsD
 whgFngRnKY8YWvSZLiPTeangiy6K7JVczOtyLTj8=
Date: Thu, 20 Feb 2020 00:43:17 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme/pci: Add sleep quirk for Samsung and Toshiba
 drives
Message-ID: <20200219154317.GB19728@redsun51.ssa.fujisawa.hgst.com>
References: <20200206201725.313163-1-jonathan.derrick@intel.com>
 <20200219151058.GI17748@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219151058.GI17748@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_074324_865203_7AB019F4 
X-CRM114-Status: UNSURE (   7.31  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Shyjumon N <shyjumon.n@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Patch applied, started a new nvme-5.6-rc3 branch.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
