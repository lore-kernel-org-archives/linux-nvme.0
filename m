Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFD606A327
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BtwSzPK6;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afYwXeP8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sKkSM8RCTy1jtZRnmZu7bwj55ziVpzH7N5ae5Wrd+yo=; b=BtwSzPK6EiD+cOFAr9zgjIWsz1
	yrcEzZnY7TTzBbKPBtjsPmMKAC5vpNObLpDfn/gYiUBsemY2kY9IdXFVWurxcRnM0IEK/CavFuJZH
	5VCmKFwt8qrBFbc1i2oe6az0daJtxE8wvlCuEuWL1GFgY4lVD13xzlHwPdEfketiWPwkq5PfmucJn
	eWocb/2RjSIy/Qpo70anUnTCgifNdeqBgm7CH/3LTH9hpVf0hDpPw2psTNKcGB/B02MN3NrdeobTE
	jJGUReO0xVn1IUln6voK2tFspqc+NSaMB9X6SRzxc08Z15fNaqApsfFEU7Wgr/1IkCELe+9mIY0jU
	1/6ztAnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS8xL-0000000Fa88-2sIq;
	Sat, 14 Nov 2026 08:17:51 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS8xJ-0000000Fa7m-21EO
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 08:17:50 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-36e795af1d4so1261089eec.1
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 00:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644268; x=1795249068; darn=lists.infradead.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sKkSM8RCTy1jtZRnmZu7bwj55ziVpzH7N5ae5Wrd+yo=;
        b=afYwXeP8BlT7sUbKMOSKTXgtlix8P3K1F1bvamHJXNkdRfncD27ztmEk3bPZBk9Nv4
         UmkvyVygGj+mVL6elR5U/dywPGkAl+oyWeGdnNhAU7wt3/49rwTvgn9LoB4a0CMhDUbU
         qB0H4Koljj6YwCyHs+FGu+hriZe7gX5JwmUlqahN1+hxIBLl7+ijrnsss0F/Smdk0Gc4
         Wp9/jDIPdcYwwIPTBYn2UABernoW1KyrGDDgemAJypjv1D7LoEYaHOuCRWw2ym1sCbEv
         CX6EXG+QDTyvAbSS5JzBUxpIgaBS92VPsnkqdxaDZf72ZQkUZIGRwsxzQgyCSNgT8g+H
         OBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644268; x=1795249068;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKkSM8RCTy1jtZRnmZu7bwj55ziVpzH7N5ae5Wrd+yo=;
        b=zuuMVm39wLa0Evf5hDGvivrcxb37/KIzbcHfshw7NvsrY2jG3sgP2UZ+cihCKTaZnx
         QaES/qWjs/jnpRtQiW6XtIajD1YzoBNHaa7LkgMyroCcrSWiZ+yCYj2GdzgVNpPqtheO
         aF2dEENtmYW/rjZASRZ7WTIPKx0YgAQlLN+cqVLY09mpco/B4K4a5E125z3WElSYOG4k
         fz6t7e9OLHRvrvuRtuNX7uUIVD7kZAbYayRjajGEBvSeN7zhKHxOLqazMWxhKx4gIx5c
         jZsNiwTxCZRkotUmycihNIu+g6Y/hmrXx6j32ECuHlWRqKzo8R5EY0LUGROIxxPqodGh
         w+IQ==
X-Forwarded-Encrypted: i=1; AL+hErGm1U+cof33+/uCCGjSImDSHGuEOUUz7gKeIYiNGARWKltuEgtMR7tfCGCP32QmZQ95ac9gXHp4JTxt@lists.infradead.org
X-Gm-Message-State: APuU4Z9yfR5u1uoNhtSmGkbICZ9dwIipYrTv00sIJnJ947LkJE89TZqz
	kmRl8oIw/8LNi5IyoqVzzMQmEm37fiTFnVMYRf+oeBkZDvR7MPI1b2EM8rfmgAcm57o=
