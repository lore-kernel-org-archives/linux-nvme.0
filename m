Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6234D13C2E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wUDUsA9wy09I4xotPH5CVpOIPQbkv3J0mX/+TNotjGs=; b=KvtSTkUhlX/s25ZHEjX6hGHEpz
	ASIF/rrG6cLLU5fPBIsf5ITtNwtOEmoyKDPUTbbTH9EfmH10R3DkcL5ZwGYAaS5Mp5h/UbaGhu7Ez
	zBFC1/0NMONJA4jntbEWBP+o4MXrAAigbEPJ8s8aA8U2YxoYbmNQWwiyQxW+cWHygcMNlfWA2U0an
	Ss9UMoCz1ZttnSErDzXg2+E2CVYrkLpxohAHSdUYou0ah60QAOqFOT79C5ZO0Q5Hxq3ZYR5y6Dt1K
	ocClDCVHRcCN5hgOxz0biicjBpH+I1hfIbQEAmhARWIqiR/bLmMVQtkVKU9HaxIs9nK/4VrVhI951
	h5kBEopQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkOIi-0000000CkL5-2iiO;
	Mon, 26 Jan 2026 15:14:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkOIg-0000000CkKX-1D8P
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 15:14:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C23DC227AAD; Mon, 26 Jan 2026 16:14:41 +0100 (CET)
Date: Mon, 26 Jan 2026 16:14:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH] nvme: stop using AWUPF
Message-ID: <20260126151441.GA9705@lst.de>
References: <20260126132842.3332090-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126132842.3332090-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_071446_475088_27DC6650 
X-CRM114-Status: GOOD (  17.33  )
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

On Mon, Jan 26, 2026 at 01:28:42PM +0000, John Garry wrote:
> As for the per-controller AWUPF, how this value applies to shared
> namespaces is missing in the specification. Furthermore, the value is in
> terms of logical blocks, which is an NS entity.
> 
> Since AWUPF is so poorly defined, stop using it already together.
> Hopefully this will force vendors to implement NAWUPF support always.
> 
> Note that AWUPF not only effects atomic write support, but also the
> physical block size reported for the device.

Can you add a dev_info to the kernel log when AWUPF is set, but
NAWUPF is not?  This might really help with debugging any issue
if people were already using the atomic write support (hopefuly
not..), or if any other issue arises later.  Otherwise this looks
good to me.


