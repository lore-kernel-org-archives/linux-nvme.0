Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6F9EE57CA
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Dec 2025 00:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CM5j/yBW3dz04dNQsc1opNAD72v+zvaz2DyLEChJY6I=; b=lndtzPk8LXGikWsIL/sIOEfrtz
	I6jMwDQDaNeRz19l2bryalO9rIfpfqidGQDNQxm3b0kWTOattH1JKVIQh0Np02E3PoowhK+WQ9a7n
	86SzCj/6mORec7g8o+ckRrg5zTJ3Qa3KB2IZkjAOkrL+ZirkRbHLmUKfDse3rY89FXF5zdWtuqCpO
	pjRH+xT4mPb96gS2+QUEHD1K7vVa6cV+VJ0eTQ479973b5CVOLWprViB/DVnZ7FrKe3ctMUkwJgTM
	hDtVpj88l98XcMuxDo3wlTvQ0Bger1RaEIqpYZi4V14WpCj3GsxaSTqt+XA70Fe+t9tA6G7P2zYHX
	1mjU9lcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vajhO-00000005U21-1VMg;
	Wed, 31 Dec 2025 00:04:22 +0000
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vajhM-00000005U1M-05up
	for linux-nvme@lists.infradead.org;
	Wed, 31 Dec 2025 00:04:21 +0000
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-943d0cafe77so176994241.3
        for <linux-nvme@lists.infradead.org>; Tue, 30 Dec 2025 16:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767139458; x=1767744258; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CM5j/yBW3dz04dNQsc1opNAD72v+zvaz2DyLEChJY6I=;
        b=AqZR/BDSA/hn6RvdsQWI5OphApZShg38DDfmurfFdYL71mYHv4jyw5Lhmi9VC3pfvA
         w80joh08wkqlnPqci6UI9uRtozHSACP8am8MSOjVokO/Q7XNg/KaW5jqoESQPv68VotP
         uMhhJC+hGM6+rHFldEQ776NLunDQcTisj7t2pOSgcMIHyCfVnlcs+aI6Nr9x0VURm8hs
         QMZanRGM6l2/BsnTZUHcOg0Vjx0tER7MJvjnLpTe59etem6wbqy0w7iIH2QkqPLNG2NK
         5M8EALse14GbCq7a3I9eLwSrsq5Uyo3B4l+3ky5mSqPQxPhj6pPa9YCA8kisO55LV+6K
         xKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767139458; x=1767744258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM5j/yBW3dz04dNQsc1opNAD72v+zvaz2DyLEChJY6I=;
        b=kXx+sqcRRUpbbZnF85rhxjUZMpGToD/hEbEt7S2kXKBvRwSz4ai9NIfkeGxsrwH1ei
         cVvi7jW5j58mzUAhbzFm4scbklaghW7eEcnU1+8hJCYJ2n5BcUv4fwiDODFyZHjpbyOH
         PdWyxeQJ9gQFYibDtBPvHipRnlKqXLcfvnTiHYr3YZabfEjyXliE9R84kIAXiOElW43/
         gevuJ/ewFrYLSg53cfL+VvSiRQNZUapgBuBnFfixR0UaDkUC1jW/WsweKZRT2OOyaS/l
         ir1pP+8LzBNehoDTOVgTdbF7RnmL0a/EAoukT7nGrM1XlhBVejU4t+yEA2ItSH8GC95F
         CsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVueABsl6rvD5if26jg/zZNSUW9pkXM4knZZ25zSMkPGdb8QRgJakhDTnBxRyIQ3KnthBWv3ErtAzn@lists.infradead.org
X-Gm-Message-State: AOJu0YyJvLVdRMcmaiL0AgvPqhv9pEeRPNwhObR5Z9R/5fuU18OR4F6f
	Y9/gkiKtnnTuIt/dEQ/OZPc/5M/Skc4ACkqHrK2f9LzPaQPCyjx7ss1zkDSxPi+FwF+dWQPeNSY
	lBZsa127FWrmM185M7v0oYEvVoaXN2hiZk9bQqbK7RA==
X-Gm-Gg: AY/fxX44s2enUFuIz26KhO9dbVIo1ZlLnKpyEdffkkII1+JRme1AH2Uogb2G21/35rE
	v3UDUW0gll0qz4lIVszhU5BYx0HABAbjXPJVNJhMJQ9ZiCAEEJEFAP0EpP0GFjbOWAsDeCVfuag
	CwhUH++ipEwJyRV2XwQh6bJsQesWAQyYdC2cAFpSDFjUpmkYyNtiiKlfxL6+s2M1EocNNOFFlF1
	6WA0nMVOX379CyeucaokrseYF1stc28L91yjPdM0+L1F1x80b5Jpthqa8pSPy+7fvOPCJk=
X-Google-Smtp-Source: AGHT+IGdph9FBlqULPQzzt1hQjJXF965X5q3TVDSE275hNHYMgg2YH4ag57ksXSRgmHs2wHfwZy8vPNK+AaGGsm0YB8=
X-Received: by 2002:a05:6102:2b84:b0:5dd:89ad:1100 with SMTP id
 ada2fe7eead31-5eb1a60bdc4mr10342737137.6.1767139458142; Tue, 30 Dec 2025
 16:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-9-mkhalfella@purestorage.com> <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
In-Reply-To: <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 30 Dec 2025 16:04:05 -0800
X-Gm-Features: AQt7F2rupBfy2WapK2hJ-tVaiMJ-AJR-W0SDjy_HvVlQ73bOEUcqUZHQml-xKfA
Message-ID: <CAPpK+O0dmysf6HxQN68q-JzSm-YATXQ1ZUcz-D56-+4WE-Aj7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 08/14] nvme: Implement cross-controller reset recovery
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_160420_203643_7FAFEC0B 
X-CRM114-Status: GOOD (  20.94  )
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

> > +
> > +             if (!ret) {
> > +                     dev_info(ictrl->device, "CCR succeeded using %s\n",
> > +                              dev_name(sctrl->device));
> > +                     blk_put_queue(sctrl->admin_q);
> > +                     nvme_put_ctrl(sctrl);
> > +                     return 0;
> > +             }
> > +
> > +             /* Try another controller */
> > +             min_cntlid = sctrl->cntlid + 1;
>
> OK, I see why min_cntlid is used. That is very non-intuitive.
>
> I'm wandering if it will be simpler to take one-shot at ccr and
> if it fails fallback to crt. I mean, if the sctrl is alive, and it was
> unable
> to reset the ictrl in time, how would another ctrl do a better job here?
There are many different kinds of failures we are dealing with here
that result in a dropped connection (association).  It could be a problem
with the specific link, or it could be that the node of an HA pair in the
storage array went down.  In the case of a specific link problem, maybe
only one of the connections is down and any controller would work.
In the case of the node of an HA pair, roughly half of the connections
are going down, and there is a race between the controllers which
are detected down first.  There were some heuristics put into the
spec about deciding which controller to use, but that is more code
and a refinement that could come later (and they are still heuristics;
they may not be helpful).

Because CCR offers a significant win of shortening the recovery time
substantially, it is worth retrying on the other controllers. This time
affects when we can start retrying IO.  KATO is in seconds, and
NVMEoF should have the capability of doing a significant amount of
IOs in each of those seconds.

Besides, the alternative is just to wait.  Might as well be actively trying
to shorten that wait time.  Besides a small increase in code complexity,
is there a downside to doing so?

Sincerely,
Randy Jennings
the time.

