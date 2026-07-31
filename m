Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2632C54F54
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 08:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FiXGCSVgsJ6Co3SAik/xWEItMp+tC1Cn0LrgFxLjn9o=; b=WjMYs26udqFWpWhxy2LGubHFIm
	PmpW6EI8ufbjgdGYiuxCBQ7JuWQGU5Lphfc2djNTYJt+lXU4xUW1WzdFdDgCrpVLSFLaOD/y4VRvS
	JNTDispW512Juy+3k9TlS42cfC0v+pS8f4U7yijy1Dc46f+9zAIZDBO/ZhAc5qlj/pxbsTMrf8w6P
	wZskGi0NOLD8WdEFyObliqc5HkbhcV/yjBEiyUygcqLcg7krcR+GoM98RAMylVfJhYOkQfLyTHJ/t
	qb12CqLncwTg7XnDCdoROLXxBqyNXmYg28MxBGz4aPWc/4npLF+wA+blkRoUWcxUlqGPgDHZiAras
	13/Ivg9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpiO5-0000000C2Ck-1EE6;
	Fri, 31 Jul 2026 08:14:37 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpiO2-0000000C2BF-1qEd
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 08:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=RNoa/guj+h++8I
	kZvb2F6gHdY2uJXx8VET2Qj8a4VlQ=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=MCV7BlsXs2wYbuQtoetBVr0jY/uc7b4N1dm+v
	U9OzCUqaK3HUTEPTNps7sM9FMV5dRw8NZw9DrbcRCtDKbLewtzwK9Hs6WxkoH8PPGQVzSA
	OJD9sHVvgpFzG0IJWGVUBkR4fPuqVd3kV3b5ul5RBR3FACs2eEGRl3zmu+i0Nxf2ITgNPI
	IZT37vBoAoUY95CFZ6FGztp8C55o3do/PEILmoLqelRTplCSwXBMMSh1AcB2K1hMvLKPcL
	oE54JlP85ABuS0bYjS6NVV/iXVsicC9rIHj0YhS+s92eJ3ea/zTL8s5V3GOb6+CMPm3CpR
	eltPBh/llBuuFepP84CmXWggQ==
Received: from localhost (<unknown> [193.207.98.130])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 5010176f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jul 2026 10:14:28 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 10:14:26 +0200
Message-Id: <DKCLUFJYS7HH.2EBXAQNUPN5B2@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 3/4] nvme: add debugfs helpers for NVMe
 drivers
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <kbusch@kernel.org>, <hch@lst.de>,
 <hare@suse.de>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
 <gjoyce@linux.ibm.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260731073918.614014-1-nilay@linux.ibm.com>
 <20260731073918.614014-4-nilay@linux.ibm.com>
In-Reply-To: <20260731073918.614014-4-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_011435_118070_431B2617 
X-CRM114-Status: UNSURE (   7.99  )
X-CRM114-Notice: Please train this message.
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

On Fri Jul 31, 2026 at 9:39 AM CEST, Nilay Shroff wrote:
> +static int nvme_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	void *data =3D inode->i_private;
> +	struct nvme_debugfs_attr *attr =3D debugfs_get_aux(file);
> +	struct nvme_debugfs_ctx *ctx;
> +	struct seq_file *m;
> +	int ret;
> +
> +	if (attr->get && !attr->get(data))
> +		return -ENODEV;
> +
> +	ctx =3D kzalloc_obj(*ctx);
> +	if (WARN_ON_ONCE(!ctx)) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}

Just a nit, I don't think that raising a warning just because
kzalloc() returned NULL is a good idea as failures can naturally
occur under OOM conditions and aren't bugs.

Maurizio

