Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C82ACEACD5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2024 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:In-Reply-To:References:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uhLOfNttXcEYAtBMsLB9Grso7BqU3vS1REd6YW7plOU=; b=vwtkMK4kZUPqat1T0sDFJlGprs
	KZedDNtZhW//HOe5yNeSs4hmqd2KZy7MwqypuqIk0fT5d0+P/J838tUPSR933Ue9wbGiZesSbC8/g
	tBHRWrBV9lYpyIUxT3/FGc1MoNoKDQbdGjQtUtEGmuDoHNj1trYmyaKVsOMg3tKTEXGidwIM/qvyo
	UXKB1vW4SoHfAv5PIxdeKUoEAYwkMHv1/+WgV4ymZ30q1V4vwGKdBYDoewTdjKcoOhdy9op8l8p5m
	ArK8szPZMlLZ2QXxvRqDq8bIKx44gVTMMIu4op9otOB9eygXqgd42ktq/wrwc9/UWOkiOhhw2jk+f
	0irpa9qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svfH7-00000003PEJ-2wSF;
	Tue, 01 Oct 2024 15:58:57 +0000
Received: from mout.perfora.net ([74.208.4.196])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svfH5-00000003PDm-23HK
	for linux-nvme@lists.infradead.org;
	Tue, 01 Oct 2024 15:58:56 +0000
Received: from jimw8 ([98.97.139.223]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lbtbu-1sCjf30cXE-00evug; Tue, 01 Oct
 2024 17:58:25 +0200
From: "James R. Bergsten" <jim@thebergstens.com>
To: "'Christoph Hellwig'" <hch@lst.de>,
	"'Kanchan Joshi'" <joshi.k@samsung.com>
Cc: <axboe@kernel.dk>,
	<kbusch@kernel.org>,
	<hare@suse.de>,
	<sagi@grimberg.me>,
	<martin.petersen@oracle.com>,
	<brauner@kernel.org>,
	<viro@zeniv.linux.org.uk>,
	<jack@suse.cz>,
	<jaegeuk@kernel.org>,
	<bcrl@kvack.org>,
	<dhowells@redhat.com>,
	<bvanassche@acm.org>,
	<asml.silence@gmail.com>,
	<linux-nvme@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	<io-uring@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	<linux-aio@kvack.org>,
	<gost.dev@samsung.com>,
	<vishak.g@samsung.com>,
	<javier.gonz@samsung.com>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
In-Reply-To: <20241001092047.GA23730@lst.de>
Subject: RE: [PATCH v7 0/3] FDP and per-io hints
Date: Tue, 1 Oct 2024 08:58:17 -0700
Message-ID: <006901db141a$bf9aa590$3ecff0b0$@thebergstens.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEtLMzQU9Mj3GK9LglaQbGW3QSfFAJ3IhvwAcJpBdOzrA9SwA==
Content-Language: en-us
X-Provags-ID: V03:K1:lv/Ipl00MnBrV8wUg8fbNZhL45WxX047MlZz8sQSg7lOnpxDafj
 sctE9uJCJBO181V3JR/KCGtQEG8rMmYDC0NJNzoVB9jQz7Pdno0U7uAK3m6Z9vsAs9GYJSf
 lyWMXG6tQg/J7lLe6hTY+ToIsKv+7SKuWoeo8WwyRTZ6fewLcGBa3tg8+tzdHOx2mqRYey9
 WRH9M3x+SzUUDzPMPNgcA==
UI-OutboundReport: notjunk:1;M01:P0:pQSu+TW5dFY=;ylEdpCoKiDT8/Slfhz/Sd90pVEp
 m+8gKULh/QRyvaZX26q9Q1CCwc3B9RWrVwd94iKI3r9YJKLbiWBDZ9QNce1kwY0l4FlYg7CtG
 LcWPHOh5iKvPvGvb+DFxEkSHYlAWGTZD5unUrQaOZoRh8ddF7h04l0iy3BPtlRdFsSSsj7VIo
 Nj1MBasULB57ZcWOPTNYZPsoS46BNJh/dUeivc81D4C4IWri4kaewOJHzr0zs3b9UYide02fb
 EigfqMv3hegVOYmJG5VSaJ7h40NlSIK4EB64TdFj5GHfQxzwkT62zV2L+69RArFR4x63mGOJc
 m04hWeXdpFv1CJ0Xn2om62m5n+fShUJCb0J+UjO9zE6wZJqifQfUXRxCVjUoWNCb3rWHd5ITZ
 I/1R+38/FzZApsTTTjDlZa7fQ44EKwbuOAZLlLfz7edXmNl2Qys1O9GtSy03wAEpDtp0kM9rL
 NXER9Od+ED20n4tbPp2svmcimtYI2x0Ynic4cSYF11DqJHZgSf5qRhxnDD4XAIElq9Mqhv1N4
 i5lyIv8YBWD6LBy0W4ycKl5HrdqQzYhC1lmIfnK1It0VE79zkquFvJijCAMwYGUjwZS5NIY+4
 zNZGIPjgWMbRfy/tDoC5dlvCliQAdhkMCPJwn/H8b9AuFPtvEG7OZkvMXon8Ig5nWKovn/d1b
 xqp/dcxcBfgL/fi6gYe3CCKIMqe/q3X9ll1/W1l+pebHzGeLIVG8WcmV/r7KE6DWJgP+vEBUt
 uW2K0kguFR12aTRqdc2kaXP+yZaq6uI8A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_085855_619414_E40162FF 
X-CRM114-Status: UNSURE (   5.56  )
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

Now THIS Is the NVMe I came to know and love.  =F0=9F=98=8A

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of =
Christoph Hellwig
Sent: Tuesday, October 1, 2024 2:21 AM
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk; kbusch@kernel.org; hch@lst.de; hare@suse.de; =
sagi@grimberg.me; martin.petersen@oracle.com; brauner@kernel.org; =
viro@zeniv.linux.org.uk; jack@suse.cz; jaegeuk@kernel.org; =
bcrl@kvack.org; dhowells@redhat.com; bvanassche@acm.org; =
asml.silence@gmail.com; linux-nvme@lists.infradead.org; =
linux-fsdevel@vger.kernel.org; io-uring@vger.kernel.org; =
linux-block@vger.kernel.org; linux-aio@kvack.org; gost.dev@samsung.com; =
vishak.g@samsung.com; javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints

Any reason you completely ignored my feedback on the last version and =
did not even answer?

That's not a very productive way to work.




