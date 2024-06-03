Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0A7C25B78
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 23:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n//7JuWmmDlKjPyCXIvOJTAcm/2nWuy3jjUYwm4ygfc=; b=uRAy76D3pLfWrNh6RMBo+JQCu5
	a+32EobEVKVK8X5H8smzu2e4HkD/RoQ/z8HflPm1Wzk6eqicFYndsAQ/zp+s7DxMhjU3zk4WKIf0V
	TD+f9ODR1mnr1aDT7q3FNjFyxX9Ivd6X8Aqxu2Oe3D8fKdAMUlKssImAFSSigI5bIpzVSQSP6Ns47
	/nWrWoDUvbgmz6C2idSMQTIIpuW68uV8VRjFDM9Od4I6qR6yncmzUO0znzBttDzk+TMwcqfSsfqQC
	A4wFmYd6rTA9qmLqpWhTYQziKz0nID4s+jG5ucF7Q6OKVS0qtfBHKoHDZ1oed5yLSOr0K/JE5EPAk
	QQFmArFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGvb-00000000bUV-3TZM;
	Mon, 03 Jun 2024 23:17:23 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGvY-00000000bRn-0pXe
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 23:17:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8E506CE0F8B;
	Mon,  3 Jun 2024 23:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8343CC2BD10;
	Mon,  3 Jun 2024 23:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456636;
	bh=strIsf/DyhBWZNKni9ScJM6ldctiDED5cb9LBJmg2rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSJhGWBJLaY9KcfQ9iuEnwuPMv/LwKuHafTMeZo6PaOMYWzHXaVl5E1CJIjCnMz3G
	 WEpyqgPBMwW98J7loDFWhRbM/19rvHfGuU90ivoz4sbfSyfJTBkOVS2Eebg98nIIRb
	 ixUrTsUAxxYjTEhd9w8pErdvD2CSC+Q75FOlNolsgN99C9gpBLId/3LvOPNVmuq7Mf
	 n1KDLUXBatcGCMDuFxBLdFoc6BUwACtzbf27fO/awQJTwzsb/PH9nIYw4bRVDC3hLN
	 h+4/vi9CH2iUL//jfGbdYlpwWOFx7mymWCdpAU6KuvnuQKAJjKvVgx+49A9w82IpoK
	 A9/4XuJHrd9kA==
Date: Mon, 3 Jun 2024 17:17:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	mlombard@redhat.com, hare@suse.de, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH-RFC 1/5] nvme: apple: fix device reference counting
Message-ID: <Zl5O-nTU4NN-vTCs@kbusch-mbp.dhcp.thefacebook.com>
References: <20240603230524.3854115-1-kbusch@meta.com>
 <20240603230524.3854115-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603230524.3854115-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_161720_431597_584C48C4 
X-CRM114-Status: UNSURE (   9.76  )
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

On Mon, Jun 03, 2024 at 04:05:19PM -0700, Keith Busch wrote:
> +static int apple_nvme_probe(struct platform_device *pdev)
> +{
> +	struct apple_nvme *anv;
> +	int ret;
> +
> +	anv = apple_nvme_alloc(pdev);
> +	if (IS_ERR(anv))
> +		return PTR_ERR(anv);
> +
>  	anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
>  	if (IS_ERR(anv->ctrl.admin_q)) {
>  		ret = -ENOMEM;
> -		goto put_dev;
> +		goto out_uninit_ctrl;
>  	}

Replying to myself: need to add 'anv->ctrl.admin_q = NULL' before the
goto.

