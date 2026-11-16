Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D780606A329
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yxUdhfzN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gkv+AhDe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=; b=yxUdhfzN7cwrXK
	unz6Kg86MuObd1oAM6/6PH0P9WmbQGvuqQLNC3R+inoPA4owJzgx5zb8dOQjgXmUwWAS6CqAjygvB
	9TvNXDoTFC4TZ6HWCQxIqP8RBxkM+DM2wzF+tAL8DS7Z4cM5qcXFPWIlifdtsCL+ts9tJz+LVsU4p
	MdTspNvQeQI/dE5Lta7aTuVo9wXt2IIgIjOIKKNWZS2oRRZfhvLaWqloO5xKfPa8UtudGsdr7MV4t
	IQWdgZmtFLmV+Wuh0ht0GhPwY/YziRBExCiFvczQsKomy46E1iBk+qUDR1zmjL1vkao62Uhe3ORzf
	y4k5uoknbOoJuCbvd6Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzML-00000003AsB-1OMa;
	Mon, 16 Nov 2026 16:15:09 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzMI-00000003ArW-0RoQ
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:15:08 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso906536eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794845703; x=1795450503; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=Gkv+AhDeLGeAfC5wqb20+r/LHwvzYmaB8gjVknigp5BPVin2QTk+RzfmgLRJnBXDIS
         UXzxklPL6T6hOqTk89DwmCAZK/7lj0XYUdSm8SF9bjj/KA57RtYwyNggoyUXXk+foIb9
         ZoRsZSsc89wQtOtqsH2EqkdhypxffE6thWxrZ5FP/f2ev9BOHAwSKvXBI+fqwilvWryL
         2nbshX4YB3IiaYkELb6wuyOjrTYnEio+yzmCfigtqk4h7ASKqazDA4ttJKVF9PDySVs4
         za24q6Sz6hWjKQ4LBiHhfLCRSYMZy1s5iWaILyXT0JCjkUZybwZhMhe1029AjLTe3pLo
         mAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845703; x=1795450503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=UYQu2gXGRraiQa16pw7xCyDp4sJceM45L7BNEllSYhmbMMXpr8tuAW5QnSxFRTHkHV
         Xatmvl2COXQj1Su2n0SoHy3pTJ9eMTK3cgLnN5bl/MLM7rGOhNBrJs9NMhQEnEyXjoxY
         bdoUxcbb5IiMQz3UpqXA3JY9Vq/zTSyKEZmE5QAJD2atQ8YQ6wldONFYa5rynUoaxMtG
         MdmDITIE1mTzqN4MRAziXyHGplcJ7Q3w39wpxFS9gbNikd37WCkwVbbQWOCWDg2U0XKd
         ZlCiUE/qBLLDubIOvepYmeS3iECbNphSpUzStPoKeg4kjd66TdSYbKiEMIEJFEvz+U+3
         tSPQ==
X-Forwarded-Encrypted: i=1; AL+hErFz4pHJi08IKsPK7xQxQ9SRkkricLV+Jek/49iXaWWQSPpTRuhTFCUvq1oNlzY2+Dp3D7nVSlreCZAh@lists.infradead.org
X-Gm-Message-State: APuU4Z9vdGG5JWzZTUn/6DgDBTNGUUGYZXeltHqrCLUDBetSZQire31F
	XjtasgkdnRLTDoZZVqpyJDhIgWBXw8KG0GCdXlLz0h/RSBdpPJ96xgeB
X-Gm-Gg: AYBFou2Na1rjmND9MS6AJRE4P+9eJEeIUWFbMutJWFzGSYLnvKnWIJzrP50UccghGdl
	p2FA0ppBPT+C/sHS1+jkl1wqQGuIKc1QmCqProf6lT4PD/F2ZlvIBiV3/Mnw2PU/vQbLUFmx2rR
	8getIr2Fly/iUvFpiAwCHgo/2/H7iwx7C16/nMRqBQc7kGJP53canG+LvDY+xSsud+eJk+g2QOX
	4CzhCVe+RxbGW2GUoUPASiC/Bf5NWbtj2RzDlqVwckaMTEB4R6rTvsas8k6T3VRs02G1TBFpEtX
	2aSQWXN2JsTrEAyvcjk/3CNjnIESX2vfIoQGbqlvl4IqWLp/cm/s3EYdUyNmLV2jd1JiI+KoJ73
	faxDtrNeIUCT4FFtKPYEpN2/1q44yU+iBtnjb1iJqWD9MUCRohsts3CYt9fybLum6rbP1X82o+W
	m5l9Vn29NWr2Y9CtoGcVdyuD68yT83tE4FEcZb4tPWGaYQO78c7aWdZF0lyRj+G/3DjI3Ks298J
	YHniToqF1i1fvFktI4Tj2wsHN0Uu0Q0Scs1nEZgLtgiAprquqKxFUUlbYY692cUvT/+B60/DjF7
	2rzqigdMiX1ms24VCCZ87nmfRjsEtK/SYIxsX5XGfOKviMNWCmizJ/XTNUhGG4Fr6V7trDkT
X-Received: by 2002:a05:693c:811a:b0:36e:9763:9268 with SMTP id 5a478bee46e88-3796695b721mr11102878eec.26.1794845702938;
        Mon, 16 Nov 2026 08:15:02 -0800 (PST)
Received: from localhost.localdomain ([103.178.205.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380e031f3e5sm1494597eec.12.2026.11.16.08.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:15:02 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: kbusch@kernel.org
Cc: hare@kernel.org,
	hare@suse.de,
	hch@lst.de,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH v2] nvmet: reject invalid write-protect feature values
Date: Mon, 16 Nov 2026 16:14:39 +0000
Message-ID: <20261116161439.2767-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179484220923.249619.10986402925266130295.b4-ty@kernel.org>
References: <179484220923.249619.10986402925266130295.b4-ty@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_081507_574118_10576B40 
X-CRM114-Status: UNSURE (   5.80  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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

Hi,

Thanks for applying the patch!

Best regards,
Sreeraj

