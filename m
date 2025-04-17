Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3921C369C7
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PdUpoo83PnisgTtpWjy4DIw3N3dpKRphaHPr3f4GvEw=; b=YM8wEld/38m62eXTmNILox+n8Q
	kqvmHEruU3yLRMSo0g+wZeAyDa1j/mJSoDflWUwdQt+wYddBxnQsK0tCFjsZ5MqM3jFBCqhPwl0cM
	Ghkh/UFRQ5SQwV9yu2RKU2fo5MV4iX1arDwdmj7VqHH7N9pRb8C+GIXZECd+MTlQCByad4nQYAPQo
	BveT8h7LglLEyUI74WfaONCfacfNUwtuCy9eOUvRqIhrEmM4nSKLoQVMBB01yReSj6njdUL9SJJ1r
	YJPZa/3+9fO6JvCGVo+7HP4Z61dxmcXWH0tXNKLzK/rwyKU0f/fydtYmYh4LvLeRlNR7hfNygze6y
	nAWt8e9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Dwy-0000000BQDE-1R4V;
	Thu, 17 Apr 2025 01:21:56 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5DP8-0000000BM3c-3LoV
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 00:47:00 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-39ac9aea656so264246f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744850816; x=1745455616; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdUpoo83PnisgTtpWjy4DIw3N3dpKRphaHPr3f4GvEw=;
        b=MCOA1EaKGZqPvfK6Lpu3D2m613bDZCK8VgENwwcteuiEnwexPXEGXqhP0WhQzyhhwe
         JQ3Xr9h+sY0Pw02zxG1ZtiQTDKMiNd9uf2DV7MKdjvaD5Ba6vZJJVS3noM02k8HmZkz1
         Rwu6fNS8BpjeKQ08OGg7ajtpbo4ZvDhz4ylf2BOB8H9mbhCWC6vAqRzFJtUTv/59wMwy
         mhYBf5Pf3fJwSULA4Bc2lvZSr9ULjIu5dFqf9C2EHSvRdNndakCeMb7Ms3AB5MGU1vcO
         yZDL7nnVuaafmEyPo/LQSpZReHar3MnqHSyIMhKcj7udsz32UCd8Ud8EZxRVeZsRW/hy
         ai6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744850816; x=1745455616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdUpoo83PnisgTtpWjy4DIw3N3dpKRphaHPr3f4GvEw=;
        b=Y0O51otZIdPaYUnvTiZUwJz8glkedCL51OHJFxuH+ynUvkv0yQdPzJRlOH2ehYWmPN
         On1BO/0WlcQatLLCtoDKCDGroxmwdmpEWVVFeK+rp59Kdi6cO8qRB+m6PsfchjtpgdlD
         2v6DQdRlJ1gXszKMzVhJfH9WJ0G041IzAXc6AZboeeENLb38Et0oZ8w1r3M47tE07OBg
         gvUoOIV1YAzkTkmMTwTukD1a5bV0Dg0jp2WjveJu653yw58/nDBmjTB8t7FLUMvgkKjN
         4hfB9KARXnAlDO1SpZ+Zkd0sjBLB9h1Vc/x7hPKTa/sLLC9wUJCvWpX1PkpOLThbFl7K
         ZhDA==
X-Forwarded-Encrypted: i=1; AJvYcCUgQt9sHoaJWmr+cTurlbCxh5Yk+NPx4oMLAHuWkkBREL+6i0TYVHOwJLFF4HO/YzvHvXki3+ERx89Z@lists.infradead.org
X-Gm-Message-State: AOJu0YyO4AVxxvcgWtNBLua6t/wa8vQ4zsEwmTILydcjK5WEqvZ4AFc2
	Xd9ShEjVdflN3gnhTfDU5chBDybJUcTpcF4w9Ofxu/dJlMNQ1/BWnjaqB8n3DEOjqI8a1oaBfcO
	KvMOlO02Euwke3fkc46N4KaBu0/pnClWmT/zhjw==
X-Gm-Gg: ASbGncv1vH24oSNF3kM1QWSUtk5i3K0Qk/Df/CuLi1EjLnYFuUVEfMd9YkmRg6eVKIk
	LXoidNF5qdQnyk1P81YLksvknzWD0Git2JZhlW1IKJZjRpgs8mRuXYVzaFVYxBs5H1rId3xdeAw
	8//2b02quoK4GvSCjmKUyG46Uk3lsjOD7VUg==
X-Google-Smtp-Source: AGHT+IFXOHl/7JXPbobdQ7qD8MWdBoGYOnaUH6HNs45B4ZXG9TK6FBTyG0XoTm8t8gs8sdEV4TzCUWKs5HK+V85zhgs=
X-Received: by 2002:a05:600c:1d9e:b0:43d:fa59:bced with SMTP id
 5b1f17b1804b1-4405d6cc4e5mr40574635e9.32.1744850816515; Wed, 16 Apr 2025
 17:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org> <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com> <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
 <4cd2cbb4-95ff-4f3b-b33b-9c066147d12b@flourine.local> <4c334216-74d7-4a30-add1-67b6e023d8d2@grimberg.me>
 <CAPpK+O0tmewK7pH458TOxjtimjO9on=4YDRFbS=FPTgM+KFTzQ@mail.gmail.com>
 <8ac6cc96-8877-4ddc-b57a-2a096f446a4c@grimberg.me> <CAPpK+O2SBm6-zqbiDbUB0yubVTvTrXWn1R+GAPne_+LGvVXp6g@mail.gmail.com>
 <945f4ee5-3d9b-4c4c-8d45-ec493a9dcb4c@grimberg.me>
In-Reply-To: <945f4ee5-3d9b-4c4c-8d45-ec493a9dcb4c@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Wed, 16 Apr 2025 17:47:07 -0700
X-Gm-Features: ATxdqUH1xwKOsh542pxYrVRq4ZpcISOHDqSJ1ufyC0_cIpqfJJyYlNd3i_cUs1Q
Message-ID: <CAPpK+O2a8uWa7M-7Kk=2xdhjDjWtBisz7o0yGPpah=iWrQTnNw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, Mohamed Khalfella <mkhalfella@purestorage.com>, 
	Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_174658_836459_DD070DE3 
X-CRM114-Status: GOOD (  21.15  )
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

On Wed, Apr 16, 2025 at 3:15=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
> >> CQT comes from the controller, and if it is high, it effectively means
> >> that the
> >> controller cannot handle faster failover reliably. So I think we shoul=
d
> >> leave it
> >> as is. It is the vendor problem.
> > Okay, that is one way to approach it.  However, because of the hung
> > task issue, we would be allowing the vendor to panic the initiator
> > with a hung task.  Until CCR, and without implementing other checks
> > (for events which might not happen), this hung task would happen on
> > every messy disconnect with that vendor/array.
>
> Its kind of pick your poison situation I guess.
> We can log an error for controllers that expose overly long CQT...
That sounds like a good idea.

> Not sure we'll see a hung task here tho, its not like there is a kthread
> blocking
> on this, its a delayed work so I think the watchdog won't complain about
> it...
That is probably true with this patch set.

I believe controller reset (for instance, requested through sysfs) is
not supposed to finish until all the requests are no longer being
processed (at least if it should have the semantics of a controller
level reset from the spec).  This patch set may not tie the two
together on a disconnected controller, but I think it should.  Also,
if reconnection in error recovery is tied to this delay, as it is in
the patches Mohamed posted (https://lkml.org/lkml/2025/3/24/1136),
there were other things waiting on error recovery finishing.  Delaying
reconnection in error recovery until the requests are dead makes a lot
of sense to me.

Sincerely,
Randy Jennings

