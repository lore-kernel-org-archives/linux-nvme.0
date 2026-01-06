Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95146C47BE2
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jan 2026 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=; b=mii6SawavmJI/j5vbmuFmObCdd
	UpxVm4nSDMdR+pk+KGtlIroILlMQUCZ6JO+dzvJE8lFg7QD/ZyxQPHqTQE5EmZxRCTpTUQDZZwfzk
	WM/iYGwE3WTloRMfH/EaqmDIpB4Z9fmcAVlFH+/U9UCtA7eK83Kpd7yxPX02fVvI+Z5CC15SH0zAm
	+1KiVtQGuvA/1DAN8yvMisxylvAEcFwgNzrc8hv616VZXVrNiMSP1F/8bhPoLVTeG24UyyLHNJWCo
	eNktZfXa4l12a78/ifi2kbmm1OibSlmLcgTLu2ND0oHG38AXNDE6/zDwbiPo87oAGoaAgti5KLNgc
	ja2bTwlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd4ee-0000000CpTs-23NZ;
	Tue, 06 Jan 2026 10:51:12 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd4ec-0000000CpTR-0EKP
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jan 2026 10:51:11 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-5dfb5fcf063so278930137.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 02:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696668; x=1768301468; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=;
        b=PjWQQwA06UeMm5djn+kHSWo63vXJnL6pGy0pybvYnxt+dnz83sagtuVaR4mU02z2Uz
         ToE8DjEb720xgUSmQWK34H18E7B1yNk2Qhgn1JzWc1it/5NqJnFBK9qrvWUI59dmHlgs
         Kj5ez46TxqDiqjlGfUZciok+Qt1q23vuOUQb4Qi8670IcbbECkDIib3SGsDrseTW0ww5
         h3C5XfxQrnZDCkjSBdLDTl6W9YLyAqrq+NL+rMI7XlSIJYtTRITkKRK1VPijIRX9hFYW
         wN+6vhJFqGJK5qu5NXIBDjZWqe2JOkOcmKg9rwW9L6PCD8BxyWlWNcn3+VzyIV06V0lx
         OhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696668; x=1768301468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgKm0Dz5kCA2GU4NuqY7+TTkk8YqK+aTLnjC2jrhSe8=;
        b=MOTtfmpAs0wUYOMFILfsnV2xQbZ0OisfHfWeEkq3HCa0WStnIi6umcabM0WCJteILQ
         8OU0nG17J0XTifXqLSQki9zQUjeWgLnNyXN0woPg1AXYqitj4xq5St5ZLGrLnDgVJ/SR
         k7FaLf+3jSwIJdrsM1DL7iB61hfyOtDoF53rZRr7coi9lOMexU4i0JQy3OUj0y+nNrwb
         K2nocTuBmEFqugEGQJ1UyLLHU1nKfEAnWfCRpnc0XN3erO0+XQ9mf91mXCzk4LJ5Cbcp
         JPn7GFvaU0SlBsb7BBBPQFKVp5Kp62B9P/bLIeQlk0PS2GFmRGlVax+n+BXGLRbLdG8L
         ri6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+xXCMEsVh44nIZ2HKi00I5PtuOGUIyNOS70QFLvsRxx2Xx5g3gYijlDCpiPrGypYx7Lv9lg/F06Cs@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6nq3Zl1AAa1bvrHgqHftCB3n7GfbVZqku4KPfv5JT/vZjFkxn
	SxEK4ACLTRvmj3VZLBwAF+wGQPVfaYCHPRQzSW4c9cofA/Lm8jJUY8W6MM4I+YcSQ2nUHzV5nXF
	G/I4QEvst259HoK7OaQ6eUx8oSHgWCKHj8Jg4
X-Gm-Gg: AY/fxX5aeD7N7YYfqy0WgK0zhq+K3Xu8kvqGZTTkthoy/EcJfV9urToy9aK0NKjR12D
	OMxu4jMGcJ/46ZyyCWCuMxUvCQfzmVLE9Zc4wIXUTxDKNgYnB7WhuRzP4oQmfns0w2wLNvrrGbO
	zS5tHvIiP3Ks4A/aebNZvXiQs3SqQNNWctp6+RF2VACc090mMTpHzim38wwczT/w9lexD0bBaok
	I743BbJda2D3ptIoJlMGwr6V9zdLa50oTRxPzUZtKyqRuAEv6XiVHVbEgEahUQmdvfBYsuR2CqG
	JehaA1X7aABST6+n2L/3fXfo3Fy/YPP7Uw22Qg4=
X-Google-Smtp-Source: AGHT+IG2uv1i3e9VAkX7WrpVZpEjcXmJcgLs40z5E6+u/p3r0x0uDL2AqAtu2qxiDLvSn4yhY/B10wpKS49o44BJQhw=
X-Received: by 2002:a05:6102:3ec6:b0:5db:ca19:f02f with SMTP id
 ada2fe7eead31-5ec74329ce6mr659777137.9.1767696668543; Tue, 06 Jan 2026
 02:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
In-Reply-To: <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 6 Jan 2026 13:50:57 +0300
X-Gm-Features: AQt7F2pteEDNo2W4ylDnO8TsfR4yxOikMZf8XxLHSY1WQzegoJEkL84ArTG5zIU
Message-ID: <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_025110_093602_CC1D0CF8 
X-CRM114-Status: UNSURE (   7.20  )
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

> If a user follows the current rules, they will not get a write which
> spans multiple extents and hence no -EINVAL. That is how it works for
> ext4, anyway.

What if he makes a sparse file by writing at random 64 kb aligned
offsets and then trying to overwrite 128 KB atomically? He'll still
get EINVAL as I understand.

