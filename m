Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC2FC624D6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wAOVZWWAZyNqiAN1kvJxCkt/t+Qqid7UQt/sGIBG1O4=; b=mbMm3O34tPty9iVNpMJCWjMizU
	spTh4NHAtYFu8U+T6J0O3IozgRoOwuSwshbTH6VOcBu9SuQ+r27jGUc4kygfZprzvqhm6omvJFStd
	L5xjOZzy9+jlx7FZ0+Rc8RlU4TZZNNZehonD2d0zWBHO69ll75VzjvDfeLdJHszfYHyd25VZGTpvu
	t/P1Y+ltpnk42TDflA4m+orP6jTgETP5Qn6gsVugztF+/9LSlT2rwFR8BwFVjlIMPj6bivlJgzodm
	Mxni6+LyVhA1GkJvM5YOT7pLt3zC8d7Ody9m7z8BSKvjuYIEAZmIBxGJf9AJTHMIZy5EPt0oSAFxj
	jiVLnrmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lZO-0000000Et06-1zWh;
	Wed, 02 Sep 2026 14:04:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lZM-0000000Esz2-0H1u
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 14:04:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C243168BEB; Wed,  2 Sep 2026 16:04:00 +0200 (CEST)
Date: Wed, 2 Sep 2026 16:04:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yifei Chu <Chuyf26@linux.alibaba.com>
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: verify the hostid when looking up a
 controller
Message-ID: <20260902140400.GB23598@lst.de>
References: <178782553270.1581249.13595405857993482779@linux.alibaba.com> <5fb6acc2-4ac1-4f1a-861f-13c88b3b9239@grimberg.me> <178814381141.3422569.11201888645559295686@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178814381141.3422569.11201888645559295686@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_070404_262337_73BDDB07 
X-CRM114-Status: GOOD (  12.58  )
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

On Mon, Aug 31, 2026 at 10:36:51AM +0800, Yifei Chu wrote:
> nvmet_ctrl_find_get() matches controllers by cntlid and hostnqn only.
> The connect data also carries the connecting host's hostid, but it is
> never compared against the hostid the controller was created with, so
> the lookup can return a controller whose recorded hostid differs.

So?  The hostid does not identify a controller.


