Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22646C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:27:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F9F61076
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 22:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F9F61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tQrHdu5T/fGLvxF8Q2y90aVxvnmmf6WFJiC18K10LW0=; b=pgrPpT+6kwgRxTBKM9xRskRyA
	TJtkft/BJiteTmMYjxybfJ9MDv43dmAHieypW7du1Bws8wB3GUws2JAMYKnVGOcDwcWzWwn/S/s0Y
	fUcnUyReWkqIr2mOWXUXb8o2tMTzlWGnJsSh/GWcZVrY4EXL0HsyOISaj11XkbTq0DUygR42hqGwA
	TZ+7opk4mvt23hl1SFApp6Oq/HoU9ahuWBdP/muPoJyyqJoZLoewbI+NmzL6rbUSseRE1qyTGBUAC
	wTGQx59SkrX1KtkWNx+jY2/u7iTvg/RwkZxddhRKDHtTVcxWIMsXRxFvAa7ulk8g7+CDndmvEptCv
	bd+x+2UnA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRjIf-007rIj-UL; Wed, 31 Mar 2021 22:26:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRjIZ-007rHc-A4
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 22:26:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 540DD61076;
 Wed, 31 Mar 2021 22:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617229609;
 bh=3S6iH7Idv6AcPsPxkFmAuUU5SqJJeOcLYIxvXN15mgo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iGQI/DGREWmQ97ieQLVj9Y+OpFgfJNioYAFZL+ckMKbyvC3Nx8lr/mZarZ11ckwqq
 YwuC7Qa70eWGvg6cmYGWFzyrF3gy7MpvvdI/5fVjGYv7fsa6NQRfgV3D/3VPipVsHh
 coNMfk4ueKs9NfcwvtGGaO/tIsIdcEKVCeeqHOke4oAPClqv9FVUUvcULRzovrjzZX
 C2ANLGoRjljj/pFPLBGn249SXf22Kf+fFxM/3kQDsi1e7XHvwK8EDG7mV7Tw90Z+8E
 xFvHtlIKaZ2irHcjaldL5LAAzB+xqEoLTxOYyLXcrn/J1trWV3kdjY7S5X3egzJ9eI
 WP9EU/D9JrH/g==
Date: Thu, 1 Apr 2021 07:26:44 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210331222644.GA28381@redsun51.ssa.fujisawa.hgst.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <027410bf-1563-47ce-1f69-73071df81ae3@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <027410bf-1563-47ce-1f69-73071df81ae3@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_232651_609859_C6AF691B 
X-CRM114-Status: GOOD (  29.74  )
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

On Wed, Mar 31, 2021 at 03:16:19PM -0700, Sagi Grimberg wrote:
> 
> > > Hey Keith,
> > > 
> > > > While running a read-write mixed workload, we are observing errors like:
> > > > 
> > > >     nvme nvme4: queue 2 no space in request 0x1
> > > 
> > > This means that we get a data payload from a read request and
> > > we don't have a bio/bvec space to store it, which means we
> > > are probably not tracking the request iterator correctly if
> > > tcpdump shows that we are getting the right data length.
> > > 
> > > > Based on tcpdump, all data for this queue is expected to satisfy the
> > > > command request. I'm not familiar enough with the tcp interfaces, so
> > > > could anyone provide pointers on how to debug this further?
> > > 
> > > What was the size of the I/O that you were using? Is this easily
> > > reproducible?
> > > 
> > > Do you have the below applied:
> > > ca1ff67d0fb1 ("nvme-tcp: fix possible data corruption with bio merges")
> > > 0dc9edaf80ea ("nvme-tcp: pass multipage bvec to request iov_iter")
> > > 
> > > I'm assuming yes if you are using the latest nvme tree...
> > > 
> > > Does the issue still happens when you revert 0dc9edaf80ea?
> > 
> > Thanks for the reply.
> > 
> > This was observed on the recent 5.12-rc4, so it has all the latest tcp
> > fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
> > difference. It is currently reproducible, though it can take over an
> > hour right now.
> 
> What is the workload you are running? have an fio job file?
> Is this I/O to a raw block device? or with fs or iosched?

It's O_DIRECT to raw block device using libaio engine. No fs, page
cache, or io scheduler are used.

The fio job is generated by a script that cycles through various sizes,
rw mixes, and io depth. It is not always consistent on which paricular
set of parameters are running when the error message is observed,
though. I can get more details if this will be helpful.
 
> Also, I'm assuming that you are using Linux nvmet as the target
> device?

Not this time. The target is implemented in a hardware device.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
