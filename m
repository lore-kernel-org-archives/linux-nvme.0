Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03359C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 18:09:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B7964DBA
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 18:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7964DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JCuBSmyGQOkuVjpdh4srl+xDMmGHhur1kL7QmzuRPBE=; b=kwjavNiaOlMmLFjiB2dwXgMGE
	BdrMxOkgpeSvR+sc4fQV//O6TR3oE84diLjdVI1FMQHHsH7gj14GZPlD0UDjFx/VD8HG0WFmsxDti
	zsv7JPqKdcM0fo5MVriSCG/VDAI+hxh0PIR5PuK2eNz1VovTAYBDql2RaaankKeDARSoNPY3J3f/z
	tqedvUlBqANo0h42MD00BzzutUXd/sK1i+h4sEAB5oIwhqa9TKtMXY5NSy0598wrGOts1MFY2xHb0
	LkbVV/YdAhWwzYmv2NYgzJpzPqtw/rs/wtvCK+rstQukRrsTiR2tAl3qOqG9KBaDdaEJnedcNAM/c
	6Q81yCMjg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAcsM-00052C-Ho; Fri, 12 Feb 2021 18:09:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAcsH-00051Y-UD
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 18:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613153341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IsKCNOETLXXhO0vv4Uv4utq9x/Y2rRSM/dS8wn5MRYQ=;
 b=AxH4rHpWe6SICotjqRisRp8JlHpKQyXnDsvPYDTvtXcfObmVLqG6EJtDDwrlAKPjptjzmQ
 TfvdKMH9mRL3aywii1kS0EB1gx3Loi+mFrM7h08/3q/prgxM5O74SZmmQ8tidE0FONSLj1
 nAkiFKZnlkNVdkofk+t8mCIp2atA/6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-R1WhqZ39Npi4u-1T5zwSEw-1; Fri, 12 Feb 2021 13:06:44 -0500
X-MC-Unique: R1WhqZ39Npi4u-1T5zwSEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FB5D1934104;
 Fri, 12 Feb 2021 18:06:42 +0000 (UTC)
Received: from localhost (ovpn-114-86.phx2.redhat.com [10.3.114.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40A4F19D6C;
 Fri, 12 Feb 2021 18:06:41 +0000 (UTC)
Date: Fri, 12 Feb 2021 10:06:39 -0800
From: Chris Leech <cleech@redhat.com>
To: Shai Malin <smalin@marvell.com>
Subject: Re: [RFC PATCH v3 00/11] NVMeTCP Offload ULP and QEDN Device Driver
Message-ID: <20210212180639.GA511742@localhost>
References: <20210207181324.11429-1-smalin@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210207181324.11429-1-smalin@marvell.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_130902_281419_2D5E7CB6 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: aelior@marvell.com, sagi@grimberg.me, mkalderon@marvell.com,
 netdev@vger.kernel.org, linux-nvme@lists.infradead.org, kuba@kernel.org,
 malin1024@gmail.com, nassa@marvell.com, Erik.Smith@dell.com,
 pkushwaha@marvell.com, davem@davemloft.net, Douglas.Farley@dell.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Feb 07, 2021 at 08:13:13PM +0200, Shai Malin wrote:
> Queue Initialization:
> =====================
> The nvme-tcp-offload ULP module shall register with the existing 
> nvmf_transport_ops (.name = "tcp_offload"), nvme_ctrl_ops and blk_mq_ops.
> The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
> with the following ops:
>  - claim_dev() - in order to resolve the route to the target according to
>                  the net_dev.
>  - create_queue() - in order to create offloaded nvme-tcp queue.
> 
> The nvme-tcp-offload ULP module shall manage all the controller level
> functionalities, call claim_dev and based on the return values shall call
> the relevant module create_queue in order to create the admin queue and
> the IO queues.

Hi Shai,

How well does this claim_dev approach work with multipathing?  Is it
expected that providing HOST_TRADDR is sufficient control over which
offload device will be used with multiple valid paths to the controller?

- Chris


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
