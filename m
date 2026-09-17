Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B914C982C1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 06:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpYOpcv/DfS/Pb4Hs6wOC5rsHRD7H9hoSeQow9V/WII=; b=BrJjfQ1hWUwJ5hqt/m0ncYflyt
	h9UboXydfAoTs0LtU7qOjRNzzNNycVRygbz8r1oi0ZLUT2SyyNODLAmv4OHbdF/mczFapf3c7HjX9
	V5yko04S/rzukZbpmOwbldk9B6wjTQ5EacJVYxw8oU5l3Tx6EGgnLzgakLNwX1HiUqHXv+b/h5W5i
	2z6sE/+g0pTJMvJ/Z6cayM8s8Jzpzyp1hRPM0TAkAiBl9XqQ7I7yuzn3+a0vyWwMhmzMGpPAc+Vwq
	fMwf4kuQUpt0z8Yqb+pYX8tW4SejJ5Bot336Lz3Q8RDJNx5f0UCR91BYparxpwP5HsW3mf8StFgDq
	8mtJ70rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x75AE-0000000Add5-0VMs;
	Thu, 17 Sep 2026 06:00:06 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x75AA-0000000Adcf-3tmq
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 06:00:04 +0000
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id E5B96EC0174;
	Thu, 17 Sep 2026 02:00:00 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 17 Sep 2026 02:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789624800;
	 x=1789711200; bh=hpYOpcv/DfS/Pb4Hs6wOC5rsHRD7H9hoSeQow9V/WII=; b=
	HXWR4qpy1hhU0ysj+5+skgxT+PHWnzdNM/AliO/+nC1j1rqi+ouVYtkwi3GJuQVn
	psrfPgMnGp3/d9/5yLK3sJq/iLcd1Y7ADopubVGNMxi9kuHmDOx7zb24YuTrs25S
	QrzmYojcgci1rPSGcEyYtwgNf1QvIijJ96dXUA/lA6d/0dKHPWrzB5CWd21CK+H9
	RRZEpgw9TD+g4Y5sjDoI2fWE0C6zkJUsNvY2NHIbrfc3goNJNTOk26jnrO8e4uNC
	Mf37O3hjC4z6vKbSPZhzMjrAef6afDMhk2WydNEEoYQqV0qAWWx6/sgVy1hnVOEv
	o9VecjX2Iv4nImkxwixxpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789624800; x=
	1789711200; bh=hpYOpcv/DfS/Pb4Hs6wOC5rsHRD7H9hoSeQow9V/WII=; b=e
	Z4T4XrAJc7P6lECDiyn55gaUXcoCZsUBZvdXxzyhe1i0r8mxtKJWixmLzGwlo2pt
	4I/aGH3INzs5teF4B3Ebg5UbinLT0Gnn7krVK91kO7RRJPCG1reMgqrNzLk60xUw
	KAe/J7RcC7a3mceQPAzjSPtlHgzIw7+2Rsb6UbGUfm31QwtkMbJDMct1xwqRdRa8
	RGIsy/csrPVOzRMYM9wCwZVewKC3vtV/f7RIWASvi5r4umpKBtMAgcFZrfCaDfxu
	h+cqL4159Ok+KAVRDcq7WAqWZGaEC1VpMUjKorXMoonszbwBqwVPWRqwOAWp0dSL
	ZunJ7gSsoX06tghWJ6wZg==
X-ME-Sender: <xms:2oGragngLdmYEg1Wx2vzfHlz1V9tZs9ERYv642M8HYjLle2FaRtvkQ>
    <xme:2oGraqpNq-HbpcXnFmQa9KIA0sSEOrEfNyapI459rXa6WArnXbcJFTGMbjJhowYvT
    TUcoXB-QEQ9itdJfkZn4UVxXkrVhUOnhYJrp18JPQWrFNEoSb-0SN2G6g>
