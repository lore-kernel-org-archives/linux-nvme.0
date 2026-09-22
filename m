Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B126C982F1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=92TuWhqOtb4Opw0WrxDzHlvkvrlOylibtZIxOMdSgTc=; b=fCdz5+TValTKycRcXBxAhaCSbI
	PGcnUpq5QEHJM5l1nK2py8m6zAi6xN66G/US83dHUi9vExqHmhrt1dNfTUg6g23UlX+j+E1J58hSV
	VKRRgkyev+yWTjyT4WIvcJDQoYZVMxyc2otboVnAm8sbOcrrVIKCvRhv/mJQU4yVhNPbag7FtyHmh
	mnSttAyGx0DE2meq8JyGdtW8MKY+rdvJyCj8Tkr/nkegeDojfYKkZw/vPv8bFA7+Svb5mKTRxtVgD
	PCjBFSigQ+iJQkXaVcjj8NHZF+gq1un9uZA9XGS2pjde7gXNFsnWptBZklgP7H26KTrR6dCg7TyRl
	N8jqLrXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8vZp-00000004czC-2n4h;
	Tue, 22 Sep 2026 08:10:09 +0000
Received: from out-232.mta0.migadu.com ([91.218.175.232] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8vZn-00000004cyi-3FyJ
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 08:10:09 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=NlF78RerIOTo/MnyozLSa9euZ5Hw7BjWTrePBtX97Ok=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790064603; v=1; x=1790669403;
 b=B3Q8G17sfPxyLqZ6/GzobbbM0TEywCwKS7BX4DRLSSCnq3hXf7Csf/xyUU/fEJfHE+YavObD
 hylAHE9gaKJyztZci/Je3JJ86ipBp+XDch507c3nY1jl4zQI/uS/oNEMuNrEb1h6Fw8xVaLYI9G
 SSB1JlYPYNDImeuHb2IewOP0=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 316ad890671470eb;
	Tue, 22 Sep 2026 08:10:02 +0000
X-Mizu-Trace-ID: 316ad890671470eb
X-Migadu-Flow: FLOW_OUT
Message-ID: <acd79732-1ef3-47d5-96fc-4dd3ff3eee27@linux.dev>
Date: Tue, 22 Sep 2026 16:09:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, yukuai@fygo.io, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [RFC PATCH 1/1] block: charge passthrough requests to the
 submitter's cgroup
To: Tejun Heo <tj@kernel.org>
References: <20260921070647.1928289-1-cui.tao@linux.dev>
 <20260921070647.1928289-2-cui.tao@linux.dev>
 <arFgjkKUwYGWbV8H@slm.duckdns.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <arFgjkKUwYGWbV8H@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_011007_985411_0446C96F 
X-CRM114-Status: GOOD (  15.09  )
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

Hi Tejun,

在 2026/9/22 00:51, Tejun Heo 写道:
> On Mon, Sep 21, 2026 at 03:06:47PM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Passthrough requests (SG_IO, bsg, nvme passthrough ioctls and uring
>> commands) are dispatched via blk_execute_rq{,_nowait}() without ever
>> passing through submit_bio(), so the bio mapped by blk_rq_map_user()
>> carries no blkcg association: the transferred bytes never show up in
>> cgroup io.stat, and every rq_qos policy on the queue (iocost,
>> iolatency, wbt) is bypassed, as is blk-throttle, which hooks
>> submit_bio_noacct() directly rather than going through rq_qos.
>>
>> A quick demonstration on a scsi_debug device with iocost enabled and
>> vrate pinned to its 1% floor: a direct fio writer was throttled ~10x
>> while the same cgroup issuing sg_dd writes ran at full device speed
>> with zero io.stat accounting.
>>
>> Associate the mapped bio with the submitter's blkcg at dispatch time
>> and run the regular bio accounting (blk_cgroup_bio_start()) and
>> rq_qos throttle paths with it.  DRV_IN/DRV_OUT commands are mapped to
>> READ/WRITE so io.stat classifies their bytes normally; request
>> completion already pairs with the throttle through bio_endio() ->
>> rq_qos_done_bio().
>>
>> The charge is gated by opcode (READ/WRITE/DRV_IN/DRV_OUT) and to
>> queues that already have a gendisk: commands issued during device
>> probing (SCSI INQUIRY etc.) have no gendisk yet and stay exempt,
>> following the same probe-exemption reasoning as the passthrough
>> iostats support.
> 
> Do you have an actual use case where this matters?
> 

I don't have a specific passthrough workload that triggered this in
production. I ran into it while testing blk-iocost accounting coverage.

The relevant concern here is cgroup IO isolation. The expectation of
blkcg IO control is that the IO consumed by a cgroup is reflected in its
accounting and subject to blkcg IO policies. Today that is true for IO
going through submit_bio(), but not for passthrough requests.

The concrete observation was that the same cgroup issuing equivalent
writes through two paths gets different results: normal bio IO is
accounted in io.stat and subject to blkcg IO policies, while SG_IO
writes consume device bandwidth without accounting or blkcg IO control.

So the motivation is not a particular SG_IO application, but whether
passthrough IO should be considered part of the IO usage controlled by
blkcg.

I don't know yet whether the right answer is always-on behavior or an
opt-in mechanism. The RFC was mainly to discuss whether passthrough
paths should be covered by blkcg accounting/enforcement at all.

Thanks,
Tao

> Thanks.
> 


