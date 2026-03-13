Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107ED106FD84
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 06:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxYqOUUpEWTZ/pLSOLUVpLeZo9RBI+x3d6XyTnJpy4c=; b=WmgU5Axk1M0+MP2nYwNUQr1g7L
	hrm1A3LaAK6QLqP8DN73HLP8ADDg7u0pqEV+TGH4CIEK+Gi1NUBQBFWmuLlkR3bN2DE5skttiE1jY
	uiJnym5O7znyqs0FgQq3qmQASlprqyYt4+F1eAnPxSwwWxlwDpde0IGHMz07Yci9C4lvHsZTQdF/w
	KOv/Y9hz0YJMKGpvbf/4qQfQKw7k6TlXrcNO8FM2jrSV1/YbkIkZ8hAlCwpDAU4t2DSOrDEG0uC1n
	P+93PDdU/bFXAZLBYm0E+nLdtkqE6hhEQIOLjKpmWI6OgEDHB5qwo0SXvIAdOdqwSOh4Rw511xw/k
	NNwtekHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0veo-0000000GjRr-0Tjg;
	Fri, 13 Mar 2026 06:05:58 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0vek-0000000GjR3-24Gu
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 06:05:55 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82987437624so1036793b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2026 23:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773381953; cv=none;
        d=google.com; s=arc-20240605;
        b=bQw90mLd9yDI4JbE6bcMobzGOnGBhaGQEqnYz/Q+TbMaA2Sm0vnQnagw1iDJmo2/dw
         XrCThZnZ00zrGDY/km+RJqCzhkX0R0JpiVAgDcgL2Rgx7VghE3LhgTLX/afIwonUZ6iZ
         hhQZcC38aU+KftttnKa1qr97vGWs83ObXZlHa9Xg+wjsP/aVpHYz8B///YxuP8+wmT57
         IfEBSIDcqbQWmCzVZhlZ6cUkP80wTYQQt4BxqEKnGzlqatzEhdI/mU11HxdFX2KPFTY7
         5D9w7PYFQS/4/E1EvqpNuc9iChWLcmDmOLCpRqAXKwslkDq+Uz8W8Suuvc6e6CHy9yYj
         F01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxYqOUUpEWTZ/pLSOLUVpLeZo9RBI+x3d6XyTnJpy4c=;
        fh=AdLX1cOrbz5q7AG4P981z0pIOPKN7T4jZwc7zUXOaJM=;
        b=ELbIDQe0sUCzbDy+1GzpEiedQw0Iq5hIG229O7ctcBUvXOvfbx87eynJPVXG6Rhwl5
         ItiWSSM14pQm2qrpAfPzlXnPT++Bfyj7goDN7tZScfG6jSs6vH7zSw4heLtTFZNb+9Gs
         Gj4vn45QbxIu9l3aoJG8JYZUPPXElShmTmJGEPYJxokS4h6HQf9zDwffpx+EIVdo3Uun
         aISDe6V431T2ofCm0THFm+SeaunsI1cmXJSdHmKKwEGXkTkBENJkfDBGAWBQmoSeLYdN
         65shzu/+nSPNY17ewO0+FajX5HbWIEDCzbQACIId0aPw5siQ0TfIfidWwezDHkaHXTI5
         NOWA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773381953; x=1773986753; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxYqOUUpEWTZ/pLSOLUVpLeZo9RBI+x3d6XyTnJpy4c=;
        b=LDuqMi3/r0XlmWzX9fFrul+RD7GgjX9TvrNvpXi6JFWfUCS4tRhvU2n3TroAIyepZQ
         oUlgluToXyMucYUkKVVktBU7g71PtDcgmtBBuITfHuFX5zbKM14ixzmIP1Uvyz+03x4g
         bUPucQiUU97MkECa2UkQn6vpemk8vrAZv2dqElYNjsiq1bfz6GY7zM/1e4t+Jot283gC
         uObIQl7VLAwfn3rSAPITJ2I1zVGM/gOKHFet6qXIekP0hk3pZuw0e+gU0JXfIUr7+dnL
         hrvA+cgN/3m+Uirw+QF6mnEKPSDwxT9zrwjVlwbJp/dhR1W3F6FqkYF6zNoB7Br5JlVN
         61Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381953; x=1773986753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxYqOUUpEWTZ/pLSOLUVpLeZo9RBI+x3d6XyTnJpy4c=;
        b=Jy0qKbh23+HkruawwgnJNWFT/+Aeoln/ijHvBIOpgz0JNz2FJ68+phsAvBaQZg/Vhf
         MRwm9GUO+Yjd+B/DNotNyUtxsRj80cX04M7SC/5uLzmST4wvVdwaCfnMUtxKNo1ju3/d
         UgX7uLhanQW8H4QRGIS+c+LYAsI4kpJNAEvBvNKNbVfUjFS8aNTmbizMQhBAeaNRhd5U
         6T8boClsGqK2BSU1VRAScNh5dTE6ZrB7y4txhUStFAje/reTsInBL1DQGB97WcZ3qvcO
         5udj8qehmhzohVjZQrafCj1Wh4u9yt5ExKNmOWsCeqg+MoCOUAMXrXJGr/hnqwGWPWlq
         udXw==
