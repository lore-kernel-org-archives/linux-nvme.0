Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743C606B04D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xVFwx8iN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzxLvodv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DaBQOBmOn2LdFzR8qRXliWsUS06vZ4v869U44kfu038=; b=xVFwx8iN92XHfkHYXfzCugyQ7a
	lalr3LoliBuYeeUR2QCxf2WwGRgqMGm7vA2LnijaGcMEE/vI8XkyvhU2mU7Uf0GSfwjFuyyypuMH3
	U0z6jBgLap6Th9RgFBQF26UEmWO0KJ4I3cPCQWpUZAKCFOPr9RmnTAYR8QLiBelGSU0ZbN2cgy1hv
	zquM4gLFnPXRArXwkdm4XWfhxo9IAoN8TedRnJWC1zIT9pEl2NOCKtJ02Ne3kHlzQZFM917Oz5u8S
	7LZwuJWvOyTSMkOSbxeJrYTbsFuaeRW7CRhyAojetZlXJcaQIuGYidEoT5i85lHaqFKQPp5duiUxT
	zMfpDWGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3as-0000000ASYP-0M3O;
	Thu, 05 Nov 2026 19:57:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3ag-0000000ASSV-0ExN
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 19:57:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8160A600E4;
	Thu,  5 Nov 2026 19:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA32F1F008A3;
	Thu,  5 Nov 2026 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908661;
	bh=DaBQOBmOn2LdFzR8qRXliWsUS06vZ4v869U44kfu038=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jzxLvodvND2uIskc/k7mrbmX7om02LDQuTN4sSWT7U4a81zt4R49PJEN298tzv1+5
	 X1R6p0Ufs2Bn4u3FpPBRCD0eADffYNw3RhMutVANraXKdCTiyvo+LKEnBElWl9dNlz
	 pJMra7ovxSrqyeiHNlyFM+R4pERiF5I/o+Y4fHPExxDIsX7eXoC0cNueIqBIykdvaA
	 DTXB7bk5AsDHZUcWmUynQ2xbkZsJ9/wfwFzcbQo08UfiRvV/DdBLKBDeBzv9KPsuUz
	 bkWqUGkTOjsU8UrGbudJVBCTbKN6HQh4nmpsB0DWR7f7Tnz7+viD4lQ9qKWQGjBTvx
	 OM+zL00zEkejQ==
Date: Thu, 5 Nov 2026 12:57:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?5buW54WK?= <liaoxuan@open-hieco.net>
Cc: axboe <axboe@kernel.dk>, hch <hch@lst.de>, sagi <sagi@grimberg.me>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	default avatarZheng Tan <tanzheng@kylinos.cn>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVEM=?= =?utf-8?Q?H?= 1/3] nvme: Add
 adaptive PCIe link rate switching function
Message-ID: <auzfs1qAOkXm8i2W@kbusch-mbp>
References: <cover.1790134954.git.liaoxuan@open-hieco.net>
 <85a11a4085d04a2823c04059702630cf34abf6d4.1790134954.git.liaoxuan@open-hieco.net>
 <auoxH197kQfUJGaE@kbusch-mbp>
 <34801e0a-5d66-47c4-9844-7844363072fe.liaoxuan@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34801e0a-5d66-47c4-9844-7844363072fe.liaoxuan@open-hieco.net>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 01:50:21PM +0800, 廖煊 wrote:
> However, L1 is entered only when the link is completely idle (no
> pending transactions). During active but low-utilization I/O, the link
> cannot enter L1 and typically stays trained at its maximum rate. This
> patch targets exactly that window: it dynamically downgrades the link
> rate to the minimum sufficient for the current traffic, and upgrades
> back to maximum when load rises.

ASPM operates on microsecond idle periods, so a lightly used link spends
most of its time detected as idle. Your threshold only selects the lower
rate below roughly 1.5MB/s on a Gen4 x4 link, which is essentially idle
where L1 would kick in more readily. Do you have shareable numbers that
show a real power benefit beyond ASPM?

> So the two mechanisms cover different link conditions and are
> complementary rather than conflicting: ASPM L1 handles the idle link,
> while this patch handles the active-but-underutilized link.

I don't think this kind of policy belongs in the kernel, much less in
the nvme driver. There are mechanisms for user space to control this,
though: the bwctrl cooling device lets user space set the link speed,
and diskstats provide utilization. A user space daemon can implement
this without kernel changes.

If you don't want to tie this to the PCIe thermal subsystem, maybe the
current_link_speed attribute could add a writeable callback instead?