X-Gm-Gg: AYBFou3uY453r7/PO5BMgo+lH/rBTojo3wC8X40GMCeX7f3BsV+j06kSutcsSesCPrc
	y4/GG8F69FqoFjlxWyH7cJEoPc7JOlsjytKlUV26jwM1cKzqeXA+bugdU4a9CpjX6ImMO7NIYcq
	OHvuP1LcYlJXmZNgswSeKTQ0wH28mvwtVSjA7COT3CD8jD2N49WOa8NJje9DuKxJUk9kBZamWr6
	u3t4W0TgirB/xOY61zf17xhMC0pRdL0aRFd0NMn/C+ci4K6EyatFM2epkHZ9V1rV4QkGxIGESQg
	9GtHiW4zpl0d/8hvITynj/0Rgo5OW3OmkpSl/Bo+VH2C199HODHxxLWVTiFcamKl7fIT1fm0t6e
	NOuylJNFcJMeqp6uJs+DG3u7jXGXo+OLKByOYv6hIvCYwHKaL5OHAxzDaR+nRaDiPdtYXiVnTxy
	n+INWv3jM+8KILhErSslZdnUyA5nqWp81pv6bv8mRzyXKon96mMIyIWe03eRK76njAktmYQfOAx
	egmb3ihSjDn5JnvZyrLaPFzK+hQ3Eyk/K9Oj5OyJOegt5zG7BHhmS8qeIWLt9K4nXLu5T6ahCaP
	vFX8F85CPZeWd3XdTWjHneDBzCkzB6PeL6zRJxhe3GHqv++lgvdob/peKhnDNc+d7I71d7mSQVJ
	44hWXIqj4+r9xLG4CfoFHxsMC
X-Received: by 2002:a05:7301:f03:b0:373:64ef:5dfe with SMTP id 5a478bee46e88-37966096b9cmr4839706eec.8.1794644267983;
        Sat, 14 Nov 2026 00:17:47 -0800 (PST)
Received: from [127.0.1.1] ([2602:feda:30:cafe:ec49:38a8:0:1866])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955ffcbc9sm21209226eec.18.2026.11.14.00.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:17:47 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: Re: Question: NVMe AER completion delivery during controller removal
Date: Sat, 14 Nov 2026 16:17:42 +0800
Message-ID: <179464426299.530664.11667871087435289393@gmail.com>
In-Reply-To: <20261109193223.GB765534-mkhalfella@purestorage.com>
References: <CAGTEBTa9dGn8TjKxRPsfeCFiRYAt-cGMAp-XSLBS86SHB6FJ_A@mail.gmail.com>
 <20261109190854.GA765534-mkhalfella@purestorage.com>
 <20261109193223.GB765534-mkhalfella@purestorage.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_001749_542003_0C344082 
X-CRM114-Status: UNSURE (   8.61  )
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

Hi Mohamed,

Thanks for suggesting the PCI-side flush. I tested it against the previously =
submitted NVMe fix using three builds based on the same v7.4-rc1 configuratio=
n.

With the unmodified kernel, the injected AEN triggered async_event_work after=
 the controller had been freed, resulting in a KASAN use-after-free.

With your proposed flush_work() in nvme_remove(), the worker completed before=
 the controller was freed, and KASAN reported no use-after-free.

With the existing fix, which adds cancel_work_sync(&ctrl->async_event_work) i=
n nvme_uninit_ctrl(), two runs with AEN injection completed without a post-fr=
ee worker execution or KASAN report.

I also instrumented queue_work_on() in the last configuration. The trace show=
ed a call for the controller's async event work at the AEN completion, rather=
 than just an entry into nvme_complete_async_event().

These results suggest that the existing fix covers the late-completion window=
 you identified. Keith has already applied that fix to nvme-7.4 as commit 9b6=
57c565984, so I don't think a separate PCI-side flush is needed for this case.

The test still uses an out-of-specification BAR0 doorbell injection. It demon=
strates the software lifetime race under this synthetic trigger, but does not=
 establish reachability with a specification-compliant controller.

Thanks again for your help.

Yaohan

