Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82AC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 04:02:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6559720707
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 04:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U223Ozkx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbxz8r/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6559720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WzYH8KU1NKQ3nTSV5z/BFxTPhnB2cF9odj3b0enLnAU=; b=U223OzkxG/ZkMq3L9UvNS7ax6z
	vVtshYV/oNG/GR2zAwKMh7MHHCthqxd42eslcbWk9eMrTL/381I2d3CRWY58qZaJPFhY7NsoG6Bkr
	zxEJQpI2hHa97+lLeu5n+J7jDNNBorSTl2ltlaKurOJHrkXv2ZDhTIn+rCg2Vi7RPdehwKkt4Ws5L
	Gw/OX1pA23wcXied1yO/80qd0vzhFQhQnTNWd3anc4ONnS5uZvZIyAV1LNpwoLlCc+M6BeZG+dUyi
	2FH+xPy/v/ismiuzz/6r763ogWEjFrNy9gCkJLiPM/rfRBi5wL4yAcK8X7wtl8Kvw5kreBmrVT30w
	igpTaNQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAmdl-0008Nr-J4; Wed, 26 Aug 2020 04:02:25 +0000
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAmdi-0008NT-UR
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 04:02:23 +0000
Received: by mail-ot1-x32c.google.com with SMTP id 5so421043otp.12
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=f+XJlTdA6/a4K3H6q7PV9t+6VuNi31yQmnM7ZVxygqc=;
 b=Tbxz8r/UfFJiqIFFTkk73Ceiev5BhAOQBycmRqT8AbJIx1+Bn+GJzWgfUbH/7c0nnA
 QmcbpFf3I4KX33VJm41qV9GwcRRukfPqBLWnLlI0yQX54y6gs+meCZ+/a7rqf+1UmDLD
 sR4HwMEPQkZDwUVZLxkjKxEao7Wai9LxtdI4n+Qj6AMu/DMRhYxl3i4QfC2zDcQzvWbI
 BLzNwOu8GMRD1u4lC2Sg44yxjyeKsebfB3cCJCPJGiJDmoyfwWXpDCiVJoeqexqCnaDQ
 RT70VjQtKKL0hGKEsK1JephwqsXYTRsen6FdueaBlDjVQ4WlQxlhbzyYSmalOkaCuk1Z
 ywKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=f+XJlTdA6/a4K3H6q7PV9t+6VuNi31yQmnM7ZVxygqc=;
 b=rjCo7RuJeMyP6tOBEu0Ua6Ge7+KAGNW5zzf/Ss9FyBa0ZCr0n912WevDS2zRSUdt7i
 dSyrc3dvI+nk0+7jUAqFjPO0J3GXep2dTJj4Am4uMmBYCoFefg10U6oeKikp7Dcv1MZD
 zPUIy0YKoPH70lC+fwyNTYAVBaq+ZHA1O5g9WPrfcarJdOTNvb+AeyI35XNGDuBP0tcT
 dl1Q9gxKbfR6I+T+DtuyCXINBLXdOSph1/sPsQBXwvzbNBgqL8iiibNYe1p1KljnjmNG
 EjVeeDb5b+NPnt9kvd8dQBZWbK9JOCM1gcFdYOuhoMrW9yput/Tekryvelk0qyrfR89V
 36Qw==
X-Gm-Message-State: AOAM532Mp38eRaTnmADFgXUK6LsW0dhee89d/58pf/WskpLoHqKwUddT
 qmMCfkeph8pIrCFXk8EhBUt3PfSlSRs90lm7HzPFbG6F
X-Google-Smtp-Source: ABdhPJwxIuI52t9Qmf4SAlMRXLQ3PXMxYU+nLkbe3YCyfwQJTHKIbpnXeKeOhxxI5Qa8sQhUwvWn3sppIRzHgGG3lBU=
X-Received: by 2002:a9d:7449:: with SMTP id p9mr2098158otk.26.1598414540888;
 Tue, 25 Aug 2020 21:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <CANWz5fhgxK5QDJpKKnpDYQ9qfuOmru9M=oLdGEf8OkaW8bd8uA@mail.gmail.com>
 <20200826010348.GA2149583@dhcp-10-100-145-180.wdl.wdc.com>
 <CANWz5fihD7gpoc=PQxRKSOi=W90vFBj-z-+yb=OF2+DTJOChGA@mail.gmail.com>
In-Reply-To: <CANWz5fihD7gpoc=PQxRKSOi=W90vFBj-z-+yb=OF2+DTJOChGA@mail.gmail.com>
From: Chris Worley <worleys@gmail.com>
Date: Tue, 25 Aug 2020 18:02:09 -1000
Message-ID: <CANWz5fh=SqVf+bBWD4YB7Rv9F4MMuwHVxOD6Zag9x=7pYRNfyg@mail.gmail.com>
Subject: Re: "Connect rejected: status 28" from "nvme discover"
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200826_000223_029092_D5A7D42B 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Never mind... redid it all and it works.

On Tue, Aug 25, 2020 at 5:19 PM Chris Worley <worleys@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 3:03 PM Keith Busch <kbusch@kernel.org> wrote:
> > On Tue, Aug 25, 2020 at 11:59:28AM -1000, Chris Worley wrote:
> ...
> > > Hnts?
> >
> > Does the target's dmesg mention anything after the failed connection?
>
> No, the "enabling port 1" are the tail of dmesg.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
