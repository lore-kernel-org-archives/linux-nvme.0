Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0533C77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dbE3t7Y6owePEdSc5SmgDJYQCbcnFAvoF49ezHl2kAU=; b=zYR1VKysf4wENPn1yBtYVmIJNF
	cYY7Ghu3h4WJ4DIdyp4FgkVVv2SzNo4jlKKojvenuAnxbjUsbCzbTfHfOLP21J/c0Y/EUc5Nf03b5
	21BlP2tiqNF53ufp5drf49oTWBt+SyOXNTKiDA72M/BQFJX+o8voaFjfeUa29+RVJmuDIBM2sRreo
	yo6N0VZATwO+Vlzf9hFpUEuPAiPvDPABBZ0GGncxoHd27Zq6spjoyW/Kpy7VqdzLc/aPt9vx2MfLF
	y1jo+M6jfOqZvlBHc7cmO5lR+inCCN0RaYjqiNmDEVCJIYh16RjlCRQrzcXBiFkZIpTh4l9cBeSQE
	v1JJtWpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poVBc-00HUfl-0i;
	Mon, 17 Apr 2023 20:10:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVBa-00HUfF-0T
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 20:10:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A32F962090;
	Mon, 17 Apr 2023 20:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDBBC433EF;
	Mon, 17 Apr 2023 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681762249;
	bh=hIoqtNRBOGqTpc2RXSotxVJwjNrNbGDsm8P+77+YGjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s6n+OO6M2Buc2XhqNeHM9gtugguD0WMhzMR779U2rIiUJX+CLJfs1kAsCMJYqORdz
	 pFC3FlpRfJBoAtYKyzu/Lc5MSdWT+tfxOonv6LB5366/+yDQrS7rAfk8i3OhYpXzQJ
	 U7pMLWRLSDNQkqq1ETPfNYrkMLh32jwuU/A5/0er0pWrH5eD5vLUi14RoNSX1VuSOP
	 oLVB4bvRpJMiDwqQEOF+YTJhUR0jJIibq30vJV0Zr0JmZKEIyp3m+NYXvvOsxfuSET
	 M2BezGuy7txhuosl/X89Go2OeFa4228IDD5jbt8jiSDygnHgYcwWfOUBjrnrMzolmX
	 aqh7glmhUt4Kg==
Date: Mon, 17 Apr 2023 13:10:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Chuck Lever
 <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH 07/18] net/tls: sanitize MSG_EOR handling
Message-ID: <20230417131048.66b6b3a0@kernel.org>
In-Reply-To: <20af9713-8d64-77de-dfbe-e9e732776d3c@grimberg.me>
References: <20230417130302.86274-1-hare@suse.de>
	<20230417130302.86274-8-hare@suse.de>
	<20af9713-8d64-77de-dfbe-e9e732776d3c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_131050_222192_D8EA1B99 
X-CRM114-Status: GOOD (  14.02  )
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

On Mon, 17 Apr 2023 18:19:12 +0300 Sagi Grimberg wrote:
> > The TLS stack is using MSG_EOR internally, so the flag cannot be
> > set for sendmsg()/sendpage(). But to avoid having the caller to
> > check whether TLS is active modify the code to clear the MSG_EOR
> > flag. And blank out MSG_MORE / MSG_SENDPAGE_NOTLAST, too, as they
> > conflict with MSG_EOR anyway.  
> 
> This looks like a temporary workaround to me.
> 
> The networking folks really need to be CC'd on this (same for patch 6).

Thanks, when I said "we can support EOR" I obviously meant support 
not ignore it :(  No ack.

