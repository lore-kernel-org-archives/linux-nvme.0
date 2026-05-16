Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCEFCD343F
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 00:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N3vbb51fhDbfK1s/JbPhTMGctN0UGzzg53qTqJlT8Jg=; b=AovcfSXIdjpFu91uZ3HjHrqkLg
	IyFNqnmjLLSWqCmKpA6qmnvGF4NMk4sdqxL6o8FC5ObV/iSRUXCGRsMW+Fhh9uIoRPHvYsiHhz2H6
	u3XkWydWEDRL93YBLjAh7ahl67LB3DS+QDKj0AD/5IivgBOvnqCoIMSpl+T/+6XNDUHCFVH3zHZIw
	0dJW66bKldQKUscZa9QgmY/0/7x/+i3o+/EUMEdamM42aV+/BiksCX8F9puwcnip1hI3tDvrWM8NS
	bwSFE+nfjnxyaSjzH0+prnKmqFGQdE1Jaj11w2IhvZ1xdwqCi7Ax0/Mx0yj9QDfyjnrb4T1ZMr60T
	udaJ6nQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO30A-00000009oLB-10BS;
	Sat, 16 May 2026 00:35:34 +0000
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO307-00000009oKe-3JkB
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 00:35:32 +0000
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-631b313e3d0so106581137.3
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 17:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778891730; cv=none;
        d=google.com; s=arc-20240605;
        b=dxUVnKZ5c6FWjzrxUp8aFOSz5WDx4o4AY44nPhqdVJFRTp1QZVwRwYNF3Aew3GBGvD
         8LlE7+qol0L/O3bJLM6wdG5tEe0Ns4fIKXyq7HXCw0KRZn10vUfaQctGp5NnkbkkgOw6
         CQeDzBCYakKTIAWm1ZLZ3VId4N30owxxyLccjGJ+ZDnGjER8RIQu0bsvXXVJZcLKBi9y
         Wapr33RMKYJerUGoFiB2ACTT03pK8GjX1C0f4CFhKQPdj2A8KLYS5XatPgBCGLFmLu8L
         wcyYVTghvXHAX85y3lSjd5AGbvk+sEDpIIkFe6zaAJxmIwmBeKWLTh7/CoL8p0qQAXOU
         B3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N3vbb51fhDbfK1s/JbPhTMGctN0UGzzg53qTqJlT8Jg=;
        fh=zXPy0+RpajdvA+USrD/DH19KjJXMWNzILMlcuKRNVhc=;
        b=E+ea3j+6ghWpOwkylAWW0GWiUngwycDwcDn3GLp6/SBhm+iQmZ8NTr+i75beBGM6A7
         pyPLbgnkIVQCB8sKLpPxkZNG8WHmhlnLs+620HygAB7Cp/5SFaOLccXAGrKIji6JXS4F
         hgostrr6Vv/jnYdEt+gRSt7aoZ/O5vcvueK4JFfF5+paEbCdzk0zhwjYW+ANcHx0/pwm
         V6Zdp6mQNu9U7nMa0J9jeTe6Qe9NPnaecG6CWQd57Dwq/z0R93eSlDbTA3F0NUKLWA1V
         obzbsGd2+bv7RBCAMZJZiHzi1yaOqKRSlTHtTd6otlRnYETdDe9L30fDYomG4MH1+b8B
         SGDA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778891730; x=1779496530; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3vbb51fhDbfK1s/JbPhTMGctN0UGzzg53qTqJlT8Jg=;
        b=WlV7R1SznTF1s56Gx2DkeEi/y54eIetVdKANc7bpbsDWWn+Sids+yHoWCi8xRxh8gZ
         G9VwwugU86BIt93G5fzAMVhYzuEb5FZi0Gq1FElTZ5i6lROS5lS9x0/ftttMYQseqAJk
         y0Rt9VYKhLFbOfckpbgIJ0e0lu4dbVGKNjfS0zMOZivronWd9ikuHG506LIbflXXel0A
         rcezZ/t+ElwsB5dwiqpiAuqonwPotR4/vCU5uRDtAs+0c11WiHHrFqu2wtqd80K/zsgn
         SDC3vk8ORSaOIyxbDhfLu3T9xKHXS4ekvjV5Lzsbf4SLXyejLeyEQzi3s85FX6wJfv71
         NJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778891730; x=1779496530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3vbb51fhDbfK1s/JbPhTMGctN0UGzzg53qTqJlT8Jg=;
        b=pWBpQPxHKDZTm5o7PxhYHFl9r68a1W+UcNlFAycDen5hAedG4y9WXATf5Rvhf8UurK
         KZEL6MbKG11HbKBhejEhuRHsWRmW6NFo+n+eC16z1hl2qoOjpt7Abmw5ZZ8UO1zhPa5K
         EX9kXR96muMFvIaXXrWU8McEUcriw/j3Yy3SSRNu9uCDB0XJI4XBTee/E8Vx1vcZKmRN
         OhppP+edRHHCvY9bD5TDIBsguLoUDU9qbWznS50N3QT5XDM4NHOAsdHBeF+Y8H5taOBn
         H7OLCZIZu4PSSty8twAnjNm6jzly1vs8lXYZ+qWXtm1VA5TLq7HSee4wGqnCvLaSoAzS
         pdaw==
