Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E4606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qkagx1yo;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q3k47A0M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=; b=qkagx1yoYC1KZo
	tefQiUcGwzHAGBJSCSw6O1WocogGWassomWNOQhNg85a28bonhDhAyQ1KufXuiM14JyE1+eC343m2
	7vuZCAUYF6Mge8xLHdgfWzIrWViEjVh520h83+eOpI16Q93JzImdvnVVHV5Z9pOYPfKctcajC5Esm
	/XOxfZxhUyHMFK9Bnlw+P48Ibq7rOCeMEfC6YOqYd3tOkPnqlrSdPJgY141fHmQxDe8p+Gce96vHk
	jsIzHNOmR0EQmqRZVlGYmlr12c4StYmhXZLhKUQcZW6b7LO2nED3N7ZDekYhlEViMFr1dH3w9KzqQ
	SVoyC42oCB4MG8+PogKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzGY-00000003ADo-0eVZ;
	Mon, 16 Nov 2026 16:09:10 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzGT-00000003ACI-2NMZ
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:09:06 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-14394530ec6so4439429c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794845344; x=1795450144; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=Q3k47A0MDyD90KQPC3JvQXLHmozP3PZKYSx9hVBqYlXK5lZp5wtR+NRsyujapArg7s
         wqUOUumxzeBtXqUkNZWqMcyu3DjLQkrCtQd5Wk5sjRiJGlnPGBjoWr5pSegqX5zYyr1y
         be2kL/BcLnFGb0Flff+J7/RwGu636XNbh9PS2Aei4+WRWxYJ6bnOytDkFAbsslAunWXY
         LOlyv7QrAK3Pl7yeRM3KYFpNUKC90H6q24h39HU7jFwLGdrRUAfLTfmzt8r7rOkdtC4X
         CzcXtOo5rJZz22A8hjc+rWUpI3NDkCVRy6wjCjqsChAhsQWKhQBTR+ixrnTwyXMD2LWD
         UwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845344; x=1795450144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=tEWJiMMIHMglSHRwgWom2sZDCqyDucdXt0U4kUZq3VdbCZXxJX4Zi5OyfJx/P9aRG2
         ljv/4vmlIXR2GEoSwe00R4v4EK/imuPvtLP89McbCfYIw1CN3gvWDo69JyHc4bshbTS+
         ZukLytF11Kx4rJl+40+21rhWVx3AcC3LOqkrqk2JEk7PN1bCIdEd3O6jP6g4rP2q8jsn
         sJaPt8PEKA2yQNPRk2laAQE1K97udgywDVrkP7XLGS6xBfmPHEaGA6xbuM6ZjwzudT7O
         PFSMuQg9czBgSoBbIHNBW9yBxSTHXx2XS+NtOMRNgm1ML+7ydRsw9CEIsJO2YctgJvPT
         C/0Q==
X-Forwarded-Encrypted: i=1; AL+hErF3o0Lpp7QHAnsNOYgrF8G3Ee5U2Rj9Ka68GD/33THFOzMXqlKGmrX85kOXHszC2ppe7BijbEUiCUrH@lists.infradead.org
X-Gm-Message-State: APuU4Z9Ml9SOvuYBgvSe4BN0uMS/fSIJpF3u2bL5O2Q7NxHCkqnto1/J
	SZDdXNlYvO8Dn0dbnIw+3rj3tVOPPRU/qCxX2AIdfx6fu5+DGseRJAfh
X-Gm-Gg: AYBFou2J+qMF5liXNHTC0A+zGUafxvwikrljhMeNFHZbX+/rZYzqFsRFyj5P12H5yZa
	f9zqK7QYzVWssBlLsGArFYWuC4ZB7z4am5c0FyUKFKfaO1ODlAMDq+owMg410KqEFejyiceiGoS
	M1BlFD6590UUwPkAJn1tqIAMHRzcaT/pYQnN3RirNjlkf5bkFgScexENmySUyHVr5nfBGUdZxtJ
	8YTkGKJliyUbJRxSQS5hSORsH3StZytNNHIKQYHgxoKKs2NM0W/SUFfrOd1kLURwXiCbANIE4S7
	+ThzJ+iWEUyvEUxVG6psnPYdmjPLMO7aNmAyF2Ft8UdrG7L4/jS17kBuKo+B5CLb+wjVO7luIXe
	znua89/roqyrYGtkJHyrrtAvS5IsL13C1NFT0uohsNssZavTRLy/FYSqzpMK6gOGreQAc/6r7Ip
	AwtCq75+vmVNdJsRGBqyhp5DVNdsnYSw2qCcAOV2Vrc/oo+kXFLe4NdP17k89AW2c4XftdBfT1V
	7Q/gzXK5yb0YrSkNewv9LVEHVJKaKz0n/2MV75VIdxjuazhJNGvlAP98j1KJq0qo24ltKIdRiL2
	l0a/YWdBQPOPJF82zuNzVnyezm5+1pyAbMmtpg/u9rzNgBiG1rr+ZUe6AlvfL3x6Fc3e1ukI
X-Received: by 2002:a05:7022:3a03:b0:1a4:9eaa:d01d with SMTP id a92af1059eb24-1b50315d8e2mr12037774c88.45.1794845343916;
        Mon, 16 Nov 2026 08:09:03 -0800 (PST)
Received: from localhost.localdomain ([103.178.205.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm38536683c88.5.2026.11.16.08.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:09:03 -0800 (PST)
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
Subject: Re: [PATCH v2] nvmet: synchronize DH-CHAP secret removal
Date: Mon, 16 Nov 2026 16:08:40 +0000
Message-ID: <20261116160840.2616-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179484220961.249619.12113326051904353767.b4-ty@kernel.org>
References: <179484220961.249619.12113326051904353767.b4-ty@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_080905_604839_0DE608DB 
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

