Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B8AC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 03:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tb8rzvIsMJ6RJjQF5wQOi3mbfxQmYnq5SEFybG+B22I=; b=dSXaz+4zZALnhpvUHtMqfHvjq0
	mr4/FzosDCbjnLBQrOQXE5AT7II9RfhTTgqIGsuVl6oYBruCS87RHKkHrk5uHk859O+ndEjmoFPBN
	fiiVZ1wMPqyUnV2Ct51WiSGIr8O/DiaheBf4XO+KEubXVAGK9OWsmTVOQgM/dL2Tc0PXXftoaa7fV
	9vhgxnSTsyFqXtumgHo38aXXfetU6gwifM1YLS7mbaDW/gwMW9CM+cDAmpBMVxIuu0HiLKJEYrVBB
	1j4YlaOuvgzXFW5hT9T7OvwLKDw3dM/vClnQLdo+6XlZV3taYFktrljxgTO1oApO/rUOsfE/k5FN8
	8kfCVaMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1welhW-00000000aXH-0Eoj;
	Wed, 01 Jul 2026 03:33:26 +0000
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1welhS-00000000aWx-25ce
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 03:33:23 +0000
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-664b05d408bso119694d50.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2026 20:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782876801; cv=none;
        d=google.com; s=arc-20260327;
        b=FFOukB1NheWiQDcwC01LTLEbbe9tGOuKAGy5b0kxjDUHfFWZMW07itiiyobwmoQx9T
         EwFPwAZMVqLoSliydGzxjESUsBm6aewY6OBCVhEL743WbMpeizGn7zWB5Idom1EoV3lF
         l5vBPkmE93m4mI1vn8ymc0Ful8NxQK/C6CLz4Zehy35gvAxKicYSu8ytQc8EXRVPnSPJ
         OdbDaptWEqVn01sKsmZBCoIFaYdF+beKgguZJvK8hbF5nCgbNs5j0Bb6cMZyyLycSb+8
         3w31aJlsi2B4sX6gTr3pKbTJAW6Pj1dDrObn+7+4PpsLuPk5M5BzQRasktXbSrM62KcX
         h/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tb8rzvIsMJ6RJjQF5wQOi3mbfxQmYnq5SEFybG+B22I=;
        fh=SmxU9/4N1doNw8KjZo64J+aqVGiSoF2b0YildNXOnCQ=;
        b=bsykRyuuj2s4i+TY4jaFhxntBw8F+H8hh0xWTtCHu+Jj2awJ8pvfwUcGoe6JQvlZaD
         xbDHg57GutFbTCy+o03jrxQAI51jjM9AwVvKBWZOchIuJXJz4qi76vr8VPu8muOuZcpy
         4wfM+2acE5SEaFNWJi4YBhKIcxM8egihNZNmez6C9zSdFA1qP3tgPJ9NNUvVOe2kxb6q
         Y4deLkw/ol3G0bJ1lLG89i0N2q/SIZcb7PJYP0W53gmh4WEhQJtVmasBP2x97+Rbg/0I
         4LjuGb/32slbYTri2MVqdA5DD2eXq1O/EBfW7wLOwUwyH+sQRcGQetSHn0SaEvBjbrqt
         9sWA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782876801; x=1783481601; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb8rzvIsMJ6RJjQF5wQOi3mbfxQmYnq5SEFybG+B22I=;
        b=o8SS+bk1Eb/9o//vJ1Ywgx77Z6bmsLjuxeJFZeHRpsRdvg0gwFIGIoyiK/a94N7Vqp
         UmUIS1VhIaUDooPxCm7YRQub0HLq4vyOiCw9zW/5HDbK4aXWyFlIUFMpypS0ZFRLBoAc
         96pU7rlR2gqjJejdydpEjgyaL7aSxP1d97po1Uka+hlRnNUzzsDqhzIs4F3anP9j1E0I
         eoCp0AGLEPMHWzWseED/o4t0CnfzNO/DB9yQTPOkEqgjisznGFiYWhzd4+OC0wyBk3o2
         gyNHvjA6KUjsVR1rQOgJrawWeQRAfjRZYpFcGumIyBFxUUNScIBDL0e1TcOzdDKbQc/9
         2KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782876801; x=1783481601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tb8rzvIsMJ6RJjQF5wQOi3mbfxQmYnq5SEFybG+B22I=;
        b=B4lC2Df7rUcWVmaZrB1x9E5q3ufIJhCbc7yXBGNlHe5bQufp4w1QIEbYYrCiqUAmgt
         dT7L6C9H0Eiy3akgvbs4SRI/0O2Putzu+KFcn2XG8FhSdHmYm+lO6Cxv4674JRG1/87J
         iL7GYXhvkVnadtJhKwFkuf99MrKUdevtJv7ixQDq8ThgVKU2fukwyI+mRSH6H0FU+T+L
         uIxCB5YhCd9G+O4YpyMMZRRbbvREabl9aVc7WgQ85QTsUKDbLdwSsrMnm420Ah9gyxT0
         y30RYMDroQHVj8Tq1yV8eYQn+nSEx5QpYtitronWBYlgKNUmmOmqDjc1SaEXG0vPHRFS
         UPLg==