X-ME-Proxy-Cause: dmFkZTFpVz0820YlZmLNkO+O0IGQnLOxVxkCbLx01MDLZkNaa0IdAtdZ0T/xMbjA/ru7ry
    wUcpkRNCigJIN67W79Hh0J4UA9oZLRs8QbBKE8RGGDrjEF/MqQhtRS4MPKynowQUUrCeMN
    HCo9Z4focITIriBC/AvzkWZhni4fOTdKhS8VewXYGIH+LPi9qfe4u3ahTBDqyyOj91I+qC
    xBlMezsyqRVso5Wyww0vt7+vUmApVtSx6bNXtBlvipTnqu8p56A5h11RqbJvxTjXN+GUWE
    ZfrAvbEHk1m26BuTBbcD+WqPiXsRrz2FpIIvqMYnvgBPAm3TG7viJ+sJpvweH/+83eOCGN
    DixyRWARpYcescPWHsfrEwWsDwvKWAyUCYukZvFSZXXAvIa5tIuQ+Tgn+HT5Dl5lbBV1h/
    LfQnggZvM8iimbztFxrdo6EdhpVHutYUMtv+Dp1kazq07ClBlDqVT44wkpioGBZSIerXQC
    UPLu3CNJhoSHmm8aRtSppmXKEhwzc5sQvz3XaAJXtz/RRUeyOAl6Tv8ZpcoB+e9DdmM3hc
    ssO/8CpYUM62EvehjGxAGHbQJ0MV+p1VgMv0QmXMVQHzwVvACOJip3bF6FjelTcqFm+zlG
    Q42DQ+oqGZfAPkktGVHelkr1Gjt2/bN7YAg+6XF3DSUqxHgiF+WE9ol8NOzQ
X-ME-Proxy: <xmx:3IGraojWkQpJDQMSTlsjCy7qJ0j19Ak4oVki3WW5ul7yPNEWUbbI9w>
    <xmx:3IGranYGoY7eo4GWBYvosOLCv9BouKG3ulWuBxrVU5W6wZqduL31ag>
    <xmx:3IGrasXlFSxABuMGAEor5vBH9FXzq7NpWofWyxenOjkMCD2BdXByew>
    <xmx:3IGranFyy37vwM2hoVaLyqdlH3mvwangY3J2KSqkZuWbYI-kFwOUxg>
    <xmx:4IGrarcl4KOTz0qHWus9qY3bW7NXeaIGilHNAVlwVo06Y3_simKRl69g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7804E32A0084; Thu, 17 Sep 2026 01:59:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AfnFG7kA3Ny-
Date: Thu, 17 Sep 2026 07:59:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Maurizio Lombardi" <mlombard@redhat.com>
Cc: "Hannes Reinecke" <hare@kernel.org>,
 "John Garry" <john.g.garry@oracle.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <ab39783f-73f5-4dab-9668-431460596b84@app.fastmail.com>
In-Reply-To: <1b36e312-222b-4052-8a8c-0583c908ea19@linux.ibm.com>
References: <20260916114533.237863-1-arnd@kernel.org>
 <1b36e312-222b-4052-8a8c-0583c908ea19@linux.ibm.com>
Subject: Re: [PATCH] nvme: work around -Wformat-security warning
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_230003_053693_249CF246 
X-CRM114-Status: GOOD (  14.38  )
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

On Thu, Sep 17, 2026, at 06:14, Nilay Shroff wrote:
> On 9/16/26 5:14 PM, Arnd Bergmann wrote:
>
> The changes look good. However, I applied the patch and built
> drivers/nvme/ with -Wformat-security, and I still see a couple of
> additional warnings:
>
> $ make M=3Ddrivers/nvme/ KCFLAGS=3D"-Wformat-security"
> make[1]: Entering directory=20
> '/home/nilay/Development/linux-x86/drivers/nvme'
> [...]
> host/sysfs.c: In function =E2=80=98cntrltype_show=E2=80=99:
> host/sysfs.c:682:9: error: format not a string literal and no format=20
> arguments [-Werror=3Dformat-security]
>    682 |         return sysfs_emit(buf, type[ctrl->cntrltype]);
>        |         ^~~~~~
> host/sysfs.c: In function =E2=80=98dctype_show=E2=80=99:
> host/sysfs.c:699:9: error: format not a string literal and no format=20
> arguments [-Werror=3Dformat-security]
>    699 |         return sysfs_emit(buf, type[ctrl->dctype]);
>        |         ^~~~~~
>
> I think that if we're fixing -Wformat-security warnings in the NVMe
> driver, it would be useful to address above warnings as part of this
> patch as well.

Good point, I forgot to check for the patches I already had fixed
in my randconfig branch and only addressed the new one here. I'll
send a separate patch to fix the two instance above.

        Arnd

