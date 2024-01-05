Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C035AC3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bk5Dr8X0YOCHd1Jl3i1ek4zNKLgAMly86kV1nZv04w8=; b=DHEjY8qj2q05w1GiRb8Qh1C4L9
	q4Q8NVPUxPQXFygaxQ2zu9ZyOuzZQHkfdhDv35WLVxm8GsaIKNcqHbPY1blOVmPpvlTLODEPi50+o
	sskR+VPpcP6M/etXXDrbWg5S+OXofaVfXkaPRiSZwBxpKeCeli7V7j5zIXdMy0UAle95WgWNu/sJJ
	0kvlXs/gzxpPLbi1sV5QnsTHB2SBpeVlFMXAKjL2UpgJdYNe4J6aVYqYMJfMJaBTusALw3jc8oDRG
	1tOxLEC+xMCCAGgRf/tf3xRTsZTxKY7bM6pNgjIyDKz3M0f0IrYXOYyiK4UwJIIH7plkQmHD3n6wT
	bz3QoHeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqwH-000Cs6-34;
	Fri, 05 Jan 2024 20:37:09 +0000
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqwE-000Crl-2R
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 20:37:08 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1D9FC5C01D5;
	Fri,  5 Jan 2024 15:37:02 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 15:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704487022; x=1704573422; bh=bk5Dr8X0YO
	CHd1Jl3i1ek4zNKLgAMly86kV1nZv04w8=; b=JusJDyBOqH5aYpg1JJ0cZU03Qy
	8utzg8I/uIquFPhD9KB0o2hhXJ5mmxxBDb9gHFjlixisHcH4rVx/EUrQw91nNcj8
	oCHfGyIxIupA+0nFVkUsqwWOAIUlX7yrVpD3Ktb2ssZ5C8W0aDBKEZi3vFT6fyzj
	XU+x71fF2SvAuj4/4gLBe/9qE7VBjlmZV7G+AkeddZ1o6CE7SgPQR+PShW74YZy4
	rn3gpx3PsUZo+G6x4BMQjjXqPcBFteFQ60Mh4EifYB5EGeCKqPah0o3R15gJo+WF
	vg2TMbCE3/0+mfhKaJ1nhqNAIjkDAYOJc15tpAypclyVI0Wvst8Pp9ytz6dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704487022; x=1704573422; bh=bk5Dr8X0YOCHd1Jl3i1ek4zNKLgA
	Mly86kV1nZv04w8=; b=lJrUv4548hvfuZxjAOK3VHoopmjb2+gPlkLQtF5nsc08
	7a6hlKbXyFVPjU/BCjteIWBtETcKIuvICwRo8Gd0sijrFjWeHC8JKTG5vbsnoBFj
	v45r7Y6JRaf4Z7gorSufAQoOM/2eiikCsY4SVQcsoz6ZNHdevc8dPGfIBOds31m+
	YxILU9dDYSoFGIU16D6/j/GR3XC32OW+rxHbGudtrejACXjRdnhnUE252YVXvgZi
	d20tPglqnUhAuZ/EgNNXPfqd7G4wAU0oIj2P7V5KIuOxKA/L13qB+uUCnO4LgED1
	kU2idQDsU3OiPGHmXItapmJb9JDwDTyI93b8NyBXmQ==
X-ME-Sender: <xms:bWiYZWTg-TuLeomyKvZ9-Qix5VfNfLMveQnsVvXiMow7raJ3ZG7dng>
    <xme:bWiYZbx-JOV4n-gVVdez4tTnMBG9C3RQXpL_ZXKBIYPIcBmTFmkMQlO1as-fwMXsw
    Vmisw1upnxFDtWhPLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeuhfejgeehhfefgfffhfdvjefhueetjeegffeuhfdvffelfffgtddvvefh
    ledugfenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bWiYZT02Fy93bfKlDbzpWYukqaPGeH7iprJ3XNrQSq9e-TxxR1CNWg>
    <xmx:bWiYZSBSvBIhTYTe5EudX4cIwDDdYxBs8Wj6UBZKih0lbpzOauDMGg>
    <xmx:bWiYZfh7u90_0y6VB_Nzp7hGU4eHiV6NmCwEzDu0CYqi5g2E2v6iZw>
    <xmx:bmiYZaUm8AaU5jWZQYc5gaDVbNKxGGCTA3RS8VJbThLplJ-7P50NRA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 840EAB6008D; Fri,  5 Jan 2024 15:37:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
MIME-Version: 1.0
Message-Id: <20508695-b9e6-4aaa-9c78-84891c1a8f9a@app.fastmail.com>
In-Reply-To: <ZZhli2FWXwP1XSRG@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
 <ZZhli2FWXwP1XSRG@kbusch-mbp>
Date: Fri, 05 Jan 2024 21:36:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Keith Busch" <kbusch@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Daniel Wagner" <dwagner@suse.de>,
 "Hannes Reinecke" <hare@suse.de>
Subject: Re: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_123707_184738_F1E1B332 
X-CRM114-Status: GOOD (  10.58  )
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

On Fri, Jan 5, 2024, at 21:24, Keith Busch wrote:
> On Wed, Jan 03, 2024 at 04:56:55PM +0100, Arnd Bergmann wrote:
>> @@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>>  		return;
>>  	}
>>  
>> -	strncpy(name, req->ns->device_path,
>> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
>> +	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
>>  }
>
> I like this one, however Daniel has a different fix for this already
> staged in nvme-6.8:
>
>  
> https://git.infradead.org/nvme.git/commitdiff/8f6c0eec5fad13785fd53a5b3b5f8b97b722a2a3

+       snprintf(name,
+                min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1),
+                "%s", req->ns->device_path);

Don't we still need the zero-padding here to avoid leaking
kernel data to userspace?

    Arnd

