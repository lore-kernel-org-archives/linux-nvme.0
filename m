Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B90C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 20:50:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DD46100C
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 20:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DD46100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=78fqIEHiffkNYWhBPEvO8Gr/EMc+NluWZPWJcsIDv+g=; b=PCm39bXTd409EwP+rsBlip5eY
	+UvCRok4OEIBMMb/U1/ohJl0DhMrvo8JqNfUIE5tS0XhdnthcaGaiTW85Ek0lRBUvm/MSFribXBPi
	LN5B58foeQfCf2ijUezKt/nQGFBaoGQc3Uat9puGbK4BADpasfX/p84oltMfIIT/Y8649oSuhOFy5
	1oJ/70mo447zYsWHbAOGT8BBq/ftfPJ4V4HvTRrmlbDKxP1Qi3yWDh7ivim+e23hMWADrqmarp/7G
	03LzFLjkpteSBcAMOZc0JreWbvBN/Zk3S+Wqt9klMdMG6FLD6WvZVPThH9dVdl8fqKThxRGH0CBlo
	e5oC0C/5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRhnE-007ZAT-IE; Wed, 31 Mar 2021 20:50:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRhmx-007Z5U-Lv
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 20:50:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E1696100C;
 Wed, 31 Mar 2021 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617223804;
 bh=Ny5R7s8guBJL3gFl/xlcHnd8wGa3OZVQnAj7IdXREkU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VPSSGB/OAc1lzcZhvuZvJkz5PnXWUHSQOT6PXNAyckWnHZCz3eFqFX0OecBfXV4JQ
 j+xAr71xPxvOXZfUkpzPDoCgsm6KK9BWMcaC/6A+wNgHeAG/Ey7VGA3clqubIinNIx
 j5E83ixYhq++FJYaQyjihtN2sv+mLpWCL8nrq/nEGFZ3TekFWxwmI13wxse5JnYexP
 AL+Tji+Ej8hDr8IlzIXh3VGj5nDjAuVJtIXH0kaZBAfs7VBV1KR216UHAw5rCBpL2Z
 eLxGReAguIJ9EUH57TvcP7wGmzU4CZ9KMPOeIT4Uzyh/3yP76ZrqZhXdRz+cecFMZh
 nAZIVj5SOLVeg==
Date: Thu, 1 Apr 2021 05:49:58 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_215009_728862_37AFA299 
X-CRM114-Status: GOOD (  20.52  )
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

On Wed, Mar 31, 2021 at 12:10:55PM -0700, Sagi Grimberg wrote:
> Hey Keith,
> 
> > While running a read-write mixed workload, we are observing errors like:
> > 
> >    nvme nvme4: queue 2 no space in request 0x1
> 
> This means that we get a data payload from a read request and
> we don't have a bio/bvec space to store it, which means we
> are probably not tracking the request iterator correctly if
> tcpdump shows that we are getting the right data length.
> 
> > Based on tcpdump, all data for this queue is expected to satisfy the
> > command request. I'm not familiar enough with the tcp interfaces, so
> > could anyone provide pointers on how to debug this further?
> 
> What was the size of the I/O that you were using? Is this easily
> reproducible?
> 
> Do you have the below applied:
> ca1ff67d0fb1 ("nvme-tcp: fix possible data corruption with bio merges")
> 0dc9edaf80ea ("nvme-tcp: pass multipage bvec to request iov_iter")
> 
> I'm assuming yes if you are using the latest nvme tree...
> 
> Does the issue still happens when you revert 0dc9edaf80ea?

Thanks for the reply.

This was observed on the recent 5.12-rc4, so it has all the latest tcp
fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
difference. It is currently reproducible, though it can take over an
hour right now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
