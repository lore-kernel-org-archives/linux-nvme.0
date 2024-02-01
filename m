Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25122C47DB3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 00:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=; b=gXEPM4g2OGy4Dl+X2EukWpwevU
	MXwAtsFqZJY5X86kbSCFu8blO0GVtoqMe1/Zyge/XGsTFnQm+CmEGImWqtbrjwGukQQVjr6hAHcKx
	YP2/xr+5q34ZKsrpY4QAP3KkKa5TPOYsWYdkQIv2kam8op5p4JHIyMtkA9T1ZmyAdS2TmcQgES+EE
	1FIHp+mkhfuBegBHtybFDu7jSm9t8OB0jn707TuTZn6CB2KjECEdXyBEqcFU24WJAzB9MehBQDlOd
	sUeXDW0I1mRWlAejwTqh4pUIetS1mDU+TcRsKUYxOZMsQ1vzyMgv7RxLhaeHBDAJC1Xwpov2jmt3S
	Sd5HJqug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKxU-000000065L5-2Grj;
	Thu, 01 Feb 2024 00:29:36 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKxR-000000065Ie-45JR
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 00:29:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 20F12CE1C37;
	Thu,  1 Feb 2024 00:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE60C433F1;
	Thu,  1 Feb 2024 00:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747370;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGg1l7ybEZsNbcK9S3PlmGschzMZ2FUmTJL4rihhhHUW+QsoimRCEYPY2CHkay0dK
	 pC8D5ouKAlvmJ/MdWfK+BGFJM7i8G9RQBLJrsWD4LM9aCPA6qI7aus6Fk9oCT3n7nd
	 6cxkJsdvP9x3fb4klxNg0I00SGAu9v8PcmJMf+y+aUH+2oWjsNZ2jGegGkMte7HoXP
	 B8sW1FHItXbJodiz+RgyNLnY2ydoD6NttQFwWbtHEC3bqeE2GpH66g+ne5H6IY1u/P
	 kQIU6Yo6AbTBqJ9g/OcFaxTMSlskv53YvsVJ2uz7RhHEb68Bd/4iFyAiFQ4XHXpuDt
	 6bq9LHyvYaZxg==
Date: Wed, 31 Jan 2024 17:29:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-common: add module description
Message-ID: <Zbrl6D0NEBzY0XiD@kbusch-mbp.dhcp.thefacebook.com>
References: <20240131230138.7343-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131230138.7343-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_162934_191958_E45CB4C2 
X-CRM114-Status: UNSURE (   6.12  )
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

Thanks, applied to nvme-6.8.

