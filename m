Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D9AC433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:37:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4367C61186
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 14:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4367C61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=++ZHgMXncMtPZB1CRkeRtmqRs3rcYwravTqDy0U6p4o=; b=kYxsNz1yyjbsc109zBYWqDA/x
	1S7BSKz0yIP68NeOEJdYX495Rqtz79Cqyi7KZh5L7sWRC8/Pz7UEo+ehOW8TsJhRJa8CYTZhZnyrX
	WvnadHFeVWd8GSgUektekDtAl0H/ZjhVS3Xp26T7t+x1wrZKSG5PIkyoo7UhOfwqBjxdOudT6ZSDi
	xbW129ollYKAkvfNVVsUDjq4tY5lQE/dNUTyomkjl6kn+DvfbmcKabqIDfZyLim8Qex7bzhGa0kxx
	SlkGhT7iH+mF3HI00OYIy456m0JsNsKubp1HPA652jJSMtZ9HTBD99N5h7eOYBBbD4BVEmC6VUazZ
	mGQOecStw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldwAH-00GMmU-1U; Tue, 04 May 2021 14:36:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwAE-00GMlZ-7Q
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 14:36:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WRpsXMQBEUhfzg/vbNgZh83f2XgqNkdnfoOAY307L1M=; b=lIbZZ59576a6OBvU1O/dg970aG
 ieCgdBOIK3TRtmehfo6NA3LKlhEEi2hp+5VcQur52qRZSWFQ+WGyCNYxNlcaaTxp5Vzz057QwxyBE
 0ikgcNQilqsLpygKMIy8CzVQpbPNSoOnJmCHVLqNPX8AT9NLnFQtaoW/sSwrOcoVkqs9rx2jyoHER
 CI0fGg/G8eSXrf2Hq+I4WTvck4X05yuWzencQFv44Mn/RS9a4b7R5kKU98Vn/xr+9Px8zMhCn/Ilu
 pTZnYUU+tgerM1DDvsAj5HSNZqt/1yChO35kTWQPbYWXySE7FCSAziIO668IlvAZj6qMgWGBxdDgn
 pDbrcqwA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldwAB-0042Ut-OY
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 14:36:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89630613B3;
 Tue,  4 May 2021 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620138997;
 bh=9hPqORT+xSEbCGuuJCnC4x8vBndyRuj/C3AYxN32cyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=djvYefWV45OrQx1U44qkdJ2Y+htGpBMaBlNVQgV49k9KL5zz7QSP6J49bnOZZ02AO
 jW795GYj13Iy2+1cgIyRfutXZnx4DLdnG3OkgpPcIsZorDUU1Zudv+h9mMb1hoc/D5
 G0Jzjea81xgtNkAHzqfSRhbdx8IwINuk0PGkYuYr1a6qvmaZrCPth4ibVd1x+D2Tk4
 8j7WPeO4XGbzyuDpxOiRFRW7yeIScnNROsbibb3I3hPRvmEYeWcnYpZHJ9pbNcM9Si
 AB8DaOWvVTiD052GvtRGkAZKuidvcrlE5HjUMdMLd6LZR+5Cwif1ayNLgij5Akriak
 wCAw2T3M5Sl9w==
Date: Tue, 4 May 2021 07:36:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
References: <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
 <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_073639_861630_81712305 
X-CRM114-Status: GOOD (  22.98  )
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

On Mon, May 03, 2021 at 01:00:05PM -0700, Sagi Grimberg wrote:
> > > > > > Hey Keith,
> > > > > > 
> > > > > > Did this resolve the issues?
> > > > > 
> > > > > We're unfortunately still observing data digest issues even with this.
> > > > > Most of the testing has shifted to the r2t error, so I don't have any
> > > > > additional details on the data digest problem.
> > > > 
> > > > I've looked again at the code, and I'm not convinced that the patch
> > > > is needed at all anymore, I'm now surprised that it actually changed
> > > > anything (disregarding data digest).
> > > > 
> > > > The driver does not track the received bytes by definition, it relies
> > > > on the controller to send it a completion, or set the success flag in
> > > > the _last_ c2hdata pdu. Does your target set
> > > > NVME_TCP_F_DATA_SUCCESS on any of the c2hdata pdus?
> > > 
> > > Perhaps you can also run this patch instead?
> > 
> > Thanks, will give this a shot.
> 
> Still would be beneficial to look at the traces and check if
> the success flag happens to be set. If this flag is set, the
> driver _will_ complete the request without checking the bytes
> received thus far (similar to how pci and rdma don't and can't
> check dma byte count).

I realized this patch is the same as one you'd sent earlier. We hit the
BUG_ON(), and then proceeded to use your follow-up patch, which appeared
to fix the data receive problem, but introduced data digest problems.

So, are you saying that hitting this BUG_ON means that the driver has
observed the completion out-of-order from the expected data?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
