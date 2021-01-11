Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CB7C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 20:10:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E18B2054F
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 20:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E18B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z4O9QINDUltPCQQ1Vh7wbWRPfN5ZH8bQ3+7g91P/k4s=; b=NARcsMLFFV4c0Xp4A6hXEBmLM
	FGFkGyp7KvA6qC72XjoDi5A1q+Ynto02XRT2/I+2MJklb5q1Zud9w1f+W1wcMBswJJAW/uJsrSJDp
	cjFMiwjOSaQbGhE89lZCYXmuMgovpW1CyeNzqIR/4G9tkZnA3/GNrWK+CiBryjli6ABGd09ezqKgb
	g7n8RwWaU9aLWHxuwphfrnMuQdU+3ZwKmQOfcyxJgPVOqyKpCWy5N8bT7Qw1wCd6gSKrIIlcprGxK
	KEMIVhgvtcAeu126tG88xJLTR7ipSLecrv55kMgDGJkBLVh69dkU+E5uBJ2gq3IQ7CH+x2KvwTvjJ
	1N1MLubIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz3Vw-0005jY-Q4; Mon, 11 Jan 2021 20:10:08 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz3Vo-0005gO-DN
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 20:10:04 +0000
IronPort-SDR: RPgkByGaRutoynoPORBuV/MRSIbyCp5I2ddqwOkAnYkF4Byz0Kk//cYYiNsMl99c4eKE5BtOe+
 v3m8ACmiu5sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="242001388"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; d="scan'208";a="242001388"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 12:09:54 -0800
IronPort-SDR: +qPM/UzZo74nH7HGjzxtv88PQdgEG8W6blJsYVsxZZnnBbr2YbL4RCXm3Uk+R4w2H+ANcTStig
 CTRvP5FAo7cw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; d="scan'208";a="464273023"
Received: from michal-desk.igk.intel.com (HELO michal-desk) ([10.102.102.231])
 by fmsmga001-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 12:09:51 -0800
Date: Mon, 11 Jan 2021 21:15:52 +0100
From: Michal Krakowiak <michal.krakowiak@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210111201552.GA90320@michal-desk>
References: <20210104155343.GA26034@michal-desk>
 <20210104160220.GB1024941@dhcp-10-100-145-180.wdc.com>
 <20210106090053.GA32643@lst.de>
 <20210108223431.GA1451691@dhcp-10-100-145-180.wdc.com>
 <CAPcyv4jLWOKDTyGzwar4C0H5euggvD_Ak6NESLd9=1THGC=ASg@mail.gmail.com>
 <20210111170110.GC1458209@dhcp-10-100-145-180.wdc.com>
 <CAPcyv4g3LKRmUOj1QHmkQ5rZ4BfH6TQaK6jKhXfb2DoBW-MoUQ@mail.gmail.com>
 <20210111175018.GD1458209@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210111175018.GD1458209@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_151000_659803_242934B7 
X-CRM114-Status: GOOD (  22.97  )
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
Cc: Jens Axboe <axboe@fb.com>, Michal Krakowiak <michal.krakowiak@intel.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 11, 2021 at 09:50:18AM -0800, Keith Busch wrote:
>On Mon, Jan 11, 2021 at 09:10:34AM -0800, Dan Williams wrote:
>> On Mon, Jan 11, 2021 at 9:01 AM Keith Busch <kbusch@kernel.org> wrote:
>> >
>> > On Fri, Jan 08, 2021 at 04:12:31PM -0800, Dan Williams wrote:
>> > > Is there a more centralized place to land such a helper? trace-cmd,
>> > > perf? The nice thing about kernel parsing is I don't need to have a
>> > > separate pile of disparate tools across subsystems.
>> >
>> > Yes, I just placed it in a temporary location to see if the other nvme
>> > stakeholders are okay with the idea. If so, I can make a real patch
>> > series to remove the in-kernel decoding, and add the parsing script
>> > somewhere in tools/.
>>
>> "Somewhere in tools/" is still not quite what I'm asking for, I want
>> something nearly as automatic and seamless as the kernel ftrace pipe.
>> If I need nvme tools for nvme events and mce tools for mce events etc,
>> I'd rather just have decode in the kernel. Perhaps this is a use case
>> for a usermode helper that accompanies a new kernel tracing file?. If
>> the helper exists the events supported events are decoded if the
>> helper is missing the interface is equivalent to the raw formatted
>> events. Decoded events "just work".
>
>My only concern is that decoding omits fields, so you have to ugprade
>your kernel in order to see the missing ones when the current kernel's
>decoding doesn't "just work". If that's how people want to maintain
>them, then I won't object any longer.

Like Dan, I really appreciate having the trace parsed in the kernel. I 
understand the concerns. What about having both: detailed parsing and 
raw bytes? It does not seem to me like a big deal to append a field with 
the raw data even if detailed parsing is implemented. Let the parsing 
extends the raw data instead of replacing them. This will result in the 
detailed human-friendly output (which is nice to have) while not losing 
data in the future (in the case that a new unsupported by parser field 
appears).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
