Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6CC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 10:24:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68BE64EC9
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 10:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68BE64EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w7KM4UUOtFDHPhHV+pBTMZsnWbclYqn/ctjbELlvTvg=; b=YYCOZlLQqwnyD7QEPXglvqWbN
	5mwV5vrWPUHVcwag5ADjipNko9fhoaLeQmD5MvTGUm7aGJbGhJl2c+WJlFa30bLtd4/tOEDchrIEE
	UaevWAlRO3udNuhhepXACd4fRsbUOHsnH+ctzDegpKl04OBPJr3dMqA2WFTaVoVLlxNTN5wbdiq/x
	5bKWWiYJF26O/c4iVD7lQBTrbDWrlNutIYDuaCxNtvy3MObLDcwRpFWepbiWqPNuY8d7giEidt8UL
	indemEm5DlVioxaFtFshNyeQ0VS+9y99kXjQSh26JRvVascSRLpFk58T7Gl8vlQGwR+TXr/k5gvK9
	i+wpHNFJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lErKd-0007bZ-Lq; Wed, 24 Feb 2021 10:23:47 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lErKb-0007aj-M7
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 10:23:46 +0000
Received: by mail-pf1-x42e.google.com with SMTP id j24so1053998pfi.2
 for <linux-nvme@lists.infradead.org>; Wed, 24 Feb 2021 02:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZeAKwUjfVantAtmk1WgAuKBtOEWjsNpRDHkEhf83xH0=;
 b=eacoAwUwa9BJ/olZP8XA0scWnTJT9LOjVeYj4YdQvcnfBqWRZeWKZuXj9NBiZe3jOW
 08Xsc/NIi0x0+y3EGgOGIg6+aafUYMHDQ4nL6ao6w+v3GrsnWN8plrPiZveV2/l3Kw7Q
 TjR0fE/CUF2+U8kxfbV/EFWwPCg71BkoM+ownofKxvxbvkCmzXEur+nqQ3ICeabGpxLf
 3paU8NZvnxJd0jHRXeBlBvK5yoTHQJ4JfUE0gHOzFLCQ36n1tVHCGeduO+ooOJbV4g3f
 3T0iwLdkmACPJIBtCJtPB1mX0C+/VRvDxFak6YIEMjfMb6smbYxGAvOecn2I/LOkpJ9p
 SjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZeAKwUjfVantAtmk1WgAuKBtOEWjsNpRDHkEhf83xH0=;
 b=VBKHjDqhn8i9M7tzKWjhZzZz5wyqFUZIYlSo6xUDxsNphKhrsUwO4xK3zl/AFSQMFE
 gAau8aZ9R9HDEZHY0mUNbZeRfJmBbeqcUrWUCe/SaQuDRy60n5LsNQY3p269iMfAhSn5
 t/q67NbLReZL+iIRDTC2oDspB2DVl+dVs7EQs3gzteIjjqbUvStsmFo3P9dpDUUWsvIH
 62Jz8/FifDirfMttdO28pa3Hmu8eY7EHfRMV0IznOtoHCEDiVeE1nLTFSEbtYjPOcpoV
 FVIFjpDU4+PnezKLGt2nilOJQUc3QaBMUhF4tnJj6WuJHGBQv2jVjXzN6fDjXl85AbP8
 dn+Q==
X-Gm-Message-State: AOAM531xmwSwgKwKc3PTQiT9N4Avvb7SOQec9hyeWJnyhoHhdhPlSToP
 kpddavJlLWhe3WI5idS+gDb+YgkxZh2sm16lFQpUZT2Uvp+pvg==
X-Google-Smtp-Source: ABdhPJzVMyqkkig6PMVI5kX3jkB7lrOfkMUdUbth9cA0+P12a9uiEUkfVjuBb+wmKJAJelLHuFohvP0gwThNOoKpFCw=
X-Received: by 2002:a65:64d3:: with SMTP id t19mr21882194pgv.208.1614162219399; 
 Wed, 24 Feb 2021 02:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20210223221046.3367795-1-pterjan@google.com>
 <20210224092147.GA2195892@infradead.org>
In-Reply-To: <20210224092147.GA2195892@infradead.org>
From: Pascal Terjan <pterjan@google.com>
Date: Wed, 24 Feb 2021 10:23:23 +0000
Message-ID: <CAANdO=LFVGNWNs_p9h0GsukVkRMcDQ1A5qsaa2m9HSPhu0wr7Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: Add quirks for Lexar 256GB SSD
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_052345_760609_90C358EB 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 24 Feb 2021 at 09:21, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Feb 23, 2021 at 10:10:46PM +0000, Pascal Terjan wrote:
> > Add NVME_QUIRK_NO_NS_DESC_LIST to Lexar 256GB SSD to allow it to
> > work again, and add NVME_QUIRK_IGNORE_DEV_SUBNQN to avoid a warning.
>
> Why again?  The drive has always been broken since the desc list has
> been a mandatory feature since NVMe 1.3..

According to the reporter it works on Debian which is still running a
4.19 kernel
My guess is that it worked before
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=538af88ea7d9de241e6b6f006e9049c4d96723bb
as the error was ignored
And I believe it would have worked again until
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a
as a waorkaround was added at some point (it changed at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb314eb0cbb2e11540d1ae1a7b28346397f621ef
but was laready there)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
