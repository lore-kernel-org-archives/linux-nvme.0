Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E67C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u74yg/M4Fxkx9BQwfM3eTdqX2f0fV4spwaVbAhO6bhc=; b=qpcISsW+yENtGD8QYP/pI3uNnf
	iASeFWjFOUoPZbJllQbbB0AEd6sOzLZCVu1e6sqNGgrSVk6AgoEo2NKE/TYUZLZDm9axtr345fWdW
	8CbiKxbY8H82YPDTct842BTK25H6k7jMd2QYCnIccaQdL1KuGv6k2lp1pslPx60/iKVi2f0K5owqC
	jkn1W8E9Eic7vYN4YowCsuoYAJYhnZ8DVDT5aDNAsAkbW40zKcIBw8FheUS91e1rUV2z8fhvqtJ9t
	vub+Szb58HBZyzXzD77f0MBXOiwvwQ67/ng+EWYG4wXom2TEnS4GMtU/UNwBmqQa5S/x9t1uud7Qt
	lGyB6v+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrRwJ-00469L-BI; Wed, 18 May 2022 22:14:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrRwG-00468i-9u
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 22:14:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A333061000;
 Wed, 18 May 2022 22:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62099C385A9;
 Wed, 18 May 2022 22:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652912079;
 bh=u74yg/M4Fxkx9BQwfM3eTdqX2f0fV4spwaVbAhO6bhc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dfSXkoFUfztPS2hYCcdSVFN5LcY9J3A6JSb2MUk9rXsB9pPGDp5W5X/5YHpP+jZFC
 2hbS6vY3ktiRoibpZFRW1S8shUJYYBiJ0c1WI7VHSap5kgIlMWIW/l9vlwTbgSYSyN
 Wlct7D6l0qJz62W7XK5n8XZ5HLPNLZofDQZG7pbEULy3sh0rI0XmGywcEDwT847NWV
 1oM5KQwa0JpLHM2QBuvLO4OBT9xprxSdEhiVSsY81RSnuK2XFqnTUwlgTtcShdaeUw
 ugsdce279EmFkq7qzG8DZb0qexWdwoeP+5485rFGGcR43hoek0KrNsdxzbU0UjBGDu
 F1wevXVj6+uWw==
Date: Wed, 18 May 2022 16:14:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: cleanup blk_execute_rq*
Message-ID: <YoVvyviy3eJolJ3+@kbusch-mbp.dhcp.thefacebook.com>
References: <20220517064901.3059255-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517064901.3059255-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_151440_418107_415269FD 
X-CRM114-Status: UNSURE (   7.98  )
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

This series looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

