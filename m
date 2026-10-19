Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD2606A31B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RzrqdxR+;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Tzc+wV7Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mmxD4Tum6zEy+TUT0Nw2BCCmCp2Q3UZSNxY4R/g864=; b=RzrqdxR+ycRoanUDueR9laTEXo
	SYnzFXXNjrGIxE4aPQ7zkcOFWgmzjoxOfjJPfkCBTgiSAFMfVPRZy+WEdC2YVwV32vNWS6VoIcMjO
	7fBBZqdE6NyDe4JFyVkcwR/FlbgGujwFWlCZqa0IJK4U/MXBIx1XuuHuO6f5XEatnCWAafxW6TLR+
	bzMUDcWrMwt9Xx3+A4txYotE8dwrBMbQJFL7tRolpTzYmLgqmYukt1aARKPGZp2DViiSVpiM/ug6m
	RWvIS6zYxQ4Clbj+sYtlqf2roNuYirwJUMiR1X+oQGHY/+u3/EnDAtA0R/zAxx4M0db1zUyGJjMtv
	W1m0mRzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIusQ-00000008NL4-0Omy;
	Mon, 19 Oct 2026 21:26:38 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIusN-00000008NKf-2N2P
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 21:26:37 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4956869750eso20738455e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792445193; x=1793049993; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mmxD4Tum6zEy+TUT0Nw2BCCmCp2Q3UZSNxY4R/g864=;
        b=Tzc+wV7ZW5jU3f3V0qsbyzciVbrjiP/GvB3DtfV+CwVZc3izU5LdBUu7yu3lKMGnvt
         YKlciQfm0BU8NVUdonJ/szLpQe6g7B2ZVpCaaOnga4NzVFgov/ehk3F0BETvU3nTZChi
         Uvjhu0K46voeyNuZd3stXeC4i5fYJRHbrfncEWGOr6X5m/mB9Qcp573n17ZfLa1lqjZ3
         Chqv2yawRKHMSGwz6mac8crFm2SheYoL2OHV0/9EGaGB+1k8dUpXmMEvjRHoiScmKb3l
         gAzJLxY9l/oTzVuwYaObrRG1Xigx4j2fZoBVb0eb8UsYTZe4tB8/7TjyCrtA+7/hGe/Q
         LLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445193; x=1793049993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mmxD4Tum6zEy+TUT0Nw2BCCmCp2Q3UZSNxY4R/g864=;
        b=kz5e9trPH5g24ftyWuyHnwyK0pRZpJg05JiXyxHz/hh1iNnzBZiCL7ri8mYsZka6Dt
         wevUBmLQzJYVdPvVL6XLOCjTyseisZpQqIANqh+rM1wgobYKxzE7mnr4FJuWfEtkZm4A
         iWIvr0X4MYzko+Gw65yZF1CXiCjPxkD0pTOXQ9fnCbB64D4Hns/sCyXN2kEOPmhIUdDY
         1AFhH4ILKSfNBGTbjwQm4TFbP3zaTVSY9eDtcaIkLJcmL0svHFzjgFT4fQ5UptUN2Dug
         MoblirE/74AXATZeZzfbYuqntCpoUozmXgCtdq+q1m05x1i8twGDqCuthdUNBIqYDQq3
         kHMA==
X-Forwarded-Encrypted: i=1; AKwUvBwXAie2n/wFHU+vvggnINge+UVfr4MQKFSDAryo1VHd7GZC9VLUpWYYhxu9jzSQ3lQJIQGP8iY5oMPw@lists.infradead.org
X-Gm-Message-State: AFq9FYJcBFQfrYQ/9WSoi+IywVk9rz6RjN0h2gKffzPy41JDUniNb+yp
	an4TljiiBUBvlXi+AdTaznH0dnRrsJYdJZs0tr/0sdA3NdQg8A1I0HYIOwnW1Q+MK1Q=
X-Gm-Gg: AYBFou0MeXWAuKZoU4SfCxtAh6ddoXHw4Bc7lh+pdPTzE3IHBSBKBMdsrRB1c1gThDh
	fqxQrsngAM4E2C85R7tuHfKLRVc+yVmhqrRsDKQprpCXFj+q2HXY+KuoI89Pzcgb703E6Idou64
	LxqK1bQs6m9Mv4Gsiq8F5KrkGvO7lGbU7QuC+NTzTykZuErgVX6FoHxbLKpuyCVe6UmrxYKQiPd
	PiWmlaNzb25WZNn0w3mPcZOo8A83+OP92s0FT8/ePU0J4QlQ5YTT359n2TcCJSR4u3JN5SCnTYo
	yzqcGrlE1ymmZQ8/ypctGFmfZc2GYVBLAee7OBUUwQ7IjuU2mkZLm6Fe79bZR1ib5cN/Ryzt2Qm
	GmzkgnitC/rT9IQtT63JFQojA3ZFu4QQKS72g2Sg1/KKkSJw7gHPCO6z2gByDgxJTToavtw+dMj
	TOZCgpIeBEyiVaO3hdIjFl7IynjG/9JdNsSegImp1id8vhUKWKF0l5wdbgkFP+gnbEQ+sDXQcQP
	NXUN5zfkluaR9TF1Jc=
X-Received: by 2002:a05:600c:4e03:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-4a1d75ffbdamr211563375e9.19.1792445193470;
        Mon, 19 Oct 2026 14:26:33 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1ce33155fsm216641335e9.4.2026.10.19.14.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:26:32 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:26:30 -0700
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
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 07/18] nvme: Introduce FENCING and FENCED controller
 states
Message-ID: <20261019212630.GN2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-8-mkhalfella@purestorage.com>
 <179242929827.3619480.8550407233438315193.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179242929827.3619480.8550407233438315193.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_142635_644090_DAAF19E9 
X-CRM114-Status: GOOD (  15.56  )
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-10-19 19:01:38 +0200, Daniel Wagner wrote:
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -542,6 +542,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
> >  	static const char *const state_name[] = {
> >  		[NVME_CTRL_NEW]		= "new",
> >  		[NVME_CTRL_LIVE]	= "live",
> > +		[NVME_CTRL_FENCING]	= "fencing",
> > +		[NVME_CTRL_FENCED]	= "fenced",
> >  		[NVME_CTRL_RESETTING]	= "resetting",
> >  		[NVME_CTRL_CONNECTING]	= "connecting",
> >  		[NVME_CTRL_DELETING]	= "deleting",
> 
> The ABI documentation needs to be updated.

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a2f5d0710db4..c47274fdd9a5 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -140,13 +140,13 @@ Description:
 		PCI transport only.

 What:		/sys/class/nvme/nvmeX/state
-Date:		November 2016
-KernelVersion:	4.11
+Date:		October 2026
+KernelVersion:	7.5
 Contact:	Sagi Grimberg <sagi@grimberg.me>
 Description:
 		Shows the current state of the controller. Possible values:
-		"new", "live", "resetting", "connecting", "deleting",
-		"deleting (no IO)", "dead".
+		"new", "live", "fencing", "fenced", "resetting", "connecting",
+		"deleting", "deleting (no IO)", "dead".

 What:		/sys/class/nvme/nvmeX/numa_node
 Date:		November 2018


How about a diff like the one above? Similar to CIRN and CIU, I am not
sure what to put in "KernelVersion".

What do you think?

> 
> -- 
> Daniel Wagner <wagi@kernel.org>

