Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21F1C021B3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L3GfVBZPNIG5qDKUks2BtPgtADXfzW3N1roYhgf4YM0=; b=xP/gDMKKtOD7abHyvITazL2TpX
	4KKcZ51u0jswaN1iO/Ot4iZJCLGPR/97qy8a/aTWlI7xVL/eUFNfY5Cu0qFYYvJbyT04dHmMlJx/i
	Sd3gEEiETmh/3moUuSKojGhFvoqaas6U2H2ObQvrUAZtiZsSuBd3BXtr+6nqqI6y7PoD56Ed0fSiE
	of+hkuwt+U1RvgAZXxY5HHeIkhrKdcy2Yyc2GFFSNVfoBKqFjUKGMMyvYBSlPKXGqTvCeEEVDObzc
	e4gJMh2QM2cHdJynwWShNWM+ot9kCO/JYGf0Mr4TTVKvZyg7vzVDlXHXYEuUvIPa7WGlmW1gvc4Md
	OTVMQeGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlWG8-00000006GCh-0Z3P;
	Fri, 21 Feb 2025 16:52:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlWFo-00000006G7X-1P3X
	for linux-nvme@bombadil.infradead.org;
	Fri, 21 Feb 2025 16:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=L3GfVBZPNIG5qDKUks2BtPgtADXfzW3N1roYhgf4YM0=; b=SHncIMxaQB/516SowY9yfjYZRj
	HgqllJoRYSryLbewq3SDisoB92hn+carizcChIpbZCsl1KGTFUh70j5cLgkUlIh9+ovMjwlg6Dg3M
	O1ajMPlLYG7TMrpFtHYucgrn2J1Tj0ge0yCmDshaSAn3U49QMjkeuNH+S7akC6H+8OlyjfIaMxxsl
	Iy9FGQ9aHwqmMmJ/VuqTIA2Gj/FXdZYpW0BK7u88XmZs3W2rQW/3u3JRyw/4RU95E38Eo5DNn6Mvh
	ZviQzfVR+5/6X4gsdQ1+NBno1Mx77kPrk021ad8jffGUMV5U4DxFmqEKiKMaQjQK8wAsng3xjro5s
	3nfKmrSA==;
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlWFl-00000002gue-13I0
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 16:51:55 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so3832210a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Feb 2025 08:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740156710; x=1740761510; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3GfVBZPNIG5qDKUks2BtPgtADXfzW3N1roYhgf4YM0=;
        b=N4OqAqKjOXVbFpK26za6DGUVVCsnfD64RhYV6oZfr5owt0w3Q68bDl0G3dOeRfaOJm
         k3AYwFkC55iKYmFOeE8iQwTu51NFcaM4BOIUWb3NFDqIdIuxELzXZUWSJ2nYmGxmDuKA
         TdrpzvbaPyBBuFis2Gjd9+O5AaDF7NHhKwTdW4zqk9AUwc/hbGjCMbQ8/1g+1pqU0bDk
         FSJEei6uInZe9BLi3DQOqeC/jYXwrPOx8unHb4Abpe87/WlYD9BvtJEkCeTlweRtZnEy
         6U6R4j4uk1edd+wKbnHzMdBfSisYv6WCFuMKgy7HAJBl4OC0opN4qxGjtPKGKJFPGUPh
         ys7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156710; x=1740761510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3GfVBZPNIG5qDKUks2BtPgtADXfzW3N1roYhgf4YM0=;
        b=pW8cqOcFnsuOl+ieyYIYgr1XtZC7XMJw9cqGSGf+Qq+4xtiNPujCGDR6bNgzVoqFrs
         hfE+1lyyUmCEeUMF50q8VD7QcCdj0haSDJ5ElMIvYRUDHkW6i8GtJPmIu1/S+O8I2li6
         oTWRVbt2fUGEr3AbPYylkU0VB+cNx3U5hzL9e9lqM5QlR9p8AQJftZdprw89trNSiaX0
         yVaXkXia0MDLQWYATY8KzkJ7lW00xK5ctsneophSqyXCY9sWgW4nHyPatpm5TGPVHQK4
         f6GT4Qcjtyz2D30gs5iE8gXAbCIqxoNsqjsF+Dmkn6eSzlLS9pKiAYMGMUskIfIwa1ek
         XW1g==
X-Forwarded-Encrypted: i=1; AJvYcCWiOiXkUGju1lbM5Md9W/uVKIKOi93e0asv7tf/ME3TPpbx1duXDNCPdd3orTKl8FTAAXI/2vPD0oWq@lists.infradead.org
X-Gm-Message-State: AOJu0YwXiPruHqpGllQk+gRacUspxUFTzPWnwqbffTsrpowIiQWqTeFf
	2k6MlN++8pfc3oOuHW6Ac5F8YKC2VoPTcyjsAXFMh1bn2ybv2uv6cDH9W+TzuK+ajOfLfbk4Iv2
	kPX9yS5kB2y7Mjd8oRBjK6oweYms=
X-Gm-Gg: ASbGncsTcVl+KuEUj3TDWiX7Ua8X9QDiEhH8s3HgEIUpIoSxfIqJXMmmeB6u/4qnQkc
	XrYlrJaPD1EmdjspiFdpXEPGdRqgX1ydPmz/0t6hZYFZn8ZQ/nelvTv2vqXBb3HBkBtRJxws4Yj
	YyYIRLKQ==
X-Google-Smtp-Source: AGHT+IH9RKxj/U5zpI3JA7hDcdGZ6v0ycbSRxZnemxlkZtExRwiejOddMUWgeNEe0/MCt6WbW7V94i7UPAID+ZQRr5A=
X-Received: by 2002:a05:6402:5246:b0:5de:dc08:9cc5 with SMTP id
 4fb4d7f45d1cf-5e0b70ccd99mr3708605a12.7.1740156710272; Fri, 21 Feb 2025
 08:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz> <Z7iqJtCjHKfo8Kho@kbusch-mbp>
In-Reply-To: <Z7iqJtCjHKfo8Kho@kbusch-mbp>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 21 Feb 2025 17:51:37 +0100
X-Gm-Features: AWEUYZnfVYIJxHkGF1zZWtSz2bHpYaGIafeC21mOa_0SYKWj9c3lZDabKwAoH5U
Message-ID: <CAGudoHGF8ULGPEE5E6ZCTcVnm3qjY0BfT2DmBjKohW_rDK0JSw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()
To: Keith Busch <kbusch@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>, 
	linux-nvme@lists.infradead.org, leitao@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_165153_444304_72BC358B 
X-CRM114-Status: GOOD (  15.84  )
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

On Fri, Feb 21, 2025 at 5:30=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
> This patch appears to be triggering a new warning in certain conditions
> when tearing down an nvme namespace's block device. Stack trace is at
> the end.
>
> The warning indicates that this shouldn't be called from a
> WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> and tearing down block devices, so this is a memory reclaim use AIUI.
> I'm a bit confused why we can't tear down a disk from within a memory
> reclaim workqueue. Is the recommended solution to simply remove the WQ
> flag when creating the workqueue?
>

This ends up calling into bioset_exit -> bio_put_slab -> kmem_cache_destroy

Sizes of the bio- slabs are off the beaten path, so it may be they
make sense to exist.

With the assumption that caches should be there, this can instead
invoke kmem_cache_destroy from a queue where it is safe to do it. This
is not supposed to be a frequent operation.
--=20
Mateusz Guzik <mjguzik gmail.com>

