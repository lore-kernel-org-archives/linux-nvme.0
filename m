Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A9FE94108
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Dec 2025 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=; b=l289EZAH3WWKpBvrMMMDQgXn0o
	sYsgtX0wTyzRUDqEe9PK5LYvtIKA726HcLev8bRSqXAu2L6j7pwLtGfFjRXVCbbBu7ZTguqrqMLih
	Fdfe/l/aNH+hd+yHtUhZ/OFsxLNoLHlU8Z6fnHf41QhXXVzJIE1CEJF74CODXFMYLyxV3BGp4waqZ
	qQaSxlV2EgQ+8lBiyx3PQJbQBXhVn2Zn0NCTAZmllFaMeAE3tXMrYIraK7ivB7jByEDuiIAH740xx
	Jqr6GWrfAvpIxNQNREwNK79ojlHHd4cATsYhg4Df7xtDPVSxOIRCW5WYZFcv7wFZohIF5csd04nNV
	z9qV4Few==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaVbt-00000004cL0-1UAu;
	Tue, 30 Dec 2025 09:01:45 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaVbr-00000004cKY-23Wp
	for linux-nvme@lists.infradead.org;
	Tue, 30 Dec 2025 09:01:44 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-941275fece4so2100391241.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Dec 2025 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767085302; x=1767690102; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=;
        b=XCyeuZIJEHlE2uNInSa4PVNGTp9NLV7GucDQZDc7uKgio/5/WyBhfi6V1vOQxmirT2
         vLt3t1PrgiFun4UcMvKu0Pig/Xt0ZtQdOBsdyisEOy5GUm7sGFVAjUjI+Zx3+fptMa3I
         phbQgVkxtTAA1HSzGxsQ+laCsOqh5v4WYwKGN9JlzvNEJFH0Fs/aO/m1tU6AivYM3Imf
         RmNGYlrK7WcdhhbEJcaKZTIwWEYL+312G7t0Rd4f/kpy6Ec0SS4XlZlGt23NzwUZKjbI
         Iw57qm60pTmWLKI9dfuzU68U9VDV8zlJv5J3kEwEBhekZqpacxCeaiNbQ8zGfvB5UikE
         1VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767085302; x=1767690102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=;
        b=PlmSi/wnicxi6Ox6HHpNEIBW91pKXs3QX5dK8sz9HohhX7GaKHWNyUXi/X7enIAoCe
         cYbuC0GknKxqDsJ3e6LJPFinep2TZOZbU0Hd6JfOHSjSgBmAhDKmIKDA/UBZc/J2uCdb
         CUdDBqzrxM6EoNoq7hP8B/u5e5JzsHcHYTCu5Zn8pKRKF/OKZTx0EM2q2xHDygOTMRCk
         Ihg34VQ81oJx229WbjJ2uWfha5d9QYfgDjP4/sfDF4DcFRsKtxoXEqggcLQ0NnfiX67g
         f3TZJPqbItwqDqr8ndi7qTSs0wdzpiRqKZzmnt4M2R6BAJfjsafT5U6WmriroNvan5Nx
         gspg==
X-Forwarded-Encrypted: i=1; AJvYcCUz0gMWsv9PnGlg71yji0MMioMZONav5X93oF0pfj6vcUnYbX4gH+DcmRW8gUIuuLBB01iDk6tFfn1L@lists.infradead.org
X-Gm-Message-State: AOJu0Ywu9hhAvXZ9IzkeQPzzBOudR259vAxqJEyb5Ybu9xqMwCApznau
	tNs/GdJRlUyiWJpq0jZXD/WLaUzqCYB90xIy2PWuc0hsxvQI9+m4u0Yov7F8BhwqY7tie8n6s3S
	LkYrgWjsj3v0xh30LQ/fUfliZmnpn31E=
X-Gm-Gg: AY/fxX7Br9EyVNbFoWKFMZHrSB15X3Gw6rl1VgxW+BYSYGDWyUEJNKYRlnmuJUK7Zo9
	eA26dZJaM38/A3LgDNJ2XYJLyFgnX9alUwjnZ4wRPbVFLYg/F9/mjXiMouFZTNkwlZWHlHi91RU
	1q0YgskYnCyv6bURfWuo54SfC0hnWVi0W6D93zV+zs4fdJqE/ptEcCxyI5Wu6kRjsI7jGUaOQmP
	q4A1sUkNvQIW4Z9rPh+e6FpX08NBBZdgVUEYcaeHA0XqZf9ez0IZQzVTxwzG6IyCr+9jwqANgv9
	7BR7lk0q0EqfFFOb08Yt09nV/UY=
X-Google-Smtp-Source: AGHT+IG2VVd2ulHKPqepblT/dcXUBuIzAvujT/19dGd3qTOe0K1RCNJYxzEAIxGbD6sVUVs0vdR/LkZE5bbIY8gLskw=
X-Received: by 2002:a05:6102:2b9b:b0:5e4:b9ff:3fae with SMTP id
 ada2fe7eead31-5eb1a6171f8mr8982040137.3.1767085301799; Tue, 30 Dec 2025
 01:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
In-Reply-To: <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 30 Dec 2025 12:01:30 +0300
X-Gm-Features: AQt7F2qmQ9Z-5a8F2Rg29NY-tgt0ZGYPV6trfPXjMIRVYLRN4aNMe6W6AAufCfY
Message-ID: <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_010143_531723_AB6A3E83 
X-CRM114-Status: UNSURE (   7.15  )
X-CRM114-Notice: Please train this message.
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

I think that even with the 2^N requirement the user still has to look
for boundaries.
1) NVMe disks may have NABO != 0 (atomic boundary offset). In this
case 2^N aligned writes won't work at all.
2) NABSPF is expressed in blocks in the NVMe spec and it's not
restricted to 2^N, it can be for example 3 (3*4096 = 12 KB). The spec
allows it. 2^N breaks this case too.
And the user also has to look for the maximum atomic write size
anyway, he can't just assume all writes are atomic out of the box,
regardless of the 2^N requirement.
So my idea is that the kernel's task is just to guarantee correctness
of atomic writes. It anyway can't provide the user with atomic writes
in all cases.

I see that xfstests also check 2^N and the check obviously failed with
my patch, should I submit a patch for xfstests first?

