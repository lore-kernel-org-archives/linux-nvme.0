Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C2C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 09:37:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39556144D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 09:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39556144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Js3QLg46z+WX/pELT1sTsEhoFCZeFZxHWLMvysSI7iQ=; b=CZUFEwPFYFxXz1uaLNf7W5OH9
	DxAua8AF0H0XKR801cQQGOdfwFwSBVQrrcvy8/G7q7MIMOm21mQzP/lrPonLeIT43OLPcGbp6j9kK
	7uwx///RVPGvXUX50BVesyPHZJyOV6YknZZ5NpApkxFi3EibC4CeikwD19CSmVYtdeliLOSztkExs
	FhVYRG9zk3G9K7mYjZChYJzQm8o03+Smuno8Q5XvaeQ0qVCOhhpY7+SLkgaxr4Rc8qKzESX+huz99
	HLGRCBL9/bLAEOV0xoc3d0U9DH+tQqNLOzOIZc6o7UXmCeTzMw/pkTBGOnugEZEsGISCs3fPOheyj
	HtsY0pMdQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZsEl-001BdO-2F; Fri, 23 Apr 2021 09:36:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZsBn-001BTL-J9
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 09:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=FhcWkJNOytqtRu8SjegGwTKIkUQYX+yghzEb9UHjuJA=; b=WaLRtTlCx2lUnwXhjMTndhCsCp
 mrjIun91zHlOKYDX15jeanO7yRh+GKlnm8AWy80R085YTR4/JPhJXuunktdk/F7cHD3gxwBQuPf0h
 ROsJFBMZPxvao8S5NEnEuvkRUdK0AuUyV2qCsspFJOBefeWuKmgttiLA2BqLJHwMxTTdozGgWCnO7
 U0MMd6QrQlEoFBISx24HlHDfj0EB4+p+sSlYUINc3SLK7/XHv9A3SWJQ2CkjwKJB0/40WqQzLyWJ4
 gHl1Tk8Ic2qBE2t39NyXVr6fpLzyAOvHRYRUk3gc8ngXXIaXza1PhVwGal7oct6OX0zN0vffe8Dsb
 qTcB3hBw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZsBk-00EHyW-UU
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 09:33:30 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619170405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhcWkJNOytqtRu8SjegGwTKIkUQYX+yghzEb9UHjuJA=;
 b=iuyIePeIcOSSknfB48pJshAPZrdLKHHJRxDWcUixuu81wew8E8E2hatn3CM3FCK0F2pZ3X
 xNfqhTCxlt18OZDZBJNa35Q2RMiByzBYfem9UrwTgSw9zfJIDkXdfzbjpq9GrNzyCjZYaS
 0GXgvbpJE20ahSwolbFJ9gMAAuclRbU=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 77679B020;
 Fri, 23 Apr 2021 09:33:25 +0000 (UTC)
Message-ID: <bf56cd86d579a9b3d669050345529aa056ec8bda.camel@suse.com>
Subject: Re: [PATCH] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
From: Martin Wilck <mwilck@suse.com>
To: Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>, 
 linux-nvme@lists.infradead.org
Date: Fri, 23 Apr 2021 11:33:24 +0200
In-Reply-To: <1c178648-8740-401b-86cb-ce65ffc7d7dc@huawei.com>
References: <20210422152219.7067-1-mwilck@suse.com>
 <1c178648-8740-401b-86cb-ce65ffc7d7dc@huawei.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_023329_162213_4E807EC1 
X-CRM114-Status: UNSURE (   8.93  )
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

On Fri, 2021-04-23 at 16:35 +0800, Chao Leng wrote:
> 
> If ana_work is running, this may cause wait for long time, because
> nvme_get_log may time out(default 60s). If work with multipathing,
> it will cause fail over delay, service will pause long time.
> It is not we expected.
> We just need to do this before reconnecting, so move it until
> calling nvme_rdma_reconnect_or_remove.
> Like this:
> ...

Thanks, that makes sense. I'll look into it.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
