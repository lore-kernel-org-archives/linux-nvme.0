Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5071606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c/hxoL3q;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=G8Y+FNyX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4G41v3Y2fe+OJB6BEq+d1RMvmEUNwaoblh0UBYdzIJA=; b=c/hxoL3qPScU3AloGaIEEzbkwX
	eMnzUFe5BRMkq79mwtjy6m3i6I6qaBtpyPcBsl6Dg95OFLccIoVBOAe4hqBD8NVbwIZHLGnGMEVv2
	LnE5IJRZPSTArl28s26WwtSVG2q29+cdAPySTHz246EJIBaqAV7xDTiy95FKn8C2Sk6gKmjqF97hw
	zdfVfKjjoo7jAZYAnKTwirB/Up2Hqi9gs9bQBmSTf6yDtiv0cnJeeC0gVlNeHaS+dGDv0P+K4y2uq
	r5z4AIHHqYtAVCEwDuMbADVSRj27G9BomXUWpaEBl4AfXMTHtv1jpddUxH5WAyH3qHUhEb7Qp20NW
	ZgEWae8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsrv-0000000CWuM-1ejq;
	Fri, 30 Oct 2026 20:06:31 +0000
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMsrs-0000000CWu1-0nhs
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 20:06:30 +0000
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-35c76e9614aso1658237eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793390786; x=1793995586; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4G41v3Y2fe+OJB6BEq+d1RMvmEUNwaoblh0UBYdzIJA=;
        b=G8Y+FNyX0b4p41Ww4cU5c01TWsMT3sMyBC7u6Sm6PgphIEgELSA06IJAWXnZMCkadu
         zG27/3pgXJ9U2f6iM1AmFmLPrb2bF0Ixc9m9rN38ha1hMBg3vlmrX7JPDAJJxHkb5wUJ
         2/TOLMZ6NkwKP2hAPYupUodqfa9BQkz47D85381L/204ftS1wvUk+xgSutpSQtJ1UuDJ
         ozrW6Wh38eMuBox/gP8Q4Yv/jReF45l+sk+DVjzSS6OwSOSjNtl9t1rOyfKD+OPSEKfx
         JTvGa8VQT2mb+bi10UE1GQ9KW6ttFRpd6klcN7kXB06j3kU7qhOY1Ox674xYtjEMtRzb
         PzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390786; x=1793995586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4G41v3Y2fe+OJB6BEq+d1RMvmEUNwaoblh0UBYdzIJA=;
        b=swYnTuKM5b9FTKWLiCsiijUJuxXxOaZXodhDvuZ/KjcrOMgKGimWM+VpnCl2Cg4K7u
         UxrhrKftFgQe/lUqERfGRaFDHHkKDHPf1eeeX+m0ZjCeks4rQaey5Fb/QuQJ7GLa5LEN
         gANB9pCwcYG5YQv2ScgkBlCYx1B24AoqoCPq1/4pDxRoPMkLGYVuO6DgwN+ru82RdTjA
         oknUp9Hs6YhtNPtqcQGyvHyqOuonPo25CrBnC7/6w93IJH/kTD3v8xIxbVh963iY2PIb
         EsfWqKU13B1NiI17+XTlNJm7YLdiJrMsWd7t5rsv/3KoeI7YcZOwdssLNYlGBl3du7iJ
         aMjg==
X-Forwarded-Encrypted: i=1; AKwUvBxRn5YvcvkbIeZL1nKXlp9MaajZyDCPPg+1NsxB++7vyvwFelfYI9zCNj1rdlMavsI/fGv7fG7/uaU2@lists.infradead.org
X-Gm-Message-State: AFq9FYL4gBcYdXDfy+wxabDOUmEDG8UJnP9qbgyqS0KUt1sqFd4yMFhn
	HEIdKO5TgweKcewpVVBp373e11kM+IgJ34gvE9ROzCy8Ta2EgEuyeVG5dPxeoQCbDld+9hB54Wo
	y/GM+
