Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08C5C27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V7vaEVpmG2RwsTzAKQW5R1zRk1h3qTFZY8+hhd0hSUA=; b=l93QVOFVlACN7Z2/Atvt8KYdRK
	QZhprvnTJ7UgUjqNrtmUQ9/wYphnABjWuIYcppMMwKUSt0IR1YJar7Okjg54UB/gTx/xBd9eygLFP
	L7WZvPrrv41ro5REt98NnPu0It1UxQLPL28NKX6xNwCsvhxwwO1AQALC/PBgU3x1FR4tO/9lRru3m
	w5RfBo+1kM7I3lLCzrMU3DSTqq058lKBbSaWYaI4wnr+DkOJb+XN6m4iKJrQVgSQhZOy/Om9rpKIH
	ZSYOwgvm+lmalsuYfjsA/R3MWBK2jJca+M8JFLh1xKddsQmZKBftrOVZloqjDySd7TU8Pz/ZkGAqp
	JSv2qILg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9iP-00000003Oc2-0Ivz;
	Fri, 14 Jun 2024 16:23:49 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9iM-00000003OZ7-0GiD
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 16:23:47 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2c2db1fc31fso403230a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Jun 2024 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718382225; x=1718987025; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7vaEVpmG2RwsTzAKQW5R1zRk1h3qTFZY8+hhd0hSUA=;
        b=EA6JxY+OLUcaRAL5dsX9HQGKK4Jb7lTjfdg+Y4GP6TflNTYNF03yYksgx1Z9ioJRcP
         gxG9Fvpp0j6ebSXLfQ3KXoQTcHDcpWH2Hdox4elsxOWzmJPcrCcC0x75ulgkbg8fQFdY
         Ds50ggrjqPi8Diy9+/4gw+QteXLSJA7nrE0o+sT8jzDo15rIzHjKLRS9dDGLeKiwTMK0
         wG9SWZ+AucnV9lBSBJVcyL3fgz5MUQNiqN50+SK7/HFVQmnVgW97hv+S4zhQokJul7nJ
         Z6FwYFRPjfhU0hr3KctaSCYz0jYQN/bZmGdMhgyWjrhl0C8/+6A+vjbarjz697Q7hC2q
         Z7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382225; x=1718987025;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7vaEVpmG2RwsTzAKQW5R1zRk1h3qTFZY8+hhd0hSUA=;
        b=HPEYVQDTfCWGLLuokfnlmCdtso64xqRupYkQwbSXiXjLDSLyK/1Fij5/wQaNU1AcIU
         v1odOTzzBPEq2WwBskKUzhozgJumxavstc2gz3EFAKnSkwxjf6R8dGzI0ljjD6SoxZlQ
         Kt1wAf7D3nsdYEcoMmYV1lpEsfHIt2agAZ5ExQPxAg0qwycEVsM0chjB4/PcHK5pG/DV
         q5kUfUvVmrbjCWqWvn8YwBq3C9Eby+jW57d4NiNyhVSQVz4OlULO4KTj4yXuM5AMVDLZ
         bLp+CX5OB8Q3nZf/JzTtVByUcxPfc3Le3ljuPdsAABVlcI4yPJBH26Ol3q02P35pcGBI
         mHQw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8Cena7ZWvn0AMtDQjJbgBdp0XhOgtB17ern/dLy4KO8EP3UVTGkkPRt5M7JSJ/vxHynpATf9nKZ+uf1GSKdkbq8fY37xqomRNopo8qg=
X-Gm-Message-State: AOJu0YxCIdxqpRcUQfygPdkm5HlyaVpN8AW9VYn5l9WzC2nVJhWSB4M+
	+6gHhqEPaDCM1Wcs7UK5q63daM3GyZNVaxZOmXKDUNYmgl0yM1YBLaljEOPbnxY=
X-Google-Smtp-Source: AGHT+IFalaQCW4lC0HwsXT+MgtNdWkETqGGO3S2q0czZ2zVCeyt7k6ERpmMLcUdUuPUoSdg8KrcJIw==
X-Received: by 2002:a17:90a:de14:b0:2c2:f042:d96d with SMTP id 98e67ed59e1d1-2c4dc02b83fmr3292751a91.4.1718382224613;
        Fri, 14 Jun 2024 09:23:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c46701absm4112038a91.40.2024.06.14.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:23:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, 
 Yu Kuai <yukuai3@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
In-Reply-To: <20240613084839.1044015-1-hch@lst.de>
References: <20240613084839.1044015-1-hch@lst.de>
Subject: Re: move integrity settings to queue_limits v3
Message-Id: <171838222277.240089.6158080107617222931.b4-ty@kernel.dk>
Date: Fri, 14 Jun 2024 10:23:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_092346_144250_C24437DF 
X-CRM114-Status: GOOD (  10.99  )
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


On Thu, 13 Jun 2024 10:48:10 +0200, Christoph Hellwig wrote:
> this series converts the blk-integrity settings to sit in the queue
> limits and be updated through the atomic queue limits API.
> 
> I've mostly tested this with nvme, scsi is only covered by simple
> scsi_debug based tests.
> 
> For MD I found an pre-existing error handling bug when combining PI
> capable devices with not PI capable devices.  The fix was posted here
> (and is included in the git branch below):
> 
> [...]

Applied, thanks!

[01/12] block: initialize integrity buffer to zero before writing it to media
        commit: 899ee2c3829c5ac14bfc7d3c4a5846c0b709b78f
[02/12] md/raid0: don't free conf on raid0_run failure
        commit: d11854ed05635e4a73fa61a988ffdd0978c9e202
[03/12] md/raid1: don't free conf on raid0_run failure
        commit: 799af947ed132956d6de6d77a5bc053817ccb06b
[04/12] dm-integrity: use the nop integrity profile
        commit: 63e649594ab19cc3122a2d0fc2c94b19932f0b19
[05/12] block: remove the blk_integrity_profile structure
        commit: e9f5f44ad3725335d9c559c3c22cd3726152a7b1
[06/12] block: remove the blk_flush_integrity call in blk_integrity_unregister
        commit: e8bc14d116aeac8f0f133ec8d249acf4e0658da7
[07/12] block: factor out flag_{store,show} helper for integrity
        commit: 1366251a794b149a132ef8423c8946b6e565a923
[08/12] block: use kstrtoul in flag_store
        commit: 1d59857ed2ec4d506e346859713c4325b5053da3
[09/12] block: don't require stable pages for non-PI metadata
        commit: 43c5dbe98a3953e07f4fbf89aa137b9207d52378
[10/12] block: bypass the STABLE_WRITES flag for protection information
        commit: 3c3e85ddffae93eba1a257eb6939bf5dc1e93b9e
[11/12] block: invert the BLK_INTEGRITY_{GENERATE,VERIFY} flags
        commit: 9f4aa46f2a7401025d8561495cf8740f773310fc
[12/12] block: move integrity information into queue_limits
        commit: c6e56cf6b2e79a463af21286ba951714ed20828c

Best regards,
-- 
Jens Axboe




