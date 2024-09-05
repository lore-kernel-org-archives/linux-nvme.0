Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDE2CE7AA1
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2024 22:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Ol9s08BMyod1imyUaFYnG0naL/4NEYz49Sti39u3ac=; b=Elwdp65A5SnS1JKE07kt68Yolt
	HSl0I2NlYPpqaqaR8JJduQqsPMHX/ApN4id8gFOwhmeG+1m2Nvm7bEy9h47LbU3PLmyMCvT35csth
	IC+Nfi/mmzb3XBTSKnmnxla7Uv6Rt8Iw7+yMx4xujfiS5lRCdUlwIg0Mdu4JiIPHaVNAq299thyss
	jRllIL8EoOlGAqgC2RzKh8rKXvNM5qoIc7EB8CcH8xDnXKR7XvdQcwyw72lApoJm2EjicbO8ZH8xu
	XaqrCeWDuyuhcbnE+IvlzCRbbqXa7Q+q53aiKc0jrApdj2grvTIy2qFUJ8B5IdOj9L41zz4gIAvI8
	DRtyCPAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smKjb-00000009zTa-1rJd;
	Thu, 05 Sep 2024 22:13:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smKjY-00000009zSr-2pV3
	for linux-nvme@lists.infradead.org;
	Thu, 05 Sep 2024 22:13:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A25645C0065;
	Thu,  5 Sep 2024 22:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E278FC4CEC3;
	Thu,  5 Sep 2024 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574422;
	bh=wlGcOqVw1zlmE3nrLDDnTcljzhPleYJaO2RahZ5tAVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTHOBgwvX/OW7+eOlFseiwvNfCCwaJqB1OrsCRO4crdB+0Ne1bqu390hqvoC7tBAa
	 Y4jcqGAzlI4DQgYH5iHLXp5q03dzn09b+CHDbQyinpyt9b5YRs4Ro9oHX5KfhUWiW2
	 kIDM0n3atyJcz6vtUNA/+Gtypw512xcna0hs2+drno6fLa0KSiw8UgSQBxRKayyHbS
	 tEqMB6cPSDwNLm8RL5G7OjZ92u8fuhqKSYDWQrCO5wF9sgnFQIvlPaSwarLH4VPmXn
	 gW8BGTxhOmvRUoJpeNV2829IxT5oIf2oCF3685OYuKzhVfQhiTs35jDCKkRVTomjoN
	 219Ie8k9PTsOA==
Date: Thu, 5 Sep 2024 15:13:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <20240905221340.GA2732347@thelio-3990X>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_151344_874318_7E795CF3 
X-CRM114-Status: GOOD (  16.38  )
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

Hi Stuart,

On Thu, Aug 22, 2024 at 03:28:04PM -0500, Stuart Hayes wrote:
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

I am noticing several QEMU machines hang while shutting down after this
change as commit 8064952c6504 ("driver core: shut down devices
asynchronously") in -next. An easy test case due to the size of the
configuration:

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- mrproper virtconfig Image.gz

  $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/arm64-rootfs.cpio.zst | zstd -d >rootfs.cpio

  $ timeout --foreground 3m \
    qemu-system-aarch64 \
      -display none \
      -nodefaults \
      -cpu max,pauth-impdef=true \
      -machine virt,gic-version=max,virtualization=true \
      -append 'console=ttyAMA0 earlycon' \
      -kernel arch/arm64/boot/Image.gz \
      -initrd rootfs.cpio \
      -m 512m \
      -serial mon:stdio
  [    0.000000] Linux version 6.11.0-rc4-00022-g8064952c6504 (nathan@thelio-3990X) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT Thu Sep  5 15:02:42 MST 2024
  ...
  The system is going down NOW!
  Sent SIGTERM to all processes
  Sent SIGKILL to all processes
  Requesting system poweroff
  qemu-system-aarch64: terminating on signal 15 from pid 2753792 (timeout)

At the parent commit, there are the following two prints after
"Requesting system poweroff" then the machine properly shuts down:

  [    3.411387] kvm: exiting hardware virtualization
  [    3.411741] reboot: Power down

If there is any other information I can provide or patches that I can
test, I am more than happy to do so.

Cheers,
Nathan

