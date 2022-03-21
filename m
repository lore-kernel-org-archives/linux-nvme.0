Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9562FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TSNVuSnbvIrmpYd40cWqscwtHUtWdf6oUuadIEPAeUA=; b=sgQJalHYCzD4sBMj5RE5RwHf+J
	bXNFigDsOdb7WtjaDuWDevIQhZChwPIIGCGxyvtxL/Ke6RREc4gNJtsgg9hX6g/A7cC3qZJHwEUac
	/sC72M+MG90fYFHc/eoVROqblYQEX2M6hh9zWbK4VvoLW/ajSYk7f4vvFd4rGtAZUN6fRU0KqZJwL
	tNHDAK4/xUsW0PJRIf1eYmqtykQqKc1+ojecWRzrO3xzSUDXIpIXMl6Dk5u6lizsFSENzBEtJa4Kf
	3V0P/M9BOrP+B05vYwbZzIuRq83CPYttPrTsowQcpz0fh4/a+U18xeDD1B1i3jD29g5dSSQa5wVAf
	BnaxR9gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWMPd-008h4b-7C; Mon, 21 Mar 2022 18:05:49 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWMPa-008h3S-Su
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 18:05:48 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id h126so29596661ybc.1
 for <linux-nvme@lists.infradead.org>; Mon, 21 Mar 2022 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TSNVuSnbvIrmpYd40cWqscwtHUtWdf6oUuadIEPAeUA=;
 b=JS44z5GrvDzN8Nk3/iZed3F6xvezUpsBiR5u/t2sP1kerSgKT5YqYkKlhpvB+dMqxN
 7aWQk5/dbH3BL9oIadV3/mho1beF812nZewvlx2kxTr+jVpmsjgr1bGentexObICo2ku
 Z5/nkG+D/qeH73f54qDH50P39rGGAFyXTtbJr47+NqIvoJsF103CybY580ciCdNTBxpF
 kLdIyrsf7iSWojOND9cOf87lEIWwVwfbb6COa00sv+1wpxaZUOv1wMAEcxH3TN+eCZBL
 oBTqJIh842fciAyn0pAiBSRfmk6fkha/Ta9kG76HPopjjjLb8Hl7s8VXLdpV7bhicENs
 tecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TSNVuSnbvIrmpYd40cWqscwtHUtWdf6oUuadIEPAeUA=;
 b=UL0oq8aP06WZ/JiA8/RPVoSQ4P+PZDnnWEMNPYwBWaty8pulLanoPfrL4qGUABxARO
 3aF5LpZawMD2oZ0ru8ilB0c8rRmAA63rWDGo5EViVLuOkRYNv/57noHTb84HbTnjypbu
 dP+HVnhRbqcGYzQy5JCpxlsdEt3E71KYlhSV+E7WY2T9YWjZ1yC5Fve8Pn8KimeDR80/
 sAJYl3eG1f+s1ER1GEEeZH38xcNjkKnpwM6rjm0JniraPrr88lyTrn/7oPi3lka3+NNH
 QRM0yWJMQvPUXO6f4ZZ9XiZr5c2Zl0qVdq9EEJVcDBx44JQHxx17EacaQlZ3fm/YTK8u
 bifA==
X-Gm-Message-State: AOAM530EHbyEGG+y+Hj3zRRJlw6I78PlYu47oSHKkhQwDxJYuFSV46Np
 8vccprDjZYTneXlwHzOmPi0ON5ErFBQcI1maL18xCYgl/k66Gg==
X-Google-Smtp-Source: ABdhPJxJtcjfz6TeqXmp3Xg4Kotugj4+AHliUsu3m20c63Kdl74xMHungawQ5fVQyughfZf1EpSzViKpUhAFXhJ7sKE=
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr23920876ybn.6.1647885945548; Mon, 21
 Mar 2022 11:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0coRbCPVnwVfeHYVxLHQp3HRd5V3aWZJ5uVwyyr-zk9=Sg@mail.gmail.com>
 <d01b7cf5-e46c-0cf3-5e58-64547f84817e@grimberg.me>
 <CAHex0crgDtzTcC1BMECvPsCUcdn_CtPeLLKQAtF2R=Yc=kELTA@mail.gmail.com>
 <16af7558-70ef-6ce2-bfcf-10a8f28dd749@grimberg.me>
In-Reply-To: <16af7558-70ef-6ce2-bfcf-10a8f28dd749@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Mon, 21 Mar 2022 14:05:09 -0400
Message-ID: <CAHex0conQPypS8Hr7m=Gbuv5dA7As4ZB+jr_4HRGPKW2KtOZYA@mail.gmail.com>
Subject: Re: nvme-tcp: invalid h2cdata pdus in response to r2t
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_110546_953759_1E23BDFF 
X-CRM114-Status: GOOD (  15.04  )
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

Yes. It appears that the patch came in with 5.16.15.


On Sun, Mar 13, 2022 at 5:28 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
>
> > Good news. The patch applies cleanly with offsets. And, I can confirm
> > that the host driver issues multiple data h2c pdus correctly. The
> > various combinations of digest options work as well.
> >
> > Of course, there are options for target implementations to avoid the
> > need to send r2ts, but in the interest of correctness and
> > interoperability, it seems valuable to fix this bug. Whether or not to
> > shepherd this through to other kernels is a different question...
>
> Did you happen to look if this patch was picked up by stable?

