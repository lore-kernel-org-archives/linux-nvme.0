Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAE5C47BE2
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jan 2026 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ldNN7TPiitMUXj/K/meNw1Ywd+KTahnUn5Ex+h9BKEw=; b=EHygQeMjfbWXc7MOl5KSECq7wS
	Cp+DZKv0k05rsILAHWBJh41DQKW9+ETqXY6tgU2wqKP5r/lzqqGMTkLz0gVOtwYj6lzwBeKlZqQd8
	FYLSf4RemyclF20a2UcHAegs0KF4lyYSzwFUzbK1OOIja7PoESYS7Faj88j4ctihRGApJOXhqLW/1
	TkX2ATcEP9AtMRRFcvIId1Gprinixbz7AfdO+vO8jzK5VrhFcJEpXJLywHex6yGjRVHr+Ul/ugGKS
	MFLtkBZUSMTY/Nw2Cr1ZptNPVSJ/zAjg3RGzS2vwkH6oN6Rt6g0cpHmyzebpjIdwMYpVxe7l6PmCT
	B38j1XbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd4jB-0000000CpiU-2L60;
	Tue, 06 Jan 2026 10:55:53 +0000
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd4j9-0000000Cphx-00qd
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jan 2026 10:55:52 +0000
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-93f56a97064so235872241.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 02:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696949; x=1768301749; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldNN7TPiitMUXj/K/meNw1Ywd+KTahnUn5Ex+h9BKEw=;
        b=CPl8rxswhrIcImjBECBchUloFb7qSsitREu/dWrZ/xU83EAmjc3OY3kZposb3J9f54
         q9RXHReYZwsR3NNXM+/a0eDoXskEQgvWC3KuxpsYUOYdXbhmNR7HsfyH4O6MU76aRVkx
         Gap2HHbadkPxq9aA7OQO/6FOv8U1am0INgJ0rd06JZSYZ31pg7yv+CVtaZHJgm67k0M2
         gch+/8HOukJWpJ/9+E2JShgPoMXsfTDam3+aw0aheEKnsZEc12evBhilYGkEaWat64Vm
         ndnJ82zDFc4gLoFoeU6KTeZz1ZHOjnXgJz1GEdAXHzDSJudpA6msJxyAe67OnaksLZJy
         5isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696949; x=1768301749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldNN7TPiitMUXj/K/meNw1Ywd+KTahnUn5Ex+h9BKEw=;
        b=LOkFA6/7KLHmlH3T0Z5sNEt6R2weraJlNmEEbgUuMnEfKoBwDReHJUFZ5++ZY9pzsI
         Vllb5USRge4Z3r+QXW7qJEwdGkynnMnfzl13Uk66aLbKUaM2Wy8DgN3D8LFKc4ycTw4Q
         X63OH1bsBkfJDuG0BeVehd3eD1ZSMaPphd4J+9IKeOOclaRGS5yZcL/VFBbS+VDL3/Tu
         hDS/WlBhHrMx7EsHhZ9YaHpP+XVIowb6MiQO2eYcg6jPRm1OXCkAhjh3QpsquqErKjei
         MoVt6oZ6dRIlN1Eh7161azCNcadHOBA5BuZgHphrTDEA4BMttOJbXl+SSUIL5Gr3jr36
         RxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHP8pcvABtsq/27crALZfUNaE8r7lRUYTcKlYyEZIJOSbp+aUuFXwa17EqGhT0cG2+0Xga4ip5QkL8@lists.infradead.org
X-Gm-Message-State: AOJu0YzqPMMEQ0DE1NufIgdTd3mw5QvZUoliCID8YOITlAJS7N0l0UFU
	invkFx7kwmSPcs7/sAq3dwI5w3moigDuXaJZIhBqdP26wi4FiquoeviWBgdCzbJHKxDQDF/gC8A
	Gc6CAyVQGdk/UrksouZngKZTrCAJRRu0=
X-Gm-Gg: AY/fxX4aTchlBaFlTIzgUn9Q9KDBQ/T9UWGy05DNn8KlNxedvIR4cmv3oYk2hMoXnA+
	+iUw+5KY65bRJWdoky9VhpvVcZRzGiiIW7kexgXngP6dBnd+5OA/+KeBgBkZGsUOAQOGy6iPgpD
	5uOo2TBdYxtOp3f4QqjG0BISIr5TNm4EBTDT0dj5q8zd9AdyOPazQxgfBiQZZPze134wczKEH0y
	zgFJVE+r/z/MRa7zJlzAj4UwyNV72iA98JH7yKUZ3uWs0UVoFiGp0IFA4zrJTCO7iorVYl2gnGW
	gYjjHf0h5HIGORw2iM35FX0f3QvJ
X-Google-Smtp-Source: AGHT+IGFoH9Y84rpaN1l+X8UZbyzkaeW4wOIDyKYcl6PbmM/WLSSLClvmnVEPUgHWsmN62CLL5qGP1Eub91pxNSTXvo=
X-Received: by 2002:a05:6102:e11:b0:5db:dd12:3d16 with SMTP id
 ada2fe7eead31-5ec742e6215mr607418137.6.1767696949542; Tue, 06 Jan 2026
 02:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqquxezUTTQJyo+dpbXEUdg7iS6GnQbCs+ve_i-Qp5MbiA@mail.gmail.com>
In-Reply-To: <CAPqjcqquxezUTTQJyo+dpbXEUdg7iS6GnQbCs+ve_i-Qp5MbiA@mail.gmail.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 6 Jan 2026 13:55:38 +0300
X-Gm-Features: AQt7F2ovahLl9KL2Xz_JUwgXquri70znksxVq8JGoQtF9ppZ5HGcl0niTpSm_SU
Message-ID: <CAPqjcqpos-RE5BF8To0BXkO6BtL2oNADTEa1qUzpGUGoNQ6KiA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_025551_045997_7722B958 
X-CRM114-Status: UNSURE (   5.51  )
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

>> We don't support NABO != 0
> Also, what do you mean by that? I look here and I see that the boundary is checked by the NVMe driver

Sorry, never mind about this message, I confused NABO and NABSPF of
course. And boundaries don't matter a lot anyway, I'm not aware of
real-life devices with boundaries.

