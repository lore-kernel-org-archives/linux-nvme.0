Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075F5C10DCE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 21:06:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66FD215A4
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 21:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ejhsRRHX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFRTqQc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66FD215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GfILJkyWTtTxXVf2+gILsy7EAqoO2Ni8m2f8ZWXN5zA=; b=ejhsRRHXis678J
	sbS5AJuNC+4m2/YxG2q8XTKL1Uzowr9vQZZeTqvSHtd6WQfs5iIpuELBYYRHMViLF/94eSwdKYAGf
	SdLQvVAeN0zImHfL8I6IKLOBqhGwmvyfBUNqTbKDaBNx/JebJ46XKNxrx5JnnMfBO0LF0T7tLlOsZ
	mJ559vSNaNaeBF0Oz3RqtcvlHsRSy/5eGrGMeXhw3Tre9J3XiexiLoR8oQW+ElKsz7KTSIRAJFO+y
	3QvXSRPdsbjPRfWs/EIIDsQTBI97aRgdk94pdsj89pyzrtqumaSr460Nmy/+bj8cfn5qpicT/8l9+
	+ZPpqsJfbHdqzupCJh7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBm5M-0000LU-Or; Tue, 10 Mar 2020 21:06:44 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBm5J-0000Kz-WF
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 21:06:43 +0000
Received: by mail-ua1-x941.google.com with SMTP id t20so5225087uao.7
 for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2020 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D+CcqMCGGfLANRRYdXwD4WpcsZVTawPHYAphcEMeQ4o=;
 b=YFRTqQc2/Hsix88xWZybbWKJ9cBtq3ncR8SjfbllUrNUVLYpAlaHL+nBrpMjoAutfe
 59n1TGQpps3+Me4NTettQ/Oy13uKNGkFdnTjL5cUYtWiPCpsypibW9gLGUJ6ok4RR5T6
 o2JkokJVCIqRjK3PfuWnWRj9rKUCT6J5ppLA7z1nPGkGkHjZGkqMSkDLFRnHK4Er+lpB
 GlwGcIQMgz5lR/88F07BNTKtZ3LAFyEnA39/B11OBSN4Gy2wWzbFQYDpUCUeV4+Wlp7W
 2ntkvXJLp2e4k7npye9CpEr4L2oqVoFjGKHfZSVZjJ0wlU2YEs/ibIUonb0U+WaWWT58
 NmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D+CcqMCGGfLANRRYdXwD4WpcsZVTawPHYAphcEMeQ4o=;
 b=KNNjKmm5Jh6KzJWbabRlbcYgFTJmMB5euD7krlSqc1PgRVbMlxhqfDHIhT6TmEqwXZ
 L9qHbGTaeJnBtd6t59alCzh++G6xUOCWihf+JJL/bCOFkAkh4Es9hKFganhnrFKqey+q
 tT3YhptGx+onHiaiVsb8XMMSkaIgCBqr5txdli/mqCMbCUtcJkfqPX6Wh0hBrIvkinxh
 WMC0fyXjbCdP1pUgzjjHSfqSK9SQRarQ0D5MF9KiAEJvoN8dC1KaJk9f524oClufJM+y
 iDA/97LHusvf545bqMxX2+zXzo7lpmAgaRdy8m3uowQZMYLiKPJ/nJDaSErM/ACldLfA
 HfJA==
X-Gm-Message-State: ANhLgQ1b0n0Rdi7dx7lmJEd1ANltq7RedFP2PUr2Q2vt0/jN6JQYkhGE
 jMsoWebk7Io+hqexHjr09ign0R3XQt6rQ62fDOlzTPqGQvQ=
X-Google-Smtp-Source: ADFU+vsHHk6A34kQIBnfLV3AVBmU5FJ744RLJpiFLaAgfaDwF/R5t4BOhiVF8ZbEHJpL5Dv/tmd2SLw5fyqZ9skx6eQ=
X-Received: by 2002:ab0:4913:: with SMTP id z19mr12890991uac.132.1583874399030; 
 Tue, 10 Mar 2020 14:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200220145241.12982-1-kbusch@kernel.org>
In-Reply-To: <20200220145241.12982-1-kbusch@kernel.org>
From: Keith Busch <keith.busch@gmail.com>
Date: Tue, 10 Mar 2020 15:06:27 -0600
Message-ID: <CAOSXXT7CP+4OGkQ+W9GR7kXYMvC=5iuAzgc2t5mv4BcEF+mBbA@mail.gmail.com>
Subject: Re: [PATCH] nvme-multipath: do not reset on unknown status
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_140642_062260_62DCAE6B 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: Hannes Reinecke <hare@suse.de>, John Meneghini <johnm@netapp.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 20, 2020 at 7:53 AM Keith Busch <kbusch@kernel.org> wrote:
>
> From: John Meneghini <johnm@netapp.com>
>
> The nvme multipath error handling defaults to controller reset if the
> error is unknown. There are, however, no existing nvme status codes that
> indicate a reset should be used, and resetting causes unnecessary
> disruption to the rest of IO.
>
> Change nvme's error handling to first check if failover should happen.
> If not, let the normal error handling take over rather than reset the
> controller.


I've applied this to 5.7. Many developers had input to this patch.
Please let me know if attribution should be adjusted, and I will fix
ASAP.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
