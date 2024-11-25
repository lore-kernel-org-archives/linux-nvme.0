Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5220D3B7E8
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 07:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZIGo3yTlv6am7OV853ap+f/qjKN5h0CP3WCOH7VIhA=; b=V2qEW8bPHXyHZGCYHPq76qQmSl
	sf2voJuv89+F2wTgIybm5cKscS2zDKKwvFEkZMdwzIWnx3eG97n9wPr+dvT7fqOd4aAV+Qm6OyXUz
	n87BpeQmPvRQe+Pe2FuKjGVSbfS+i638xsLvk/vipmMW0G7mg5udIkK2kRERwLTh68QPgi2BrF+uw
	d3jKQeOUyuedJxxqpFjxCSEiu7Pj7BXSUfNGtuJcokDAp9Zg95gcm7IdNw9aocijigZDinjnLzCi4
	HnbnxOWOiqUeVRm1zsbLSgylEE4yeb5R12/34/6oWnFRAyxx3qpHbo75XS9FtXWOkPsOAA0QPYo7V
	3glmAB0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTwe-00000007HpY-1R8E;
	Mon, 25 Nov 2024 07:55:44 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTwc-00000007Hp6-2MqK
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 07:55:43 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-53de582163fso536061e87.0
        for <linux-nvme@lists.infradead.org>; Sun, 24 Nov 2024 23:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732521341; x=1733126141; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZIGo3yTlv6am7OV853ap+f/qjKN5h0CP3WCOH7VIhA=;
        b=ZdKxUeO7Tm/+IrrK78H5ADZusG+2zVHB7wl2WSO73xBysQ8KUU0XTlyiKk8xY1B5+o
         zHzSFJLwIKS1WxceLYf4koGf3WuN07MAB9j7kqT8j2WBRnH0OUi0rrEDoCG/vQPkFjip
         MGL0kpj8pD/y3wyU2EFaBKlhQe0zh6QgbM2HvWnjvedice5xm337CgRYQYe7FsQlO8OP
         TXCRPbbT0Fo5mBUvyjt0a2EsRV8z7gtuPKxzU61Sp70sb5jYl5pwQlEuUgPPU2wPsNgT
         qxtKmmdSjBjjt6v3rPQoUHsTYyCUJDzIK2tMpZlv28JNe6whOkGeqLV129z5qy5bNH7s
         rQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732521341; x=1733126141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZIGo3yTlv6am7OV853ap+f/qjKN5h0CP3WCOH7VIhA=;
        b=cfnEB4JQWCcSSq64j3D77JJCxy1ZAHqNUveKRAKyC3W7Sxh36i36OsJbBNooOgWz1U
         0KSj3F1Cp8rglfcZIhUFkxtWZfGidTfQumijTQgTzDavrAPiuXwPAelM7Q5CkeNuqMTr
         Ih/zmGCuWDX0OaKm3mzPD07hDlmBK6lG1+5YXikvjB3R65QsVtRVxFWsmy3iUtnG/Olu
         807ScmI0f+u+biHykbANp0bYW8243cxoI3USTpW+VdsBqvoI6SefYTfaA7u0AiYh26s4
         BeiZGt8c9O0b443AwWRszXx+9v0Z2QjFlqq1TLzR1DMJBNH1DX5vx4DZWFF+IGUeXQNc
         Oqgg==
X-Forwarded-Encrypted: i=1; AJvYcCUf2kTPIdbccgpOXHkce3gIzN9N/GES9J4+G0rXNdo202Qk9pp9xmBR4F+r0TElOxVsPZPgvpQLBWsJ@lists.infradead.org
X-Gm-Message-State: AOJu0YxzwDL6vniY6efLDEWJ7CkxlDA/bEL0ljVIH/YZB2jB8GlWnyPi
	ZSg0hDN/FcP4bEFgCIuXcr8H+eI90Zdu45F3tlmX0DzlFleZHzV2KlFYpxKEITMlWgtrG7sleub
	VdLEV+R1+8UvLvoo9pwjC6vgWQuGfGutA
X-Gm-Gg: ASbGncvbRw2dDYss5UFJ31tSvDrTEOMh7zEUvFL9enoQKT5E3Mvvo2TQ/YRHk9U+zHX
	pojDrz0zFt/GJPkebbYDKZeO82W+IQVw=
X-Google-Smtp-Source: AGHT+IEX2TQ1O3wTcFG51cUF7z9UVov8MJqQaloN7Rc+mJwK8eOPWnWbJfLX33PQhLuzvo0p7hG/6wBrOsprHcNtofM=
X-Received: by 2002:a05:6512:250d:b0:53d:de72:a185 with SMTP id
 2adb3069b0e04-53dde72a1cfmr2753944e87.5.1732521340396; Sun, 24 Nov 2024
 23:55:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1732368538.git.chunguang.xu@shopee.com> <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
 <20241125072240.GB15647@lst.de>
In-Reply-To: <20241125072240.GB15647@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Mon, 25 Nov 2024 15:55:28 +0800
Message-ID: <CADtkEeegfVhbkA-nbaOaveqtvSpxKebB9OdaBvCsWtSFJ7P46A@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_235542_600170_5F6A6A5A 
X-CRM114-Status: GOOD (  11.37  )
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

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B411=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=B8=80 15:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 23, 2024 at 09:37:38PM +0800, brookxu.cn wrote:
> > From: "Chunguang.xu" <chunguang.xu@shopee.com>
> >
> > As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should =
no
> > need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simpl=
e.
>
> Yes.  And this matches what RDMA is doing.  We really need to go
> back to the attempt to consolidaste this code..

Yes, I also think we can do it

> Reviewed-by: Christoph Hellwig <hch@lst.de>

