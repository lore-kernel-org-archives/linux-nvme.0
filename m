Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DB9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2Lf9Ymp10pm+Ci8I5k0K6BQ/XPqTSjzfUJePAsgaGU=; b=klwpBlaZDa7sDHdH3T7lzC21yd
	77RFXX3BCkyLb68/csIeDR4NqLEe3k8f3SHbLLGZ30l64ThK0pgj9WfM4cBfeg2qO6pvS/yPLiqFU
	0TQUKMWuLsnls0CBdmgaxsoUsi53PUMD+HUTl7cDdx8rT8oGSM5jazq0g0QM5Z8u2hM+3CQyHqPqK
	1NNX4jyrYdTvQtHKXkp0LGvVkC9mHoDPG0sLAYA1RrW7a5mGwDwRPzZfbQDr1TSWrsFchLCQh/eu2
	280JWctRGOs2ucnx679nnJyC3ZfKF5uMNoK6AjrfQoIJGYohshnQzbX/qfDLin6zLzXnCzMAbiVVD
	bpxX4VQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFiRw-002grd-UK; Thu, 03 Feb 2022 20:11:24 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFiRu-002gpY-C9
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 20:11:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id AF81ECE2114;
 Thu,  3 Feb 2022 20:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F600C340E8;
 Thu,  3 Feb 2022 20:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643919075;
 bh=4BSXxY3IonSFV0/jTnsSKEp9cBSpVvVKAZx5Z73OKBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a1sA23OOTGBzQUsW0WgiQ1AgpsibE0HLS/PRC17y19bQAlaqYDCzSp8gHd/CCb/D6
 nX0UBLUb9gsYhH7R/b5IMiCzWNsapQCa2rVGJtWNVtojtGetuRJo/PHomVV1S8tV2K
 h+aOdjUh9/3aprBno5KlhAn9F0HYgBxtCjPFP9vVllDAesYm+asCe4WhOq1YPDRzkW
 HD1GNrEQ5qlNdJUlNdQc4KVj4wDO2d0+g5rbQQC3TURttI83Z5bTUIDGO99lQEog/9
 8dPLuF5/MxdZhpFyDKG3uqSlCmSm1WEblCRut/gyqaLZdp8t63tzKxnmubDgkc01yv
 REvLg1kFMBKiA==
Date: Thu, 3 Feb 2022 12:11:12 -0800
From: Keith Busch <kbusch@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
Message-ID: <20220203201112.GC142129@dhcp-10-100-145-180.wdc.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <efd2e976-4d2d-178e-890d-9bde1a89c47f@acm.org>
 <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_121122_598185_655B61DE 
X-CRM114-Status: GOOD (  11.61  )
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

On Thu, Feb 03, 2022 at 01:50:06PM -0500, Mikulas Patocka wrote:
> On Tue, 1 Feb 2022, Bart Van Assche wrote:
> > Only supporting copying between contiguous LBA ranges seems restrictive to me.
> > I expect garbage collection by filesystems for UFS devices to perform better
> > if multiple LBA ranges are submitted as a single SCSI XCOPY command.
> 
> NVMe has a possibility to copy multiple source ranges into one destination 
> range. But I think that leveraging this capability would just make the 
> code excessively complex.

The point is to defrag discontiguous blocks into a single range. The
capability loses a major value proposition without multiple sources.

