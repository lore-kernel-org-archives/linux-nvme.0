Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AC0D0EE19
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CkUuKL47esnuYB4rzdSD0YMfBXPI4yPI1K9UgwAZ30=; b=Fr1GIawPItM+RGP4DSwO5C40wE
	Tnmq+Y6xigrR2pXrpauUIeJhM7QKSdRgoQCUhduW1MtzbVfx+enVrBrg1jlYt9W/c3e2Q4gkpTTyA
	s0xSOT0HAy6Q2l/zu+cYtu6gcUTcLVJ3+coFz1QIAD1jm5eM/VB4WL5P7R/gqPdvaAgNdKROkOBr8
	q8r6zzzJeOuWz4KK8Ek62tU/A/yE3keqHFwFGX0J9AkaL4tdDzS3dk0/AwpLXsXuTuyuR4K7a96Ta
	fwIYkhWdxwuLIWDrVMqQg/j6i0zYQMPDmGSB6N6+a3f2PK/x99kq3ZXhMnMpdgLtJoccxzsZTWZqR
	uWwFENrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szJVS-0000000H7gm-2FRA;
	Fri, 11 Oct 2024 17:32:50 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szJVP-0000000H7er-0tsT
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 17:32:48 +0000
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CCC913803B0;
	Fri, 11 Oct 2024 13:32:46 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 13:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728667966;
	 x=1728754366; bh=9CkUuKL47esnuYB4rzdSD0YMfBXPI4yPI1K9UgwAZ30=; b=
	kZO5GIOsjG1Uu6g8+Uq4Nu5sa7ZPNxCvkvjubYn5JWNwUFqAakgGuYdFCnMAxIbE
	JqZLx2zdAF+IZf8vbjA6Rf6cUXgiOrauRtLhArMFqavd0oKa2UeU1gswjYh2LFs1
	WyQAyjt5ZzljKUY/Bfam0EVHSj/dmMY0g19Zyga12/D4eoPE8vD6Uf9F3RVK9fxf
	nEzt0b45GwyNgkAmMqm/5TYrpwXAiri4h7THc0/m8T/xgcbNafdXNow4z09nh+12
	htPRq/JNvMmxF42hM+rq5GSaBJsCcwJ34i1/wbVyOowwIt7BiSOYkFGOsLVd6Okp
	ZUie/Hoc2a8bw2QkYT3n7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728667966; x=
	1728754366; bh=9CkUuKL47esnuYB4rzdSD0YMfBXPI4yPI1K9UgwAZ30=; b=A
	tDMQtdog4MuyDXvTP1C6h7F9+FJbbTm9aGsabGM9HovXFhjKjOwOBYz4q2h7IZZF
	KyJcwG5PW2qUi93W7hj0/lPgH5a088bj2eH3OeXw7Cvw8xmE9kwdf5Qc/G4vrP16
	JQllC5kzPzloqVrvkKkniPCmTyJYkdcqbRMeN5hH6xbBjgnkXKCNyatPTT8p56ud
	S/5GfH1THOy8oAjjibST2LO0RT7lFpuBVnxs1NCXUT7n/OWnsnAbeyeZl5TYZsJT
	3sdbfgypJoz8azLtF8yAhqKZW6uxQHVBmfcL6qqwCrsIGZpQYGzBfCMMY0z463GY
	teRsrK+nDyseoImg2nGRw==
X-ME-Sender: <xms:PWEJZ3C1MGuOZgLU6Z-ANXLuCxiLC0J2ruSWE56pdJ6nFj4mHzCnvQ>
    <xme:PWEJZ9j89RFnFQT5Qa1N9lmKIy0LIMCRJyOkDNK7QZdcHtrdO0bd6ldHDxIvP6riR
    Dp1xIsWAhqFgLaUOHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepofgrthhirghsuceujhpprhhlihhnghcuoehmsegsjhhorhhlihhngh
    drmhgvqeenucggtffrrghtthgvrhhnpeekkeevfefggeduueejleelkeduveeigfeljeff
    udejleduteelffeuffekhfetleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmsegsjhhorhhlihhnghdrmhgvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrnhhghihughhuihesvgduie
    dqthgvtghhrdgtohhmpdhrtghpthhtoheptggrshhsvghlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehksg
    hushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgthheslhhsthdrug
    gvpdhrtghpthhtohepmhgrrhhtihhnrdhpvghtvghrshgvnhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqsg
    hlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PWEJZykQZwWMORQ63au5LvuRQ9ToY6Ybxq7SH0nfbjZu_XroPa1XoQ>
    <xmx:PWEJZ5wjFp7n-e4NxlEIIHeFqrp2b4TguTDlEjWRHIvEo7BtAskwbg>
    <xmx:PWEJZ8QVf4tfOnbjs3-yul9cfQoRfga3A2n0Or37ax0icBPyNs2RkA>
    <xmx:PWEJZ8b4QBzHKx2eWirZ6EsQ4TrccIQnOe57zf4uUSM55wGv3B45mQ>
    <xmx:PmEJZxKhplYi0vd_WYDCm5t7_dAGADrEKF-3ml9u_oIJ-HXsAIuZ4jgE>
Feedback-ID: if4314918:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 23E6C1F00073; Fri, 11 Oct 2024 13:32:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 20:32:23 +0300
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
To: "Christoph Hellwig" <hch@lst.de>
Cc: kbusch@kernel.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
 martin.petersen@oracle.com, hare@suse.de,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Message-Id: <455d17f6-ec55-4bce-b9d3-9f43eb4a056a@app.fastmail.com>
In-Reply-To: <20241011081452.GA3337@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me>
 <20241010123951.1226105-2-m@bjorling.me> <20241011081452.GA3337@lst.de>
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_103247_370809_6F3C7173 
X-CRM114-Status: GOOD (  11.16  )
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

On Fri, Oct 11, 2024, at 11:14, Christoph Hellwig wrote:
> On Thu, Oct 10, 2024 at 02:39:49PM +0200, Matias Bj=C3=B8rling wrote:
>> From: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
>>=20
>> The NVMe 2.0 specification adds an independent identify namespace
>> data structure that contains generic attributes that apply to all
>> namespace types. Some attributes carry over from the NVM command set
>> identify namespace data structure, and others are new.
>>=20
>> Currently, the data structure only considered when CRIMS is enabled or
>> when the namespace type is key-value.
>>=20
>> However, the independent namespace data structure
>> is mandatory for devices that implement features from the 2.0+
>> specification. Therefore, we can check this data structure first. If
>> unavailable, retrieve the generic attributes from the NVM command set
>> identify namespace data structure.
>
> FYI, I still disagree with this for the same reason as before.
> Assuming we're not really going to see hard drivers I'd be fine
> with using it by default for 2.0 (or better even 2.1) by default.

Sounds good. When I am back after next week, I'll update the patch set w=
ith the version check and add the missing logic for hdd support.=20

(Apologies for double e-mail. My phone client formatted the mail in html=
)

