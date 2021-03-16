Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D87FC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:35:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C966510F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C966510F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wnie1jRISSbza0MNcaCSRFIEyELsVj26zS23oEVRwbU=; b=LSEuSpADTE1Qvsn5SWgSlX9ZC
	M883ExpsQC4GGQnIWc6erhJYI/gTY/ZF8UOF7fX8MZLSICKgNWk6KnsNI0t8NvlJWkw+5gpw2k0Xl
	CTPYlsVF/4CZc7rkNXtf6OgeqJO7w/V9zyJfYBsd2Wl7KOl0OyN5Dfggtsqd7A0cDEFAUvPL61Iv+
	ImSlJsV8E1goAGfa4ZQRucbLBEizkdOnJVbB86gRNDUy1qVn9NvI/+iViI3MmvkfqfP00R5YCKNcD
	ISQ1MFwchA93zECfYL60k5KyrXBxEhs1cAkgrf7ZI3tgkIGYHLO5ncjGf+Q2iw5q32ClNyYOAOsm9
	pEKkyfEBQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMEWt-001dFK-B3; Tue, 16 Mar 2021 18:34:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMEWl-001dDx-KB
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:34:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7C20468C4E; Tue, 16 Mar 2021 19:34:45 +0100 (CET)
Date: Tue, 16 Mar 2021 19:34:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] nvme-pci: allocate nvme_command within driver pdu
Message-ID: <20210316183444.GA30936@lst.de>
References: <20210316170632.4161183-1-kbusch@kernel.org>
 <20210316180255.GA30086@lst.de>
 <20210316181354.GC4161119@dhcp-10-100-145-180.wdc.com>
 <f1fea65d-2be1-dc87-5f64-116884f452e9@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1fea65d-2be1-dc87-5f64-116884f452e9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_183447_914394_250FF3E4 
X-CRM114-Status: GOOD (  18.83  )
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

On Tue, Mar 16, 2021 at 11:27:20AM -0700, Sagi Grimberg wrote:
>
>>>> All the nvme transport drivers had allocated the nvme command within the
>>>> driver's pdu except for pci. Align pci with everyone else and replace
>>>> the stack variable with the pdu command.
>>>
>>> At some point in this series nvme_request.cmd should become the
>>> actual structure instead of a pointer so that we can remove this
>>> indiretion.  I'd be tempted to just do this in the initial patch,
>>> but I'm fine with any kind of patch ordering.
>>
>> I tried to start off in that direction, but had some trouble. All the
>> fabrics drivers embed their preallocated command within a larger
>> protocol specific payload, so we either need the indirection or have a
>> copy of the command.
>
> Yes, tcp and fc have headers that prepend the command so its better
> for them to have cmd+header allocated together.

Ok, I guess we need to keep the pointer than.  Would have been nice
to avoid that, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
