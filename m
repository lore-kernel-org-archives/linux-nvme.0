Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7331EC10F1A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LSaEPxVGB4VRFhN0LqOEtyEy/jFC7WAzADq60HPYFqQ=; b=JOujr+L0jV/qEHEWXKnELFNgP8
	odT0tRahd2kzm8zw2efgb/1pH7eEWrUnOIwTlGNUtdTZuZ3JE6SGPJux8xOMzzoRYIX6MQIXMGLhG
	mpr/P5g554lLaNvijXUWvzqdV4t5tXvo9AYBV74VxgPiki2Bkd9TpBRNknNnIsD5aimfEq2LqQvbv
	/gxhkKopF0TO7o2q5CjJg4lkirVY8hVdV3NvAqHjqpJ0YFFyYemZcCWmbzZIE85EB6m135o9/ZKu4
	6pT9B+uFrBzwE5RnMs2fawfWt2pq1tBJO7n4aPpJ4Dhw8ajMYVZGXI4EIKNOBvmvnjRz7GeI8il0S
	m889bzTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s26xx-000000093z4-131H;
	Wed, 01 May 2024 10:13:33 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s26xs-000000093yZ-0YpG
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 10:13:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0BFCACE12A3;
	Wed,  1 May 2024 10:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97032C113CC;
	Wed,  1 May 2024 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714558405;
	bh=LSaEPxVGB4VRFhN0LqOEtyEy/jFC7WAzADq60HPYFqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLCdG4P204MY9r14VG7N5UbVi/010J52zgG0eVbq8OBvnw2QSXKJFq+2pIRVbnsCf
	 8BclO0KEVIZaP/JrN5xvnXYv8wuuKvHNwiw/Pf54JKxY9mzlEHzIavWH5IK576xSEq
	 I55U87uWnYmwTH2GBOQG1QE/Z1FrKMnqGsZfB73vPVyahsi2vFi3WHalm5TdXjvXAq
	 cQwgNg9ZvW4RxVu9Iun4hEVEfByWroq6aOSv1ORqbxxk9Kv+bTBS58D/m/QkCErbnm
	 hlCPTUphjh2563hYpo8PHwk+H9KRxG5oOoruIlFcd/9Ko7+DCsB9eIFekgefNhr0E1
	 uQn5aSkt+43vA==
Date: Wed, 1 May 2024 11:13:20 +0100
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] nvme-fabrics: short-circuit connect retries
Message-ID: <ZjIVwOazsC-miBK-@kbusch-mbp.dhcp.thefacebook.com>
References: <20240430131928.29766-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430131928.29766-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_031328_373447_6AD59C6B 
X-CRM114-Status: GOOD (  12.26  )
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

On Tue, Apr 30, 2024 at 03:19:23PM +0200, Daniel Wagner wrote:
> I've splitted the last patch into the hopefully non controversial part 'do not
> retry when DNR is set' and the 'don't retry auth failures'. I hope we can get at
> least the first few patches in and have a lively discussion on the final patch
> at LSF.

I've dropped the previous series from the nvme-6.9 branch. This series
has been added to the newly created nvme-6.10 branch.

