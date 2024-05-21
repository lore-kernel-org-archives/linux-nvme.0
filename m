Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3EDC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JeJtgnkTwi66saq4X8YBKzixUpDhG1UPvIIwVdqvjz8=; b=EyPfleEFKy6SwbPBhl4U3yy71L
	USke0av+d0WTfCqDRdbnwo3Ri4tHwk1Qv5d+R1ftz8xGZX0g3s9XLy7GzbMg7x61tC+3yjfEbM4dg
	ULr5p7BYA49WN6SuKRlbGWIl9hbwkio8Y0DiqGu2Fn1/vrSnLCycsR6BSk6ZLDS5Jwyf9eXJh+9uJ
	fiqwpWg63Dn1BBM+mlHJSUFwDAa6c91S9jQqT3Nqs0hG5ekPDKoVuxnrUO4xffwyp+20hrpjD5/pl
	KGtWBjtg2vzY59Rnjhgh8ErNQdJ3ltZ2Mbvm93MGLDBHDStFge8uBigq1wYUSG15lCNacCps+7bou
	Rkz/+3pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QzF-00000000Gjf-1vpc;
	Tue, 21 May 2024 15:01:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9PqO-0000000032u-461n
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 13:47:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 695DD61D9B;
	Tue, 21 May 2024 13:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91930C2BD11;
	Tue, 21 May 2024 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716299276;
	bh=JeJtgnkTwi66saq4X8YBKzixUpDhG1UPvIIwVdqvjz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8nbKXM9vgXarPa1t5SXB7SVl9R5i3UHC1ymMQXJPLXG3oDVS5ovkkyB/IjVAqFgN
	 4HgpNGEAMNrnpV4BT+fCN3GobOsQBvTRXZXDSs9syf9hnTqHSfFpRmAe9Oj3RFHBpN
	 mBA5Q0+Qfa0GsJCVLkdBeZnKRIjWJh8nJyarPyFSvdOgI7D29bAEWzihjTVGAVU6UT
	 9uL7hwcUh/rHWCsqP5nTIDZTAEGRXGO8yGLyxxPYIPpegtmtRTZ0zjezpRHQ1TufOX
	 EHyTid6LhGzwBkbxGnhizFZfnwFPco22GO7QyZxAkneeOEz4Ycwe5WKfBahEJ9Hc5X
	 WzHvk/0m++U2A==
Date: Tue, 21 May 2024 07:47:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	gjoyce@linux.ibm.com, axboe@fb.com
Subject: Re: [PATCH] nvme-multipath: find NUMA path only for online numa-node
Message-ID: <ZkymCX2q5v1SN0DL@kbusch-mbp.dhcp.thefacebook.com>
References: <20240516121358.3145962-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516121358.3145962-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_064757_086303_C3938E07 
X-CRM114-Status: UNSURE (   8.62  )
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

On Thu, May 16, 2024 at 05:43:51PM +0530, Nilay Shroff wrote:
> In current native multipath design when a shared namespace is created,
> we loop through each possible numa-node, calculate the NUMA distance of
> that node from each nvme controller and then cache the optimal IO path
> for future reference while sending IO. The issue with this design is that
> we may refer to the NUMA distance table for an offline node which may not

Thanks, applied to nvme-6.10.

