Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52494C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8boM7ORGYNMPVReZtTMFOzEa3BTzmrT4lpyXZ03SE4=; b=lZOrEg46co578TXp6rfXeMetfd
	kQ/a5/HxvXk8KZ8k8jRIZPLAmLgkk67p69BFlActJDLCMavpwgnYn8s+3dSWZy35jrxYq2to0+oGZ
	XXGr8mz9OlzlaOYlyZ92SZGkfGaxieMAudh1XWf1zJExmA/xTY4JD0TGEuTOOGvIkCasSVqNovAye
	Fa6XA4sO51PHgwarKat5rFkCjvDAbmv/jIBCNiqFJyWh0bQtUumNlXt2ic195dSleRnfLI4psE5fX
	R49BtoiUmzYgKFwf3jGbfUYwgH7tYsnxOyt+hXX9Ij+2Zx93+vgpbTdlTiBc1dyArePEpOIaIQVa7
	36U5TOvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTfeF-00000007LHK-0cZK;
	Sat, 27 Jan 2024 10:10:51 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTfeC-00000007LE5-0LHB
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 10:10:49 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-42a8a3973c5so4072861cf.2
        for <linux-nvme@lists.infradead.org>; Sat, 27 Jan 2024 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706350244; x=1706955044; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8boM7ORGYNMPVReZtTMFOzEa3BTzmrT4lpyXZ03SE4=;
        b=WRDDoTTK7auvXt9nJT5TAvRo6YkvziyRg+446yXy48vYNogF2uUcKus25K5ZeT0McK
         JH1vc0aIxL4PAcWuTnZxrH1MDXiA/D/Z0sCyFoUBg9Djkvdg95Y8ohiHD8kqhAdHEjg6
         R9RBR4rJ3t+wAZL2MvAYW77d6RXYP/tgtXfVKvqSEsME0pKZMnSNRb6mFt7fbrsTY7xT
         Z/P9YEQkK/RvC/djXCWR7dYr8yuLvgURsnGVQpyuUn4SUdgdNUXdaRSrmdQG5AzfiY0z
         QSTjj/GFNVllZHPuNS8Bo4uOWD3BOaIHxoFCfgOg2YYYoi08gZ+J6upkEo2eEbtERhb+
         ZTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706350244; x=1706955044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8boM7ORGYNMPVReZtTMFOzEa3BTzmrT4lpyXZ03SE4=;
        b=sP6aSa83UlS2rYLjfNqXUS0hNZYvQxNtd2kL8832WIrRkzKpLxoFk/oWqHP/VPWMjt
         CGaRujfFcHuwL5rWKGi/INmWrAl15F4+QbRH/tW6Ng/aIkgHDUf7BXmEnpqlshhsgp4z
         Sa4+dpYh3bJw/Gkq1kfVjTkOuqfcXG17iiyi9WeIUw9yvGkv9fF1GBnSkimDXy1nMcid
         NuXQGtBpSoOh4CysiR5xpaT0gTGkahUViUTZTx3BM1tO3HMwU4qxLQ6xm+4zFUUrx1g4
         GlecYpJBveGLllEvgDVt6x15wRmSOKYto3Ls0vOmt10AmPIude8dJcckSi3Iw5r7tMSs
         9QKQ==
X-Gm-Message-State: AOJu0YzNxaOqKHa12/yjD5Iu8wlNq5F8MyVsSkKoOmXolN5bkNV9CKsP
	pl9U6/brvFD7AdZeepIV31hz7VGvC6pP4SwCSegm2namzNvgyQkTDRFAMnP0Md40iSrR03cBozE
	PWT5as2lYghL8rcp/+9YLQ+9MIA8=
X-Google-Smtp-Source: AGHT+IGUiH9HXC26Vu3/anzdVnuqtGlcGQJbaXMTzGJ5DFv7hsAeCFLU6XPgobuQw9kM3iclvcK7hFxD/N8fQjpWGJI=
X-Received: by 2002:a05:6214:258d:b0:681:9ae1:94f3 with SMTP id
 fq13-20020a056214258d00b006819ae194f3mr1669408qvb.115.1706350244304; Sat, 27
 Jan 2024 02:10:44 -0800 (PST)
MIME-Version: 1.0
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Jan 2024 12:10:32 +0200
Message-ID: <CAOQ4uxh1BCmBA3ow130p1FBUrLLRVO2i_DDtAGQWhAzrabmP8Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_021048_142092_F6AFE6D9 
X-CRM114-Status: GOOD (  14.80  )
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

On Fri, Jan 19, 2024 at 6:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> It's probably worth doing another roundup of where we are on our journey
> to separating folios, slabs, pages, etc.  Something suitable for people
> who aren't MM experts, and don't care about the details of how page
> allocation works.  I can talk for hours about whatever people want to
> hear about but some ideas from me:
>
>  - Overview of how the conversion is going
>  - Convenience functions for filesystem writers
>  - What's next?
>  - What's the difference between &folio->page and page_folio(folio, 0)?
>  - What are we going to do about bio_vecs?
>  - How does all of this work with kmap()?
>
> I'm sure people would like to suggest other questions they have that
> aren't adequately answered already and might be of interest to a wider
> audience.
>

Matthew,

And everyone else who suggests LSF/MM/BPF topic.

Please do not forget to also fill out the Google form:

          https://forms.gle/TGCgBDH1x5pXiWFo7

So we have your attendance request with suggested topics in our spreadsheet=
.

Thanks,
Amir.

