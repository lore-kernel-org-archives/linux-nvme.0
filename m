Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F99FD9E31
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 03:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EstLyzavajxQSjr+mlq0lPsb/dLDgYfeCgFO9w4/7Vo=; b=kG1sLRhT+PxklzWBIfVV/+NQXc
	r+0x6nVUTCnE5zvxIQvbghME6MMO1YeSfnJXLx99zE1CidzoC2BEZP6BHBejde2LGiUa/1IjV9F0z
	AeJX1/4PJhdiX4YQYaX4MMuvjxVWQPvGrz8IAwuFfQ9TIAuLHP391Ce8GE/h1Nv1TrFpraFd3kRiC
	bX3X8hHi1Q/pEuzglml8FOQwzyd/9XB5sxZPG1HTugbfluXs1ZB8UKs/gFfYQhJuVrhPz418+blN5
	l4i9j37INQfwrnaWvFcgnxqkoq2cxf7LlxVjHNuCMnuIBO07rfiGAuUvVyj3mHm4BrXOzl9YJgwkT
	IntxUDFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvoAQ-00000007Z2F-00kL;
	Fri, 27 Feb 2026 03:05:26 +0000
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvoAN-00000007Z1s-1dXC
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 03:05:24 +0000
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-94dddb3c3f0so455972241.2
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 19:05:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772161522; cv=none;
        d=google.com; s=arc-20240605;
        b=ZuBGNb9sbpoqZb3dPRjXZFJhpVVyi35WgIjkoLlD3sa0tyDtEBdnQDjBg2kR9OxTPU
         43aLjYrFeI55kNJFWl5aWtgtygoN+iA79cvGEhjvZiiDQURzLDFndTOSS/sEfkThXbgm
         9YsvGQljt3+YDXJgR40icVmNfx9BNXoDz5wPwa4u9Zz6WffG6Vwe3X1xwf2YDA/vVszK
         7dyx9o9BInY7bEuJRebjj1fK+McyXuuJyoyLE4xkDmqqx2pCaLzMHXchs7Hx/8kxUB+B
         Sgg7bSq/CgBQdleK+ryAAtu4Q2NSHmApzy4WWrl1ZeqYc/x2JMbJpUNRMy1GYgALSW+Q
         IHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EstLyzavajxQSjr+mlq0lPsb/dLDgYfeCgFO9w4/7Vo=;
        fh=xilbe8FQfWClx2cAdIlp5BAyx8PK2yWF1ll1x5g1vPE=;
        b=JY/mLPoQYMLtejBmZ0J+Zinns1TGNqpy8W7q8tUqkMRG536bK1AagvUKyHeUt8EwML
         5ppAmMCDAF5Ht/0j3gd7pjKCwGNB5ELaYlv4uGWj3f3L/QitYm2WjKkiMEzmv5Amr417
         KZ7kkuDG6vwtF7w0cuUv05OyvwCo0RO97JU0NZerbnOwvqYlULroPCczyczbh6rA2ryJ
         7V4nX5PhO43qp5X7O9S4eoPuV8G82m3GCUqqqiXkx2xrf0RieCEuww+bs6gRqDkOQgMW
         EqZ2Rr0Xb+VKti1o/yWam8OGYz/qAJASU/s/dEZi04svo99y03EpDzj1Li89TGJgDvcR
         ECPA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772161522; x=1772766322; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EstLyzavajxQSjr+mlq0lPsb/dLDgYfeCgFO9w4/7Vo=;
        b=Bhu8Dgkf5ECEt+kScwTMc5wO5bby20l5dEgWQG+wF/6SEUIEeXiuY75PiDNSHuHoiw
         huJJiex6kUg52oI4dK0hZgrapMULdRsve/wQbo91yJNhqNO+j2kP1CciYpS/WpQsecMm
         /MlpQggnMSZ5LH6RpxU63vjKsbh2YyrxomM/2jyA6BsrKXF31+VepAt6I3BOGqvj20ZL
         kH/Cvm5+jhZwxMJpV16KrFUhhgW579CNygVFfy/0ThftjzjJMzmrmRTfI340w63B7iGt
         60aJxIibuKvjjbYRr7g01fQG1E+RJYbgLq+bBip6pLM5tPrH0iU2dn3TNmBY10yXDOXC
         5D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772161522; x=1772766322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EstLyzavajxQSjr+mlq0lPsb/dLDgYfeCgFO9w4/7Vo=;
        b=uW0rfikNiA/EbzluoX71sd34yxEdiIViu1uOxHBv7hcd8f8jo4EQbOeGA+w62B2mUP
         APCw33mJHvXiYZCu00myc8UDQtttZNZ1GAFUaXpCfVBbkmJIkKsW77ANI5q1Y4ErACel
         GeExgqfPt09o57n9QR18wBtOwAP4wKHm4N+iwn3a/nWg5J68f3/cdD0ecp8WderzKlIm
         ld5pKgRa9CCW98es7MoPLM4DRBS0Sw28iWINsxq9dACHKgjo6dfPUBhDvMXYlMdtQ3mE
         C3IXmFQctKVsZMNI65L7c2A6FMJv92gDZr2BONr5n8tRsuL61JByAMHUzjcmwm39yMjU
         cisA==
