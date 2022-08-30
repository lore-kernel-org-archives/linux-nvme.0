Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2EAECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HhYvE6/qtWX1bJYm3FRz37tHKl9FWgUBxwlfEBarztM=; b=UCld5j3o96ZJ9JZi8RI1neOHsy
	bxM4lD7K5S/ok8zqRYOkU31LvDSbu6T+/aKSv3vKQzOijDdhpFIyostYNzH2uYAc7k8GvdbUD+COq
	i6OJG8asoie1pDpbL0cI7p6H80aIyE0jTHHtA8u+1j8kbvgwHdsZucG7k+qDVa+Up8kmIPYZVfy5g
	Gn3tLWHIar2yl8KWlcO1sNpnUCyEhl/YCBIPo6mncJGppDBquNEqCdR9CTiWKgPzKvdnrFfjrfcOo
	dzpAD9MsjpU/S/UVNEc2MAqUkblVQFDgWYkx9hqLrocAB/zqZbHQ4xRyDxfVRxpfBzQmQM0TG+ZP7
	Ebxc6VBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT2YP-0005tS-DQ; Tue, 30 Aug 2022 14:49:25 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT2YM-0005sG-Lx
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 14:49:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 82138B81C28;
	Tue, 30 Aug 2022 14:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7254C433C1;
	Tue, 30 Aug 2022 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661870959;
	bh=Dzjaphq4UAXQkL2mUbBVnH83+3rkr8jcDzgfNpw0kV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvaljYjGnf7QfqzJCOUgevVHPyykqebfdpSCvDkTKBxACcol7rI/X7q7Zgt9OlW9J
	 hpFx64nt4Ya/t5BUlheLdLk9Ju2l6Sy/lvX6w8uW1JEDBZtqqmhqAslKxeTFvcZE1w
	 3YKVT5bxG15aXGQHH91w/5P9fvudtaK6IMtIGpKsjJeQk4GrJkqrLCBBEer7Vu9Q1b
	 +FVTol0sUB1d9Q8hO5+Gun7VwI1s/D7xbipa2+/nOOQjU6V1gqKwMDrfk3KU/VosGu
	 V1JOg4q4UwqrnLvXkUV0qm70JBNyWOgN2AQ9p8qQ5t3CAoOysPi356+M52uzmtUd5U
	 bvcnxffq23qyg==
Date: Tue, 30 Aug 2022 08:49:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Message-ID: <Yw4jbGGyyWEdunS+@kbusch-mbp.dhcp.thefacebook.com>
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
 <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
 <YwzWyrFahUlqs2fx@kbusch-mbp.dhcp.thefacebook.com>
 <d8c62800-bc37-eaff-8af4-9f9b450edaaa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c62800-bc37-eaff-8af4-9f9b450edaaa@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_074922_876065_7862C62E 
X-CRM114-Status: GOOD (  11.44  )
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

On Tue, Aug 30, 2022 at 08:18:19PM +0800, Chao Leng wrote:
> On 2022/8/29 23:10, Keith Busch wrote:
> > 
> > So DIX support doesn't imply IP checksum. Even if the host device can support
> > it, the target device can not report it uses that guard type.
> DIX just be used between host_buff -> host HBA. The target do not care.

Oops, serves me right for jumping in the middle of a thread without knowing the
details. Thanks for the clarification.

