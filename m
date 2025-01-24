Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D73C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OiLWNnPvZfiJWXL5QmgJDlz26jy+AruYnB3C0FsXo6g=; b=wj1b+JA5wq3hYqi24KfBlhVM23
	sW23JN4zmKJ/+1QCYnKJyTE2/RPa1uT+wvs6hx4Q2jGs4/tEsbHee6zUr/JRDQD2HVn8BqMpLC535
	WVJ62gHH7SnGk/5eonz7cBNANZrLSdoBCFw7dx1X5If1jZfA4A20+Dqo3XftOBbte9VsPk2TivzAg
	8p9lgYKWj3CptaigjsTL3ZrCowph12/L3sIrykFSvdBEIvhoXNepE9pOrqPurTJi8IbmDCXQZqjAW
	GZXV/Ys/GFo1Rka4He+LFxVsu180D1wNrlECo/MQmjUAjjyxWvEDQ9ErXRypSPR8wmQIu/FA/73uF
	50zMwCUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbOb9-0000000FJO5-47Cr;
	Fri, 24 Jan 2025 18:40:07 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbOb7-0000000FJNa-27e2
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 18:40:06 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2162699e0ccso5021505ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 10:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1737744005; x=1738348805; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiLWNnPvZfiJWXL5QmgJDlz26jy+AruYnB3C0FsXo6g=;
        b=R2/MaromnLauVseNpB3x3wrQ+fNbpVXb322mXGJHqgehrXvZvi9NknTY0cJN7/Pm7e
         juTbOiBv8AF1VU8pVlYXML3Ye5cKr7NztiE22efoRVIxZvmWNTPFXDZzciw31ravSoT9
         ziGYJMH4t/b8gH1o+jNJi4TcRuFK2jjwjRrSmTdGyd9gNB7lWXXIoJh/s41o1phvcK14
         1DWvNXBqZjx8y7Eew2vNFrqaBU/sC3ngsUpWUAka3agwINxJbFz/wS7FWDOpgFncGedY
         sSc0WZ3qu/RubcRJqaCzrE+E4hz3PanZAtKjfxDoz5IufVHfBhFVUhAaX61IQveiIYYL
         ARWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737744005; x=1738348805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiLWNnPvZfiJWXL5QmgJDlz26jy+AruYnB3C0FsXo6g=;
        b=CYM0Aj2o/dCxkHbVYsIw3hX0UD0K82wzmRNhFdU0Q/XBenoQ4Wh9hDQMWTtwbzfkrU
         Hf2cqQegpulq9FbDYdYkQj9lpZ1lZH9rEO6y8fIIu2XRONgb3or5vX0aldSVEADijA5F
         wEC6HSnG7oIWmiThASwdIKRO84pMxpNDn702Dt0aDYh+WrF255T1sYP9cd7sWeovIBzz
         ZS7WymD67efl1FjVcyvMPMunSpWFuO+k+Th+kM6EEdpBxT0v1RCF43UVRe8+O9joFHoH
         XWLKpwGf49sxw3iNRKnWQSnDEr9vtXtgzDwunU1GxgH+DT3lNlFVWdzS5wryHNGjFtpo
         58dg==
X-Forwarded-Encrypted: i=1; AJvYcCUq0txe1ESF95VeaJmogvKkMDcEub7aaRuiPz4tfZI5sLXfESmwxRy1RqEoEaD87LO6K5LiPXFCZCbc@lists.infradead.org
X-Gm-Message-State: AOJu0YzcJ4o8cMVn6X7b7V5T7p0zp/UinplhkRyxn7WaaHXv+nGER8fl
	bQlIRA2Lx+2AI4xS99Jg2L3pcLZ8JlNxcIaN1h9m/MEQ5USYIUNarZxkIU+PX4ft1eIOFBCSLgJ
	83aFkvdnCxEzrTYHtuvKFdwFdobxePfgPip2sNw==
X-Gm-Gg: ASbGncsjX8O5GeV9zDbgMtU3l5PlOOKi6rPWTf/YQU9AaEJTclGxNICUzL+Dr300OIg
	ikB37U7PqjM3F+f4mpwRYIVfZae4VOmMKs0uj2+pB2y0lG8NIyp7Md7IKcnoL8g==
X-Google-Smtp-Source: AGHT+IH/VwdVombeo6r5bSckRFm8+fpeQfvYL+cxWvUSDPZSyS+Snv9igdLGYiyT/Z0ZPDH0gIdypAql9JBwixJNv4w=
X-Received: by 2002:a17:903:2412:b0:216:42fd:79d8 with SMTP id
 d9443c01a7336-21c3563c7b2mr186011955ad.12.1737744004726; Fri, 24 Jan 2025
 10:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20250124180342.1628060-1-csander@purestorage.com> <Z5PeLAaAv0SwV-y6@kbusch-mbp>
In-Reply-To: <Z5PeLAaAv0SwV-y6@kbusch-mbp>
From: Caleb Sander <csander@purestorage.com>
Date: Fri, 24 Jan 2025 10:39:53 -0800
X-Gm-Features: AWEUYZlzerfBg6UlCHxPr7-DGdrDI3Ri_jmjgTTyZsVpVqcaTYQXCQczxKQ80Ek
Message-ID: <CADUfDZoxWEup7oK0RVE7=HyPsdf4CGBboprku41hu=+b2_Y7Zg@mail.gmail.com>
Subject: Re: [PATCH v3] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_104005_583586_9148802D 
X-CRM114-Status: GOOD (  11.76  )
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

Indeed. Time for v4...

On Fri, Jan 24, 2025 at 10:38=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, Jan 24, 2025 at 11:03:41AM -0700, Caleb Sander Mateos wrote:
> > +     msg.msg_flags =3D MSG_WAITALL;
> >       ret =3D kernel_recvmsg(queue->sock, &msg, &iov, 1,
> >                       iov.iov_len, msg.msg_flags);
> > -     if (ret < 0) {
> > +     if (ret < sizeof(*icresp)) {
> >               pr_warn("queue %d: failed to receive icresp, error %d\n",
> >                       nvme_tcp_queue_id(queue), ret);
> > +             ret =3D -ECONNRESET;
>
> If kernel_recvmsg() returns an error, don't we want to preserve and
> return that instead of unconditionally overriding to -ECONNRESET? I
> think the suggestion was to set ret to that only if ret >=3D 0.

