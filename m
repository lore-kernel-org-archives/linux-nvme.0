Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798CEC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9dy6OGNEdl5SppCUePud5XFfmKacRxz6jdTcFkLhqno=; b=PD3g3nym5WqVwpa4MrZ/fGjiKW
	7qmvYaFxAD01OxknVuEKbqKS32PicsaebufHI0gnJVhe/kmCDMvywX+1aparYoyT+RPRhBGTfL70X
	MqB+fOOh4DtR0039ZEp5PEBe1cKkf1Q4ff+1ZrTIxw6kHPJ07W1pGazLl+QsHc2pISDmYYxb9k024
	FH9uVsb36JZY1TiaS/oDKPh/E2C4kCZEGiJwRXY/l8kUc7nDpdCtPazyzNOy8U5/LQWFFTSmhmSUL
	jISYQNOxYhc/jAoiBRYwLyz6E2KVPGM5gJp+/AtRYbqiQ7M8mqwyVXEy1l5VtyZg5hw7dbEfTjTud
	xWtpCt/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeIfD-00AWJ7-Ol; Fri, 30 Sep 2022 16:14:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeIfA-00AWHz-Il
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 16:14:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D71EF623BD;
	Fri, 30 Sep 2022 16:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5AEC433C1;
	Fri, 30 Sep 2022 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664554494;
	bh=iieU/wFSJMsR6lEF8Z4eAaXZHM1Nsm+5KvRZEUTIDQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsgF8hJ3RkrXBIrUHYRvTfMty9yS2RFNWfA9sJxC9H8WjAC02wMmtbdKW9fUVNFGD
	 nKmAQBfZ0sdinBJb28jtkC2a+zfAcEWXCbSsz8ASJ/kDAGE76b4Y/RzJsL6k2wBWlQ
	 GyqzHaQih//IyI3gWQVBqnSwy4U8SrbYgfy6oRbOaE26ibPS32nJXVr8udodmSxsua
	 26Rj/WtE6+YXRjozoPS9aAbbFLPWGUpvzNNSijXvaL8q/AvHMduxDcbh6QTI0K9LXD
	 xRHAJ9i3rrRAEhzgz2V0wzDOhm/F18vfEDEInTzhPTh2Ax52D53deNamc64CxLDgD0
	 eMTGSXCqkB37w==
Date: Fri, 30 Sep 2022 10:14:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Neerav Kumar <me@nero.im>
Cc: linux-nvme@lists.infradead.org
Subject: Re: add NVME_QUIRK_BOGUS_NID for Intel P4608
Message-ID: <YzcV+3odaX1j4yqa@kbusch-mbp.dhcp.thefacebook.com>
References: <CAF9DR03RxNagB37S=F__JUhOf0m=M8vwCJ=kv93mQYXDGTJN7Q@mail.gmail.com>
 <YzcGICHQRR3NPjed@kbusch-mbp.dhcp.thefacebook.com>
 <CAF9DR02G-wrRD_AyNzoW4yRoch7_5+LJC=8knBxz-8TT1CZEVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF9DR02G-wrRD_AyNzoW4yRoch7_5+LJC=8knBxz-8TT1CZEVw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_091456_674121_32D20234 
X-CRM114-Status: GOOD (  17.24  )
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

On Fri, Sep 30, 2022 at 10:13:04AM -0500, Neerav Kumar wrote:
>  lspci -nn|grep NVM
> 09:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
> Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
> 0a:00.0 Non-Volatile memory controller [0108]: Intel Corporation NVMe
> Datacenter SSD [3DNAND, Beta Rock Controller] [8086:0a54]
> 
> So, it seems to be the broken 2x4?
> I only have access to a P4608 so I have not tested this on other
> device ids, if there is a way to narrow down the patch to P4608 I
> would be happy to do that.

Yeah, that looks like a 4608, but unless you have another one, or perhaps a
couple of regular 4600/4500's, I don't think we could know if all models suffer
the same problem. It might make sense duplicate identifiers was isolated to the
4608 within the same package since the intention (misguided as it may have
been) was that it appears as a single device instead of two.

