Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565EEC77B73
	for <linux-nvme@archiver.kernel.org>; Sat, 27 May 2023 04:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LSe+94f5mYxECiCE2aA8YQ+7DT5mkjJ22Pim9NQqr4g=; b=Zh/9+S3JhJAo5TfzbhAEfYm8AJ
	eJY+CrrHiG3y5I570kxqBNObaYA/3oKpl4Crl9KK5pwoe71Upc0j9zjPN7CQ4as7H75AHBNSvQWTw
	8lTU4psm51jCSxR7veRsNyuEpoJSyswZp7vO3jR6mZGeaGpoqFtfplMHxhohqMGicZVKaOOzM8XX6
	Tm6y7ifuSKva6KSx5pTBvcU4fvObyeFOyzfM/p5WoW626e35dSEDvj4B/Ibm/U2VHhE9CZ2+RWZ4G
	U/RGq9FrAuTg8SnHQ3GAwk4RIQ5x5nIaDXCcx+UR0gAoUPnYmbXGsalnfQULkfPFpL192SGGqHxYJ
	4JCMnCGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2lJZ-004p79-09;
	Sat, 27 May 2023 04:14:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2lJU-004p6d-0w
	for linux-nvme@lists.infradead.org;
	Sat, 27 May 2023 04:13:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB6E60E05;
	Sat, 27 May 2023 04:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C040C433EF;
	Sat, 27 May 2023 04:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685160834;
	bh=LSe+94f5mYxECiCE2aA8YQ+7DT5mkjJ22Pim9NQqr4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FwesSK6dBFUw3++zyfMs3xY8lMp0BmWl9j4hANvH5L58Ua9fqWOvfo23Q7zrDsoAB
	 ndsK3OTTubRtEeaO1GIJo5Jpwh4yaWaQN3jOEmQf+6nZTFKj8c+8i4uyInMBBADsgp
	 HgUTLluigyGtYyr5twrIlNE+1ueWU2jpyfsof0ccclfdDVSbQ9kL/qbOnbAGTU4VYw
	 1+AafksBwSe+Dz9s6benGEUI1YczTMvPf/4D11Lj7Q5aT4yH/XJ3+dJC3Q9yGIBUqU
	 A2sCpKwchnGNT20PKAbLq02laTX1CojZjfjKqeo2vR4hdwEiG6FWMNee0s5sLZoyK8
	 T2CDELvWZcBEw==
Date: Fri, 26 May 2023 21:13:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] net/tls: handle MSG_EOR for tls_sw TX flow
Message-ID: <20230526211353.33df9ca0@kernel.org>
In-Reply-To: <20230526143152.53954-2-hare@suse.de>
References: <20230526143152.53954-1-hare@suse.de>
	<20230526143152.53954-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_211356_372512_F397367A 
X-CRM114-Status: GOOD (  10.20  )
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

On Fri, 26 May 2023 16:31:50 +0200 Hannes Reinecke wrote:
> tls_sw_sendmsg() / tls_do_sw_sendpage() already handles
> MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails out on MSG_EOR.
> But seeing that MSG_EOR is basically the opposite of
> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
> MSG_EOR by treating it as the negation of MSG_MORE.

The cover letter didn't make it to netdev so replying here -
please add test cases for EOR to tools/testing/selftests/net/tls.c
(FWIW selftests now take command line arguments allowing you to narrow
down the set of test cases run, it's pretty useful here, waiting for
all crypto algos to finish is annoying)

