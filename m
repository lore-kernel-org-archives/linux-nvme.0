Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6ADCA5FA1
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LRXRMKUc7hby8sfn6/3owXND2OxfjdsuZ9xeJILdsHY=; b=Gy9ySDcLIybFBOpvj9s03wyyJ6
	CoUlZH7m+bUubNAGY2Bbu4YadlnocGLbpe2jMJ/yDYliJMWpa/spfGEgK/3y0MI654TnayQ09qXox
	ERCYn/z+MKcm8Ztnl6uDxka3FAz2101+gyy4i9gV3RM42ALPItHfZCzEC+4Fa5H+pgFb++4rjMNPc
	PRhlNsSOR6x4ZA404dGYY4io9Ry4Pm1BCQKM7/RweoPb+vhRweWzHLeJbpgNbop76efJEztBcBVva
	y8lZAReFP2t8w6OTBDcOlMf+JW15dn7ntiHrjVoi7t4MQ6zMpAx1frc9jIV9NjoDFBCyxOTcKqs7/
	t3eCEJKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBXmu-00000003f21-1Kmg;
	Tue, 29 Sep 2026 13:22:28 +0000
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBXmp-00000003f12-49Pb
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 13:22:27 +0000
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-3411e0ace58so5483481eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 06:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688143; cv=none;
        d=google.com; s=arc-20260327;
        b=PDKYA9PfXTzXrc6f8wg73P/vW64GJt/zJlXSx2sxZIqJ2w/Nn75lxZ0raqTsv6gQCC
         MNtN95+bYu2D9lsZvhJtpBBDjbIhPxuDkMuHpHhQL3OssXwzqiQyymK/0/EId+Xfj5rc
         WPKUbFW8k/TFrczrb0KGZQb0A8foO46mkJ5qDe7+g1IRoEFvxX5KtrhiMYm9TzyJYgfc
         DgpdbJl/9PlhmBHzdH43185PVEMu0dy/qiwD0QLHdIUmdaDu69TkLjwVtQzxBAgGLGaE
         JN2RMI6HpEHHpIF2zsKVIE7Hn5o7g9j/PZY7O7xffygfSOLCoJlwuUkxYkUdmCHa3C6V
         5XFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LRXRMKUc7hby8sfn6/3owXND2OxfjdsuZ9xeJILdsHY=;
        fh=TSrpI6PGemanUyH3ZXFRJYwVeRz3t8IoUVdtgOvdUC8=;
        b=lr4KyQE21Ja3i58qgrf+U5iqTOVI0w/XlyDFVU+lOKju0NIQXhn6rBYPfv5gaAcZxs
         aOJu3MCOu5WJVYM4F1G8NekbmFnrhjZZVnfEawQc9dQGSN4Z4d6i61JNUHMGGP65fcpk
         +0OMz0U2vnSwsn5wL0cHBj461ksnj4sdQZq/kN4aL4R6IAPD6rTotyIBgibUPPJhXeo/
         xI0E4+uqVEGK3uXDScg8CSFxYd9kpkciyAFj9OjjhH1cYCHubOY9bSzlN6mTu5W+/E32
         ugAIghW+pk3QUKcCjoVvSIzETX9vDA9xVE0bR87USNJFaU4QTcG+rSWhoDXmjyZw87uR
         Hu6w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790688143; x=1791292943; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRXRMKUc7hby8sfn6/3owXND2OxfjdsuZ9xeJILdsHY=;
        b=DUA+sjIf0zBrtRBB/uR6/66UnQPM38scudhewW2NrMWNfArNvnhrU7fffUsfpW01Vq
         b2X5CaRDdY+WKP7ushYtZ7TRRB4kUrasoWI5aLGOG8eZtzAmJz/089NNRmWgxXhaBkCg
         TpNZKTbcFb4kh9XsupZeZ0T2W3uI054Wm6ExJwYZKLf0zz+zUGpdbATSjXAvwtrX2XRJ
         OJGKkiZKP3+++L0Avcf3dx7iCHY4IA/37vGD47YVMcUlSgjwIcx3Bhi/Y2D7pjyUiVdL
         L8lP5e/aPjTtWihbVKkVTe5dvrZzME29gAlcPywzEHXWm67ugUYUujRETf/qbCOAHEGb
         eYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688143; x=1791292943;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LRXRMKUc7hby8sfn6/3owXND2OxfjdsuZ9xeJILdsHY=;
        b=foJ2JOEp8uGuFeJNshlSTOMggvRccjsYofXeI/lUPdHDeGh7KFLROrDpT5bYYllWYk
         GVGrACaZg9XzAwZfqzorOaNiqV8KsZfeMjFDCX02l0PMbPFIKAsMjwGVik/TpV0z68nt
         inudySDp3FIAKxa6wJLy0TxN39TafbAy1lf4G+CnIZYJl2x7N8HgVciFWEbO9fCErF3o
         N1pDwJJquuR015WPfolba4EInsyQYdl+s7xE+HHsJqIwyFiZs6T8M+nb2OfywYIX9WWc
         NXaZ5aquKfeDhw1Y35Jp2cxyFVGJwJRtWGzwyj0YdAW9bx84yQ9Y+U7EYueSUODyhU67
         G6Cg==
