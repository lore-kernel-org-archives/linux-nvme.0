Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35525C00A5A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fYXPmLKIt5MuF9M6sfAPtrgIJMJ6UraLbcHocFG1QrA=; b=sB9Wyf6Q3++WpgN/qLxX8eBDUI
	/w5Qt6uDXR48v50r+p6l7LRX0iYJjO4IU1tIW/+mT6s3a7bQcakJUKRCpbLP48jadNZK1pLrZNj/y
	JVHz2NJoA/00JADwJVGmBl7yg6dgA2bc7JPS3Mz8aO6zHh3X8TkNaYb9o0PBW04zFsbFns8cKUXw+
	AuES5FC0nn0JkGd3RWM4DAVgkQq5nhMrJD+UptOeveB15O3eknTb30Eeaw4LWnCIMytGb1NkJegLo
	ZpzJ+61fZ+5JVse+h7LlxwcJ5Mom2l+ICyvh9gvnEyOjNF3zcdHc7fgNSjd4ma/vdhQXGY6iDxhJx
	0vf0Edsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIPpq-0040EK-Tj; Thu, 19 Jan 2023 07:59:46 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIPov-003znc-83; Thu, 19 Jan 2023 07:58:51 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id DDA3B41DF4;
	Thu, 19 Jan 2023 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1674115116; bh=qyTTsAPiys3la5XkUpFouJxNDSn76IufAXYFiFAQBnk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=mitHd9GYk/SoARidHVomS7q8ZfQ2d1ULcTBxBJmXayM9ZzLstLc2FZIJdBjMnckQR
	 gDYp8dfFqoI03GxQ4eEo0Fr6u9YykYkH6fZXzyRjJEYB0xVC5y8q7kWuEHlxrcvEgr
	 p5Y1hIDnXP9fduqf2FlNsRb0GabgREmyR+s2Uf+XNA3BA0Pf4XU7HPmljZm7HPSAiu
	 UTgPMiaPun4+/avrBqNXEL+lsi7U5vTbDHCDuSKx7GWUBaHRH1VhSoBvw42Z6shEr0
	 b8/fLI7yf6fQJ2aEVzoWcD2LjAxZFkb1dczmckFmBZ+y0h2kaQMbEcoGFdORCTXhcR
	 IwSx9uZRI0Cgg==
Date: Thu, 19 Jan 2023 16:58:29 +0900
From: "Hector Martin \"marcan\"" <marcan@marcan.st>
To: Christoph Hellwig <hch@lst.de>, Janne Grunau <j@jannau.net>
CC: Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Eric Curtin <ecurtin@redhat.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
User-Agent: K-9 Mail for Android
In-Reply-To: <20230119061452.GA17695@lst.de>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net> <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net> <20230118052450.GA24742@lst.de> <20230119061452.GA17695@lst.de>
Message-ID: <60A924B7-9F29-4AF1-9DF8-EA90DBA48B3E@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_235849_784812_2831ABC8 
X-CRM114-Status: GOOD (  20.73  )
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

(Replying from mobile, please excuse formatting)

I'm actually not sure exactly how this works any more=2E The previous seri=
es I sent (which had slightly different logic) worked for me on a t8103 Mac=
 Mini in smoke tests and I'd assumed fixed the issue, but it turned out to =
fail (in a different way) on other machines/circumstances=2E This one seems=
 to work everywhere, but I can't explain exactly why=2E Maybe we do in fact=
 need to issue an NVMe disable before shutting down the firmware to reliabl=
y come up properly on firmware restart=2E

Maybe something like this?

/*
 * Always disable the NVMe controller after shutdown=2E
 * We need to do this to bring it back up later anyway,
 * and we can't do it while the firmware is not running
 * (e=2Eg=2E in the resume reset path before RTKit is
 * initialized), so for Apple controllers it makes sense to
 * unconditionally do it here=2E Additionally, this sequence
 * of events is reliable, while others (like disabling after
 * bringing back the firmware on resume) seem to run
 * into trouble under some circumstances=2E
 *
 * Both U-Boot and m1n1 also use this convention
 * (i=2Ee=2E an ANS NVMe controller is handed off with
 * firmware shut down, in an NVMe disabled state,
 * after a clean shutdown)=2E
 */

On 2023=E5=B9=B41=E6=9C=8819=E6=97=A5 15:14:52 JST, Christoph Hellwig <hch=
@lst=2Ede> wrote:
>Folks, can you chime in if this comment makes sense?  I'd really
>like to send the patches off to Jens before rc5=2E
>
>On Wed, Jan 18, 2023 at 06:24:50AM +0100, Christoph Hellwig wrote:
>> On Tue, Jan 17, 2023 at 07:25:00PM +0100, Janne Grunau wrote:
>> > +		/*
>> > +		 * Always reset the NVMe controller on shutdown=2E The reset is
>> > +		 * required to shutdown the co-processor cleanly=2E
>> > +		 */
>>=20
>> Hmm=2E  This comment doesn't seem to match the discussion we had last
>> week=2E  Which would be:
>>=20
>> 		/*
>> 		 * NVMe requires a reset before setting up a controller to
>> 		 * ensure it is in a clean state=2E  For NVMe PCIe this is
>> 		 * done in the setup path to be able to deal with controllers
>> 		 * in any kind of state=2E  For for Apple devices, the firmware
>> 		 * will not be available at that time and the reset will
>> 		 * time out=2E  Thus reset after shutting the NVMe controller
>> 		 * down and before shutting the firmware down=2E
>> 		 */
>---end quoted text---
>

--=20
Hector Martin "marcan" (marcan@marcan=2Est)
Public key: https://mrcn=2Est/pub

