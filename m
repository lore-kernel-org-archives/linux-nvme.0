Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A6D61040
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13A6D61040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=b0ew203VR64et1
	glap8uEoA/lKEgZe1skYcguMMmJLfMhNbwoVGBuJ/iAkNyIMhjaC26vsEvnFTmida37KjXVhqMi0C
	fp9Nax+IrlTOKL9h19FrFZeqckOf2/17cVijlv68LHCgJh/gf7kb3mCl9P9dMgHA9bfupaUUYFQ5n
	RkpzxER5AzLcEQqWVgbEH2QSgATpteC+e3GN6FJQuF+dzsLdm7LDG1P1g5A2JkxvXmVxyRjm4rJ5L
	0nh3/e826Dnl1h/mDXqot6kRb+4gi1HQ+2GBE5kce3sZ1m8K2TkDVDZKifhwpoZBqE2tYhPZ92kBX
	marM/Qyw/NTtcxKXj/vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maHQw-00Cpci-FP; Tue, 12 Oct 2021 13:03:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maHQP-00CpaK-H4
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 13:02:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A163967373; Tue, 12 Oct 2021 15:02:31 +0200 (CEST)
Date: Tue, 12 Oct 2021 15:02:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Nitzan Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 0/3] Fix-use-after-free-when-a-port-is-removed
Message-ID: <20211012130231.GB11048@lst.de>
References: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_060233_725697_F3562792 
X-CRM114-Status: UNSURE (   7.74  )
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

Thanks,

applied to nvme-5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
