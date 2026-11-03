Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9B606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ED/2BCP1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ut/7O8Gh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=; b=ED/2BCP1QTsBbl
	vl0UTq794AGEWVyOj2o7RbGkewGVWkTt8NpBPi6Tcqe02N+o/59aW8lHuGe+z/UhqKrEOnLO9poGS
	5EwHOjR9jiHcMsKP+nuyvCeqkCGVnygF7HwXoUot/K8qzKuetDMavVS1CkqXVuVlTmLCh1j3VugGG
	MdrFNzRES4jgViwHoqfvDh7x/VCMEQb8iTL3Y8UvcfR/rTVDwCIkH5IKawh+r+K+v2kYGoOrNsg6p
	nchvfroIcaS0cH/UoUIWxnNpKW4GE8Ls+bmwBMZcgIA4l715FeBE4rLuEn/u6b7d3zPHhZV47z1/i
	JHf0nP5cGwz6J6QA8wOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAKb-00000001et2-2ofx;
	Tue, 03 Nov 2026 08:57:25 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAKX-00000001esO-1Jh5
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 08:57:22 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1a2761c69fbso6576513c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793696240; x=1794301040; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=;
        b=Ut/7O8GhDCPGhgNXBO2dt/dA34lREQjw2+7FukNfsXXmTiNH8ZroCDjATV0r7keT2d
         3W/Vm5d/CKeV+gfTE8oMkMbtTk7CmWg2wY/261FSsqlrNBYDa8gVZrrVPPV0VemT5Ln9
         JR/g3JYL5/kF9MwgMXlvebdJZtj6ZANMIv/+KDdonXZCBphTlBDyLk1CyV+eQP3A/rR+
         VqRAuiV0vlRZKXwco+AnMpUAfDq7kHyWSsCeHYra8c6bcDIkxhbhbPA9iQ48m0+wuoVd
         MkWYVlz3WWrCqBG7x56Jqg1VpNIMYmLi3iRzvWoJ+9pY+D+akwEO1cxA2PMaaQ6GdTvl
         yTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696240; x=1794301040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Er/6bqz2N7+83QaIQ6D94RNvY6ZoeYk2XRlSx4xqVLM=;
        b=mhDs77YYq+oxL/pIBk7hyIwclujeU1r1VewoVANuHSXSvM+2vIX7b3HRBqN2HB5djD
         wh18pjjXhXFDD1xXSrw+nyp7s4X2I3OlzeBHrDL3zdS5fK3eFziQGMD+MrQJpKMgCWq0
         uy4/ZXz8r6qaG45Yv77aekO1Zmz53xd6yLkvN4ZcFdka2fzI2+ZVNjBzFMpMZfah2ek+
         tQe/zEcO+5K3FxkmvlGJDvCJ5hBEtp6PTAcXhNjNLApQuG+fbz9e3csRXALskV5mffoA
         qF8qjtOMRgdRn5yJxQS5g8orxonTY4de0Ue8M552iU1ulWlyx+JMfUwjLDpF89quxpBo
         ayeQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1BexWWBS9a/ADcoEendfTeugN1NOF6UnZx8LXw7LB6pVcv9gCNImYIz+S1zj/GfCj+nK6i/+utGlO@lists.infradead.org
X-Gm-Message-State: APuU4Z/Rq0qTsFwn5xayPrcvkNK+oD0dSV/Tu8brSaoTyNdAHQAXKYVX
	2DQIuocGlYTExmUgk5X1D27VphV1+Fd+I5SQoh+K7pZwqw2jIBBl/jIU+OzqjGE6qvM=
X-Gm-Gg: AYBFou296xfONXxYG3A9YsXh2etYLcxMEMDUmlqxUwtotHWaljgt4NdSmZIxal2Ul23
	M+iCnso+mkJf6VYT0P4K0NkLo+tev/5Q6FNFb7M79GzMfpNJGh0A38R19jLqPbI0KJAj7xhD4Bz
	zD0qsNu3a73nWn2i2HXkmsfGCo3NpjrQz92XlnzM3t6QpGSiwHa1iNVCVaKwe5ED7T34MjSVcK+
	TP+VNjN0Kb743kcB3eRdAVH2fkYZQwmnO3OBugs11jBOfRrRuv+x9wYzqUAOvNQJ/nBEykCACMp
	apzPMLaH+KgW0ZKaOndUMNDShMOCv4yrD5F8gk39pSIprPYuWUjFuSj916lxXtbZmmqpVqKfUH3
	MGLQObUu4jUb1yNkiBt4qs0vgBWjdRmBJ2P4MaWOmiQcf9Lt9cunI8sttFtW0gswiBEHCx6MoUM
	YLaeWhNKrja9xv4n4MkafvbMYV0qFjgAo/BBlSLNEsPSh8+YOpxCs8Po/3QgHCTczNz04Ux16VD
	C4eAtkE3c+7qOO+GsxIiaYv3fNcJEwBPqIi8t5fl8JRNgPzBWiQM1Kd1eHcc2D++s+fBshHCq+/
	ctf4qLBJoO/pBQAwdEjR
X-Received: by 2002:a05:7022:1113:b0:1ac:9da7:e86e with SMTP id a92af1059eb24-1ac9dc67128mr17230382c88.30.1793696240266;
        Tue, 03 Nov 2026 00:57:20 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm39704029c88.23.2026.11.03.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:57:19 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: wait for SRCU readers before splicing the namespace list
Date: Tue,  3 Nov 2026 03:57:13 -0500
Message-ID: <20261103085713.3479756-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103081418.GB4301@lst.de>
References: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com> <20261103081418.GB4301@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_005721_356675_C2EE9FEB 
X-CRM114-Status: GOOD (  11.72  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 09:14:18AM +0100, Christoph Hellwig wrote:
> This feels like a design issue with list_splice_init_rcu or rather
> using list_splice_init_rcu with SRCU.  Do we need to encapsulate
> and verify this logic in a list_splice_init_srcu so that other
> potential users won't get it wrong again?

Makes sense. nvme is the only caller that pairs it with SRCU today; the
others (btrfs, apparmor, ima, smack) protect their lists with plain RCU.

I'll add list_splice_init_srcu(), which takes the srcu_struct to wait
on, as a separate patch next to list_splice_init_rcu(), and switch nvme
to it in v2.

Thanks,
Qiliang