X-Forwarded-Encrypted: i=1; AKwUvBwYPuVdxkA2QpmUc9fSwxSoXm+G2pzwKlgtWZ8ywbE6l5OHQdvzXwOXAfwRAZfLKmjZe0KCN2g30wkm@lists.infradead.org
X-Gm-Message-State: AFq9FYI8Aum8JMsLf16bu58UNZ7/Z9MgyQ7seekuEUYYjgIfcF7qVsSN
	4yqV+PkKVl8X6RBAbXMrCOn3/yg+kntgyUL0rAxcdG4KXO3TU/D2yvfUBN2Yn+10U+lrd6Irnbm
	8a4/wrP/KkM8IZZFDVPl0WNy1yu7rSuw=
X-Gm-Gg: AYBFou3qFmt3ddMAH8Oeh9F7Fm6qo8VfzZkchPWiHNvRwJC9x6CNmBo0ZbNH0psXEb3
	UqKCYw5/TwPjGdY07/3JRZ1khOwsXG1hbq8KyaXvwhW0uIRFzTshafLp9P6kzDY/12MuGxOTuyf
	KE5TvL482qTM8KWG9VLb2aohc7zDD1QJ5Vv08sLJQ1URt+G/ZjNqOMNAcDkejoWx7BCo/MKQ98l
	AAJmlgs+28XvjxBSyoShGNCGhyhI7dSzHyzB/hL+1hnlTNoOBvWN2gbrqpOZg5yt0rN5Bl1Sz66
	feQNYvF9MVFb1WG9QoVKqvhg2SCncFNI6ZIf7KX7G0qku1a/XocfSEw4hGASaEglpi934/ch5EX
	a2106CSivqeZVBWrD1yZ7nveBWOeooUAiBVZqTEsvhz4UOijscTJSnXuBGxqyUyuT/qoS4rhkyS
	tVsB0g/wDSiROQKTUIePa+UTkBpRUzYPV5bCiLTpxKyqal2ggee24=
X-Received: by 2002:a05:7301:1501:b0:343:fdea:9a4 with SMTP id
 5a478bee46e88-343fdea2578mr10273152eec.28.1790688142453; Tue, 29 Sep 2026
 06:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net> <20260929-debonair-busy-hamster-be2fda@quoll>
In-Reply-To: <20260929-debonair-busy-hamster-be2fda@quoll>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 29 Sep 2026 15:22:09 +0200
X-Gm-Features: AclHuK_jJoonbrdcWTM4pJ6-SA0D9nOYSb3Qq4ribSs7qfnRaIDq9x1ahszR1jY
Message-ID: <CADo9pHg2JyGyOA=_6orXdhDwj7NaKRBciyQMG2w7fQcPm0MNwg@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: mailbox: Add Apple M3 compatibles
To: Krzysztof Kozlowski <krzk@kernel.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_062224_034496_435BAA13 
X-CRM114-Status: GOOD (  15.63  )
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

https://youtu.be/TPwe53kCJuM

Den tis 29 sep. 2026 kl 10:21 skrev Krzysztof Kozlowski <krzk@kernel.org>:
>
> On Fri, Sep 25, 2026 at 10:22:49AM +0200, Janne Grunau wrote:
> > The ASC mailbox on Apple M3, M3 Pro and M3 Max/Ultra is compatible to
> > the mailbox on M1 ("apple,asc-mailbox-v4"). Add their per-SoC
> > compatibles "apple,t8122-asc-mailbox", "apple,t6030-asc-mailbox" and
> > "apple,t6031-asc-mailbox" to its dt-bindings.
> >
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Best regards,
> Krzysztof
>
>

