Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01864CA0FE4
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Sep 2023 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WUJcLosxt8J3jS1e28+kAUx6eQPk1qGTm1RGM+WZ8A=; b=sPDX6k+hlkqCJkmSc6bAbErfja
	Ca+ZbPDA80i99W6wYJW3kV3cis1V4aRTs5daOOT8dX5bAFUFFdxmVp0IpGhgW18MDT/WzMWOED3aq
	LPcHENnTU5ztB6uqLSsFEIOv+yOoMV5xmGxVTiN0lOk/BQqRNVYymzMYWLib7s9ZVdE7cXL6aWwyT
	Ovvsg9dQibKq/bOOH6mlMdOrOoWVaO5qtuBEkN5lb887JT02LbGu6IyGDSroTHStwc2zqebwcw9GC
	sXzbz0irsze7OEPCcosRtx12uoZxNEzW/Y/yJjANjSDcD6iz+x2ZoEPKNXxEaCNWAn0bqvqINHYnm
	QT7SL/bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc5PU-00038A-1F;
	Fri, 01 Sep 2023 14:46:08 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc5PM-00037J-2l
	for linux-nvme@lists.infradead.org;
	Fri, 01 Sep 2023 14:46:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 7C6A0CE224C;
	Fri,  1 Sep 2023 14:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A259C433C7;
	Fri,  1 Sep 2023 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693579556;
	bh=fHjow/WvUbfNkCkvz2bMa0XT3GQibJuyW+vSz+Li4fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFbMIu5gdrCnPboulPiG7l8r7tCTP5eBWyhSQ83+gMW6pQJMWB/pdFVZDgLvgtvii
	 PSS+5EOaWAFSEgK2qMCURXqDAf0B8G0Ac+7UXXoBg0Su/XXWDtoLIT+LO7/S/qQiRS
	 IZA7U7upKJS6v3yUKp/AyYXgBX8Y6Agv8MR+BH+OASGNE2+mKivpMnonQ/wjYcGT33
	 FSIp5BtbJ4w6esUdhSYWYOCkUGF00q9FXfBoc/TFTbA0+X1ZwjF/UgKAvM5pG8WgwP
	 1yuNO5twePVxt1r+vVVBIbJg0kWGLyp5dZhbyqxAJVinz1SNI7k26Vpi8CMsNf5IKp
	 cTpyyPmUc5fqQ==
Date: Fri, 1 Sep 2023 10:45:50 -0400
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <ZPH5Hjsqntn7tBCh@kbusch-mbp>
References: <20230814070213.161033-1-joshi.k@samsung.com>
 <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
 <20230814070213.161033-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814070213.161033-2-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_074601_099315_552279E0 
X-CRM114-Status: GOOD (  15.09  )
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

On Mon, Aug 14, 2023 at 12:32:12PM +0530, Kanchan Joshi wrote:
> +static bool nvme_validate_passthru_meta(struct nvme_ctrl *ctrl,
> +					struct nvme_ns *ns,
> +					struct nvme_command *c,
> +					__u64 meta, __u32 meta_len)
> +{
> +	/*
> +	 * User may specify smaller meta-buffer with a larger data-buffer.
> +	 * Driver allocated meta buffer will also be small.
> +	 * Device can do larger dma into that, overwriting unrelated kernel
> +	 * memory.
> +	 */

What if the user doesn't specify metadata or length for a command that
uses it? The driver won't set MPTR in that case, causing the device to
access NULL.

And similiar to this problem, what if the metadata is extended rather
than separate, and the user's buffer is too short? That will lead to the
same type of problem you're trying to fix here?

My main concern, though, is forward and backward compatibility. Even
when metadata is enabled, there are IO commands that don't touch it, so
some tool that erroneously requested it will stop working. Or perhaps
some other future opcode will have some other metadata use that doesn't
match up exactly with how read/write/compare/append use it. As much as
I'd like to avoid bad user commands from crashing, these kinds of checks
can become problematic for maintenance. I realize we already do similiar
sanity checks in nvme_submit_io(), but that one is confined to only 3
opcodes where this interface you're changing is much more flexible.

