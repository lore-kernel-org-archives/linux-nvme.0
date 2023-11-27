Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282E2C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pa4KmG4/GrZ3zIfHfcJTPlvXSEJB+zWpHRsFzuxElCM=; b=m/jU34Pp2BikA77MbahStzWJJd
	YZLb4tRjX0z+ayq0LWPOuHeWTWSZcQRr3tiefKxubiBQN4n7zvcBCmVnQEpQf6B81zWDQs3oFBAh9
	+FReG0lB9z5wRZtRbpWfAHtx8QtHQh1juXaMweiDmowc43s3phGeN/K0gOmEjIRcFL8Lfkp0akeN8
	SvI9tu+RokYRO++z1FNhesHMW6AVS/cp1FJqkodHF1hMUUi+SYH2o1spQsuNLiN/fUxJ49RZB0vQ+
	SgI0gdZozkQmgb+B+npzf/BRhuBRjlSo/iR6Px8t0RUZP+D+jemW6U8oqcFzJGjMiUKBTsXWk8zck
	dz4sEUWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Z69-00287u-14;
	Mon, 27 Nov 2023 10:44:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Z66-002875-2x
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 10:44:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0A49761136;
	Mon, 27 Nov 2023 10:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DACC433C9;
	Mon, 27 Nov 2023 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701081853;
	bh=BM0cucoJgxfeP1gzwakogjRSOFzNW7OJuGhJzO+AwkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NI16mUAXXRUJtUvwYyXOroh0N2ft1jiQaRcczcB6RhO4ZvmnLcGGw5xn9e9s8qZ/E
	 4UtGTLQbcZU6MQEelp/SzIZQbKaZN81mvujDqRsT8+/E/mb8xqHfdLorKxLnPpY/83
	 QJnjhmu4Ctj50+2mguMeihYYlaoqSTccpPZwk56KRIZqq0iThWX/jAte8nS3z68HHn
	 W0piVO6Df6MYWYq8GeYO5moxBV2ritL3K3AcXx0mpYlL8/jDGShBmq7Srz+NU7vaJJ
	 6Vkhd2HT2KsUzaJrrhdfvoHlMgwVHVUH/c3aSxXyu5I6FVoOkZ4I62SQap+sVsUz4I
	 nAdevmLpocSCA==
Date: Mon, 27 Nov 2023 03:44:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWRy-4Bhqw0Gxo4c@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127103208.25748-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_024415_016250_49724DD0 
X-CRM114-Status: GOOD (  11.40  )
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

On Mon, Nov 27, 2023 at 11:32:08AM +0100, Daniel Wagner wrote:
> libnvme is using the sysfs for enumarating the nvme resources. Though
> there are few missing attritbutes in the sysfs. For these libnvme issues
> commands during discovering.
> 
> As the kernel already knows all these attributes and we would like to
> avoid libnvme to issue commands all the time, expose these missing
> attributes.

The id namespace 'nuse' field can be quite volatile: it can change on
any write or discard command, so caching it may quickly get out of sync
with the actual value.

