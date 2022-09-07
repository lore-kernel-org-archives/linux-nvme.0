Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13677C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OAozOLfsSu85airilkZUPxfrQ7UUHv9b5i5qxI0WaOU=; b=BwGyHo6Ub8o1knSNVlkkLmHXll
	7sy8vUctdf4h200NefbItjKmF1dn59enJJ+K6KZFChsmBvBgb+we0cmtX5nnMpLXcdCKVGuz19e+Y
	cTTi6ttygtPVoPV+vBGhiq4S1LUeSBCxZFRRiCwo+CPhJQbh/oVY2JKh4jH8lS3XB+u1ATSqqMKOt
	2GuKBnSoQIbayPw2Iln8T1R2deWmNidetFx5/csQXJh+7FP0rVushRvBOTN49fKb4uU+3APwAL/iG
	4fpxH+SaP6krKbznqA3L8CXIafOFUXUy2RVzmyGjgliLHOqQVG8iYglRSoolSSnK1q3ttMQmvIUiq
	4F5kA//Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVuWd-006Fy7-DM; Wed, 07 Sep 2022 12:51:27 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVuWa-006Fvj-Gy
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 12:51:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5B186B81CAF;
	Wed,  7 Sep 2022 12:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9835CC4347C;
	Wed,  7 Sep 2022 12:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662555081;
	bh=kX1fEdgbpgeA+Uc8I3t0B7Xx7X2EuMPL087s9UV+c7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmX93yQ3sFuVa9lihJ3zpYeGa2Muqh+3fFQSPlD2KcVAEhHe8AFjBA1VEAPJEk2ia
	 xoC7f6RppiO/J/MbLdYKRwtqxvM67F8ftQao6oTLgGvQrCjrNZ/jX9GCBCy4aVOal3
	 qJL7kOvw2UldC8IzXCdX4Ctq5F6MS5r6WtLLZ93tShOzif7qvL/DQX0bqf9Iuv4amC
	 hcOOrlXAujne6TQ31ua31CGohwIpLVjKxx3kL3Eunv/egjGwp85ynV0vBgvhBmZOeI
	 2jY+U6kr3c9ZANudMeJ4fKqAmNNKt3P6iL17vZcpzDPWTj/L9nZLVNN4hEMNYgC8f/
	 ioWq7NA3tU/NA==
Date: Wed, 7 Sep 2022 15:51:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Patrisious Haddad <phaddad@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Israel Rukshin <israelr@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <YxiTxJvDWPaB9iMf@unreal>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_055124_773240_A2A56707 
X-CRM114-Status: GOOD (  18.61  )
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

On Wed, Sep 07, 2022 at 03:34:21PM +0300, Sagi Grimberg wrote:
> 
> > From: Israel Rukshin <israelr@nvidia.com>
> > 
> > Add debug prints for fatal QP events that are helpful for finding the
> > root cause of the errors. The ib_get_qp_err_syndrome is called at
> > a work queue since the QP event callback is running on an
> > interrupt context that can't sleep.
> > 
> > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> What makes nvme-rdma special here? Why do you get this in
> nvme-rdma and not srp/iser/nfs-rdma/rds/smc/ipoib etc?
> 
> This entire code needs to move to the rdma core instead
> of being leaked to ulps.

We can move, but you will lose connection between queue number,
caller and error itself.

As I answered to Christoph, we will need to execute query QP command
in a workqueue outside of event handler.

So you will get a print about queue in error state and later you will
see parsed error print somewhere in the dmesg.

Thanks

