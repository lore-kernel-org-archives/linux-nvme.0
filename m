Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98D5C41604
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 08:27:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4D32078E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 08:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2qTyhmCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4D32078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1QwdMTBje7JlGqc3j87Kv1bG3WmxkxumqYxdmGtvCJM=; b=2qTyhmCx9x558MISC5ovfpUAN
	3OIVPOIrUbyacnB5/70Z91dcyRvVGhQ0IecmFPtDcO7lqj11FLADEA/xILLCy7WgKs/cFDYfHzXtJ
	G9mVihpUIkSiG152MhV9nKrxayBFC2yCvwO6KpKbzuF4pMDF2VTiXYxthgxcezZhUJzenX3TTG3uK
	3E1Wocs9j0C3bbgUQcxIWX8suH3qQS4Z7+x1j5ZzfKLZhwpMobfOO7NLkl+TG6tbAfUELv8WFK20I
	uNIJJ4q/LFv44P1Eoha8XvUy1BgvNTQSDWVNaOCsUu+21ghzBPgSxZffDGUr/8T9kdhIXvmsZqRrm
	/vdnvtzuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPiJn-0007zV-QW; Tue, 06 Oct 2020 08:27:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPiJl-0007z4-R9
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 08:27:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F0AD867373; Tue,  6 Oct 2020 10:27:27 +0200 (CEST)
Date: Tue, 6 Oct 2020 10:27:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
Message-ID: <20201006082727.GC10243@lst.de>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_042729_995592_FA688E9E 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 06, 2020 at 10:07:49AM +0200, Hannes Reinecke wrote:
> On 10/6/20 9:51 AM, Christoph Hellwig wrote:
>> On Tue, Oct 06, 2020 at 07:48:40AM +0200, Hannes Reinecke wrote:
>>> Well, because it's established behaviour of the current code.
>>> Changing it now has the potential to break existing scenarios.
>>>
>>> For PCI (ie non-fabrics) the current behaviour is arguably a corner case
>>> (as one needs to have a PCI-NVMe with CMIC bit set), but once you have it
>>> PCI hotplug is done for. So there we really want to change the behaviour to
>>> get the same user experience for all NVMe drives.
>>
>> Dual port PCI NVMe devices are pretty common in the enterprise space.
>> I really don't see any good reason to differ here.
>>
> ?
> Differ from what?
>
> Normal (non-dual ported) PCI-NVMe?
> NVMe-oF?

All multipath devices should behave the same.  No special casing for
PCIe, please.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
