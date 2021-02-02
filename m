Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32E1C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 15:23:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4625964E40
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 15:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4625964E40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3tJ7u9WyijkzCvz5W8g31xYXoKUfUPYYZ3h8lvQ84kQ=; b=tpfE5/bbegY+B3gH8BG+hC3lU
	5rqOmreT1o3t/MBdECQLtVFX+F6S5h7l6oaBSQB3VQBSqj3ZdBriLpLu4DuFLx3d7BaH1MECWBMmm
	5V3A8WnP9NNtp0Nm1Hvm/D3nX1OuALL8YKEui/DuKhRCQXKq5fVb4CUCgjUq2DmCZSfiJ/GJMYB4J
	oPpIScitwDnsnp6SGC9aX35sJW+QvyYA+Pbqib1VfWh62FbC8U15TP7AgfZTxbDT4XWqxJSpzQCEx
	JTOshKWdvFX2EKt/RkPqu9loMH8//AF3bsGWuPe9B6GzvOfcTrVvsWRGBkuaflC2sYBY1RhxYTRJt
	tcsh8/iJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6xW5-00080a-2i; Tue, 02 Feb 2021 15:22:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6xW2-000807-FP
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 15:22:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C178A64E9E;
 Tue,  2 Feb 2021 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612279373;
 bh=2vGmfZdLHPk5Iqf5ytlSV/TRN04rjbPOAXIjCMheVMY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B2UdaUnzNqyILVaPV0i4GPdsq5PVThHLFOG7FVE1xLYMUPJ4OhxInlFA+Pcc6E3hv
 RYfokG/dZmWcX+7nBTPtzAy1f0ur1uPm06vENXsSWdw6d0lEpNerU28izdry/NnbUr
 Y70VC//QKBPC5Fb+Cmp94mB1wnJsdBzrS357pPEjojCrbtZx8o3qnYxQyzs60ENaXb
 ozqyII90KtWPO2BzK/2mug72eZkVN+769qHuiEF3aYPCDR5URtrMRzrfQHw9eB2V9E
 ezLe6mAxYl67MPhkewBkCdJ+nDMbt6FEINmylgcrO1qWMkvvmr7V569ztjQFe/qyz+
 7fDpFN3brKbwA==
Date: Tue, 2 Feb 2021 07:22:50 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: Buffer I/O Errors from Zoned NVME devices
Message-ID: <20210202152250.GB2128135@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB56561E48A54530BC7F6DCF30EAB69@BYAPR04MB5656.namprd04.prod.outlook.com>
 <20210201175306.GA2127465@dhcp-10-100-145-180.wdc.com>
 <20210201180257.GA14971@lst.de>
 <BL0PR04MB65142D8FBF2B6BC88E32DCCEE7B69@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB5656F20169A935B9100ADC1DEAB59@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5656F20169A935B9100ADC1DEAB59@BYAPR04MB5656.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_102254_677697_25F5A4CB 
X-CRM114-Status: GOOD (  26.86  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 02, 2021 at 03:06:22PM +0000, Jeffrey Lien wrote:
> Keith, Christoph, Damien,
> This errors are happening on both the 5.9 and 5.10.7 kernels.  CONFIG_BLK_DEV_ZONED is set to y in the .config file.   
> 
> I will try the patch to disable partition scanning that Keith suggested.  I'll also get the latest FW loaded and see if that resolves the issue.  

After re-reading FW dev's explanation, it sounds like something is off
with the implementation. The spec only allows a "boundary error" if
you're crossing zones, but you said the reads are in the last zone, so
there's no opprotunity to cross to the next zone. 

What did you mean by the "zone's hole"? Does this drive have ZCAP less
than ZSZE and we're reading from unmapped LBAs? If so, I think we are
supposed to be allowed to read these, but we just can't write them.


> -----Original Message-----
> From: Damien Le Moal <Damien.LeMoal@wdc.com> 
> Sent: Monday, February 1, 2021 3:05 PM
> To: hch@lst.de; Keith Busch <kbusch@kernel.org>
> Cc: Jeffrey Lien <Jeff.Lien@wdc.com>; linux-nvme@lists.infradead.org
> Subject: Re: Buffer I/O Errors from Zoned NVME devices
> 
> On 2021/02/02 3:03, hch@lst.de wrote:
> > On Mon, Feb 01, 2021 at 09:53:06AM -0800, Keith Busch wrote:
> >> On Mon, Feb 01, 2021 at 02:36:12PM +0000, Jeffrey Lien wrote:
> >>> Christoph, Keith
> >>> We're seeing a lot of these Buffer I/O errors with our zoned nvme devices.  One of the FW developers looked into it and had the following explanation:
> >>> All these Reads are from the kernel during enumeration and for LBAs that are in last zone's hole hence expected to return boundary error which is getting logged by kernel.
> >>>
> >>> [65281.936988] Buffer I/O error on dev nvme1n2, logical block 
> >>> 3800039296, async page read [65281.937165] blk_update_request: I/O 
> >>> error, dev nvme1n2, sector 3800039297 op 0x0:(READ) flags 0x0 
> >>> phys_seg 1 prio class 0 [65281.937166] Buffer I/O error on dev 
> >>> nvme1n2, logical block 3800039297, async page read [65281.937335] 
> >>> blk_update_request: I/O error, dev nvme1n2, sector 3800039298 op 
> >>> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0 [65281.937336] Buffer 
> >>> I/O error on dev nvme1n2, logical block 3800039298, async page read 
> >>> [65281.937498] blk_update_request: I/O error, dev nvme1n2, sector 
> >>> 3800039299 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> >>>
> >>> Are you aware of this issue and if so, do you have any recommendations on how to avoid or resolve?  
> >>
> >> Is this from the partition scanning? We don't partition zoned 
> >> devices, so I think we can skip it. Does the following resolve the issue?
> > 
> > We already have special zoned device handling in the partitioning code.
> 
> Partitions are ignored and warning printed, but the partition table is still being read...
> 
> > 
> > But NVMe should make sure to never span a zone boundary as we set the 
> > chunk size to avoid that.
> > 
> > What kernel version is this?  Is CONFIG_BLK_DEV_ZONED enabled?
> 
> I had a very similar problem doing zonefs tests on Matias machine on a ZNS drive last week. The problem was the firmware... An upgrade to the latest version fixed the issue. Not sure what FW rev you are running here, but upgrading might solve this.
> 
> > 
> 
> 
> --
> Damien Le Moal
> Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
