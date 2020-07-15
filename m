Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6388C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 00:55:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7571C2071B
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 00:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aNyI1WbQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOr7XfOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7571C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ar4e7yRHHzeezkNB7ou3Qkn/O6+GklEAVAufiCh6+Eg=; b=aNyI1WbQto+lQ01XXQyV/pNCf
	9Myz3gcShL3XrH5CyYYRQpyuu39XmDUn9CgPm/YMQ+FSbKEAkuT+7BvlU7EMrHlisNiTAy7xDvuii
	U73MOsvIpaQWY5UiDqhVOuQgNVni6gqXGqtPYxPOdexfgbV2dYW3scIlxvpPuKpIdQZsy6cJkLKDN
	FnYrgPOFnm4WZgcgklJW093njM2Lxq35DrdrTGZ1o315Iyadg3sX4Xw/RnC6TosR43KD+yrT4lA02
	6rUcNP2rzUnTJRxVvFFiduCYanhUOzX2srxrjXJZ9D80vA4KRKhpyo2PwTXs+Wki7/c6GTlNwgCya
	LUpHSYWEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvVhb-0002x8-Fy; Wed, 15 Jul 2020 00:55:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvVhY-0002vD-Q7
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 00:55:13 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E1C52071B;
 Wed, 15 Jul 2020 00:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594774511;
 bh=ItzZ+HJABDzi/CDl9Ip47V+0tlTWk+2tTgFSxQIVfj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vOr7XfOsYgTn05+xXV6jGj0WhUMgO2unPv+xwf1Ao+Q5JHIgPYI2piWilmEgxsg2N
 9GDH0nEDQY4xA8hWK8HXVac5AYQQ/9N6ZxATVoV6gWesW8r1kqu4ESlY9+isCoU35W
 FhEIDHucELxNihgPASMOBwfgn30ASikbfic4mFCU=
Date: Tue, 14 Jul 2020 17:55:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 02/10] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20200715005509.GB2772284@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714233057.10915-3-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_205512_964012_E963F5AC 
X-CRM114-Status: UNSURE (   7.78  )
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
Cc: linux-nvme@lists.infradead.org, hch@lst.de, willy@infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 14, 2020 at 04:30:49PM -0700, Chaitanya Kulkarni wrote:
> @@ -3933,9 +3918,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  			blk_integrity_unregister(ns->disk);
>  	}
>  
> -	down_write(&ns->ctrl->namespaces_rwsem);
> -	list_del_init(&ns->list);
> -	up_write(&ns->ctrl->namespaces_rwsem);
> +	xa_erase(xa, ns->head->ns_id);

Since you're using rcu to protect the kref_get() on load, we need a
synchronize_rcu() after removing it from the xarray.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
