Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377A4C3063F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n4kUBRQrdx2CGWwKrDgL92ebtE5Gyg+bfTU+CSzkAt8=; b=ufqWHz04A4gn6kUQRSjfpeZOwH
	519E8cMaN9m5Syq9hM3WRmL73J4yTHumLp1x6xUpRG8rqDCwJjP29/LiwLkzMUSdxRKkvyEmg71/F
	H/JO68q7CRAMjoG/EsxwAWcshJrpBeiE3cWPlqQxLMJalEC1iIif+I0APvCPPrcDjNA6k8cd0aZoX
	e17jGs6+pcuFZPwwe7fvf7DefmUtWnH3+pKGS6k/IOKm4ZXKnOVXU9SoDcm5kvoxepzGWSNt5Zc0V
	ddeSi2Eg+YWf5Zlq1ddmbv24eEr/NaYcShMB38e1KHLF6Gqcn2joV9aL7kL8s3cBLBEJnlKgzfRnp
	ZG+fsw6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGNIy-00B6OB-0G;
	Mon, 03 Jul 2023 17:25:40 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGNIv-00B6NY-0W
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 17:25:38 +0000
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso7243124e87.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688405133; x=1690997133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n4kUBRQrdx2CGWwKrDgL92ebtE5Gyg+bfTU+CSzkAt8=;
        b=fPvby7RWNhhWJ3wBolEnbdAotZ3JLJT78FZIvayG8/GVnG0STYphwavS30ktr3Nq5b
         UYgTdsN4ho/jKZRazJDccpfXyWDR1o+lN9Qr5VEXT2Sol4VnDFHo6UtoXzKIlSF3ulIx
         O5dl7aEo2+1fyBcIhvjngW+iZ2J6shc1hiBv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688405133; x=1690997133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4kUBRQrdx2CGWwKrDgL92ebtE5Gyg+bfTU+CSzkAt8=;
        b=Ua2WrJ1frLGF9vOOeP/QehKW5yxqh+FMC8ibEKx0fPuVrFceNmLo9yyl2iQP6uBQcN
         1dBU207B9IOeanRMTROU7xgOaYC4TJrjQaE3ydCDyqgmD2xEWmwTfnNZ5U0K7Hs5qF0Y
         636gTqORYNejF6OFa53XMoUSCmdrVhfy5kCaJQ9Nxipr6cc3D/2VDqG11+1j6JBhs2vH
         QQvVm1usiSqIJ6vo0MJhphVWYoLIl4v4qHbJcJQSkCk2QlyFQJx0AQ+Qj0B0Wdjv06i5
         pJn7oYCNd7HcAlpz/BKYpfuTqJdXgYpfI6lT16G5sTCG/NKgGPEVHMzEtcodFqMeUPY5
         O84g==
X-Gm-Message-State: ABy/qLa1lLroxYFlZ5ULqqKD0/RZtNEAm6LA1McLoH4P4+n2Znz6/JMr
	SFR1vah25YOgc9xkF+QY9Q87ONY9Gs9zzdoWy8X9L9Qw
X-Google-Smtp-Source: APBJJlGpY2CFr1v61+apsyk80WkP/yMTXq2o6Lhekz6HRyI776VJ0ElrqOS28FCxK5aIUtXQhH1Jpg==
X-Received: by 2002:a05:6512:328b:b0:4f8:7697:5207 with SMTP id p11-20020a056512328b00b004f876975207mr6750291lfe.23.1688405133003;
        Mon, 03 Jul 2023 10:25:33 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r2-20020ac24d02000000b004fb745fd22fsm4046514lfi.32.2023.07.03.10.25.32
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 10:25:32 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so75552101fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 10:25:32 -0700 (PDT)
X-Received: by 2002:a2e:8955:0:b0:2b6:9b2e:e352 with SMTP id
 b21-20020a2e8955000000b002b69b2ee352mr7461069ljk.9.1688405131758; Mon, 03 Jul
 2023 10:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <23bd2eafa9b9a23e4a8a96fc0180bba9e77e42ca.camel@HansenPartnership.com>
 <CAHk-=wjgnB11KzroXS+Gi1TQO19uf0FvkMBn=V7mcQ8q78ucnQ@mail.gmail.com> <69eeacda-d59c-bec8-d115-4bf7c97d7690@oracle.com>
In-Reply-To: <69eeacda-d59c-bec8-d115-4bf7c97d7690@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jul 2023 10:25:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkqWU+OVkU5YM=X0rdF4wvcMynReCo+0fyD8ErMb51Sg@mail.gmail.com>
Message-ID: <CAHk-=whkqWU+OVkU5YM=X0rdF4wvcMynReCo+0fyD8ErMb51Sg@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
To: Mike Christie <michael.christie@oracle.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_102537_200859_C9CB545E 
X-CRM114-Status: GOOD (  15.40  )
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

On Mon, 3 Jul 2023 at 10:09, Mike Christie <michael.christie@oracle.com> wrote:
>
> Maybe name it persistent_reservation.c, or if people think that's too
> long does persistent_resv.c make sense since we use the "resv"
> abbreviation for reservation in nvme and the block layer.

Yeah, as a non-storage person, I really would prefer more informative names.

Maybe I'll never end up looking at that file again, and my one-time
conflict resolution reaction is really just that, but I do think that
we can afford the extra disk space.

Do people really end up typing that file name so much that the extra
keystrokes would matter (and if so - do you really not use
tab-completion? Is it just me that tab-completes pretty much every
filename I type?)

I did do a simple

    git ls-files | grep '/[a-z][a-z]\.[ch]$'

to see how common this kind of two-letter thing is, and  we do have a
ton of them (the test directory has single-letter "a.c" kind of files
too, but for testing that's fine).

Some of those two-letter things look fine: things like "mm", "fs",
"rw", "rx", "tx", and "io" are I think common enough in kernel
contexts that there is practically no real long-form version of them

And others seem to perhaps make sense within the context of individual
device drivers (ie there seem to be two-letter board revisions).

And then we have the ones that make me just go "Whaa". Like that
"pr.c". If I hadn't looked at it, I would have expected "pr" to be
shorthand for some kind of printing function (eg our "pr_warn()" etc
helpers).

Clearly it's not the only one.

           Linus

