Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB2606A332
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uQiEMf9w;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=trqOBXhs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QIo3a06+f6WBr6Mw1qb3r+J2x+nDBIFqmxAPWvx+J9g=; b=uQiEMf9wG3JY/uEvA12weyPO6Y
	WyZz1xdlSYUUhhYqCy8w6gG73VIxhc4+ap+OKLl60YcOT+sDd7GBrUp8GSIJkJZ8bnA7vkYtITT5c
	rl7AYqhSq/PAk+hcjSgolEG9JNGyZ16ZUEYSJb91Bu9nIZ3c4aQRdP0xrQd336fx1qdSmIjEiyEAS
	20dDZDi6TDHd5E8aEwGOg8zr9uuU91tkMMeRBX9lKKWWfn9AuhXwI9qbB9SwyhL/iIJ96g3zb3OTm
	pSE99Um0gLvQ8s137ggmq7q+VojPeUIYLS9fTjQYNAYdM6i5o6AO5FgbDuVzaFzvGYIJZdy+znCRP
	kjFPv9ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUeg5-0000000Go8y-3DDy;
	Sat, 21 Nov 2026 06:34:25 +0000
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUeg2-0000000Go81-2y2q
	for linux-nvme@lists.infradead.org;
	Sat, 21 Nov 2026 06:34:23 +0000
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso904768241.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 22:34:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795242861; cv=none;
        d=google.com; s=arc-20260327;
        b=KhP5al2BgBMZX7WJCdnY4DX9ruCwITxSSfHxOlKV+yAZBCHAU4KKWAgQ86Y6qH0bRP
         GHmQ+n4O/lVRqBPWkIkFEuf8gWOnRzVgyqg/5frqGW74TcI1S6l0MBQXFO+ih1fcf4VY
         9CJay1vcnbuy6zVSsc11OVY3qQlRXrYWi3thkH/L+8p1jTC8gl2/arAUeATs+gAQbbAn
         2Q29ki/O66v0F0lQ3AXv9v1mmVCcIKctA/2/FcnbG3eGJqhwcj1S368v9sXggv/mw7xT
         s/Cg64W1tN94zNaYAoGRrI1BS3suOyASZPwgBxmPs9kUj9lVb1ycpXIBr+Bbaqo/t/Sn
         JraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QIo3a06+f6WBr6Mw1qb3r+J2x+nDBIFqmxAPWvx+J9g=;
        fh=G9K2tJAL1cDyoyQ77HRuaOCLkGHikaZJ8tKuYCOsw8I=;
        b=YR4KZ9czb72Zr59ZT9CvJDGNmd1vYThboBn6Zlviz6QGUWgHAo56pCiy7YPT6HmRMf
         YkR6nyy0NtX+VjvcNwTA9Nm0IKO4sKUUDZlWguTX1lUshdkLxazox7bIxzEAn6f4ns6E
         Uy8V3bYCvDavEomY1j3utHui4ThLgrK7G4mZLfIBTWyPHjnTNRRmJT+aaz4NdUW17F+w
         cigtsUAO4l7P1HFEDsbKDjaVq8YhSOTldDS7GyOUNYH7HsuU14Ti/tY1Q/AJ8glVfBsU
         We9wbN8fadkDtgeKts/o2y0l0oQpwoGdv/jNJSTk+KHP16O0Qr0NmdoSH+NS17ctUIdm
         0mGw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795242861; x=1795847661; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIo3a06+f6WBr6Mw1qb3r+J2x+nDBIFqmxAPWvx+J9g=;
        b=trqOBXhsTljG1//tGqb8FBTou2w1I34aZRkbc5ue0W6K4Enbp8YgfFw+rcKMa9UM3m
         bYyJt7n7EcKiXV9dYPZS5+n9pxL7hvRn5uw/QYmPKs6Xf+oG2yFXTjuXzLx+ljm8upOD
         y/luVc0BPpial0K2ilzuv9ahtRZYxEGsDToaO7r6SBGiXAVsgoNmtY3YQfeLKcvG9SgF
         FL6sf0EDiXi37fh+ySzyrQ7uFEPmiRrU2uX8VK5dJxvF5Ye7LUKWL0JKYJXP5he5wDVP
         sETIZCV8RRZ+bHxkPcG0SugctdFrepwkE/e91rZbZ9K6+aqrfH7mdfIrhEYC8MEPxgqQ
         Uv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795242861; x=1795847661;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QIo3a06+f6WBr6Mw1qb3r+J2x+nDBIFqmxAPWvx+J9g=;
        b=iOgnszXtCIenbnpnpM8DwQHMEinlEL+xd1CW67ui/HU9pub3DKO9WVFsEaf8gxjgfx
         Me2GsYxNji0J2Fht6fBypxT361i/GqPBms1zCUrMZxkNLZcht0eMskKau+rRmAackN+P
         pm8qTO5nDesYcja/8TGdKHmUo4SS62/EoRNejLEVhjr08Je5pWv1ZhPztq2KwA9fy+0a
         +ssxLWO4gA/4UfX836XnvvKl0U6HsZNRFfhEKthR6I/uU33J4o3qKTfUM1WU/TydKsu7
         RubGRMobGVR8Zth2W1/3snV+Dw+HEG+N+UnyBp6Fw/rjXFC0NxwxKZnwih7s7vqzS6nS
         WP1Q==
