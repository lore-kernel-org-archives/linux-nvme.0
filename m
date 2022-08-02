Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2794C00144
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 02:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7FKFesSGfgxjLo0wFuddvdOLNJhKyrPal8jhhIo8JBQ=; b=4AkX8uU3tNfY5VBykpR7rcc4jW
	h8exCSqRoozu55nI9+wmHkIUNpRfO++eaz7WPDbur25Ipbzje2Xx7qo6Cf1l0uIHkgwGrBBB9acd0
	qS/TKQR5Tn/58gHLECINaTdDACNdfkIW4JDKTDz7O20QFhMQvKb/3pYfMLgIOJ7t4IdjGq7UUgv1Z
	7efqWGR0tUaoZBhY5imCVLHe4G/b9k157OWmhnOnvNK4t4YHh/xZWgRdCVgDD+CHJ9Hxt483oOIJ/
	qOmdXjDeX5qd/l+lua7RsHlpkw/FDTTbX0yDCVRap8+zrpB3ELOG7jVZlj9IQOpj0j1qYPP2c1uUU
	z3Wj8q3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIhYi-009tB7-49; Tue, 02 Aug 2022 02:23:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIhYe-009tAX-MA
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 02:22:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D15BD60FD0;
	Tue,  2 Aug 2022 02:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE34DC433C1;
	Tue,  2 Aug 2022 02:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659406975;
	bh=zfXihpHotlOrcxPKnVyliz9E5YGQ6A1GZH+/R4p+2os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyUMFgnE8fcTNQOck0i1AaWuCMTNRQfEhLQCKkrxN07i8p+8Ca0FDxb4HsvcwpKVo
	 dGiiLe7TVEci3bcOABRcsJzSusgJGA1gGI6Fik6BKBGroe3bE0jVGE7sIPbkjmi36i
	 qahNrETSkQ78OuOzAo1iIzDCdJ79CsMIy/TDVtyxuhHgdGmUcaW6R0gInDMj0yGVkH
	 MSKhO0QWLNrbwI+2aXnkl9TAZcp/9guKJih1Cf6dZH1OwMUOYt2ZLUFCwyrz6APCAK
	 CYFzoyLPkRNjpKP+KdmPhRnUxrIZZmiat5cCj6sset23crqCAsRWEfTlxEE8KuPGRA
	 u66qNww0+JyAQ==
Date: Mon, 1 Aug 2022 20:22:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-pci: fix race between pci reset and nvme probe
Message-ID: <YuiKe239yI1HO7/f@kbusch-mbp.dhcp.thefacebook.com>
References: <20220801125753.1434024-1-ming.lei@redhat.com>
 <YufkHXoUrw7jRLuT@kbusch-mbp>
 <YuhqNUNgkT9HpLEo@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuhqNUNgkT9HpLEo@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_192256_866310_BD68DEE5 
X-CRM114-Status: GOOD (  15.32  )
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

On Tue, Aug 02, 2022 at 08:05:09AM +0800, Ming Lei wrote:
> > 
> > If you are encountering a nvme_reset_prepare() condition during scanning, that
> > might indicate a failure to communicate with the end device. The scan work may
> > need the error handling to unblock it.
> 
> Not sure I get your point. nvme_reset_prepare() is called from storing
> to pci device's reset sysfs attr, so it can come any time, including
> scanning.

Oh, I mean these .reset_prepare/done callbacks are also used by the PCIe AER
driver when the root port sees an uncorrectable error. In some cases, you won't
be able to successfuly use the PCIe bus downstream that root port until after
resetting it. I was just considering that scan_work may be stuck because of
such an error.

