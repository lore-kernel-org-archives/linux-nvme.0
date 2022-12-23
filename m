Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D8DC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2To79WNMTF4K2+fkid8avf169IweySAkg3+yKw0TyYo=; b=xRKUT3OeJckizqfz3pUMFMecu9
	dFygmLKfY9R9J6y0s9pwe5buKjCwz4N51iXShH7qm9BBt5yv4ABBAf1SdCy8WH3W0i74fWfKNisVs
	iV2pF4soRU2g9y1ZYdQTQRK6yPL0ZsbJNFLiCImd6MoTZE5WKVc6ZozRM3FeR7v2HwNib/S9SisR7
	gk+GXR+/B+TTZjy10WMSpsuhQvvXM93Oj5hyzsu9Vi5wDXRSxlv+2jI629VGFon2GL4RLlLqFxNEJ
	d5PhEmF4W0bsOH5adHgRAcIHtOIAh5jOtGBMr4TaDdgXxgWD3EuUstQImzBNap+eqRijyv7WBahIm
	tKQh8KlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8iqn-008lSW-2Y; Fri, 23 Dec 2022 14:16:41 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8iqk-008lQ5-F2
	for linux-nvme@lists.infradead.org; Fri, 23 Dec 2022 14:16:39 +0000
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E78EF4E5;
	Fri, 23 Dec 2022 14:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E78EF4E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1671804992; bh=2To79WNMTF4K2+fkid8avf169IweySAkg3+yKw0TyYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=blnjTx6Luu5jxoHHHqqqEhrSVJY3AocV2e6LZRXSggmhh4QE3rKtiLbqhYMCwVmJP
	 z6LyNSuLmWZUq3Ez5BqefVzKlpjzKTDuQLKzhGfG9GmnJF5HducAh+uTckpxjPYHBi
	 Q8THCAHlLWjGHoE+Xiil55euKp98gqsvcRnhGD26mUQEaudii2jjznpuCRpKoUkHTc
	 qmL/a57NYZrQaodlFqHwcyzrKeDt0iDFQiZ4bWk2M7l5+UZuJC0mMEZhCtxX6uhXvw
	 0ImFiIu/nP6alzxOI8LNPZL6+E+UWTsB6nY1NzRCS15b6mvhbiNeXMhVx2XfkEkfzJ
	 VSScmSK6j/P6g==
From: Jonathan Corbet <corbet@lwn.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
In-Reply-To: <20221223093351.GA8028@lst.de>
References: <20221215125130.261098-1-hch@lst.de>
 <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de>
 <20221221083450.GA23903@lst.de> <87mt7g27lv.fsf@meer.lwn.net>
 <20221222160920.GA10193@lst.de> <87zgbfma5w.fsf@meer.lwn.net>
 <20221223093351.GA8028@lst.de>
Date: Fri, 23 Dec 2022 07:16:31 -0700
Message-ID: <87sfh6mchs.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221223_061638_544003_67E133F7 
X-CRM114-Status: GOOD (  18.62  )
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

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Dec 22, 2022 at 01:54:35PM -0700, Jonathan Corbet wrote:
>> I'm not really a fan of adding more top-level directories; one of these
>> years I'd like to try to move things in the opposite direction.  That is
>> a battle for another day, though; for now let's just go with this and
>> get the document merged.
>
> I though about that, but could not thing of a good subdirectory.

We can paint that shed another day :)

>> That said, I suspect you'll add a build warning about the new document
>> not being included in any toctree.  Fixing that would involve adding a
>> basic index.rst to the new directory and adding that to a file like
>> Documentation/subsystem-apis.rst.
>
> The new document is included in
> Documentation/maintainer/maintainer-entry-profile.rst in this path.

Duh sorry, I'm not quite sure what I was thinking there.

> I also did check for new warnings and did not see any, even if that's
> a little difficult with the rather chatty shpinx output.

Someday we'll get all those warnings gone...I hope...

Meanwhile, if it's useful:

Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon

