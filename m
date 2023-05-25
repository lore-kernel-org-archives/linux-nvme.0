Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C1C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mS8QVqTCq/nMow+2Mhlb84AkEtOJXvPYqNwZ+bHY+4=; b=qIR7d6frxhb4Rqd8R8q/IDwtPm
	S/0JzGb6xd2dQfiEMiL6+MKLExgosymmyZJkvrmayyKtlhqlnRBv3779DipyCFebf6krZUaN7OtaU
	nmRex8+vm+2pbDq9zFuXoAWA6ip9dJ3/SG9Sdo0/i1Lvoqi8Aqh6sBzVJphNj0jb7RO0l3AIjJSBr
	uDfQfrcmj3AslKkDzEbspYCeNQKN7qQTCgE9smVLWYZ9TKzXVtj/RHdtNruG6Rx308mUucvQm9cvb
	NVEmadf3nwaJocN91r5Mu4o3WAyv8DdfWMSXLOREU2DoLDKjpfaCVmtJJcFq/iss69HV/yVqGFiCq
	C81NorLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FJq-00HKLx-2g;
	Thu, 25 May 2023 18:04:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FJn-00HKKY-2q
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:04:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 74ADA64820;
	Thu, 25 May 2023 18:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6770EC433D2;
	Thu, 25 May 2023 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685037846;
	bh=9mS8QVqTCq/nMow+2Mhlb84AkEtOJXvPYqNwZ+bHY+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzGGndT2Iin45Z0R5t6ZOj8V5zgEBbigddchuZmbLaDluphDAg4I7l3Pt1yvmUcS/
	 9XNnt5DMMchdAUgQ8c/qBIDNaU2P05VMS/4Yu3iYwoCTKyUVK7AK4nmvJllSSkU3TW
	 4D3igFCXE05neeaOMCFZ0WEgg0+fNQUukMHnq2B1HHB40emaZKVTw/7eUUNJ+cZ7Qs
	 rZh8jZmbqnWWQMOfMry9lZn5qrcDNqeU8hEKRSfF7vwQrbpRAahPiJo26gkxmMbEDl
	 DvHHfJzERCQtvKVvauzDeh0GO1E1u95SkIz/sWn68eP166zIofpd52mir47v+qQdsd
	 IH3QCYwTKfT5Q==
Date: Thu, 25 May 2023 12:04:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, james.smart@broadcom.com, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/2] nvmet-auth: remove unnecessary break after goto
Message-ID: <ZG+jFObXxfhyCVFZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230519094052.48575-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519094052.48575-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_110407_958670_9F3A12A6 
X-CRM114-Status: UNSURE (   8.06  )
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

Thanks, applied both for nvme-6.5. Looking forward to your follow up
clean up that depended on this :)

