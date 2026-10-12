Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D8FCA9ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xP1oht89CwRZ8lK8dc2psCTyCsXfeaCRWjUSkyJhkJg=; b=JltuslqV7AWi8nYuUZH7biLXMm
	QcT8j7sxwxMOOFVU848ebF/u6rfYuDmNLNxZxt41eViFUUMzKmbqxGeQ/n8qsRQcKbWTypB2oFszF
	FpLi/85JqT8kUmCM2awCIy3KFGTMbyNW3YAPoz933k2wCIx1/ftcBGH70OtVGs/EsU1+aG+OhlTPi
	9iTMPgHro0lTHl0r6rkiIWIRbUSUOkbqC5k6cba3Aio+ldOWE3eJpOAaPMnS+5bE5n7ZcCzzjA5uG
	xQgYLknPKj/OToQm9NJwqKU55pYZUKWMfmP07+ilNQr/DZutc61tx+KKZBTuSfh6XtTW6CsF6BdGp
	kSs6v4Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGHBs-0000000AhzJ-3MDs;
	Mon, 12 Oct 2026 14:39:48 +0000
Received: from out-179.mta1.migadu.com ([2001:41d0:203:375::b3] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGHBn-0000000Ahyh-0isL
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 14:39:44 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=CEkn6V5ALhhqhhpxb3OWlxXupE8t6sIgFZ0BVdRWG90=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791815981; v=1; x=1792420781;
 b=mdCytkoSLrzPBrXSb6TPfgPUphJ/NUPDhEGvUnJTGA/XcBrDJm0n63PNRkBO0F/mT7DKCquG
 6P23U0b7lVFP6pP3ojn+9oIwDXFGeV9g1KgUAC8ewe92sduxyrwgxym0wN1hVWR7zsEOF74aFEs
 QnRiTRqgZRagLLfXqU9/Ya9A=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id c71f62ae9e69f9bb;
	Mon, 12 Oct 2026 14:39:41 +0000
X-Mizu-Trace-ID: c71f62ae9e69f9bb
X-Migadu-Flow: FLOW_OUT
Message-ID: <8894307f-1042-497c-9c16-3fc1312486fb@linux.dev>
Date: Mon, 12 Oct 2026 15:39:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
To: Christoph Hellwig <hch@lst.de>
Cc: Adrian Huang12 <ahuang12@lenovo.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jiwei JW10 Sun <sunjw10@lenovo.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
 <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
 <20261012121736.GE29954@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261012121736.GE29954@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_073943_434653_15DC3CF1 
X-CRM114-Status: GOOD (  14.68  )
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

On 10/12/26 13:17, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 09:42:04AM +0100, John Garry wrote:
>> And now we seem to have a conflict, as Christoph wants block size > IOVA
>> rcache limit but you find it may cause this soft lockup.
>>
>>> 2. Another NVME with mdts=5 (maximum data transfer size = 128KB)
>>>     2.1 The issue does not reproduce regardless of the 'bs' configuration
>>> 3. The condition '128 KB' is identified because the IOMMU scalable IOVA mechanism supports a maximum transfer size of 128 KB.
>>> 4. IOMMU pass-through mode does not trigger the issue with the 'mdts=10' nvme disk.
>>> 5. The issue only appears with high-core-count servers
>>>     5.1 Reproduced servers: 448-core server and 384-core server
>>>     5.2 Non-reproduced server: 128-core server
>>
>> How long does it take for the lockup to trigger? Pretty quickly, I guess.
>>
>> Does changing the number of CPUs affect throughput (before the lockup)? Are
>> you using just a single disk?
> 
> If the iova cache locks up under a perfectly normal workloads it
> is broken. 


> We really need to fix the code there.

Sure, but it would help to first fully understand the conditions to fix it.

