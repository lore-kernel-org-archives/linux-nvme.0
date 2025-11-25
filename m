Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A158D0EE13
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wynpj+E5fG2Oh1abG+WZEscR5HBvHm5298AKLCuUClg=; b=428+YOtMb5DuOVSIBqEXaKQsGJ
	DhS6XREzxE48TpPaLtzHfkpSkHYXCDpdQLWqg1yD9XtWmiLHpfGr1IQPulBEAFWTHHxALSg7kS1Cs
	NvF8kksmz068CoLUpWr9og1aKR5FTk4zHcwovIAR36pFCag9N6OstuBweoW+Ik+mjl6ykewAgRhHl
	n57mEuSHURtOuHQYjnkJPgrSW1QjpFPDeuf863mYLdy3NsTKiscbxf83qW0yhLD6Dr/GeQ5qBET6F
	K5MIgxWCiqYLH68UN6NIDrD9nIeizPKhUV4nK2PfdGYmE0LUmQ0lkOkfqZtgWjYT9iIvLEh02ZCdR
	dUpfv7HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNya9-0000000DpDi-2Y8d;
	Tue, 25 Nov 2025 19:20:09 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNya7-0000000DpCr-2FaL
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 19:20:08 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-948f8fa9451so172127639f.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 11:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764098406; x=1764703206; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wynpj+E5fG2Oh1abG+WZEscR5HBvHm5298AKLCuUClg=;
        b=D2eByZdARjfpRApFiLncySA9QRGSCOx0etFD3XHLfNGuxBq394UmTuG8QLhHKgCKiu
         Ecu7vuhkzxiVYXzWLzvKP2WhuBPd1NedDixf84pFn6SOcfMHXuu+dDn0H89oLTlzZJWN
         xfv+pRXpTsoSzUaS3kK0eKE9S2lPSe3ZjXg/6Iq4YAGyPuOReKK5bnSXWUQ3T6VrjN0h
         mrteRHIjlxhtriOxyjDtEzpXweRSqxjcmK9tm4hA1yMk0WpZL46wH07ulTRe0EN1Txia
         zjvKR5VAc3iAlYvsDUVdd8FKuGXuD+zbX6NABsMQTW5Vd5QTXgwn55GQwFgOWqS+ECKV
         Nxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764098406; x=1764703206;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wynpj+E5fG2Oh1abG+WZEscR5HBvHm5298AKLCuUClg=;
        b=NHimMN/DJBGCeX8fNG+TlO/JlBSz7zkWlPkfQjeh8gJSXdO1e8bP4sZL8LcHPsdCVJ
         TQgqwMl/3O2yNfWROKAsHVR9u0xPvvsITKDw5rydiqXdlxoQEHaCwpSYMAswUmNUuPxp
         JBEwxmhzI6ioNPuU0o3WF1TtzmbLJ+vpzjswrxeu8VGROygGXFZxe2l8dYIF/N5MsHRl
         +MZrNC14Ux5FjMDVgRIJJBuKifLbQr2EWdkQgIdY+vjNKJom3UDzabilLYFEqPW0qA6c
         rJxPcTmNl+ADh0DYYHhBM2LG/pCGQWDjudB63vnJfTK+TtbotDQLokHRiBG6phdHbgnC
         6cBg==
X-Forwarded-Encrypted: i=1; AJvYcCVnlPHRH1nHPlwSdE0qYMztRLncVNrZAg7GR8sYf8+lWq0Ie6aMFgS7pltxUcsovTWNKBB+Fb1H3t/F@lists.infradead.org
X-Gm-Message-State: AOJu0Yxhz3E9R7j1wCAzTOadpogZ6fq7R3ZefBOzQQ+vjfyR8EilO0S7
	PWlJH14U5uYshQ0VrR7J4L/SWM2gnBSyyiU18Tzao3NZ/0FYQYRZn+VHptNpmDYuNkQ=
X-Gm-Gg: ASbGncuZxs16qYPiy99FOSlM+MitqUd9vvbT3Rx/lrrQdxqJmRHjzQSzyB+7XgpQoII
	Kg+J7Gxi+U94w07Ipee7EQ+H35MEdstcau3AeLyNfpUTvXxWSkFa/r7MjEavILXSFsPQe2a8ril
	vwWddod4t4XTVPpr09h/JKlylVfF4hqJ1+AM9apkhG4uGCrLngA+qyiWvRhgkNufsH/ZH4AHlar
	AqQwhT8/+KPTshcvkZTYpb6JQfPjtbGOE9oJv4Jy4WHpX6ETPnXg287bDzjwseJ1DsvTu7hu5Ly
	SaDzFCIzQu8fwEo2vGL6rrU8HSF1WgELs3atWzmdeBZ6igR7kbPpLdzRj+vdhb9uB/qtCh/SniD
	abhsM67fs1oH1p9MRYXgAJGIu3Yna64UROWszSK71LiZDvioJltz00Ianh+HjshZ2oRtQW+LBMK
	9jow==
X-Google-Smtp-Source: AGHT+IEoSNUPWsr6TkiMj1VyTgtSM+H2mYKN8PQqct0sy21hTM0OQb7u5ZARk6n0QLi/CE7kBBB/xg==
X-Received: by 2002:a05:6602:690d:b0:948:a32b:b6c4 with SMTP id ca18e2360f4ac-949473eb047mr1023076839f.3.1764098406436;
        Tue, 25 Nov 2025 11:20:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949385c2405sm668551239f.6.2025.11.25.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:20:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
 song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, 
 kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
Subject: Re: (subset) [PATCH V3 0/6] block: ignore __blkdev_issue_discard()
 ret value
Message-Id: <176409840493.40095.8097031483064544929.b4-ty@kernel.dk>
Date: Tue, 25 Nov 2025 12:20:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_112007_583269_C615691E 
X-CRM114-Status: GOOD (  10.03  )
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


On Mon, 24 Nov 2025 15:48:00 -0800, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() only returns value 0, that makes post call
> error checking code dead. This patch series revmoes this dead code at
> all the call sites and adjust the callers.
> 
> Please note that it doesn't change the return type of the function from
> int to void in this series, it will be done once this series gets merged
> smoothly.
> 
> [...]

Applied, thanks!

[1/6] block: ignore discard return value
      (no commit info)

Best regards,
-- 
Jens Axboe




