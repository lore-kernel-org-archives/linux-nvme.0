Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B51AC432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 15:07:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C796214DA
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 15:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EgU6iTbd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0bB7XPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C796214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tW9HJZuQ1hLtElNbEhbVBmSjcmt7ySTzEEHCaZK7blo=; b=EgU6iTbdt1e2pJ
	GGIAF21miTtrHWQRCnkZp1cBRLvCTlu0v5RfQzadyR9e4iHte9TK31kL4BmxVlbFiYc1BmOrF27BZ
	DHGzI4aw8fmzQxc/Bn+VdSRv6Soqf8uJkONoHr0fW5Z7yO+zaNk0Qpcwj4JEyfX9JhNVjhSIQulXF
	YYgf8yFG9QbpGqqqJFqd8x903PqHviddSOuhAygXtr3WPpUlJmQJDK4y0rWsJm5IvnzHF2ZHJDOly
	tpvNMLyx9iwU1aMahADWHQINgbAlqJW64mMEDqwmeDxqbqM/7Y7p0t1SJ3JgW0nXvvA8SsuZEMqjm
	Bh0CH1rtW1fpac5N6Nfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCmPb-0005bN-Bv; Tue, 24 Sep 2019 15:07:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCmPW-0005b1-Pk
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 15:07:28 +0000
Received: from C02WT3WMHTD6 (unknown [8.25.222.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07F59214DA;
 Tue, 24 Sep 2019 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569337645;
 bh=UunFgAk6d8zsWESVvOrrvRAZj6+71PQz9u5zjdWb3Es=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a0bB7XPmdG0PxgPGbaKWMY0xBhoxpA8yuxKDGBNIVt4qPHMmp+eL9HQPVXq6AI/QE
 OwKAr/PO9etlc4CZtFwF8LUhDbh1LOmxk/XqGWY1EiAIpNfANUgSVd+vf+NRmKGy9Q
 i251BOW/pofqRwx/25xXOxn8fbpVUeR3sV2B7Pc0=
Date: Tue, 24 Sep 2019 08:07:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 0/6] nvme: double reset prevention
Message-ID: <20190924150723.GA21929@C02WT3WMHTD6>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <8cc6bc39-a060-3128-bf19-afb06a5c36ac@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8cc6bc39-a060-3128-bf19-afb06a5c36ac@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_080726_865258_F4E69EBA 
X-CRM114-Status: GOOD (  10.23  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 23, 2019 at 03:09:43PM -0700, Sagi Grimberg wrote:
> Keith,
> 
> The series looks fine to me, do you think we need more eyes on
> this or we should go ahead and apply this?

Sure, I think the series is okay as-is. It will clash with a fix from
Mario, though, so one of us will have to rebase.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
