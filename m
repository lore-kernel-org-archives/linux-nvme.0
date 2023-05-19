Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82799C77B73
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 02:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=; b=W4sBgFBKikgP/3LMV/zZirgLz3
	6gbEEpFGooq3mlJrz2i7AM5cbwonDdPz45iCwANA96iJ1MkyvlsjMnMP8U5rnRkLGrK197o6y5xIT
	RtTqXTjgEy3njKLmY3pgGYaW3aEFliQJVsT6t+cAizjBm4zLJ2XEn9XHmgOIueJE/+oXlLMqjw3o8
	eTvS11e/OeALymzW1TsGrVktJJYdG4cXgu3KvATrQYaVIDhK4CUEf2+efcjxZOmIRf+521WqkmUC/
	JALKUEeUiosPkVKAhHut1j/nS2nlOM6ChoGp+14r6sRwepqGFMm9oDpBK0/QtJHkkmMxc85ln9Itf
	kh03nAXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpcQ-00En6T-1Q;
	Fri, 19 May 2023 02:13:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpcO-00En5b-1r
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 02:13:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 40B5B6538F;
	Fri, 19 May 2023 02:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F02C433D2;
	Fri, 19 May 2023 02:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684462397;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6GntMqQzqa+Pjhi9JOI50bq+fHj17pCVrdSJ87Kdas0kepgKOg/8g9FDWvL85ROG
	 xCMBGEKcXKhKsAlrcV42CsOE8TPB6la0/ovFsTB1j9XGpWTLRsns9LAttlcGGG9BN3
	 khddQAPemr00jp4BUdU8y6dXxiCl0Nd0N/RfcLZw+dhdFedJN1A30mYnSyMqFeIZyV
	 Y3WC01Jp+Xncl5rtS7EvfV88Ewf1ww0lQeOqrxph6BNpOQ+tI2R5YI6AjnGzTVyeee
	 8uNhGG2dEFks24+7FNQY4nGk3uJRKRYO9ujZ709qQH9E0RsHzPf4qYjdZlFqZ5wncd
	 shlolGaWQ6cAg==
Date: Thu, 18 May 2023 20:13:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: dansmith@ds.gy, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH V2] nvme-pci: Add quirk for Teamgroup MP33 SSD
Message-ID: <ZGbbOg4PFX0HmBqL@kbusch-mbp.dhcp.thefacebook.com>
References: <20230517213232.4977-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517213232.4977-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_191320_662612_B018403F 
X-CRM114-Status: UNSURE (   7.79  )
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

Thanks, applied to nvme-6.4.

