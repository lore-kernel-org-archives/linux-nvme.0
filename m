Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5648DC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 06:24:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C42613E1
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 06:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C42613E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0muklu++MKHpZ2mi3NMwGtNc4SGpJtN593IBu2QsFeA=; b=WkedDD/2yYM1RYfRtF/ADxe8F
	nvEG5eUh7TtPLEyXcQle+YxAxzoA4+yfwpk845wSwMo03UwDP9iUdrF8IIvQFQvsq9GhBvd5BtlPO
	6Dsyv+PrxjuqhnFCQ6hKt8Sa4NJ29ttt92ULL1S11/B7X9rxbSQ9hhnhPHNsbX5VznGLBqb89yWux
	L7T///I2QK68j0HfLI2HMbcxqlGNH+6zIcFo4Y9lJPIPnT/0Iyx/exnVBpGO4PEUuQis97kAhhOJN
	oLAPtArW0dZnIyszS5BD8N6TwVaK+YU6cF/HcKpf9PJ2rNtfkeYr3rq+xmeJ3AFIHmEo2zmlmIG6q
	EsvGZ0sLQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lfzL1-00DM5W-00; Mon, 10 May 2021 06:24:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfzKk-00DM4t-RU
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 06:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ee4fpLs6sa9IK9h1lMA6Nl8aTs27Sw/zRn7C8SVHu8g=; b=nIJXv2g+FzsyzHLwX5y//4O8GE
 K3zsnzYUUU4CAfthucNrN03owARon+qCXzOY/rPcncbO0BsP/iDs9mqzZh87hCnupxnHTPqOotlkF
 5QM8i+Tq9Xfro0Zc/HCGEg9gDibCM1o3nmTtUybi7dyWcGcY6tJ/lWpvFkDjV0G0gVT2H6i0uSw5X
 BvLG16LTU3HpqryeNlfJEeY3PRujV2IvCDIYBCpuKt8mFemfcPq55h1Z32eV9xCwRRe2xa58Y2a7e
 jcR40r4lvM6pwAt+NSHL2qCf1+viIqtFACsRuIp9qYEDG1mJEd5Gl2s/CDrA7YNSimVFUoRwN83mf
 uAEiN6Vw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfzKg-008Kps-RC
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 06:24:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 66C4867373; Mon, 10 May 2021 08:23:46 +0200 (CEST)
Date: Mon, 10 May 2021 08:23:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
Message-ID: <20210510062346.GA30116@lst.de>
References: <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
 <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
 <20210506120855.GA1546@lst.de> <7cd891d9-6aa0-fd98-cbc5-1df2eabbe31d@suse.de>
 <20210507064656.GA24437@lst.de>
 <4fd33328-9060-6e95-dd26-ab013e44c07a@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4fd33328-9060-6e95-dd26-ab013e44c07a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210509_232359_073367_9E880B22 
X-CRM114-Status: GOOD (  16.75  )
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

On Fri, May 07, 2021 at 07:02:52PM +0200, Hannes Reinecke wrote:
> On 5/7/21 8:46 AM, Christoph Hellwig wrote:
>> On Thu, May 06, 2021 at 05:54:29PM +0200, Hannes Reinecke wrote:
>>> PCI and fabrics have different defaults; for PCI the device goes away if
>>> the last path (ie the controller) goes away, for fabrics it doesn't if the
>>> device is mounted.
>>
>> Err, no.  For fabrics we reconnect a while, but otherwise the behavior
>> is the same right now.
>>
> No, that is not the case.
>
> When a PCI nvme device with CMIC=0 is removed (via pci hotplug, say), the 
> nvme device is completely removed, irrespective on whether it's mounted or 
> not.
> When the _same_ PCI device with CMIC=1 is removed, the nvme device (ie the 
> nsnhead) will _stay_ when mounted (as the refcount is not zero).

Yes.  But that has nothing to do with fabrics as you claimed above, but
with the fact if the subsystem supports multiple controller (and thus
shared namespaces) or not.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
