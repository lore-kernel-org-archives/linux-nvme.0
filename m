Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA325C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sJfYyAfMGMBF0Xlv9um+ifOfxBm2UMnyXbgZ0FGiTu8=; b=eoJyNZi2/vMUUhkHPme0wYzk/t
	GKId9wF7OrI7jcFarK8g4Y11HDWwu1E5vf7aBKDict1K2RfXnvXEEY1e7sE1GmZFeEHXr+rQKlvvo
	6MZzgByICCgTfbQ1TQwtHrhX5p/7y+OujmqF4wbAtj12loMTt/zOz49O96PYhPUqHKGF2DArSW9XY
	w2zQIud+wvkSSS2Uu50ii8isVYLBXzJoDzYAJYKgMSK1Wr/FjeGVhDa6EDczEU2RMFu22K/Cs1PAF
	DxQ9NsQA3XLszI8rvUSYXcvsF/R0mK9R5msRC7i56108nb04oDdj1+4g/KMpKj2r0pqGOQQF8c/dY
	VfImtQ+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLryL-000ISv-2f;
	Fri, 05 Jan 2024 21:43:21 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLryI-000ISS-1y
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 21:43:20 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C9735C02B0;
	Fri,  5 Jan 2024 16:43:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 16:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704490993; x=1704577393; bh=sJfYyAfMGM
	BF0Xlv9um+ifOfxBm2UMnyXbgZ0FGiTu8=; b=Nn4xRmtU/lGxURPoNCcuELQSt4
	8JjN08ObTdMgJTA+fK1+4G1O7PPw6FpCSVN2M+lEIT9I0yF3yhK8xCVAbMc5HtV7
	NhkGxtXzF8id6G4fZYPoTqHJtXVUQ0IRX0KEC5QCNXjSf1zQVxhGnJF06/fHjL1r
	t8l6FgXhfoLtuDaxnta6mcZfO1TZF1EECoCVbElqH/aZaPaeYpZULoF6E6Rjjhol
	fekJxD23Q2q+/XwBBxB5qUluNowcvAVKdUvD6LXTJbD0PJbU562RO6P8MtFi96vn
	VAr9yl2HYA11+EdI1C0PH/0f5ZCiNQndCcOF4GHElk2aMoZdiFp3WZGTLlrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704490993; x=1704577393; bh=sJfYyAfMGMBF0Xlv9um+ifOfxBm2
	UMnyXbgZ0FGiTu8=; b=IXjwhailbUZHc6COqA5JVscOjtbTdWcDKGlnyHlzAs+Q
	FcB7u4pDeOEu11CeZPXXOkP7pxt8Hv59FOFgF8u1WyMwrozcIKzMyGpIk5NWu+IQ
	qb+WRNBcdw/CrqQUCfgu8nYKgMAnHivbkpAMqQnPwngtlxjlkYWdFW5g3GlmDDni
	wwFY3AgujLiUaHH6Z9lw+IkyKQr2nSevO20pM+qOgPF/l7xKtHazZd/d4OE8MEqM
	D37hPZ6+yZPmKYjFvz8kM5yYWEho4CF08on0gRr9jzLMouX/mEnyb8g0uMFRi+VD
	chp/6fJdLDlGLQH8QibuEjYHcwRG/eH58SE4G1DjWA==
X-ME-Sender: <xms:8HeYZbtfBjRZurX8JNVXJcSpeDqhkQN8I2lCmMNOKEwK8U3vcZLGUg>
    <xme:8HeYZcfgEpNzPjUUv7PQg4jDpDWhWWNkIKHRCdAqFdSIw0DO1xXc6PGVMmNu30dM2
    L8BMX_YiHH-OgSzlp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeuhfejgeehhfefgfffhfdvjefhueetjeegffeuhfdvffelfffgtddvvefh
    ledugfenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8HeYZezW0FX8WOtZfRXYv0BLefpPEGy1_22EHFD1fZxmhpUhvb5ZuA>
    <xmx:8HeYZaP2djl1uED8fytDl6WmsFEMS88pUYQ28R9aFhQZ_4S6-sgZBQ>
    <xmx:8HeYZb85xU0UqJYMkazVJbN_M4UeFS7gHRRY8jtrM9SA48ZBu-IxFg>
    <xmx:8XeYZbwph26eXHguKtVc2ZKO0H0a9uYns7C-4It7S5zs7XIbtvlBgg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 840ADB6008D; Fri,  5 Jan 2024 16:43:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
MIME-Version: 1.0
Message-Id: <44c39a85-a1e8-4c3f-9416-b1f17e5bc36f@app.fastmail.com>
In-Reply-To: <ZZhtK6vjk5UD7pxi@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
 <ZZhli2FWXwP1XSRG@kbusch-mbp>
 <20508695-b9e6-4aaa-9c78-84891c1a8f9a@app.fastmail.com>
 <ZZhtK6vjk5UD7pxi@kbusch-mbp>
Date: Fri, 05 Jan 2024 22:40:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Daniel Wagner" <dwagner@suse.de>, "Hannes Reinecke" <hare@suse.de>
Subject: Re: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_134319_195507_604650ED 
X-CRM114-Status: GOOD (  14.18  )
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

On Fri, Jan 5, 2024, at 21:57, Keith Busch wrote:
> On Fri, Jan 05, 2024 at 09:36:38PM +0100, Arnd Bergmann wrote:
>> On Fri, Jan 5, 2024, at 21:24, Keith Busch wrote:
>> > On Wed, Jan 03, 2024 at 04:56:55PM +0100, Arnd Bergmann wrote:
>> >> @@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>> >>  		return;
>> >>  	}
>> >>  
>> >> -	strncpy(name, req->ns->device_path,
>> >> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
>> >> +	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
>> >>  }
>> >
>> > I like this one, however Daniel has a different fix for this already
>> > staged in nvme-6.8:
>> >
>> >  
>> > https://git.infradead.org/nvme.git/commitdiff/8f6c0eec5fad13785fd53a5b3b5f8b97b722a2a3
>> 
>> +       snprintf(name,
>> +                min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1),
>> +                "%s", req->ns->device_path);
>> 
>> Don't we still need the zero-padding here to avoid leaking
>> kernel data to userspace?
>
> I'm not sure. This potentially leaves trace buffer memory uninitialized
> after the string, but isn't the trace buffer user accessible when it was
> initially allocated?

I'm always confused by how the tracing macros work exactly, so
I don't know either. Looking through the other tracing headers
with string copies, I see that about half of them use the padding
variants (strncpy or strscpy_pad), while the other half use
non-padding strscpy.

     Arnd

