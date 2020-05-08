Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70454C47247
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 07:35:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49209206D5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 07:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LYbNFFEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49209206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tQLLiVQdsAMs3Ir3V7gVLWfAsajWfa/Novreire4Uqk=; b=LYbNFFEbkI75SJ
	3kN1/3q+9QMNjwo+JltF+AOmMiB5dZm0+pYRz2VkLwxhE0okj4ihQGx9m/zMA4ve+SHVnzB33e5eL
	sQH1rcLXoLpURLVmEVK5yHFHvy+jqrgl/4cHQ5SqNFun5k6yIgahbuZJc+M1VmILd4pTLHsnulA89
	xKYF/xHranzg9SQP5Mcc6ilW8Gz9gh0wZEw0I1pnJGw4XRBeWO4G8AtWhX0lpFeyVxCxGxlFxMqYk
	uC0Xf3q4dg8LiCvs83TTDG/iQyS8kGtxkqvDUBRGWqGd1q+sUdSkNOGYwN29vscvcXhQwHX51Sc4I
	mzHEPT9GONuSFGU7HwGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWxXn-0007a2-HL; Fri, 08 May 2020 07:35:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWxXl-0007Ze-LZ
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 07:35:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EC9F068BFE; Fri,  8 May 2020 09:35:34 +0200 (CEST)
Date: Fri, 8 May 2020 09:35:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE
 when we have more to send
Message-ID: <20200508073534.GA682@lst.de>
References: <20200505052002.14924-1-sagi@grimberg.me>
 <20200505060907.GA3995@lst.de>
 <f0f28e18-c432-8343-f7a7-79cb3159b43c@grimberg.me>
 <20200505102354.GB15038@lst.de>
 <6abf2183-ea1e-d1e0-360c-5d74b75c3690@grimberg.me>
 <20200506042734.GA9542@lst.de>
 <ced17f23-0bfc-d076-7c20-ad02c1b54786@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ced17f23-0bfc-d076-7c20-ad02c1b54786@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_003537_854250_299CCE83 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Mark Wunderlich <mark.wunderlich@intel.com>,
 Anil Vasudevan <anil.vasudevan@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 07, 2020 at 05:50:38PM -0700, Sagi Grimberg wrote:
>
>>>> What I mean is that nvmet_try_send_data and nvmet_try_send_ddgst may set
>>>> neither MS_MORE nor MSG_EOR.  Is that intentional?
>>>
>>> nvmet_try_send_data should set MSG_EOR if it doesn't have more to send
>>> and also nvmet_try_send_ddgst. So its not intentional.
>>
>> Ok.  Can you send it with a little helper like I suggested (probably one
>> each for host and target) that ensures the right flags are set
>> everywhere?
>
> I think its actually better without the helper. MSG_SENDPAGE_NOTLAST is
> designed only for sendpage and not for sendmsg which we use for ddgst
> (although the net stack code appears to ignore, but still) and when we
> send a pdu header that has data, we dont need the condition because its
> not last for sure.
>
> So the helpers capture ~60% of the call-sites... seems to me like its
> better off without them at the moment. WDYT?

Ok.  Are going to resend with the nvmet_try_send_data fix thrown in?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