X-Forwarded-Encrypted: i=1; AJvYcCVb0HwCfrEvVAGU2VoNB0xW/47WYwINnWmqkeznjry8HktFfRr0+iujw5Jdf5Ju+v+SGGdmUgd0dQw3@lists.infradead.org
X-Gm-Message-State: AOJu0YyOAp47Si28lcWINmvolkUMbgmcnDyK1Gm7Zk6trxSc/UHEAd3T
	n67uLHCMkIjCknfI3g4GSDAoXMhdi+Iv+4nyK5yYau4ifwXnRWYQxONg+JOnYSLh2sHuH/C8cB0
	NIwG087UWdPfHvAAZUisLlTAO8HgbyLU7m0frRPTQTA==
X-Gm-Gg: ATEYQzySf0lTr0cwfYU+1S2LwMI9jQ/Ysfei7AmEMJBbR+DuRzmYLOJWVaaYO6HsS0V
	4CicEInQSMr9v9k4j1nj7SYIFAjxrINeYrl76r1ADltt0xt3cbBkYxu29EqNr8SzP594UccF4sW
	uhNyqVk5x3teRlydgW87H8iieHHhtjTcEY8BQba9C0zE35XokuRj4SR8y0VaJDw+TbsAz4XVE7N
	tG9dh0TlrMiQw9lGajuY4nD8bxFf9MUm/eSxFHAI7RrQTZOO0pAGZ/7Ow9pFAexDKkIXtOyyx37
	vXGW7N0cyrsr31DM3SX2L3ErX+2sJRBeJlT+eoqivk462677YWyhZka8LHAx+5cJrUXAww==
X-Received: by 2002:a05:6102:3e8a:b0:5dd:89af:459b with SMTP id
 ada2fe7eead31-5ff322c4256mr654252137.7.1772161522021; Thu, 26 Feb 2026
 19:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com> <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com> <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
 <20260217153530.GI2392949-mkhalfella@purestorage.com> <CAPpK+O35BBLnQOuPg37v772g7LtOpo6onxENRObUi7C_xLCoPQ@mail.gmail.com>
 <5dd3f2a9-5b8c-4604-a84d-46532b1802fc@suse.de>
In-Reply-To: <5dd3f2a9-5b8c-4604-a84d-46532b1802fc@suse.de>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 26 Feb 2026 19:05:10 -0800
X-Gm-Features: AaiRm51kGTUdWsYFnFR2kNBRTbsID8opSx3V7UF_cYt2YN3RjTrnoCRW2odRlWk
Message-ID: <CAPpK+O1u2JBpiee+Be3ROT4uSPKuXbJKHrZxBmP2c8xrDWmJdA@mail.gmail.com>
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: Hannes Reinecke <hare@suse.de>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart833426@gmail.com>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_190523_440494_A109B5E7 
X-CRM114-Status: GOOD (  20.01  )
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

On Thu, Feb 19, 2026 at 11:25=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 2/20/26 03:01, Randy Jennings wrote:
> > Hannes,
> >
> >> (ctrl->kato * 1000) + ctrl->cqt
> > As Mohamed pointed out, we have already received a response from a CCR
> > command.  The CCR, once accepted, communicates the death of the
> > connection to the impacted controller and starts the cleanup tracked
> > by CQT.  So, no need to wait for the impacted controller to figure out
> > the connection is down.
> >
> > The max(cqt, kato) was just to give some wait time that should allow
> > issuing a CCR again from a different controller (in case of losing
> > communication with this one).  It certainly does not need to be longer
> > than cqt (and it should be no longer than the remaining duration of
> > time-based retry; that should get addressed at some point).  I cannot
> > remember why kato (if larger; I expect it would be smaller) made sense
> > at the time.
> >
> Because we have to wait for the AEN, at which point KATO comes into
> play yet again.
> So max(CQT, KATO) is the appropriate waiting time for that.
I see your point.  It could take ~KATO time for the AEN to show up after
the CCR operation finishes.  Technically true.  However, if responses
are taking KATO time to get back to the host, I think would rather retry
on a more healthy link.

Sincerely,
Randy Jennings

