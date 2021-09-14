Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D05C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 08:28:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E51760F24
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 08:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E51760F24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oBm31Wm0EJBq/Pb1X9GzPcvko6hWj+J9bxM7ApbGbD0=; b=V3GhDpTHb/SpKf
	QJeHA/o5bOp6Hnz9G0R923jfLaZ/ReKhGOgtF3jtnzbhSGLq8wFsNwzxyNMppdGLVWY8OkncM1A0a
	F+hsLBhGl/txEzTAhoV6Lh8duXfGvtZ/5aBBFhueb/GZzsJYk8G1vGtwdapcXGJqrW0dd1KDXW0CE
	pBenvojc8XhkyiEzlWr96u1TSJ7rD9k7O/XlLpxxEhow3Rs3heAF2UvUrMZddKfk3qdEyMxc6xPSd
	aZ4JBCY0xZvklGYAYiOVj0/FfgzcXVWSeOPbR5AKF8Vx3HsmC362zz8cUw+78c/No3e+YvCDaRZ6P
	MEXv6bUQZ0lwEFBhWhDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ3n6-004fuL-2r; Tue, 14 Sep 2021 08:27:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ3n3-004ftS-4I
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 08:27:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 63FE767373; Tue, 14 Sep 2021 10:27:37 +0200 (CEST)
Date: Tue, 14 Sep 2021 10:27:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH v2 1/3] nvme/multipath: fix failure to update ns ana state
Message-ID: <20210914082737.GA4904@lst.de>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-2-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913153023.70879-2-anton@lightbitslabs.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_012741_364375_5CA417B4 
X-CRM114-Status: UNSURE (   8.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've applied this patch for now while we're still pondering the sorting
of the namespace list.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
