Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD8FC35274
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 12:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0ix1+XzrUHeW3SM8P8PTlG+1DULoriisMVFgIdnp+8=; b=ARN8R4fSifCs5Itj2bl9adCIxa
	tcWhHOsnE2xIBKBeSxyBxfMr88eeib1kbkzmMYlzVL9dnxt8Ca0/a3VbP9DmkAaqwrYZcuDhw9fDF
	fURdPYybwg/M5gAdTouQKRjT2JjGD/fo20jBHzFfZgrrlRp2Rneh6mmRv3R97dJJOv1MRqankJVrn
	YlkrvhGvElIUG0KpregvnnmxIiGbM+o/rU0IL3YSxg30VrFf8qxoQybEu1BNnFFgpDBP4dDpocPuE
	K3sz+j3oXSh8iL6utqL0a65zm5m4aWDm/KqQfAdWq6hJbYwRt5/jjArBzKVJtb6sXJwAh0qPxvDnI
	WyEYCLiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE7CO-003D2z-2K;
	Fri, 15 Dec 2023 12:21:48 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE7CM-003D2K-13
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 12:21:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 81E48B8280F;
	Fri, 15 Dec 2023 12:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87969C433C9;
	Fri, 15 Dec 2023 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702642903;
	bh=mKvw66208JoF6z00mvlbMwVEaWAp39j8UJsdMCytpbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoW4FVSAG5p/T74Y0Cnr/wmvHchsQfs9q0IXhUH4BMJFBgd0aDnqERZvzKuafgBun
	 fvnlga6/YTlWxUW93XhlyX7/Bdta3iRwI59+gUskcfuLP97LyVOlUmRrFf6aQgwkO/
	 +44r81yJd0HYgA5FwTNt1bjf+MX/ArxNwXc+IoV8=
Date: Fri, 15 Dec 2023 13:21:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	linux-nvme@lists.infradead.org, rafael@kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <2023121533-impale-nature-0ad2@gregkh>
References: <20231215000358.1203338-1-jallison@ciq.com>
 <20231215000358.1203338-2-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215000358.1203338-2-jallison@ciq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_042146_530591_5B3C6968 
X-CRM114-Status: GOOD (  10.52  )
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

On Thu, Dec 14, 2023 at 04:03:56PM -0800, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> This changes the bus driver interface with additional entry points
> to enable devices to implement asynchronous shutdown. The existing
> synchronous interface to shutdown is unmodified and retained for
> backward compatibility. shutdown_pre is only called if a matching
> shutdown_post function is also registered, otherwise the synchronous
> synchronous interface is used.
> 
> This changes the common device shutdown code to enable devices to
> participate in asynchronous shutdown implementation.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> Signed-off-by: Jeremy Allison <jallison@ciq.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


