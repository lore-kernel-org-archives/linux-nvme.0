Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D68C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 12:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wn96sL16xMTjEGY+KDMGbaKdAgdCeHEBQjOm3fWFWdA=; b=lnNUnUE5dIgDqktw6oxw040dBD
	ZZDEBDz1O038JiEOQem3HRaobPgmwvogYbpc85Xx2SWmezWmPUzRvAPwQkBMH2YAGKqxE//VZCEko
	sHIEjKdTgDd7RTByvMy6nbAfyjQjYY8DyvAPD9fAxp27W5LBExt4O3SZt4owlLEx4YVbiZPtVhpA3
	x6aQ44AlNSgq0Qh0f0VT0BaCN4Jx0VDxJkLwqKzlj3jLtKDBRdk6UYYeDhGFq3mEcRkOMaewjZWRK
	1s/9HaFoDPnGO4/xCGebVFj1lrTwZLc2sgwJgAvBEh0rrOaa6J1Hav0VLsu2BuICHKrvmFYzLt7GX
	aUPE7k3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOGXF-00000003Lis-1No3;
	Mon, 01 Jul 2024 12:53:33 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOGXC-00000003LiF-2TIi
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 12:53:32 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2c86869685aso579379a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jul 2024 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719838409; x=1720443209; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn96sL16xMTjEGY+KDMGbaKdAgdCeHEBQjOm3fWFWdA=;
        b=0uAfliINDPV2PDklpWRx1Uf85ML425769KHYr6d/J2IantnA3e8dgtFjGBFOvkE+gK
         ZinuTxRRspmqeBsolX9D2YQtOi2kqIc5FjBzADpPKwUzkoxPxYifBXh75ASHd6gkoWRs
         XIAeLuywqE5Dcnona5Mn2vsNWAvIw0//qSIev2AN3YsGUWlaa1BS4FBPHTnltrv70605
         ywxgsX4Sq4dbQW8Tu4X7O4nXtwUDPnlSIpIe3XnmbH1BzXYACxpyOhVmCJJ/tbg26g5W
         YKyW+HCdhfc78agnVQhULTbzpN+ULdFvrxRpoVbKzdSSUJ347ApEcd/VAYa4vhUsk3mJ
         08Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838409; x=1720443209;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn96sL16xMTjEGY+KDMGbaKdAgdCeHEBQjOm3fWFWdA=;
        b=AXZlWeXp+H/TTV1r5DJ8rBl1buP/HHK9XokCzEYVfiRPIuQBOvumNTYRALjGVstXZh
         KdsC1RORHj6lv1LbwX3DNhjOTohP7lOIHi8mc0l0KaKucV8dL1A+3zkD1EJS4jzTNKrQ
         eXHzg4SWzkDWZ3Ex9VFvWgMDol/YN5dTcjfiE8XO608qmsb5Tkrl1+827Ih210q8rX+t
         1ud6iOvOlaEk2P2cwEHO7jb2lYUq1TRmPOki8NJICsiXQmAW7boEVzf5/J44q35hIRZ8
         yEbcWlFwBtPSIRZEdrZXwqYRHbt7b9GGXGqlzU0U+JvYdXEwmaZOuhoKNNPPAlrcUTio
         dEzA==
X-Forwarded-Encrypted: i=1; AJvYcCWUJbbEpViWLCJwxjAH0UCMVHtTTDtel69p3sX6/8+CRjvNxUXPrvVkHaGiEQpLR6eQMyGOaHMC58tWEBTdUNYT/7giZcjTUwf+h+DN38A=
X-Gm-Message-State: AOJu0Yx4PP9oF3GjsPT4uusZiKFiXzSyZybljhAsaIxAYW4ZlH6gB7j6
	rEuKoHi+9fwEskDXGAcr9ZjbtoBJhtX1wZ8TgijGcuPD2WlXkW1aAgzYWdGQrYoUeR4MJSyeqhN
	0m7E=
X-Google-Smtp-Source: AGHT+IF/M2rq2rCBfYzi9F3zCZdGntRWmhfn9lWdC/EOhqP+6hOiG2RJprL5YE6Wf8HY38GAC8yAQw==
X-Received: by 2002:a17:90b:151:b0:2c7:dfb6:dbe9 with SMTP id 98e67ed59e1d1-2c93d7a0329mr5630186a91.4.1719838409371;
        Mon, 01 Jul 2024 05:53:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce1a292sm6648820a91.7.2024.07.01.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:53:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
References: <20240701051800.1245240-1-hch@lst.de>
Subject: Re: io_opt fixups
Message-Id: <171983840808.13284.3309840121093222072.b4-ty@kernel.dk>
Date: Mon, 01 Jul 2024 06:53:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_055330_663815_41F6F452 
X-CRM114-Status: GOOD (  11.77  )
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


On Mon, 01 Jul 2024 07:17:49 +0200, Christoph Hellwig wrote:
> I recently noticed that on my test VMs with the Qemu NVMe emulations I
> see a zero max_setors_kb limit in sysfs.  It turns out Qemu advertises
> a one-LBA optimal write size, which is a bit silly.
> 
> This series handles this odd case properly both in the block layer and
> the nvme driver as a sort of defense in depth.
> 
> [...]

Applied, thanks!

[1/3] block: remove a duplicate io_min check in blk_validate_limits
      commit: f62e8edc0a9fda84fe5bf32d5f5874b489d6c301
[2/3] block: don't reduce max_sectors based on io_opt
      commit: 37105615f73125cb0466c09796f277a4c46d9295
[3/3] nvme: don't set io_opt if NOWS is zero
      commit: f3bf25d5135539603f24e377c6dec3016fbd9786

Best regards,
-- 
Jens Axboe




