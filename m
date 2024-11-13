Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE02D637A3
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQsAEfO1InkyeYqLO+agj8KVBnpzFdAGBOZc3/E45KI=; b=SI8S+Yae3GQ68+5vJIn5H7SHKG
	am7qS+cG4UqtSBV9YHbndp3XvBsZquwIaOGTvIdyFCye0t/UN6ssb4VmFUldPQL0NRV2t63fK4kM+
	jbSAhMG33GLPCwI0uZ8DXbOAolmkG7iG0NsLGNjj1pdFk9ZqbNxMj1V1Smck91Jvirx5TDkgOZFV1
	hghmlraASUdL5DOVHi56whzMOTA+wu/34mI386Y4wfQqkIkGOIzw44R+oPIpvaNlxU2pPOrsTXpri
	wcJmKlR74XZR19thi+Zbg9mf63Ub3FugSsh/CzjhAITvlh8Rb3zzSbOdKz2R6c79ZWFtBaPYvDxKF
	EMhV6aFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBHkk-00000007ekX-2DWM;
	Wed, 13 Nov 2024 18:06:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBHkb-00000007eiz-1qAJ
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 18:05:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 16780A40FC7;
	Wed, 13 Nov 2024 18:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B17C4CEC3;
	Wed, 13 Nov 2024 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731521155;
	bh=M4wyj6LnteCS8V5uLYewkH2xB3uFMsAbftOFpnkE21o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmU33Ybq9mi6SS/EE9oMZnsYv/MW590U1NZ6DxaVzwGisRddMa9zzuYeFryV5QtDS
	 QB1Jv6vnxMOSX5rBYRXUqOS6FowHhQT1bMVks5xuW99pozRML8wnXm4cFG85NjdzGN
	 sSR7950AR4zd0WyLKTM/ulQ6dCiEyE19aEd+Fqdv8YjBgrrSbxG4SmYYkHVKZ+jLPL
	 QrGdHEHKhxHtF1dkNEOcyR/ReyBh3o55WrDgYoW81e58yM1/+deuQylQTwfAfAIBql
	 TRMEGUxOOiXKAwXkIx2XewWgBGCMPTERne0Kawf5CReHfULXbSqWrCv7oHRXgESeIY
	 4w6lf8eusXQeA==
Date: Wed, 13 Nov 2024 11:05:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bob Beckett <bob.beckett@collabora.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzTqgXqjN4UrT392@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241113043151.GA20077@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113043151.GA20077@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_100557_582080_C778143E 
X-CRM114-Status: GOOD (  16.56  )
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

On Wed, Nov 13, 2024 at 05:31:51AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> > From: Robert Beckett <bob.beckett@collabora.com>
> > 
> > We initially put in a quick fix of limiting the queue depth to 1
> > as experimentation showed that it fixed data corruption on 64GB
> > steamdecks.
> > 
> > After further experimentation, it appears that the corruption
> > is fixed by aligning the small dma pool segments to 512 bytes.
> > Testing via desync image verification shows that it now passes
> > thousands of verification loops, where previously
> > it never managed above 7.
> 
> As suggested before, instead of changing the pool size please just
> always use the large pool for this device.

Well, he's doing what I suggested. I thought this was better because it
puts the decision making in the initialization path instead of the IO
path.