X-Forwarded-Encrypted: i=1; AJvYcCVdhDD0BUMftVXcRXTWdYgJn1w47zuyeEega18YHxg7lKPawEHLwYk48vi9Nn+0ICkWIZiODTZYPRi4@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3J9T7UlT7YhNSRYA2cQwmORPfPN14b1nNqwmRyrq5U1zK3nyK
	Be6438vrfjgmwa8YQGPS3HX9fDSQUuGo5ahHY25QEH5fA9HNtZ//IZ3czNHJwVLFx+q262FZ8hK
	FDQBUm3hx5/ATxUda5fZR256tHvpOKps=
X-Gm-Gg: ATEYQzyqgvb23wedXCMVPRGy2Cv9tk0HQGC42Kf3cTSirNQSYA0Mn6+7RS+dCkoJJyi
	pSWNH/DZHOckWKUNukYeKMZTg38VI9B5Xb5du5s4Ycqa+xc2Nhr3Tr2OlB4s0t4sA+qfFfRAuSn
	gW5QhsSSHwx4cp9e+55uuO6gq+17Xgc0WIltJbpVIb9IKyxSBDOLejRnbxH+4/Q0DTSQ0RJ6r6z
	fqE0ytLSXhUPNpyHNiRO/F54/DIwdJFNW5QnPSNczrccGMiPSFMl2fs7KN2GeagI02aLTf5Lrzr
	EGvS/NzN
X-Received: by 2002:a05:6a00:cd2:b0:81d:9862:a140 with SMTP id
 d2e1a72fcca58-82a19387a92mr1945991b3a.3.1773381953511; Thu, 12 Mar 2026
 23:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260211160859.GA11869@lst.de> <20260212013338.1417091-1-ioerts@kookmin.ac.kr>
 <20260310-video-foyer-58fbf3080e9b@redhat.com>
In-Reply-To: <20260310-video-foyer-58fbf3080e9b@redhat.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 13 Mar 2026 15:05:42 +0900
X-Gm-Features: AaiRm515bV4t-ZmXfF2uX13ZQOYwyy2qqMR6mqE8Qj-iGMx3LSiMUbw3crh1Wb4
Message-ID: <CAMX6_QESBMwMfG_bxtXjB1kz1mBf_OGBqKQZvQ9mM1ChGdgneQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: validate negotiate payload length(BUG:
 KASAN: slab-out-of-bounds)
To: kbusch@kernel.org, Chris Leech <cleech@redhat.com>
Cc: hch@lst.de, hare@suse.de, ioerts@kookmin.ac.kr, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_230554_533627_7E2614E1 
X-CRM114-Status: GOOD (  17.83  )
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

  Hi Keith,

  Just following up on this patch. It fixes a network-reachable KASAN
slab-out-of-bounds in
  nvmet_execute_auth_send().

  Could this be queued for nvme-fixes?

  Thanks,
  Yunje Shin

On Wed, Mar 11, 2026 at 5:47=E2=80=AFAM Chris Leech <cleech@redhat.com> wro=
te:
>
> On Thu, Feb 12, 2026 at 10:33:18AM +0900, YunJe Shin wrote:
> > From: Yunje Shin <ioerts@kookmin.ac.kr>
> >
> > AUTH_SEND negotiation requires at least one DH-HMAC-CHAP protocol descr=
iptor.
> > Validate the payload length before parsing the negotiate payload to avo=
id
> > out-of-bounds reads.
> >
> > KASAN splat:
> > [ 1224.388857] BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_sen=
d+0x1d24/0x2090
> > [ 1224.407035] The buggy address belongs to the cache kmalloc-8 of size=
 8
> > [ 1224.407998] allocated 8-byte region [ffff88800a6537c0, ffff88800a653=
7c8)
> > [ 1224.412412] page dumped because: kasan: bad access detected
> >
> > Use struct_size() for minimum length computation and move the negotiate
> > restart flow into a helper so the call site stays compact.
> >
> > Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
> > Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
> > ---
> > v2:
> > - use struct_size() for negotiate payload minimum length
> > - split negotiate handling into nvmet_restart_dhchap_auth() helper
> > - use NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD instead of NVMe status
> >
> > drivers/nvme/target/fabrics-cmd-auth.c | 48 +++++++++++++++++---------
> >  1 file changed, 32 insertions(+), 16 deletions(-)
> > ...
> > +     size_t min_len =3D struct_size(neg, auth_protocol, 1);
>
> Maybe this could have been struct_size(neg, auth_protocol, neg->napd)?
> But the target code also enforces napd =3D=3D 1, so it ends up being the =
same.
>
> Reviewed-by: Chris Leech <cleech@redhat.com>
>