X-Gm-Gg: AYBFou1d1aRPceiEHX96TYiu2BrdIq3s+xGRMWpIt123VmVFofl2Q3dluk3WvfuYcic
	+zbc6GBg6/DGzxvWDVd8+bCT6d8qJT98rcE1BBBOz3woDnz66sZoRljGqPI0P1TlU6dQ7LhS21v
	f76LNM+miAFNwuATYPShG3l4+uR7ZMlcc88oMAWFTRjH7LE+1AvHHzpDQWiMmLun9WSaJGherQd
	qFO5F1GWgL6MSXs/eNPLmy04rPmVdYR8gvOr5dj3s0lECJ0Ji7k6UE9WT8IJnV9PONNtkC9uLZC
	7HqhEvITNgAivpxit0R3xxA3fvxt4cpD9ZTzZoCWQJofBaderlJqtSiwmkPs9J1oOH7ciZFBmAk
	OcGfPji5kgmHqeR7XPzww3Hads1O8jvYgpEoe6gxcDHjoYrnFR51u1Xt0gwKqiQjD3/ccGqUYgk
	jXXcRZ+y/dmRS9oiBoMw8Pul+8qSizTisdJoPxAhEmM66zhWMvGfpk5IGDHGcl642X/PQMhkpAk
	P7sKFGoVRL75LWTR4PHb8iLTTY5ZXBF+uKzQZgaRIVGvGQXSIsHK3wfwB8dBT7s0AcTlunuy3+j
	i17OvCxMfhsIquHPC1DmulD9kUXQGbHXhvXioDJkVHy1A+Pm2w==
X-Received: by 2002:a05:693c:2802:b0:36a:1008:5815 with SMTP id 5a478bee46e88-36a4220407bmr4672312eec.5.1793390786182;
        Fri, 30 Oct 2026 13:06:26 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm10272118eec.24.2026.10.30.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:05:58 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:05:50 -0700
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
Subject: Re: [PATCH v6 17/18] nvme: Add support for CQT to nvme host
Message-ID: <20261030200550.GF122209-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-18-mkhalfella@purestorage.com>
 <4459053b-35eb-4359-99a6-05393a9a62d6@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4459053b-35eb-4359-99a6-05393a9a62d6@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_130628_578257_BCE3ED02 
X-CRM114-Status: GOOD (  18.31  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 14:46:03 +0200, Daniel Wagner wrote:
> On Sun, Sep 20, 2026 at 11:28:15AM -0700, Mohamed Khalfella wrote:
> > TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> > Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> > limit for attempting Cross-Controller Recovery. Add ctrl->cqt, read its
> > value from controller identify response, expose it via sysfs, and have
> > nvme_fence_timeout_ms() account for it.
> > 
> > Use CQT to drive time-based recovery in fc, rdma, and tcp transports.
> > Add a fenced_work delayed work to each transport controller. If CCR
> > fails, fencing_work switches to error recovery immediately if CQT is not
> > supported. Otherwise it schedules fenced_work after the remaining fence
> > timeout, which also switches to error recovery when scheduled.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Reviewed-by: Hannes Reinecke <hare@kernel.org>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> the sysfs entry needs to be documented, with this

--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -120,6 +120,16 @@ Description:
                Shows the Keep Alive Timeout value in milliseconds for
                this controller.

+What:          /sys/class/nvme/nvmeX/cqt
+Date:          October 2026
+KernelVersion: 7.5
+Contact:       Mohamed Khalfella <mkhalfella@purestorage.com>
+Description:
+               Shows CQT (Command Quiesce Time) in milliseconds as reported
+               by the Identify Controller data structure. CQT is the time the
+               controller needs to quiesce outstanding commands once the
+               host loses communication with it.
+
 What:          /sys/class/nvme/nvmeX/cmb
 Date:          October 2016
 KernelVersion: 4.9

Added the diff above to the patch.

> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>

