Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA5FC3ABD8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9TylDuM/CQHNE4/jOF9aBjXtyqhoHPSzN0YAAME7b2w=; b=vaY9kpD+muywNw1l9X88WhuJkq
	PAGl2xITSMWZt696jIxlKpF5TWi4AxPfieUg05nDQ8/bujSpd5A3rDcLp46nFoRqpW5EMhDV+kzlS
	HDVA9/cVrFtX4G16aUwou15MlB64o1w9X/uHW00HXuUkmUN1+/JcggRgBs8lxm3IB1CWTYAnVNET0
	9oegnsb5jBe70cJZzP3Oy9m2s1yaY8GX+HTHitO/tu9f49pxdUjoEwd86/W0NffFuyUiyxpL5HuTY
	fib8+ArHFqMUCX1LwnqDXKe7uwJEL9u/fcwhgibgD87tfWpYTXALcfMxaem8Acq8aOEAV1cT4CInw
	ayHlR2iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFuJG-00000003OrD-0jLD;
	Fri, 16 May 2025 12:37:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFuG4-00000003OGK-1WLE
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 12:33:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1472844AD7;
	Fri, 16 May 2025 12:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD26C4CEE4;
	Fri, 16 May 2025 12:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747398827;
	bh=fLFagoLPBAizDnyH1nvrPR3FbGOY7O6I3zPHD/jkOsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKHoDjdiZRepm824vMQxVh7A2nY/FidLGLdY5lIUkXXKvMZDnzsg+dxod4vmb2qm/
	 uT266e930qjh4415A356VvZidaTXdtQOFAUWPQeJiUAyFF/xme90mQ0EtV/voqilFP
	 bVWEDnXeL3A33XbSJwbe6SiahPqbRGKiQAMYcTMKjeRlRR2YS0f9/Q18I2+KbzczyN
	 ADB6HIG72TpUSNVWFFtbm74ogtgRf2mIdsvXu8ET04d9Ph6tisQO6WDpjSOcZvnd3Z
	 xj9RtDMLjC+07e5dACEoxCuT921C41QYCT5i1ClMj2ZCcGKLiB2EEf9O8Qt7Uhr4Oo
	 9t8eXXhtbtuYQ==
Date: Fri, 16 May 2025 06:33:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Avinash M N <Avinash.M.N@sandisk.com>
Cc: Jeffrey Lien <Jeff.Lien@sandisk.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe CLI Invalid PRP Entry Status Failures
Message-ID: <aCcwqhakl4JhrI2o@kbusch-mbp>
References: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <aCX3offAfe1k0_KE@kbusch-mbp>
 <LV3PR16MB606775F391112B2DADF64463B590A@LV3PR16MB6067.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR16MB606775F391112B2DADF64463B590A@LV3PR16MB6067.namprd16.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_053348_418833_F86F8C3C 
X-CRM114-Status: UNSURE (   7.65  )
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

On Fri, May 16, 2025 at 12:16:36PM +0000, Avinash M N wrote:
> Hi Keith,
> 
> There are 2 issues with the same command.
> 
> 
>   1.  $ sudo nvme admin-passthru /dev/nvme0 --opcode=0xD2 --cdw10=0x12600 --cdw12=0x00010132 -l 0x4F000 -r -b
> passthru: Invalid argument

Usually that means you're transferring something too large. What is your
device's MDTS value?

