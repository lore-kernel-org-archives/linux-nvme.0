Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DD4D10F2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IftgS+SqRiORt75QLzOlSBI34TvyfdYZdE/tNo4H79o=; b=tSfztlrYUWOAnBFXu5gNxOLQ9X
	eB/CDD1n4sYeIJgdlo9UtfwULQ1czS5Cfdq0dOfa5iCOqi2nltiKu5g9g4MOikHDXxZVax/WcAGB2
	zXXB6fUEtcbaXR0hygyCUuee0Vj2I8bpgg7ZOiqX8L0+Xgsc7ML9rV/L+jTxkmOfmy+gueeZRASaT
	8xiD14sACix9x4hXIA1TkiYgqTjwEikKeGlTV7dLo+3l1U9PwJ0L9xjVGn7I1s2oltdqIXcBY9J+9
	G/4hyFehrfAYzHRwQQw4BVIP6bKGTlz6pI/Uie+6lYrxEOkuetDEHWC8MFuSwwTGAunpXgQyoDTfk
	IVcq0pCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOEzh-0000000F0xG-2sOE;
	Wed, 26 Nov 2025 12:51:37 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOEze-0000000F0wn-09p5
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 12:51:35 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-949031532f9so40239939f.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Nov 2025 04:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764161493; x=1764766293; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IftgS+SqRiORt75QLzOlSBI34TvyfdYZdE/tNo4H79o=;
        b=ljl/DZ5xbt7JyA/hUR/j9ECP0V+oNhKrdOpl2sOHtKSEN3rwfk8m+4+5MyfbnUcLTW
         dHeBQJoYZxyv8WunnuIQtRdUsbQC3OJBftMTUIiaTWCRnb3S9W9jWC0E1fUXowAsAnn4
         oGN8q1jKSUQX3DPeijJw3bwPbS1QQSjVM5jvuKBp5t638FBrbAB5irO/x+74boK5NGCw
         yqOnhasfNt5w5E+Np6M2q7H7Wl564PuzD9Ct3zgX9fNppZer+oTsEy2n7w4MTnVASPMa
         +7C+OrJbjKQOSPMoFx0/i26a7uOkXmACO48uWbDzTPcnoV+Zyn9sR+Y8GOd/+uA/N5qC
         5vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764161493; x=1764766293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IftgS+SqRiORt75QLzOlSBI34TvyfdYZdE/tNo4H79o=;
        b=lJiJ49yajVbes3hvbOPFSgesQaAU59uvLM8vqOM8Wt0mUpzLXuJuK+hYhT0ivt/h2m
         3wZzM3zUf9Q4Wsnt6dYb/dxxKBfVfNZwYA1xqLhyhNekodPw3kthddfYNwuDc4czUp6x
         WVn3CcEqQQC81jq5j7ofaWin+tMIHPR13Zx+W/uyDHLihR2kGHlwTTnff0U006wgQMfq
         eyxIOSTr6+CTF9XRHRsMjzmbtCCjj72s8qLzT0cVMRCHJ7C4tlNXQCt4rznYE7VC88jr
         QvzyHAHy/W9lxG9I0lPIgwDVQcqVvV2WNJ8pM+TGXeeLw9jLgzkgv/X3b25CF63bPA6C
         yrFg==
X-Forwarded-Encrypted: i=1; AJvYcCUwgqKbzQofzlXl8g0hy5YehC9ZjzfyWil95rtfuk2Jx5zX431an5XASoBXvVxOp4WALI0atDFrUVJX@lists.infradead.org
X-Gm-Message-State: AOJu0YyPPq138Q1S0ZJ7uCDwh/H3GO5y0vlivSIo2HXdC3eyAud2n1ee
	Zs+iL/CzUbhppWzOBI3FuLi+u5XveFYUjIqxDlU+AM84SWR91SatGyLbyi3xTAT890qevSnGK85
	W9UYAmmkuwZ9WGC7zd+u1Gt46uGQ+yYA=
X-Gm-Gg: ASbGncuZ8SXOYUnbWBUWJPMCQ46cijbmOo+HqBw4mjKUifORMK4vCsijXNxsCmOtnJG
	MhNvL+bH/bcoMnkPWhUuUL6TtVefBmThAt8AT7j6tYzlnbzdkx6ekyzAnGfH9KRS0yC/e9qiMtk
	CLriFD9tL7nvnH2qU7u4Sin6/7yARfgN4txLLyHdwHK8RDxOJpNPbCrU9B9EtSvLcz9Ls9fCdUx
	bqpSnhaedFZUmeymEZTDXTD8ftSBUEqoY2g8sOipi7VcXFwOPJp3tu3Lq1hy+v9V8KAXA==
X-Google-Smtp-Source: AGHT+IHhS34m+1SD8tJpx138zZD3EsRZi3N15GwK1gcW6eip8X0EM83IiyMjYmPSNpcESushN3pe3bG8ne7Hpsjh5vQ=
X-Received: by 2002:a05:6638:8721:b0:5b7:10ea:e2a7 with SMTP id
 8926c6da1cb9f-5b965b1af7bmr16025724173.8.1764161492726; Wed, 26 Nov 2025
 04:51:32 -0800 (PST)
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk> <20251126001526.GA13846@twin.jikos.cz>
In-Reply-To: <20251126001526.GA13846@twin.jikos.cz>
From: Roger Heflin <rogerheflin@gmail.com>
Date: Wed, 26 Nov 2025 06:51:21 -0600
X-Gm-Features: AWmQ_bntz_i1QiEa4TH0U930vkLMkc6r-_qhym5yOt8grjTnHgC7kUI2p-Jq3qw
Message-ID: <CAAMCDefgRUH5ygs10_=x75tOybvPPsYC-Q+KCFPP+9Le-x5RBQ@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: dsterba@suse.cz
Cc: Wol <antlists@youngman.org.uk>, Justin Piszcz <jpiszcz@lucidpixels.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_045134_076413_2BB345CC 
X-CRM114-Status: GOOD (  12.76  )
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

On Tue, Nov 25, 2025 at 6:15=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Nov 25, 2025 at 06:25:41PM +0000, Wol wrote:
> > Probably not the problem, but how old are the drives? About 2020, WD
> > started shingling the Red line (you had to move to Red Pro to get
> > conventional drives).
>
> The WD SN700 is an NVMe, though one can imagine how they could be
> actually shingled with slightly tilted overlapping sockets.
>

You have to get a red plus or red pro in spinning disk to be conventional.

On the nvme: I would check for a firmware update.  I have seen
multiple SSD drives from several manufacturers that had timed
housekeeping processes where something went badly wrong with that
housekeeping process and locked the drive up.    Some of the issues
lock the drive up until a reset and then when it fires again (hours or
days later after the reset) it locks up again, and some of those
firmware bugs brick the drive.    If the timed housekeeping it would
likely be some set time after you powered it up.

