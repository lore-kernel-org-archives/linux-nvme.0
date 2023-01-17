Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8487EC63797
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Wfs4+0XvosXTKN+9ZseRbUtaNjCayrD+DsQV2o+gak=; b=iMnYYYx0P4oWoIWC93SrmXoGWw
	EcW4Qnw5zHoJ+hcOBJf9UIKE0aLv3uQmu8ae/SWJmwtNPZhYMkl5lubeo9R4GSwLEVmCqLp/voxvN
	inZenBTF1y7qLaBQi+tG4caxGHrQLD3yKl64KnraaFdaGU1QYcynQHSdoxfasKqcaD5p7drwsVS89
	Bw2VII9fJ29edF1qcSjgvbAH+Wly4B7B59ZJw50c53EMMRtK+vivuEhzKeCZVkanTttbR1CUVwzvu
	4r5eZOMjwh2lUsQHq4PHGVb4K39YolH5cqgaMKvjJVHtKWesJjaAuKZwkCGntEgee81WxrGA0aZ3d
	GdsGE3Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHkom-00E9EK-20; Tue, 17 Jan 2023 12:11:56 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHkoj-00E9Cq-DU
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 12:11:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8819D6865C;
	Tue, 17 Jan 2023 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1673957506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Wfs4+0XvosXTKN+9ZseRbUtaNjCayrD+DsQV2o+gak=;
	b=cyfvTxQEwcBoMCtN7LeSNrKNgon7GCZ6K3Xzhi5P+QK7JeRuZedgNoHc4ukgVWtuZLIPdP
	9wD+XxHbHzpewE7POiuKcvVq1e2lpDG4NNYbEWhofyZ6liIiZbCIcLtbXbZ4EBRbdo8Qnb
	OlNnDmAh3d6EVhOO2sXHEzyHKYCQllY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3896F13357;
	Tue, 17 Jan 2023 12:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xns0DIKQxmMJWQAAMHmgww
	(envelope-from <mwilck@suse.com>); Tue, 17 Jan 2023 12:11:46 +0000
Message-ID: <59599137a9556355cb43563a4fbcc05b0fe769b4.camel@suse.com>
Subject: Re: regression on aarch64? panic on boot
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Jan 2023 13:11:45 +0100
In-Reply-To: <20230117063735.GA14468@lst.de>
References: <Y8XINx8fpGPKudW6@cormorant.local>
	 <20230117055819.GB13795@lst.de> <Y8ZA30EoAFaFPwVC@cormorant.local>
	 <20230117063735.GA14468@lst.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_041153_636313_1CB5D85D 
X-CRM114-Status: GOOD (  12.85  )
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

On Tue, 2023-01-17 at 07:37 +0100, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > Good morning Christoph,
> >=20
> > Yep, the above works.
>=20
> Context for the newly added: This is dropping the newly added
> PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> other boot tests) to fail.=A0 Any idea what could be going wrong there
> probably in userspace?

If this is an aarch64 userspace issue, maybe related to
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D107678 ?

That bug causes segfaults of user space programs if for some reason the
unwind code is invoked. It happens only if libgcc_s.so is compiled with
gcc 13, and the pauth CPU feature is enabled in qemu.

Martin



