Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043E1CA9EAE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 00:46:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01B420659
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 00:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GOkRxkKP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zLAkol/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01B420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PFrdanssNUki0xWmw6LobMYEwH2hiQdHj/U4RVwHSUs=; b=GOkRxkKPjnf5g+
	K79CAtBRLnhAnHCU/f3r7ihSlAdT6YFlnn/ktDkHuASDFg12wXfiy8ZSlOWbeoMs1Mlm1vbyD3LNd
	QLFFHFsQFtACuq8x2c9PjgoDARQMqUTWCwYhWhFiJuz015ZQlTQJ3twAxQlVqjgWDtEcXH47GR7AE
	zldbcJGJgfL5wZitClfjqB+D5T4k8JiCubRt8qrwe5Ys/wh5gPk4SdZKp7SvoqTCVg/1EIjonXJSL
	U/lkqTUvl3X8hfMI2im+5HNSnEkM7a2WQzlMgOVGYiuPnBuo9ZoN+KC6Pa+HT14ZfhNvc3Dv1mov7
	HD3xgflHcYUKDyq7c9TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPc8P-0005Z7-Q8; Wed, 30 Oct 2019 00:46:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPc8N-0005Yo-K9
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 00:46:48 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49B7920659;
 Wed, 30 Oct 2019 00:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572396407;
 bh=kU/ViuSuZqTFjDVM7ycCIhIS9CF04caKOB2FC85DW9w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zLAkol/6GiGQNUfYNXy9eHExVTgVQWNpUj7yhjWYN0x1miMcE+WjPVw5lwd17I3dV
 8oPzdXO4mqEn4A8UQi+DCQCI6W5Zu5KAOOlfqQ8ocYsMCqvsFPEZr6sVxlVnNiyWSu
 vynJN38Jrb2rcPBGAWz5e/gTTxuqt+HTi8tOmzcg=
Date: Wed, 30 Oct 2019 09:46:43 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvme-rdma: fix a segmentation fault during module
 unload
Message-ID: <20191030004643.GB15332@redsun51.ssa.fujisawa.hgst.com>
References: <20191029144227.108450-1-maxg@mellanox.com>
 <badcd22c-54ef-a4ab-2080-55f697b184e8@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <badcd22c-54ef-a4ab-2080-55f697b184e8@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_174647_677899_3812DC9C 
X-CRM114-Status: UNSURE (   7.09  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, israelr@mellanox.com, hch@lst.de,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-5.5.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
