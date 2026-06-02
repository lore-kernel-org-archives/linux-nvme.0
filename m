Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05479CD6E4A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C1BlTrRKp43OUq56bDwUKJ0qf4Hc5Cvi/cv97quXAus=; b=zUW6u7FTKSOrLWFoN3pcRiSVC7
	09DHF6YxvzzZz56U6qJF7kliuLO6hs97VWS/uyFH9KnWkkOiHDGyg7VReVqd2AZUa6vDF6Ci08toJ
	3ol6gHBNIm1hmu5DUZI5JmdYee++VMGdQd06POmfBmck5XUi24OPeIGOxi9v1G3RG1Bk6Gaube3Lo
	6CxqAGuwX/VOKbvCBxJZbsKN/5RFp9t4IvUTSWpF7AOP3wO3bvvZcx4qlDFK6AZv8MSkSzK3JJ0Y0
	XUDR/fZrmuN/AjKG7iyntMwWlNao/FcySlJgPoYGFDd2vA5S/lZ4iF9hcxzNJffzA4toGKUZj2aBm
	Ya6CQ8Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUMCE-0000000Cl3v-2utT;
	Tue, 02 Jun 2026 10:18:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUMCB-0000000Cl3F-2G0S
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 10:18:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AE3A441989;
	Tue,  2 Jun 2026 10:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553091F00893;
	Tue,  2 Jun 2026 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395482;
	bh=C1BlTrRKp43OUq56bDwUKJ0qf4Hc5Cvi/cv97quXAus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q0ujdd/JXbNI74YBb/ihssmiCqPVByALm3pMtJ6iPmyW5MxqhhgpCxIp0d1ndfxtb
	 TZoaEsmLhMrFixj5XiO+l2GbuFPwcAPuWFwNhUOSq0zC5YN6B+n2SrufWHc6eWwhE9
	 83SEDTzESLy9EF0DheTFSb6O9tA7PdDvzt6SkhOSInQ5OdtzP0PrenOVGXFgvvFOyl
	 LkmOOszsQzcPC11ghYIQSf76kMcU5BPePzE/5GqaCt7NhVFWHHRZYI4UhCNWRV740h
	 e1BdTWSMxgSLgQLuBq/8+hhpSfUMzQcqtAom2W4RYiFa+2O8ti//UUzpwlXjBM7BRA
	 XRl8pxt1x5y7w==
Date: Tue, 2 Jun 2026 11:17:56 +0100
From: Keith Busch <kbusch@kernel.org>
To: dayou5941@163.com
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, liyouhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH] nvme-multipath: require exact iopolicy names for module
 parameter
Message-ID: <ah6t1JaF21dkx7dp@kbusch-mbp>
References: <20260529085143.2016914-1-dayou5941@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529085143.2016914-1-dayou5941@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_031803_613976_340B9A95 
X-CRM114-Status: UNSURE (   7.27  )
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

On Fri, May 29, 2026 at 04:51:43PM +0800, dayou5941@163.com wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> The iopolicy module parameter uses strncmp prefix matching, so values
> like "numax" are accepted as "numa".  The per-subsystem sysfs attribute
> already requires an exact match via sysfs_streq().  Parse both through
> a shared helper so invalid values are rejected consistently.

Thanks, applied to nvme-7.2.

