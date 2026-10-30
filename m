Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678A606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EvXf9588;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KD9tNopx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6+OCqfxDbpq61xBuSuXpAVYprxq9Hm6R+j2C8z2vLPs=; b=EvXf9588+epfZvdMjNptAH+h4T
	A3A54CJlnsZpoZzCkrp3bnK4IQwgq0q2S2GidTbIjc9GU16Em9a/XsimR3TjW7EnkxIs02Hi48c2w
	WM7rFcQMvtCZz+azIkhqzFn0wiZEOL7u2CwwH8rf0iyZJKTMW2a0XmbK5yTApBJCWEFPIQCxQVe8C
	1ipGuS0fsdD7RkSS1xrL0Ll3pnVBdxX+qkfBn+n/oUWAK97FbiomSUiHJ5hgyBXESyWlhIVWs0Sf4
	IAO5DVJoMdrlVV6sPon1DBea6QJwvp46v1CTWNKEpON4tXeZ6KrVP0Ily/Vdi2xpTEob+Ba8NDAyV
	ViJeZAZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMriq-0000000CQkl-0Jf5;
	Fri, 30 Oct 2026 18:53:04 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMril-0000000CQkC-3uoT
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 18:53:01 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-33fb4680717so12305eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793386378; x=1793991178; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6+OCqfxDbpq61xBuSuXpAVYprxq9Hm6R+j2C8z2vLPs=;
        b=KD9tNopxWNmVAbpPZOf5zMVv7ZVzBYSX7btaGhWgz+vVt9euodq4z5CP5FPAp9jf5L
         rf6ZfzyIHTVGAgaOyyMY0gc78hpl9tttyT7OjDfMlteUQvBvp3y+kduuRVUlJyIFZM7W
         2U6V3oCqC5yZ96DjxbLmhUE2qXNTy4dQs+bYEmPr3TOsZV+xIK6c876uxbsn8kppIZYH
         f05FzW/5B1S0iBH382tGRy9O3uyXS19cwH6dmIZ/Etc2V5nf54vvQ+8DDXzlGNNXRgOJ
         DwcMa3k2EwciuaNxT1LHu3Nr50JzD3Vx5nRCqDvjm5ygn9C5TW0Pn46iG6Nud8vh1Wv8
         +82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386378; x=1793991178;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+OCqfxDbpq61xBuSuXpAVYprxq9Hm6R+j2C8z2vLPs=;
        b=T1wBAHem5KK97VBi/HrM+/LOCnipmQ3EY89ARN6zba4D1/A9z18TJCOQJjz0sqBPaV
         60m0uABy4wHU7zDf5Q5FLDGCNe7h8wsJylaRwBhafpIOkor1hlhkP96CvuzEwwuERb+V
         lFXC/Lr5Fs4AGuP1CVqqIEfQo2yUdKl1EHE6YJDCA7phwcG10D7iHbYn2bz4um21BBRk
         2tvXlihvUVFZVYUmAXUUGyDZg3xuVhGm42+qtNliyas3vvjjMwYCxEMhFAhzHEvtQEja
         QpaXoUiLCAvEPte350HJwsLYHqtuz710fL/WHjoMF0pzvOiirZIjHuKcqL4KaRTToKW2
         kjfg==
X-Forwarded-Encrypted: i=1; AKwUvBy8k2VA737Hw3yOrGTDMNpoR513wx/qifvFasEnRCn4ACNpKO7c089picCt8fgz4bgq0v7lP0cAfu8A@lists.infradead.org
X-Gm-Message-State: AFq9FYJhkF0RNe25+fPSD0kufHePxFYrunLy2jB15BHEGrPVQc/Kashu
	RjGthiFwCogrn8gfd/p4X7U+GgHJ8gjs8tr7f/aykFCb01IWlljYT1rlZgAT+k3LWLw=
X-Gm-Gg: AYBFou0fbS3S1LSiNgkPUV3cAbpFt+8sK7Mx3RR2jtGHsS6Yon5PirZ6+5R9XvM3azY
	1vhEiLCqdHMjGmFeo/H7K/Th+lHiIKLUBTGkVwN+2QtC0AdcvUa2QsTnCha4LoArMW7UraJ5sKw
	+dK/SnqaSj5p3Y0dNqoFr3H/0gEtbQsW1Jew84ld/PsP3Sx/1pbOWSYFVgeLjAMII0JSJ6l2U0q
	e5FOJ/wyPtSIcKUHouy/agFJ4EyMj3XxSCiiRkmepp+fwS27mSFsJN9++jn1vdbRqAWfvWl3Bmn
	iBYg/3OXxg439ebnexLpw+3SZ8GmXwBQHw7/MecaeKtaLkEIl/TWcXY52iUw/wJSu2bmqB7Rk48
	QhQRcpAZj+qI8JueG1WNI1Ugm3PEeestivyZT8wVwjZIJx0pFL+LLA5hqGJ8E0DmOF9QYOLeEMt
	rLre9fXfcqifFrBo4IR1/HYmvlK3QxCMgLDHKzm5QcwQHgYO6dvCvbx2HwYPxMHFvVh7I5dUH9f
	R9KRgIc4LdsZdlcA09/YRuTh9MeqAhbQrlSMYvfTWeDHqdn872AYGmd1XI3/r4gipAK1NkthIor
	zZdZ/ZQOPt9cFdvCN72lHla+EpDD9dCkoqbbVr7SM326IxnUEjI=
X-Received: by 2002:a05:7300:e9d6:20b0:369:d779:bcb8 with SMTP id 5a478bee46e88-36a42059aa6mr4854512eec.0.1793386377812;
        Fri, 30 Oct 2026 11:52:57 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm10419574eec.15.2026.10.30.11.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:52:57 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:52:56 -0700
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
Subject: Re: [PATCH v6 02/18] nvmet/debugfs: Export controller CIU and CIRN
 via debugfs
Message-ID: <20261030185256.GB122209-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-3-mkhalfella@purestorage.com>
 <179241127352.3544975.2554197788837860779.b4-reply@b4>
 <20261019190106.GK2931-mkhalfella@purestorage.com>
 <a3852ed1-4b6d-44e7-b4de-bc1c6a3b635b@flourine.local>
 <20261021183859.GY2931-mkhalfella@purestorage.com>
 <69bf549b-5b03-45ed-a18f-799c6e0efca4@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69bf549b-5b03-45ed-a18f-799c6e0efca4@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_115259_976894_A241B0DF 
X-CRM114-Status: GOOD (  14.83  )
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

On Fri 2026-10-30 11:30:00 +0100, Daniel Wagner wrote:
> On Wed, Oct 21, 2026 at 11:38:59AM -0700, Mohamed Khalfella wrote:
> > Good to know that nvme-cli now parses these fields. That is said, the
> > sysfs and debugfs attributes are useful to have. Say the controller is
> > stuck in a state that it can not process an identify command.
> 
> Fair enough. I didn't consider this, in this case having the values can
> be helpful. Please add this info to the commit message.

Added a paragraph to the commit message documenting that.