X-Forwarded-Encrypted: i=1; AL+hErH4FFND6S7j9LtsI5sz9o9Ma/TiD2syS0gtuYlNtkC0kapSTOztJJR1eyDrm1e7ngt3fhRAcqQDmcq0@lists.infradead.org
X-Gm-Message-State: APuU4Z9CpYIyB5z4081N3HFSTEQlc0r4J1G7QQb79ksdSwEyKUCnEciw
	y8Ep4vZg+HBl6pPcd1x4S8YoHsik1/ykvR+DA5uCRrTYX+Fy8qzyTaOLSGWDSf0kyWXaidIb85v
	R8b9MIycacpMpnBmHlS4rjPhUnG/WLQc=
X-Gm-Gg: AZFdTZfnD1JvOlj/SjGAcqnO6qzBUOfxOQj32IHixe83WARlvpYiYfKaazi3RQZ051I
	DairYKTyxP6jHeSmN8ANJK+KT8s//sp0850dgc6kBlf6pwPkD5HDR4+6b6zToS/4JWYpmbe/WCP
	h+MuMq1LeD1jCYWPCuTn4VlFJtkodItwxRo9XbXBJAef5DN/u29p8ht30URs+y3aLT/ip+Np+ZG
	O8cOaXeBPdYefN43JKdOyILufH9Os0vIaOjALtTy+6qrL4EjiWgeZO+28tGqICJ+pZwe6s5y16L
	VxTcbfVbx8yxP+nQBBt9CGxZ7SczK3jkk6rOJPmpK5mnRpeumSZxuEmHR7X7j0Vgo6g9ma/nIxl
	tn7sS8+AO0cN+esJXvp5WIoQiPGXTmefSdV3YuNT0rrtsGuiDSXJodQAP0IgMOeYN94HdYGLttL
	nTY3Mzps1fbDsAH6GHWmtCgXErweJk+CG8+/j6Tmts1qWeQko=
X-Received: by 2002:a05:6102:f97:b0:7cc:226a:f977 with SMTP id
 ada2fe7eead31-7d7396157a3mr2218791137.36.1795242860976; Fri, 20 Nov 2026
 22:34:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117052741.25471-1-ankit6791@gmail.com> <awD6iLYWPuEgEi1C@shinmob>
In-Reply-To: <awD6iLYWPuEgEi1C@shinmob>
From: Ankit Gupta <ankit6791@gmail.com>
Date: Fri, 20 Nov 2026 22:34:10 -0800
X-Gm-Features: Aa3M54ogdmsVe0mK3YgtYc_aYRIIm9NF-0R9znF7ooCslEa4CV-P_qTqm3wpJ-8
Message-ID: <CA+OH82huu6zL_ZpwZs1AO7Pvadig1kDeZzpLZ55woU+2YfD3MA@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/080: test write zeroes larger than 65536
 logical blocks
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_223422_752225_A0EC8F6A 
X-CRM114-Status: UNSURE (   8.47  )
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 21, 2026 / 02:05, Shin'ichiro Kawasaki wrote:
> I made minor nit comments in line below. They are not critical. If you are okay
> with it, I can make the changes when I apply this patch. Or feel free to respin
> the patch. Please let me know your preference.

Hi Shin'ichiro,

Thank you for the review and for the trial run. I agree with all four
comments. Please go ahead and make the changes when you apply the patch.

Thanks,
Ankit

