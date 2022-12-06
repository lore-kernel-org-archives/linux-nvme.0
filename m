Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651D0C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MIXJsbG8FBf+SKr7UhsltDEyRBYytpHUNjew7q3bfzE=; b=cOzkBAuL3dyrEUHIwGe3sZD+DY
	yyBp4A0za/gvdIIyi8obE59gFK9S1KfudU6wf9Rk7z2MnmQcBwJgEHoxLPhac1gnodk7rCBmgS7xk
	Wj14YDpEm0t1ZE6zuNKmovafhDFeL4B1EI2/cK+SxPjf0zE3LxMo7cB8VZsD8ozx+2U/3mvjWNX7I
	tXKe3cRnW+1OD7AdtJAXd3S6IgT74TWSjv5idlvWwd93KCbTGvdB+0ByyDdeWSW1HnstNwtiptyP7
	xgWSk6zVcXDTYqqKNLQvblix4DCyswM0iG0LGkn3d9VR0TbSoyvKmOaUNtyoxDP2WX4+1Em6lI4dc
	wszksMNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2W7U-008RsK-HC; Tue, 06 Dec 2022 11:28:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2W6D-008Qvf-Cw
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 11:26:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B8A6861648;
	Tue,  6 Dec 2022 11:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E86C433D6;
	Tue,  6 Dec 2022 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670326016;
	bh=+Qn4ZIw3vmeAXl5DRZnA9pqzXg+0dYTozJ3Y4O2Sheo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoQlMj57KH9TeowcnB5VDD7D+zA8CQ2aSbvZ92TFtbxNWgGMh3YUGv4Ats1cCgoEm
	 Sqq3ED/pBOBel0kwLtcYHaOM6zVozeAFksidU1Nx2VctVCqydF3sKcA6pxtbCLWDWe
	 FI7hQlGGFdZxhFlgibqq6nl6ykqD/spTodAvtNOwEGTcNs8Xze0QLf2/k5IrU/xWKF
	 9bEk39k+bTrkR3+QYREQBtFNzVL7ifwiHrJZaEXxzKye75cTbgq1iWT2P1vZUsHXU+
	 5mHW8HaZOzPKrGUE7XnXJf5JWq/rQGuPd2uxBhTfjG5jgZfauZMP/aE2m024yua7go
	 lGs9tr7qVFeeA==
Date: Tue, 6 Dec 2022 11:26:51 +0000
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: remove path cleanups
Message-ID: <Y48m+40hPSL+9OmA@kbusch-mbp>
References: <20221129132208.4337-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129132208.4337-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_032657_576793_59CEA9E8 
X-CRM114-Status: GOOD (  12.07  )
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

On Tue, Nov 29, 2022 at 02:21:59PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the remove path in the PCIe driver and a bit in the
> common code after fixing a harmless bug in the Apple driver.

Series looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

