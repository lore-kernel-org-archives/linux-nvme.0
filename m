Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34BC05027
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 05:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSUWe6XuUo2xCHgVdW0f8rgDICtT8qqUf3ph40X9Ffc=; b=eWuOYWmGyE7khmxTcYKwZdv4jT
	+fcoePotaj/Tykle+fdY199RZNHD18Sps/m5BUd5/34txynmG3SS8ZSxX/itcexQ53tsXZ0+FsMQi
	xsOSDTiiF0t8Ou/b5fpCUI/rKZ+ByMthsOE6sKpDoe3wwY87nREotufl8IVcjrplb90Cqz56fSmxH
	ppdXrxKCkmGHn+/oSf6Gr/K0XkYwxnIwe+pOSR+fPDVSyuRCMBV3gMwFMwJjynwmPUJzSUktR+oDI
	QNQbWk7q1GmoEE3dZztVdinw1R9CjebofaE+90LX6q5mLyhrW6yD9V/gwsLS73PFHJ4xKMooiDXMM
	tKyzbALw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRoGv-00HaUf-Sj; Tue, 14 Feb 2023 05:54:33 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRoGs-00HaU6-UJ
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 05:54:32 +0000
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso12891580wms.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 21:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSUWe6XuUo2xCHgVdW0f8rgDICtT8qqUf3ph40X9Ffc=;
        b=NC1/UFWhbMcdBljQK/HTc1gC8pCUKg4tASanFo8FiQEyoI/R44NdEI6GRLy5x9XSHf
         EI/ec5kU9oidRZND5HnXW+DlPUhAcMkPRG8cfKV5Sb3kVMpyQArrwo8dfaGQe+HhFGN2
         iXaGkVAcWqF7/duMW74ZkhAZSgYhjQ8lmo9Ay4ePxf25X4zj/2Pbf6mifnTYNG0oda0h
         Jcfo27h9FANCIXp4HdnWv7+T2WN97cYdIa2Hq70ASdOWaPSW/aEJP7YCJonj5dd5QQpH
         vzL2zmoutKdzNz+0wwHw8yM+yVQxeNYvFrCMI0BSanwghO3pE2SAd5tSkFXpVrwuvKgW
         5zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSUWe6XuUo2xCHgVdW0f8rgDICtT8qqUf3ph40X9Ffc=;
        b=4D4aKxY/lEo11q6qgRfFPWyHqiagvHd25Yd4ejlWhVraIl1uEzZ6mRLsRNxgpdGGB6
         EJ9gH2k0FQgVwD6jw7691uSSNHrjXTB66VT+KHqCx7CmRzVEnsrs9YgHnWQ5XG1qCz7J
         TBAQcoZGGyRvXCXYW/DKn9jKZm68kX62ZQjPLW+POHcmaFQOoZyL88eW4/CuB1nPjMv0
         ZWqlqQYuaGAHSQvXlKD5C+EBcODz5TiCHzszVN1HuDkiwarC0NoMVIwcchW4Lf+sRydb
         YB8ZmlFhZnVFME4Ws6kubOTMnVS/AlNiqD+gUC9C4trM+DW4nwXLw4nP69RUZONzXn7Y
         etNw==
X-Gm-Message-State: AO0yUKXMa1rqgaVZmw5tFZc/P3e3XmBbmimjKjSLrFdLmufbh9cHIJEf
	HUcfvwZ6JA5y1zJ8pxFkvop5WNrJ+EZifp4mfnM=
X-Google-Smtp-Source: AK7set9EoIHAXOzq8uCc8a3C8r3/cHSGddxVuAIiydzPgaQQDWGjL68JkEGTOaH63VgxcU7B4JbMoPuHEHdeK5WFQeY=
X-Received: by 2002:a05:600c:1992:b0:3df:f128:1a32 with SMTP id
 t18-20020a05600c199200b003dff1281a32mr904539wmq.101.1676354067754; Mon, 13
 Feb 2023 21:54:27 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230209094631epcas5p436d4f54caa91ff6d258928bba76206de@epcas5p4.samsung.com>
 <20230209094541.248729-1-joshi.k@samsung.com> <20230210020114.zzmazatkxeomowxq@shindev>
 <20230210111212.GA17396@green5> <20230214045707.sf7hu4b7hzgzbyns@shindev>
In-Reply-To: <20230214045707.sf7hu4b7hzgzbyns@shindev>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 14 Feb 2023 11:24:00 +0530
Message-ID: <CA+1E3rL+CrVD4HjRjq0Dx0OFDPDBMqq72S2j3-LtZTXiPX=o7w@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/046: add test for unprivileged passthrough
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_215431_030266_9A17A73E 
X-CRM114-Status: GOOD (  13.94  )
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

On Tue, Feb 14, 2023 at 10:32 AM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Feb 10, 2023 / 16:42, Kanchan Joshi wrote:
> > On Fri, Feb 10, 2023 at 02:01:14AM +0000, Shinichiro Kawasaki wrote:
> [...]
> > > If you don't mind, I can create another patch for further discussion based on
> > > the suggestion above, and modify your patch to use the new helper functions.
> > Sure. Please remove "_have_fio" line also in v2.
>
> Okay. I've sent out v2 [1]. Please check and confirm that it works for you.

Thanks. I am PTO for a few days; will come to it next week.

