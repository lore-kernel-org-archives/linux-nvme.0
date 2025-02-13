Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931D7C021A6
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vB2tLQ8luJCtcby10TZWuCWKxWvuKnuAiaEweV/fb5c=; b=z6wJt6rlyHv1aSsvDTswnqnT8Q
	UrgOaW/34Yg4VJcp2n/9NAxSnickvmJVDFZ3kBXfBjfINwjMNv/5xRWmWh0gyB/oTu1mQv+y9ijkV
	4JIBoe/KiOczUTpk3t5iS6bziVriZ2awSajkqLuv7l2S29tXOlgRDK47OO5liUKdWdy+sHpYjPU0l
	0sz3UdXNGrlReZOuDkvtJFUELZ3RxMJf7A9qRtV5rEc7qlx7jaxzTlhzhrKesvdYk7ZgOY1TkxfpH
	Q1nUoSxxXuJUsKmcnD+PhiOIxjFGAaas59NAGTU+aJVD8s6EgQxk1W4ni5Z9KxXqU3cfQ/6Es04Xk
	gKKy2mtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ticH9-0000000Boqt-2dtA;
	Thu, 13 Feb 2025 16:41:19 +0000
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tibra-0000000BiO3-3ulk;
	Thu, 13 Feb 2025 16:14:56 +0000
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E87F138009C;
	Thu, 13 Feb 2025 11:14:51 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Thu, 13 Feb 2025 11:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739463291; x=1739549691; bh=vB2tLQ8luJCtcby10TZWuCWKxWvuKnuA
	iaEweV/fb5c=; b=9Hy452L+xFsWrycvvvMpOR9cm+RELglLGmf10ti5XFJpCPra
	aAFURThZV4MJxFN3JrXiPzcJYC7oyrXNsemLBK8G0WWPHSLU+8Uj4DYiTJE2Z15S
	NHiuo6kmBUERoogKifYuNLdDfz+zzEurt0CbIWRgKaZM7LEj+YIWLGu9UmTJZmM5
	+Tc7X5ySExZ0Ee8GRJt9AFuhr9j2TUWMwmNict5HHxJi1RHisypS5LGwXfFMVXDO
	1OcGHZDyzCOB6Rk0VYfATbMSJdmeBNAxhKATpLcGosUIFov+2IpBTvNwc0VJYgL+
	F2rKYC5+c2qORhR1reHTRbIXaeopPI7dtk/oNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739463291; x=
	1739549691; bh=vB2tLQ8luJCtcby10TZWuCWKxWvuKnuAiaEweV/fb5c=; b=a
	EIBhSP1UMOzP32rXYDdRMd9nK+mSv0CVZBScor0GRIswWzchuBi4SKCIljXYZWzD
	ZIDUGqG5UMu6qDxoWN0FfW+5SWXnI5bVr+WybgQDGHeLjrB9Np8WhLzrYp1Qge3U
	HUsYTxsiYfHZ8xoOMNul0s/qzc4WJSQ1xL6A/M0UN/WpZx3o2wkLJoCh/6xQHZzb
	Cr0lEluVENMTss/xAalNIwEnMEH6N53wizYoCjrZdxLQH0rb600v9FbXRYUVjNvd
	HcvzCFTlDU3pvnG7sKh1quEaTu4LlA1Ql/lhJiRWspSQlvm5QhZHxizW8Sl9RWRZ
	qFUZUMRjokZdk/6ynXpLA==
X-ME-Sender: <xms:eRquZ1tInnf9kRqzkJYdsJgqzfmpV6gZGjgjXJNIFJbokixtEqKbHw>
    <xme:eRquZ-esQAlMFQFvO1mBsM7OZ1UtJrb7tQAERI6MmUBx3BZf2pre8nnJFwsGb-9m8
    6GjRV5ggtbEn5v9BEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvggrlhesgh
    homhhprgdruggvvhdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgt
    phhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepkhgsuhhstghhse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlhes
    lhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvh
    hmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshgrhhhi
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohephhgthheslhhsthdruggvpd
    hrtghpthhtohepmhgrrhgtrghnsehmrghrtggrnhdrshht
X-ME-Proxy: <xmx:eRquZ4yANbrFpU9QyTEousZ9LrqnpIPXkZxxa-PGG083rHBHu56Czg>
    <xmx:eRquZ8PvOIgF_dIudDTbFb3hYzN3VV57sFtxSNSpx9W30UeOKXeH-Q>
    <xmx:eRquZ18Mr4WTOqZxZktpBpbJjwc7YzYHAPIvbJRaxFJOFw4lUyP2xA>
    <xmx:eRquZ8U6IHsHWO0WvdWVOadkBlGVRqHWhGvy7Uw0Z-yEspRiaaBPbQ>
    <xmx:exquZ8WIfkMqIOhgPSSFSrjSXxYGnq_gLIRbnQGTv-MXeOuObrmogYKI>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 798FDBA0070; Thu, 13 Feb 2025 11:14:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 13 Feb 2025 17:14:28 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Hector Martin" <marcan@marcan.st>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "Philipp Zabel" <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Neal Gompa" <neal@gompa.dev>
Message-Id: <dec49be0-c49c-4c37-8faf-72d9f89e4d53@app.fastmail.com>
In-Reply-To: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
References: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
Subject: Re: [PATCH v2 0/2] apple-nvme: bug fixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_081455_315341_D21E7864 
X-CRM114-Status: UNSURE (   8.47  )
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

On Thu, Feb 13, 2025, at 17:12, Alyssa Rosenzweig wrote:
> This small series fixes two unrelated issues with the Apple NVMe driver.
>
> * fix NVMe on certain combinations of firmware + machine
> * fix a power domain leak
>
> Although these are strict bug fixes, given the early stage of mainlining
> for these SoCs, none of this needs to be backported.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---

For both patches:

Reviewed-by: Sven Peter <sven@svenpeter.dev>



Best,


Sven

