Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C60E6916C
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgsL8dIKzjhg7/VmyLFwytuaDRSHDjTQwpmaygUxA14=; b=LtG43DlqmCPoOxZf+EQOjXgy0/
	oKhhddEn2kNMJt5IE7Cnf0fCGdCidoL+Rlq3u0FBfooFqaQfSSphY//CSeNtARSJSHb1gcERh8Wbx
	W8CrSYqKkg0BnanjXEwq9nupq4wihPKlraIrLRcfvwnAJNqVHZ41WM74TuE04JcpcUnTyEKWv05sK
	qD47ugwtJ3Yon2bbZlx/jjr4dPTFIAQBjYmkRKakEeT7qeA7iQBD/26MobJZ4SosSoDoQTz1YMvTv
	yRMAOJcbP1oCzWmox0FTFFcT1yycB73xr4YCoxgYoDQ372l0Ib/Q2IdLGgbxztDWA7lvgmaUAfNB4
	XozCushA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEW5D-00000002mOF-0uT2;
	Fri, 22 Nov 2024 16:00:35 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEW5A-00000002mNP-1pPW
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 16:00:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5AFF2A4130B;
	Fri, 22 Nov 2024 15:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93462C4CECE;
	Fri, 22 Nov 2024 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732291231;
	bh=Yk7wP9m+ZrilsJlN2GpdbtOcXhR73tQ4ue6IOTxm8rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DadUT9m4Nx0AB8aX3Z98qNpSZ8Ab96H88n48JItS/NighCaPtwRpzpP47lgYCtyDN
	 JIXdkYJvcVWrN2PE1m910ONBpaVQvOWIqzKhe95FlVinMywYHQ4x4O+66H1gYM5GyP
	 MS0NfJz0ITGe9S0xN8G1o0yDeZVvXa69KRb+BMWls+5aWdfjf8qGsJq7nXGWxpekRw
	 Xvab7l9tMpwKLHHPA9VfAIdrhwFDnITEo7370iI1RzwWtqkVb6w90SbkL0UdQo8QTp
	 1l9R0Qvj8pbjYfK4Fgz/vhJ00/1JgZr4QjWp4UltGbL7O7z+qbdtGTAqnDEkCsFlmt
	 fLVmSFaQa9B0w==
Date: Fri, 22 Nov 2024 09:00:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, axboe@fb.com,
	chaitanyak@nvidia.com, yi.zhang@redhat.com,
	shinichiro.kawasaki@wdc.com, mlombard@redhat.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Message-ID: <Z0CqnBhIpmf2snuY@kbusch-mbp.dhcp.thefacebook.com>
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
 <20241122120828.GB25707@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122120828.GB25707@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_080032_543970_8E7E9108 
X-CRM114-Status: GOOD (  18.92  )
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

On Fri, Nov 22, 2024 at 01:08:28PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 22, 2024 at 02:20:36PM +0530, Nilay Shroff wrote:
> > The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
> > for copying SG list with all zeros. As ZERO_PAGE would not
> > necessarily return the virtual-address of the zero page, we
> > need to first convert the page address to kernel virtual-
> > address and then use it as source address for copying the
> > data to SG list with all zeros.
> > 
> > Using return address of ZERO_PAGE(0) as source address for
> > copying data to SG list would fill the target buffer with
> > random value and causes the undesired side effect. This patch
> > implements the fix ensuring that we use virtual-address of the
> > zero page for copying all zeros to the SG list buffers.
> 
> I wonder if using ZERO_PAGE() is simply a little too smart for it's
> own sake and it should just use kzalloc like a bunch of other identify
> implementation..

Sure. That'll make it easier to report non-zero values if we decide to
implement a non-stubbed version of this identification later.