X-Forwarded-Encrypted: i=1; AFNElJ/PcICLIelhMg+pq2abrKPnZaCB8bDPNm2fpxpdokutt+Zj5WY48lCA7369hmkU6cVPw6oXDQFSYkrI@lists.infradead.org
X-Gm-Message-State: AOJu0YykBZK3/W8sT2NsJOBBOq/H5dBoAM72n/UPrnmfZZjpfhFVmke3
	7KC+8V6X3/koyQeodmsarE2QLyT/BRS+yxf1NRLuFrO9qxWfVN214wCQ6Ik0DQE3PvL1ZySiE6x
	rHJ0netQ0IQezjlGKsDS00fLZ40kA0U62CjVFoB5T3A==
X-Gm-Gg: Acq92OEdxlEqzudW5KUAjzchTDjyh/iTm5wh0Q9mKWQzRSjREb/HRo8zbgwKVsnlWyo
	S/uA+W+Gae+XFyrMLduLjbuRNcahuCXH5xI7vP6uUPFyygklikSlW7+yBFxtg8GUNoSc0Si6YXF
	aJkbBdbv9bbu/y7l37IlMsK37MWaUPJuSUg2TgjQ4pioJ0aZTQwPUGpT5+/L1jA1ajXUBvcTi+k
	ur7PTDrVo1Zp6ejkJdZ1GW//IKY/yw41WGI+HxLHLoi5F6UM1UA0Vxy6cmr1wbN6JaN69g94Ya4
	K/coC0Te7C/LDD3oO1UkiD+xC+3V/2YafKnJQXGFbHVXo4K0GPoSL59ClxYl/ZE1V9Ro
X-Received: by 2002:a05:6102:548c:b0:607:4fe2:a644 with SMTP id
 ada2fe7eead31-63a3c7ff78amr3835107137.6.1778891730458; Fri, 15 May 2026
 17:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-16-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-16-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 15 May 2026 17:35:18 -0700
X-Gm-Features: AVHnY4LxkEDJ_A1_sS49y7CmTd5fkr-cKjiwfRj977eBgagfhhBy54oI6NPyTIE
Message-ID: <CAPpK+O17X-0a-st6KxmMmdAdMQ6xZEk6hW0HmsacASM-DEWF9Q@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] nvme-fc: Do not cancel requests in io taget
 before it is initialized
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_173531_841268_205E47EA 
X-CRM114-Status: UNSURE (   8.80  )
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

On Fri, Mar 27, 2026 at 5:46=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> A new nvme-fc controller in CONNECTING state sees admin request timeout
> schedules ctrl->ioerr_work to abort inflight requests. This ends up
> calling __nvme_fc_abort_outstanding_ios() which aborts requests in both
> admin and io tagsets. In case fc_ctrl->tag_set was not initialized we
> see the warning below. This is because ctrl.queue_count is initialized
> early in nvme_fc_alloc_ctrl().

> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Signed-off-by: James Smart <jsmart833426@gmail.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