X-Forwarded-Encrypted: i=1; AHgh+Rr11IRMqGXjw8a0JhKP+TnrLFPoryqbw1LwTFyTAQkoajIEG8dl4rsMc+T4qhLJFxaEvR4U/PPeq4JS@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5W2UN34xPpwOyZOdUT2fk9+wYDOSlBk6jwNFTos2+TVTf3nfD
	CXaDV+FVBwO8RgIC9+vEESf232SplYXC+N/boMLwRxrV72AgZDLGdVFzCVqM311UciJ4ReTTX76
	//LH2lPfoJxQgVwxMs2fNGabCpYcREOV9q57lqgk=
X-Gm-Gg: AfdE7cmpaiMX+/W41i9oK414jE7JDPIDj5V157LmrWFSxRxrIKXul+hX5mrR/V+7LlS
	V+bDYUNpnSBKjFBNKomD5n0nSGucXUihXHUPa10hhUtj1rNJRojmOJlCL4jtw9sRSS6oD0/BENK
	UwptopKMCKOwlgvwfagahxBb93UZK4zRdKF7egHkZg+Ft2NDfh+xGhcCYBcFYfrFNXieRxssGGb
	Wcq1CuYXBSN6A8ojs0F7+MazGEeCGjyg/cA/yNVNPL0+VuBGVykPX9qqxl/mNaQeJS3/eA8xjfW
	RQSewAMAbA==
X-Received: by 2002:a05:690c:3603:b0:80c:85b6:764e with SMTP id
 00721157ae682-810daf0fcf9mr62423127b3.67.1782876800749; Tue, 30 Jun 2026
 20:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260623002329.3880334-1-zzzccc427@gmail.com> <20260626070324.GA11524@lst.de>
In-Reply-To: <20260626070324.GA11524@lst.de>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 1 Jul 2026 11:33:08 +0800
X-Gm-Features: AVVi8CeIZdBoJqb7Bqm6NCFjaCbFbmYMwSFK80vYiCrj4EvCz25feESYRTMSacc
Message-ID: <CAFRLqsUdFQCpXHmcL4jSj+cViwm=hdaOP0H+btJYrV-9BbLOMw@mail.gmail.com>
Subject: Re: [PATCH v3] nvme-rdma: pin device wrapper in remove_one
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Steve Wise <larrystevenwise@gmail.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_203322_652378_C2D3B735 
X-CRM114-Status: UNSURE (   8.48  )
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

Hi, Christoph

>
> What is the wrapper that the subject talks about?

I meant struct nvme_rdma_device, the nvme-rdma object on device_list
that wraps the ib_device pointer and carries the kref.

Sorry that "device wrapper" is vague for the subject.  I'll respin with
a clearer subject, e.g.

  nvme-rdma: hold nvme_rdma_device reference in remove_one

and use struct nvme_rdma_device explicitly in the changelog.

Best regards,
Cen Zhang

