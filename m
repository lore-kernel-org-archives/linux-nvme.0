Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E667BC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=; b=W66lQnUB91k0fjOFJsB86HI0Il
	7LCqigQYHJQ5WdRAEM3vzR2P8P0UivI0akVA/2Ffm7GsKqZ83vfnhTU9a6MqydAo7eDmV0PZrkj1o
	e+aeX+mbt1nX4AYAtGFXVpAog+41zlmH7VXpBNUvic1ltvoFhqwWVW9Wyj59OJSz+UY6iCMPZvcNB
	MXwmB+I97iRC6Hk1L0YSpYqRXyPKFt/GjFplKFRqZjILwEGjzqfdIzSirsJUT1UeIRQa6z0qx9p1J
	uW8uxxavDXpsYiSmO5MlJiaV8lNYK5wKbe5vJB20x+Phg1KU/oVHdid2fheN0bHzcjEAPxm4bCzrH
	syKyAfSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odD3o-00BhJv-EG; Tue, 27 Sep 2022 16:03:52 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odD3j-00BhIe-AS
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 16:03:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id F3F44B819D6;
	Tue, 27 Sep 2022 16:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A6C433D6;
	Tue, 27 Sep 2022 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664294624;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hmr/L/F02i/ZJ+y96/jric7WSuVR/gB/UsK938JTCJwBAsYrHnPq/HVpXzW02bXsT
	 vJZU02k7Q5kQfLoTbIsv80u0443V8YO+LZQNTcnirNDiq/6axUraEFOyN+/kXTPPGY
	 rKnLGI+kFCQZpNkrXxM3Z5ehDraM2W7/rafd0egSzZMY7pNV3gn9hsK5TZ6wtbyrn9
	 KCAEzGhjK2Kfg9eHKyQlTXIN5r1xCpRGzRu4whI3VKnNJGMm31Jft0ZaGORFqAg+Gd
	 RTfIETpcvvTdynQffvQF8I5vPLWzQRS+3aRqriQoDDpABBE3ItfdTM2OBSyJc0O9gI
	 hKhZh3k6zxdgg==
Date: Tue, 27 Sep 2022 10:03:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: Re: stop poking into the request queue in nvmet
Message-ID: <YzMe3ZovyV3y0LK4@kbusch-mbp.dhcp.thefacebook.com>
References: <20220927120915.280166-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927120915.280166-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_090347_522913_F6AF1391 
X-CRM114-Status: UNSURE (   7.82  )
X-CRM114-Notice: Please train this message.
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

