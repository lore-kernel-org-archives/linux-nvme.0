Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7DBC83F09
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=flLq9xEgsNo7dffruzcue0tL5vT71IqM1MD0NVOC0iA=; b=1QAtzrz/hhEqLpIysSGQVnooq3
	8aITWLM2Irv4ejkTivQEBZMeQAVy5HqqsMD6P5gY5RYLj9/2NZdn6uPgw7WsLDBbjKczfvTbapyN7
	fkJUT50x6xrjHsrFWbcs24tqcYTwkuBwk9or0Hb9ghCoedaz7iXgWOrwGTvbmwu7fhg2zSNWMJ86K
	65dFNmnlspHX5rkNMrX1qGfX4OLI736C7dC7HR59Id1zKfIJmEzSAQsf6thoexKze0nwPXTE8XsGg
	1kGkIU7TOJ3V9LLHl29HCqEytBiZ6j0tLdcJntMCpuHAcoHovpdmi7XuEK9aKGHsfyXSec3SF3asx
	mFSRBasQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZEyW-00000006WHa-3PHc;
	Tue, 08 Jul 2025 20:31:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZEQR-00000006RJH-1cFO
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 19:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752004581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flLq9xEgsNo7dffruzcue0tL5vT71IqM1MD0NVOC0iA=;
	b=HLZ3XuBraRibNqfier0Kau50HOM2ITFhTIdldromdpNKh81IJtlsxwRdMPmv0PKsAcZgWB
	D2/Fu1p0K5zTT55TVkmuIqFQZVnRrR5L50oNAuWEU6PXvZZ8bozKtFgQw+fzPDIJmCdGII
	kZiLKjjt5NpwQ+9UcX3gRIOEsk7W+9s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-baWVv1GFMN-8eGNAYZIXCg-1; Tue,
 08 Jul 2025 15:56:19 -0400
X-MC-Unique: baWVv1GFMN-8eGNAYZIXCg-1
X-Mimecast-MFC-AGG-ID: baWVv1GFMN-8eGNAYZIXCg_1752004578
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DEDC1801219;
	Tue,  8 Jul 2025 19:56:17 +0000 (UTC)
Received: from [10.22.88.48] (unknown [10.22.88.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44F86195608F;
	Tue,  8 Jul 2025 19:56:14 +0000 (UTC)
Message-ID: <b0817e2a-1c4e-4d7d-9a84-633913d9e0e4@redhat.com>
Date: Tue, 8 Jul 2025 15:56:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] nvme-fc: FPIN link integrity handling
To: Hannes Reinecke <hare@suse.de>, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com,
 linux-scsi@vger.kernel.org, njavali@marvell.com, muneendra737@gmail.com
References: <20250624202020.42612-1-bgurney@redhat.com>
 <CAHhmqcTO_Q59aDr3DywC-tPF=9pe3gxbyn6J4ycdf+eYEOayHQ@mail.gmail.com>
 <19484829-0a7b-42ce-99fe-e74ccda67dce@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <19484829-0a7b-42ce-99fe-e74ccda67dce@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_125623_495368_0B1E4869 
X-CRM114-Status: GOOD (  28.04  )
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

On 7/2/25 2:10 AM, Hannes Reinecke wrote:
>> During path fail testing on the numa iopolicy, I found that I/O moves
>> off of the marginal path after a first link integrity event is
>> received, but if the non-marginal path the I/O is on is disconnected,
>> the I/O is transferred onto a marginal path (in testing, sometimes
>> I've seen it go to a "marginal optimized" path, and sometimes
>> "marginal non-optimized").
>>
> That is by design.
> 'marginal' paths are only evaluated for the 'optimized' path selection,
> where it's obvious that 'marginal' paths should not be selected as
> 'optimized'.

I think we might want to change this.  With the NUMA scheduler you can end up with
using the non-optimized marginal path.  This happens when we test with 4 paths
(2 optimized and 2 non-optimized) and set all 4 paths to marginal.  In this case
the NUMA scheduler should simply choose the optimized marginal path on the closest
numa node.  However, that's not what happens. It consistently chooses the
non-optimized first non-optimized path.

> For 'non-optimized' the situation is less clear; is the 'non-optimized'
> path preferrable to 'marginal'? Or the other way round?
> So once the 'optimized' path selection returns no paths, _any_ of the
> remaining paths are eligible.

This is a good question for Broadcom.  I think, with all IO schedulers, as long
as there is a non-marginal path available, that path should be used.  So
a non-marginal non-optimized path should take precedence over a marginal optimized path.

In the case were all paths are marginal, I think the scheduler should simply use the firt
optimized path on the closest numa node.
   >> The queue-depth iopolicy doesn't change its path selection based on
>> the marginal flag, but looking at nvme_queue_depth_path(), I can see
>> that there's currently no logic to handle marginal paths.  We're
>> developing a patch to address that issue in queue-depth, but we need
>> to do more testing.
>>
> Again, by design.
> The whole point of the marginal path patchset is that I/O should
> be steered away from the marginal path, but the path itself should
> not completely shut off (otherwise we just could have declared the
> path as 'faulty' and be done with).
> Any I/O on 'marginal' paths should have higher latencies, and higher
> latencies should result in higher queue depths on these paths. So
> the queue-depth based IO scheduler should to the right thing
> automatically.

I don't understand this.  The Round-robin scheduler removes marginal paths, why shouldn't the
queue-depth and numa scheduler do the same?

> Always assuming that marginal paths should have higher latencies.
> If they haven't then they will be happily selection for I/O.
> But then again, if the marginal path does _not_ have highert
> latencies why shouldn't we select it for I/O?

This may be true with FPIN Congestion Signal, but we are testing Link Integrity.  With FPIN LI I think we want to simply stop using the path.
LI has nothing to do with latency.  So unless ALL paths are marginal, the IO scheduler should not be using any marginal path.

Do we need another state here?  There is an ask to support FPIN CS, so maybe using the term "marginal" to describe LI is wrong.

Maybe we need something like "marginal_li" and "marginal_cs" to describe the difference.

/John


