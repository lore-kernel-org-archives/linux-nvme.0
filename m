Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC727C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MCeVoSKNIdtoy7CTBwxYCfSx8QwdW+Qb1wNQYlSRnmQ=; b=4sBJ4a0btfT53tanhW2zT/NArJ
	rtBIjFeGUsy3r5S/7y2FwDixzHs0ngOFuM5EwdIsuJTIYc2rBYf5v2Z4nMv8fR3snXU7GcosZHv5m
	tECHKrKYFXjw36cyWyMiIFH1Gxez3BfWlv5oFn1RRe4E79cW6oti4cR9urvV6tVmWjvhXowFFcGT6
	XQa/cgoKGAMiU8ucGOihAhwTt5j1DKoGPu+HYt1cxjpJ1yw9vpUCG2h+gxKuxv5l5sPa6geu0nyNo
	YiE/l1IbyPEAfhCpxbTmKTWSLD3Poj2+lQgJ6m2poc98gX0C6Esmdvd0Ge4bUAzBkNvpE3oeZufS+
	JbOZrZ4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEt48-00000006khF-0Yzx;
	Wed, 05 Jun 2024 16:00:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEt45-00000006kgm-0mhw
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 16:00:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EAED5619D9;
	Wed,  5 Jun 2024 16:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68301C4AF0A;
	Wed,  5 Jun 2024 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717603239;
	bh=MCeVoSKNIdtoy7CTBwxYCfSx8QwdW+Qb1wNQYlSRnmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljwr7VULmXeIm0GHuYgub2XWeLiKd+SMBu5J4G/TpshqnpP4+ihHAvUJ/zbdBg/qB
	 9uDEHoY2CD/EGlKWkAWClAhdKeZHYnOcVFTBJ8ElxSXfOusWRyymAJh09w3eAkYFYH
	 NQzsF7D/a0e3kFz9tlMAhtBtLgIHOkSscPp/NHIW8cpNtOiISsxLnOlJfopqh4pz8w
	 htwaS6rzoZ0spVkDbPFMb4htShMn+U68IwqRa5VipC/LzK5YqEtzIUcb3FgFnZJN0z
	 XPNrRUZXsR+aCFbw3yqxH2MnUrjn/NVFhBl92CIcZ6qCpVucrLC+NyAHP18e8hpDKb
	 xvR5rNPDdKQ7A==
Date: Wed, 5 Jun 2024 10:00:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 06/12] block: factor out flag_{store,show} helper for
 integrity
Message-ID: <ZmCLo3aBTq4Tgj_N@kbusch-mbp.dhcp.thefacebook.com>
References: <20240605063031.3286655-1-hch@lst.de>
 <20240605063031.3286655-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605063031.3286655-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_090041_366547_4B6C7381 
X-CRM114-Status: UNSURE (   9.11  )
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

On Wed, Jun 05, 2024 at 08:28:35AM +0200, Christoph Hellwig wrote:
> Factor the duplicate code for the generate and verify attributes into
> common helpers.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

