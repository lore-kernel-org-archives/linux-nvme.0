Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75561C2D0E5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 20:48:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6EE206F8
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 20:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RYMifSYi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="T368gTjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6EE206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I7AWFLBJ3CKqHj3LxCfAEthcxQ6ddrJnTfe1TsBG4D0=; b=RYMifSYiHxNNMW
	ndq13UxIkHLWTfupzteY7awxAJrJL397LUVPwq9fdR4GYCxUaMJ/JTIHRKaTbO+2LTtQlRLbZYkaW
	MfFoJb+KWw6Fpx6V6MGuHKfjSUR5sRoE9TxXjzn6KKkt1xqlxRanwBq4N1OUmo3d+JK4mUguRi/Vu
	LwlwL1SFPXF/vW5gLseoik8ivul1oyb35GqMsPHKBxfheQbbM3/yo4nfl675ys/FNvYnFJKGVKekZ
	KD1mxBQTn0ZZ7SN38RYQkcMowi2bt6iphBUImtJ/tIyHXGOAXuz9d4I52/1oCs6kN/9eEeaAbjsws
	t31zB9dHbv34V5NqRI6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHCx0-0004wl-9Q; Wed, 25 Mar 2020 20:48:34 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHCw3-00040w-Kf
 for linux-nvme@lists.infradead.org; Wed, 25 Mar 2020 20:47:37 +0000
Received: by mail-yb1-xb44.google.com with SMTP id r16so1958217ybs.13
 for <linux-nvme@lists.infradead.org>; Wed, 25 Mar 2020 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=draconx-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AWwQ/MdaFzRK4+oXN2BrrbghUCKIcq6WVRGHgMwSMoQ=;
 b=T368gTjF0aOe98QD4dHhs2rTWG344V2Rf/iyJgNKx9THKEYXDkjl02/dGNDLFtM7nj
 04M2gV8pQJGD25wSdx29quKI7fxZR9fUUKbpW27ht+0gBDDe0BIeegT9DIUVnzvFKq+f
 TK7HereiGXj+g+xSgBISbCOFKRPOoqQGgv0mN1Bnl+DwR+4x3JUA4SbzhYHLPIqMZr3n
 YqHroq+UvejoVIWB9Hjk4hVnRHq+3gDFm1YUUr/936N2tqcTYb9+aDrA+N+W8hKLasE5
 xkAu6agUKCXW/GEnFUbu8Q6Y0lZN1NOvF68kQevsg/Oda31qEY8rO/vKj9QFb9zzFIf+
 Sbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AWwQ/MdaFzRK4+oXN2BrrbghUCKIcq6WVRGHgMwSMoQ=;
 b=pRhWqyVUi7jvqxhzxT3wYcGbTZVcwQpQvYE5DuSbIpRrdbtelg/1nNxsDFH2CChcx3
 aa7RO7eTAPZHLLjgZz5oqMPhy2+bbZ2W7TuZgELw4Sxhij37543jh+3PJUnWS3DcsxkF
 LFKiehDwRcXUCdSIL6MS6y5FEDoAVOYlfo5QsyTXHwZXSMnYRCrkM6FIKHhmGyTDJse3
 3AFS3nkbFxO5try/WjGDfjrh3xAUfFi+lxBoHL0eSu9PiR3u0ZaGef9KRXRjGoqSAuRe
 EBBwXjzzuF0d/BIr2CGaH+FI6mYUlsoY9zzpvcNTXSU3PKnpSobJ3mqPzr9EnV4Er94M
 fsgQ==
X-Gm-Message-State: ANhLgQ2NVePABxYu8EO+rnhzLAPNxcGYXMI0KOSyjpyj83SJ94HsAqHu
 s/Td0wZGWRXGxxo3U+fsMsjYx/DdvqKxuyf05cmaQQ==
X-Google-Smtp-Source: ADFU+vs1XgkR9lF2quFpA7PJRkEYrsc6qyGubhJKxmGaZZzqqGv+ibNMhD1nbGqx2C3wRh2J97JIomt72sdIrlmtTZA=
X-Received: by 2002:a25:bbcd:: with SMTP id c13mr8893628ybk.9.1585169253378;
 Wed, 25 Mar 2020 13:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:1941:0:0:0:0:0 with HTTP; Wed, 25 Mar 2020 13:47:32
 -0700 (PDT)
X-Originating-IP: [216.191.245.228]
In-Reply-To: <20200325204343.GB4960@redsun51.ssa.fujisawa.hgst.com>
References: <20200325002847.2140-1-nbowler@draconx.ca>
 <20200325191103.GA6495@infradead.org>
 <20200325204343.GB4960@redsun51.ssa.fujisawa.hgst.com>
From: Nick Bowler <nbowler@draconx.ca>
Date: Wed, 25 Mar 2020 16:47:32 -0400
Message-ID: <CADyTPEyKyEc1fx6wRGJAT_QctgMcrB1SWP_9-QdewXU3xYGumw@mail.gmail.com>
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200325_134735_713088_A9C2BAB2 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-03-25, Keith Busch <kbusch@kernel.org> wrote:
> On Wed, Mar 25, 2020 at 12:11:03PM -0700, Christoph Hellwig wrote:
>> A couple of comments:
>>
>> No need for the "." the end of the subject line.
>>
>> I also think you should just talk of the nvme_user_cmd function,
>> as that also is used for the NVME_IOCTL_IO_CMD ioctl.  Also there now
>> is a nvme_user_cmd64 variant that needs the same fix, can you also
>> include that?
>
> Yes, this patch should get those cases too.
>
> I unstaged this patch for now, could you send a v2 with the suggestions?

Will do.

Cheers,
  Nick

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
