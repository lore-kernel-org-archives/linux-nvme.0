Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DC1C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=su+VkTtDJAAGpLgXVxBAahKI8NZVZmXXm1sM5Pz4cG0=; b=r+A852CIjmVPhpuV5u08CdCdHW
	ZO45zjfRLGfX1PTlvHHmxLBa7bIktmvQpi1Vwfmz++kQUR50oyyC3DUh8+68ChTQIfdI3sz7XORSt
	U77c7yZP3Rlcr+RXb2R63lZVMUAU+WrYb0+DejG0W/lOhyYbVpu/h6B4izgZZKPplTztULAevm4KX
	BAJkb/UHCWUWucMsq73o/ZqetTidu9UGCrwI8llZiD/5/fbMhf1Cmspl6QKIBxADxe44h3dAaa4Zi
	F8OEHLuQXjax+6BYuskMOdFwF5fWs/VFR6gAl5mMPoJ4tBiKiBq/iOU3GFCgH8ndKGg2223rgPlXt
	jJtMYH5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2u0k-00G7EN-1X;
	Tue, 14 Nov 2023 14:03:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2u0h-00G7DH-2B
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 14:03:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C859861230;
	Tue, 14 Nov 2023 14:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53CEC433C8;
	Tue, 14 Nov 2023 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699970598;
	bh=MQZWnBtoiEG1oJi9ele0Z8y/iui8IctA3n8EhdMAqnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPMxZEWENt4I1wOlkfUkavZj/37O7hKu+4C/zBEJEn7od3rjzeImrW3/dMpbc0PTO
	 uG9Rrozh99kY65VIETaPmYQdOMwLU9J3nTZa8hV47ssEFYwx6jmvpu4nWPIEE2tHDR
	 dmbhw28CfvWYc6KB2WgQmQpbHPjdTJuJJJWVQweneqiWlP8jK5q6jrhvD8TgtjJJZD
	 80V23xBNQooxINnhboM6ouY+PyqhKbhoguRid4veceNYaE3XaJKN+nRqrW0pOOsplG
	 Gy/K3d2kk6eQJN8HrQa670iqS+BIeRKbONIX2eOit0zOXru0RcMC7sX+mXPNdJ3mUH
	 3Wx1q04yKjvpg==
Date: Tue, 14 Nov 2023 09:03:14 -0500
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCHv2] nvme-tcp: only evaluate 'tls' option if TLS is selected
Message-ID: <ZVN-IssyyUDbAkas@kbusch-mbp.dhcp.thefacebook.com>
References: <20231114131821.47101-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114131821.47101-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_060323_780496_ACC04B33 
X-CRM114-Status: UNSURE (   8.35  )
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

On Tue, Nov 14, 2023 at 02:18:21PM +0100, Hannes Reinecke wrote:
> We only need to evaluate the 'tls' connect option if TLS is
> enabled; otherwise we might be getting a link error.
> 
> Fixes: 706add13676d ("nvme: keyring: fix conditional compilation")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202311140426.0eHrTXBr-lkp@intel.com/
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Applied for nvme-6.7, thanks!

