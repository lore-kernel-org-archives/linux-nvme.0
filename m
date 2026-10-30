Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791D606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i/v6Qs6Y;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=HhnBkSYc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CXEDrLue/vvnR5MTELNqL3qGmcwOB3zKOMD71X0/Ofw=; b=i/v6Qs6Y6chtUlmoj4kSM6C7yr
	A9Le0W+TPC4vLCQ9HpSL2TeRUY6N2wxQUQN/zbQejU6jHIAspG20NljXOr8iFPmgXt4eVywBxX3nz
	CRGT1x1PpCKyaJ9RgOotAj2B1m5n9taJOnsTD7euLWAc6QYE8aDQ6XMmKzrwHhuU3h2jgD7Syb59s
	LmMz2DfbWTwBuXarKjXHQXktLqsmQlKDKptSdlyA8Ucw2A6UoHHIV4C7gAjNGuvsOxl3yDu1opAyf
	g81KSxULUorhVQwZFySmSZdQmZzMvW9uOtPUsclPiyTbzbkyMCV6AvUlatTOvLm0M/xwYkIfSFaO9
	RYeX7nYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsWQ-0000000CVTM-304j;
	Fri, 30 Oct 2026 19:44:18 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsWP-0000000CVSf-0EYn
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 19:44:18 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-35829219da8so2589103eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793389456; x=1793994256; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXEDrLue/vvnR5MTELNqL3qGmcwOB3zKOMD71X0/Ofw=;
        b=HhnBkSYcp9FBStNxQJzov8d/X/jLBr/mFw7O1S7s9dnyb/dIB8qj4+MLKckKApu9U+
         H2At9+5kzhETgqg3f7m3GE5JL/Zl46dFEUemxl1K1/zQtA/kCwF2y/ajm6pKyeE98z1M
         VmDa9IutgP4E/nVmOkhfWlTgMVNq0nSnuosEIY6RpCDFZcSdjxkR+zEN/tGlpd+UxdhY
         +ylWXIsLwoo2eNimEJ8hBq96T3wdBlMyDMFTu9JuhTat9bQZ8cTEeq2CjzH57XUImw+t
         WnZCOk2OdcDxheSBAwU+weptWoflGKSZoe8ocwbsnqtutvcWkjL65VmMm3sUccwo0GYX
         kS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389456; x=1793994256;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXEDrLue/vvnR5MTELNqL3qGmcwOB3zKOMD71X0/Ofw=;
        b=e9yEIEy1NVylQ4oVXtO7r8RIxVkw7Bl5q/vUekMQuQaGl/pEpealh/iqfQWqmOAHr9
         pYQOWcCkWlIXSb54iJgRXdgz752t7j+ycRXwxHKPr7ayaDV6IZXkJW8tOkMG2FX0rCH3
         1qagTz//UI2CEzWt1H3kCRFlseMhReldUXhFnayZF56jJXJpeoDj+5TfPY6oZxx1JMoK
         mb+jF4KCx049Z5LuHCtDEDypleGCBjtFS9VTMP7NbNxJ2x8D6PeM5/5mEeSe8V0pfc7K
         5UeoFzGrEzZGGIQs1I3Z6vx+yTGYcjF9bsNCRUHTaCQ/CLDm0OzMXSTJAmfBBJmAII9P
         TaVw==
X-Forwarded-Encrypted: i=1; AKwUvBwQS0CFcf/8j/Fr8FQt5cezEyJrUePI+4FGYQzNp4CPG2cXe7ti9fvTdj+cu8ZahkQFXMjOKhhySXtN@lists.infradead.org
X-Gm-Message-State: AFq9FYJ32wVjRmKTVnwN1XrPBn/xTURughWhlRDgZTzFXFTp1VBnz3Hc
	XNW/lZs3RgD+L8F/EKsLA8r38zpwYsDie03dKNkh+14OL9F/NCeQhbVrqNK+kLXcYZ0=
X-Gm-Gg: AYBFou1FKXTXyCCwLpTlqpJGFM+YxCOHtyEggV2ACrGxcoDecf6eLrv7XXh9IG89Y4s
	nfU0IgqV1kvbW1ookUIWHVdd+6/kVmlALzjjM9ZBPrNCsuE3GagZjJ2hv4kby6N0hSzHrqhFJLE
	RcHM3JdPxr1VSFkgb1CT2RGhQWIXLx2h8NYg8ebdBxWIIAxg/kcOElR66/zMWL4wqgL4atVst7V
	d+A6kLCMDT/nfl4s2XvYQ683L3tNN784rom4Al2ewnnTruA+vUGN9+i4qJ1MN91HPQ+Qz7T7LNL
	gHplUq2CX9ydBqnmDBqnfqM3qvoL/AV1ONEa3NAymODVDs/WLuO7FA7qpflMIkip0l5WsQzGDJs
	pRRLVK8MwX4KAffR/BuWnbVEKZixr19nU+2fGf5VU2WG0R+d5bUS1zLXHb7swpUN5Y1xM6B0cb5
	6LSTDQmq2ZTyBdsMaYLcLaQwt/wYt3aOIP0m3gdICe7pxbbny5ljv8x+AXDPHbM/w9ozNSJ03As
	HiadcCyXDDSLEPst+fhMHloZLlvk/SZqsUlPARMKx++ClEL8xMYN8vX7pnQYogS03NPvmgO7hy8
	mOMsVkWUC1N33ogrTd1uoD2bC+aJu2lhKeOIi3LQ07LYQ7t7FA==
X-Received: by 2002:a05:7022:b053:10b0:19d:233:989d with SMTP id a92af1059eb24-1ac5b02894bmr4460084c88.14.1793389455423;
        Fri, 30 Oct 2026 12:44:15 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1ac1a9e2ed3sm8558684c88.19.2026.10.30.12.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:44:14 -0700 (PDT)
Date: Fri, 30 Oct 2026 12:44:10 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/18] nvme-fc: Hold inflight requests while in
 FENCING state
Message-ID: <20261030194410.GE122209-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-16-mkhalfella@purestorage.com>
 <d9563967-9ddb-4cd7-9149-d1f37522e1fa@flourine.local>
 <20261021212357.GZ2931-mkhalfella@purestorage.com>
 <45d52d19-dbfc-49b9-a445-a8fb9e69abef@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d52d19-dbfc-49b9-a445-a8fb9e69abef@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_124417_092127_0114CB49 
X-CRM114-Status: GOOD (  13.68  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri 2026-10-30 11:29:12 +0100, Daniel Wagner wrote:
> On Wed, Oct 21, 2026 at 02:23:57PM -0700, Mohamed Khalfella wrote:
> > Adding new FCPOP_STATE_HELD will result in a more invasive change and it
> > will result in nvme-fc no using nvme_cancel_tagset(). My intent with
> > this change is to bring nvme-fc closer to other transport and only
> > cancel inflight requests. synchronize_rcu() is a simpler in this case.
> 
> I am totally against introducing yet another synchronization method. Fix
> it properly.

Okay, I will give it a shot.

