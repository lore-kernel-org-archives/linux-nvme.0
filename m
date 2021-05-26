Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AEDC47087
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 02:50:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D6661090
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 02:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D6661090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HfhYJsYZUZmTjIn8L0Lw6h342SqjjerXV0LMYwr0VJs=; b=N0vfXQjUNeFADD
	qj98bI3MI0nOK+aczE3PbZrJ79c+5F6XlxfAyLYvDTnKofaWgKdWebzWh+yAkT+5FrCntq02yltVw
	UKr6Yp6b7Mxxroh0QZjTho51IGs15Aopt8VUJvpeQi03FKZBwtkSIET9WZXR8+YiZwk2/eJOQuzyl
	GV3Q+OV+Pimrmrw2jNZt4Hny1KWGqxzFRuJJt4gjLKsseUBns/ja2l2gKNkjlFStIuzWMMlemIT4R
	i7kXJAX446ezzAXzTcnYEVyrR/ZAPFEJWVvPLd6h9yhZmxZ8KJ9jOVMMb0/Rwq23/YSZKgTJj/t/O
	sZ/xRmT6TNtb366jEQPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lljcT-00AFS1-81; Wed, 26 May 2021 02:50:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lljc1-00AF9L-RX
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 02:49:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B281561090;
 Wed, 26 May 2021 02:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621997377;
 bh=SfbOqGxm7X5NXp//WakdnkTjJ211zswh8Q9jf4zImwM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hBkCtj5oeFMQdGLiiql6K5nxAJf/2GbOcEwMXlkxOpHuG/0vYdRRE6+YDuRTLYuhe
 qcbWOv27/Vz/RsHDdeI2Vkzw8hdtDZ55sN0jBz3DXFNMSwCXBRwtThP134XNf8ZB0M
 bmf+ViKxg5PujFcgiQMIbz93FjKrJQpVwoKW+B66wfU3sIUf/vVqLRVx7e+0HmJJ9x
 JPc+oStU4FFT0pUd/Bh372QnzIkLejEx7JfY3MYABzKH+kS53nNmxiD/h1fv9Y0Rr4
 xllWKT2DDMDkIEIf67H8KILgIDpri4d1O8/gDuJ0VfUOuMHcZ44R0pGB/TtcMUjNnr
 DAQhbpbVzNcGQ==
Date: Tue, 25 May 2021 19:49:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Koba Ko <koba.ko@canonical.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de>
 <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_194937_963774_62C7BDAF 
X-CRM114-Status: GOOD (  12.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 26, 2021 at 10:02:27AM +0800, Koba Ko wrote:
> On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > > After resume, host can't change power state of the closed controller
> > > from D3cold to D0.
> >
> > Why?
> As per Kai-Heng said, it's a regression introduced by commit
> b97120b15ebd ("nvme-pci:
> use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.

That really doesn't add up. The mentioned commit restores the driver
behavior for HMB drives that existed prior to d916b1be94b6d from kernel
5.3. Is that NVMe device broken in pre-5.3 kernels, too?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
