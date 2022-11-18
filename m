Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090D3C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Nov 2022 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e0SrFmP/hoaXrNBk2z7KHrLDzCRKObgtYnuO87ZYLoc=; b=Uexzt5uIyKLdu5BNtcAYamcmRl
	t4V2OJP7Dab/BD9f61ai5Kaml1qY6GrOFsYYryN2ujQieQq+ddDxptrC4no45WhHh8MFUrMq1eSgc
	iPPFzG2i80KikA6TWDVwBHUlHlpdyaQ/3bef3mH/d8XBXZ7VBc7m04gheULH0lp/L7vK8tnuXA0Ry
	npmdTDQZJUWUlGdtXwoJPfNn4d19AXQm/B96bTd+oqIzymgkfkstxVxtewtJzXxXrutjPK6vmbMOu
	w8wxigXw3QVIy6jWwLKhvPABzV/BYVsBhbjp2Zhk5mef/ixAt7/DnPG+PR1Th2RU1OXmT/TIRVmHg
	zCQLYQmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow9x1-008mvv-5o; Fri, 18 Nov 2022 22:35:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow9wz-008mvF-3O
	for linux-nvme@lists.infradead.org; Fri, 18 Nov 2022 22:35:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 622626257F;
	Fri, 18 Nov 2022 22:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F9C433C1;
	Fri, 18 Nov 2022 22:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668810906;
	bh=XgLI/FJxNK6AVm0/yVWOWTFyhD1AJ3rNqghFxzRk8oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vI5lYvEZlEa/YNXkDMW8bQvIAsSdIN1NdMZARB/GFfiRbBknqPVhL+8VUnJp1q7qK
	 XQMWGP+1Q8Y8sTx57dzfywYNR7ElKkaLnqrzZXXDwZ8zjJn7DGFZqtIp66zOCjTT7c
	 Vt/p3CXTW6d41YkwHqCHtN8ddkK+eEpHnD1ZC0c5CTeKlBnU8X+zt1M/n5Soj/CpJD
	 1802EH1muKN2Di3syee4NEYS0TJ6bfjbIzbiUbXm+eZ+GXBShxO/FmOPO/yHpbvXsc
	 t0gyncBYJD8JQRtEGBSnQA4D4sGIpL1n6KGXBgqSFneqVDAdmCQqjGc/vCgy9MYk52
	 x6HxQ6gsVfpLA==
Date: Fri, 18 Nov 2022 15:35:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH v3 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <Y3gIl1d8tVsx/+NG@kbusch-mbp.dhcp.thefacebook.com>
References: <20221117141337.3719372-1-j.granados@samsung.com>
 <CGME20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8@eucas1p1.samsung.com>
 <20221117141337.3719372-2-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117141337.3719372-2-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_143509_196638_60EF5D57 
X-CRM114-Status: GOOD (  10.55  )
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

On Thu, Nov 17, 2022 at 03:13:37PM +0100, Joel Granados wrote:
> +#define NVME_IOCTL_GET_ATTR	_IOWR('N', 0x50, struct nvme_get_attr)

Isn't the ioctl's number derived from the sizeof the parameter? IOW, if
you add new fields to the struct in the future, the ioctl number will
change, breaking older applications that were using it. I don't think we
want to keep adding new ioctl's to support legacy users, so probably
padding that struct with plenty of reserved space is the way to go.

