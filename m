Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AB7CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5qbRwC7/61W3GYW2RtFfZm10SF5FN0SlHBZvSzQHcI=; b=TmpKRNPPKnvKBQWr/tJ/acxyPN
	RfX186kCtOTgucX3RcjvCmEgWjrgK552UQEnuGkCLEQ3Qy96iYksDOGijqlC74f1ChRL1IQVyelKK
	2Rbjd6d0GHpqoadtAnyU3d4nQmvVmtA2PyPOo0DI+3h44vVWXrwqhaIzO+DdN9hFfysHFCMrdk2y4
	o/edeGofL4Vayb2ZzcD7tWkbJyFIGduY41buLyhSvGwOZ4CNsZprCY6X3C/dGtg2Sb2i2HK6TubIy
	f49d6EfHQjKNgZVIW5l7Bg+5vuahPpwBDB13s/Xvzx67xbume0pg9bYDEcKNI5k1bC1N7BpWlDbSf
	wEw8pg4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLgI-0000000Chrk-3nGa;
	Mon, 11 May 2026 08:08:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLgH-0000000Chqu-0fkY
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 May 2026 08:08:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b5qbRwC7/61W3GYW2RtFfZm10SF5FN0SlHBZvSzQHcI=; b=TlIWJssfKxneTfLtpnMgIf7Flc
	s19DPv5bIQdkSY0r4aJ9yQuiAd+YQt0J+Fw571VWJRIHZKFX9pYOx+6ZfUi0N48/LE7/yRqn7lt3+
	gZd366487a1G/P1OrzVeja0uZFRFob4PkvDfrUWdPXxkxRx6Ukoj9tCVzxutXDhybOygel53w9XEE
	I56veMkshcziqmhuM3/b/QWRT946HreXHcNysrM1tH4AoiEv2bfxUeJxinmAFAGFYCzzaUdVWxMER
	loE2xjKwmQo1dGwvWBBYbQO97rULnqut4z3LjMD16dXvEeL200yfrPA44UtqPiFBjYKKEPrLNT3YV
	/d2e0cxQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLg8-0000000Axet-0837
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:07:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 024DD68BEB; Mon, 11 May 2026 10:07:47 +0200 (CEST)
Date: Mon, 11 May 2026 10:07:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org,
	mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org, dwagner@suse.de,
	mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 3/9] nvme: fix race condition between connected
 uevent and STARTED_ONCE flag
Message-ID: <20260511080746.GC29677@lst.de>
References: <20260508133335.98612-1-mlombard@redhat.com> <20260508133335.98612-4-mlombard@redhat.com> <3512fbae-ddf5-458d-9286-214b1d89afa8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3512fbae-ddf5-458d-9286-214b1d89afa8@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_090753_237133_4BACCED7 
X-CRM114-Status: GOOD (  10.15  )
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

On Mon, May 11, 2026 at 01:10:34AM +0300, Sagi Grimberg wrote:
> This should even go as a separate patch:

You mean a stadalone fix?  Because it already is a separate patch.


