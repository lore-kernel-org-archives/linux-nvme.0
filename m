Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E5606A324
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WrUXHaDc;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=adjCRo5h;
	dkim=pass (2048-bit key, unprotected) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=yJkPze1h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Xlm8NpSPznzsgyr9iP8jz53kjzD1q/IyvY7zHu8Ridw=; b=WrUXHaDcrkTeVVZz8rsFy7l8dp
	SWsWY4bFLoL+0WsNYinA43wpLfeTJY4aysYpwSsF3OOLtX2KmJkySHF4Wy03qJpKv3zO6rAUtqRYR
	Iddp188TcnIUC+RZh+NxMwHPGCdFtMEBEugVfYQWOAZqVdsdqUCE8jRkyD/4jnLjIkcVBX0hVjslC
	ip6yg+J1hWEy+gXOiTvn15je1uJ3OQQx1o8LdXpRgGgXj6gRogLvOVTDCK4akMQF3+QXCGW3M398T
	pDudFjYbTpbCZEq7zCkzTj1cLu4iC4owElKXwrQXA8P7MiWs0KKPoPc8tLJBNNwiK2kSJOVam0Y0g
	zniJHkxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNo5k-0000000FxAl-21tA;
	Mon, 02 Nov 2026 09:12:36 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNo5h-0000000FxA4-1ajO
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 09:12:35 +0000
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1793610747; bh=Xlm8NpSPznzsgyr9iP8jz53
	kjzD1q/IyvY7zHu8Ridw=; b=adjCRo5hEz7Sb0z6zQ53/JbivdcFl1Wuwbl3sW+uzrA6Iw8Q95
	NJGpbTBguzWW0KDLGZDwH7W9wdngKVRDg8AQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1793610747; bh=Xlm8NpSPznzsgyr9iP8jz53
	kjzD1q/IyvY7zHu8Ridw=; b=yJkPze1hfEL2u7oKMyyeCHNlb3onVxAKBz4QeET4+KlFtsfp9R
	4QxXg0vs3g9SatSOn5zi40cc4dsQVcUiKSZ72ZOigVi7OBf2UUnMhhamCIZ4VKflJISb/wXyuaI
	bVjPMgj1ggmkWQmB1WE1olCOcsKJvt+AsjjN8oLXPoGot/PFOgSOvJHppdfZiGS9kzkSgpGD3FO
	wvOhqRRtSNXLqb8ExwRJG8H/2/Z1hpYsWnzWLorD4WKE0BJ727qBPxsCqDlisedJDbhpyxHr/i2
	8Z8O6Ut9o0+S60tv/uHOB/sFbXoVJOFahGiDpD/o2JwCb+wcUtDxaaDUgehvk0YnBCQ==;
Date: Mon, 2 Nov 2026 10:12:26 +0100
From: Daniel Wagner <wagi@monom.org>
To: linux-nvme@lists.infradead.org
Subject: [ANNOUNCE] nvme-cli v3.2
Message-ID: <8cef0cb5-e147-4d45-a86d-557bb31947c6@monom.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_011233_671558_A2E9C273 
X-CRM114-Status: GOOD (  10.26  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

The v3.0 release was about getting the libnvme API sorted out, while
v3.2 focused on cleaning up and refactoring nvme-cli itself.

The command-line parsing and NVMe commands are now fully(*) tested and
fuzzed. This has resulted in a massive bug-fixing effort.

On the NVMe-oF side, discoverd and keysd are bringing NVMe-oF management
into this century. There are certainly still some rough edges to smooth
out, but the fundamentals should be solid.

Cheers,
Daniel

(*) the vendor plugins are not yet fully tested. Either these get fixed
or the get removed:

https://github.com/linux-nvme/nvme-cli/blob/master/CONTRIBUTING.md#what-is-expected-of-a-vendor-plugin-maintainer

Highlights:

- nvme-discoverd by default. The NVMe-oF discovery daemon is now built
  and installed by default, and it replaces the legacy udev/systemd
  autoconnect. Discovery controllers stay connected (--persistent=auto)
  and get a keep-alive timeout, so the host reacts to discovery AENs.
  Discovery over mDNS (TP8009) is optional.

- FreeBSD support. nvme-cli and libnvme build and run on FreeBSD for
  PCIe devices.

- Stricter, more consistent command line. The command line is parsed
  without getopt, so every C library behaves the same. Numbers are
  parsed strictly, and global options mean the same for every command.
  Usage errors are short and name the bad option. Some old spellings are
  no longer accepted; see Incompatible changes in NEWS.md.

- Register commands reworked. show-regs, get-reg, set-reg and the
  property commands use the register names of the specification, have
  one JSON format, and handle fabrics controllers correctly.

- Security hardening.

  - A root command injection in the WDC and SanDisk plugins is fixed.
  
  - Vendor plugins no longer run external tar/zip/dmesg; they use
    libarchive instead.
    
  - Many decoders that read past their buffers on malformed device data
    are fixed; fuzzing found them.
    

- Technology previews, disabled by default. These may change, or be
  removed again.

  - Privilege separation and a decoder sandbox. Under sudo, nvme-cli
    drops root and sends its device commands through a small root
    helper. The decoders of device data run in a sandboxed child
    process.
    
  - nvme-keysd. It loads NVMe/TCP TLS keys from encrypted systemd
    credentials into the kernel keyring.
    

- Monitoring. nvme top -o json writes the I/O statistics and the error
  and failover counters as one JSON document. A new MCP server,
  scripts/mcp/nvme-mcp, builds on that output to watch multipath I/O.

See https://github.com/linux-nvme/nvme-cli/blob/master/NEWS.md for the
full list of changes, including the incompatible ones.

