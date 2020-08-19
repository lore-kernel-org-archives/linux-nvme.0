Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936AEC433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:43:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637662078D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rm5SxwGN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEuC7bxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637662078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Aj0dMgQnGEgLugWnSXobvgNA0KUpGxc+W74xfGhwcfU=; b=Rm5SxwGNJgnrxXHC4BHR4Mnyd
	dM/+3dllJszx3k+jV4wAkdiwVQQ+ucaIjMrbC3dnZ6RfdRtPjw9ZujB72k49yzS59LUvT8/ohQbyJ
	fGfVCM3FGc9lTEw/vQuG1f835vEZg0PCC8q2HWiUWfj0IC680Rm7YygdFkvcs4gNnqG6z/qErRxf4
	GfUeRY0IKW8JnX7c4eKsErCYaSJC+HwHX9d1FRhFAs7+Dqx5HTQPHLJkGfprJMqfoZKaz/314FFPl
	kNlxt7Tl7taBCyRhmd13FovePCjjrZhz+4B/Od2Nzwhi605K6Qf1x7owgSzcJya7/CTfpiJbobmNh
	W5KwS1tPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8VrD-0004PO-N1; Wed, 19 Aug 2020 21:42:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8VrA-0004Os-Ql
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 21:42:53 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 97A952067C;
 Wed, 19 Aug 2020 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597873371;
 bh=pinhTPqoqxH2L+AXIWvBK5hfDh/tddhsdx7m0Akw4vk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AEuC7bxpfxQb5NULJo7ameLMi/uRkCDBFssg2Hh9Ph/nCuIth358SMN0YUN207pZC
 CRLee7W5b83xTup6n9ZwhSREsQek5bjjgoIWNMn/nhs9P5SPlaV9RW+TpuGWaKXKW0
 khJL2F8teLty+rZYfHxwczK5xb/U1f7+B0pkSIQs=
Date: Wed, 19 Aug 2020 14:42:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819214248.GA26769@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_174252_933491_6325C6CF 
X-CRM114-Status: GOOD (  13.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 01:11:58PM -0600, David Fugate wrote:
> Intel does not support making *optional* NVMe spec features *required*
> by the NVMe driver. 

This is inaccurate. As another example, the spec optionally allows a
zone size to be a power of 2, but linux requires a power of 2 if you
want to use it with this driver.

> Provided there's no glaring technical issues

There are many. Some may be improved through a serious review process,
but the mess it makes out of the fast path is measurably harmful to
devices that don't subscribe to this. That issue is not so easily
remedied.

Since this patch is a copy of the scsi implementation, the reasonable
thing is take this fight to the generic block layer for a common
solution. We're not taking this in the nvme driver.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
