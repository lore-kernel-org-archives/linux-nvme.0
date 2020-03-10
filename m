Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F62CC10DCE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:52:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CC5222C3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 20:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lU01sNnb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZUtX49t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CC5222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pj8xP7rdEVOdXY3LSKqV6BMfbbW4kTKYxt8z06N+n2M=; b=lU01sNnbicbUt/
	gRr7HU67Onao/BXhGgXPJY8HAdxccB5SEFUoBAqjDaanuWFukesmYVAW10gTH/rXNtgTt7KnQ9scw
	tgXqMe8QXQCeb74w9PyXyz+t32ngWHcNbJ05rRYEdscCyjvPnoVxQh0GBgjd7W27vr/i3oO52fShD
	VS4uhvDyedDg4/0CkLClTH7G71+lzVx5RiuciNZ30YcZ5o7Rev0MRhV+jxQXW/gBrLu0s7yagq2Of
	hCopx07glL1eM4SclAY7omI/bn8CrQak3oGASWI59l2ldcIuWY6Uy+EjWceLSKI6a/YgmmnuUf6ha
	otKYaxwwomJhajU7GE8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBls0-0001p6-Px; Tue, 10 Mar 2020 20:52:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBlrx-0001oZ-R1
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 20:52:55 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DBF16215A4;
 Tue, 10 Mar 2020 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583873572;
 bh=yai84RkOrWCBvQy+zjhigd14iq991isTYtyMhYUlZgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fZUtX49tnW/xV99wsmydjeyXpLzUCELOq/5dBgKPpCbbsueLh3muM6/FOZhgsPOf8
 yrHdHnGcAUZBpAGG+qetcSyYjOpZa7n8S7UyNceA0wkXvgsOsT1jPAtXK9mkXiIhfy
 kyHMEb2WLEExdTPWRoyxndnuguduqq2xC09pHmPo=
Date: Tue, 10 Mar 2020 13:52:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH V3 1/3] nvmet: Add get_mdts op for controllers
Message-ID: <20200310205249.GA604509@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200308105505.14305-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200308105505.14305-1-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_135253_910016_2F3E4A13 
X-CRM114-Status: UNSURE (   9.53  )
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, bharat@chelsio.com,
 nirranjan@chelsio.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 jgg@mellanox.com, krishna2@chelsio.com, hch@lst.de, bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Mar 08, 2020 at 12:55:03PM +0200, Max Gurtovoy wrote:
> Some transports, such as RDMA, would like to set the Maximum Data
> Transfer Size (MDTS) according to device/port/ctrl characteristics.
> This will enable the transport to set the optimal MDTS according to
> controller needs and device capabilities. Add a new nvmet transport
> op that is called during ctrl identification. This will not effect
> transports that don't implement this option. The return value of the new
> op is according to the NVMe spec definition for MDTS.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Series queued up for 5.7.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
