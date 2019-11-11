Return-Path: <SRS0=nCXg=ZD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B9C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 21:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ED220818
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2019 21:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h5+cBTJD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C0byJPAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ED220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DUMK3b8MQAo4cxeGYCdUnlyjHKRBK/y9TdqsHZCp+k0=; b=h5+cBTJDdgiUkH
	rD7bmBCZvCE/TvW8+a1mJy+4kjAGwMjRk2k550CdV2K4t8bJUAXSFMY35tUqpwAXGsSsgs6ZKHp/Z
	LyLJ9xlfrjxtD1JoRdfqKk/iJgZvDGErT3YitZ5R4KgS+LCmetTcKof8tLPj+enPMveeUXKDczgHk
	1goNVAbRBjQnI0aPye4VfypQVJGLT42jxceSGEHTBhVAkAYnuP193XCEqK+xSXrP/277geLEHGtEV
	kBxLRrhXriDkmn6edv0Xy+Gh2SAyoFUO7klMgEL7kpHEzQOVxt5KgeuFH2X1/5IVcqChNKJ0HYDQp
	1eZGVjf5FWCcwsBA1tfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUGwH-0008Pj-I7; Mon, 11 Nov 2019 21:09:33 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUGwE-0008EK-Rz
 for linux-nvme@lists.infradead.org; Mon, 11 Nov 2019 21:09:32 +0000
Received: by mail-lf1-x141.google.com with SMTP id j14so10975724lfb.8
 for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2019 13:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iHSEG4DClXubyHOt3t2tdpDOQlrHJ64gHfdeM+gLICY=;
 b=C0byJPAHyBGELNR8VxwingUMAz9SgITb+A9AjnUdlNbZN9If1XFd42A9WqMnybvxSh
 0xLiQLCshpJ61VXki7XNugUcsdTCSnlP9Uq5ZvPtpwpXSh0oF/NEQUSxl30OzkfQZhqn
 1rf/q3MlN+w9M3x5JJsgY/AKPYTzGwbGoib87YokicnBfZgpLs1wXPr9Y9SpAD004Vpc
 6eDlSOScgt1RgLLp75LmDJ1HFnQwHPq2IYG+5NGSbdCgOJG4spodRKfaDMd6ziILXev2
 RIhm/RbObZ1Dj6FfGK7ro1/9OeFAFam69eF05Ix8bUzPjkHTLXqiKHkU0rFiMpVWLzrf
 Y+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iHSEG4DClXubyHOt3t2tdpDOQlrHJ64gHfdeM+gLICY=;
 b=YOTW4UVCoH/d4faQSBiLcHOBut9NrD5UXB2V0mZoU+jyqe21YnIDtqgy8dwJycLuQU
 cA5sHxbq9K+GSP2eYMBbV7pG47g21iTJioE+pQDwoN9sSIDQhskkAMk008r+mzA0N828
 EYKDCyc1qAmgGVVNrUfAQ6nyR1xWU4JeK8mMX3Sjk5Punp+jiRXtJKxqJC1bVjquHJUH
 i/6fjs6cNux/miUHB6zoctr+gy83hFUbQ3EleJK0HtSiKDuV6Ij4y0Nra714EdYQJ8Lt
 k4lfipdTCo9hR8/Ks10xBMMzrw0seNSj5C/TIoVloVSrPd4AfCs0cdgk73oz5T9Ht+ps
 L3SQ==
X-Gm-Message-State: APjAAAUFlAH4PwVdqSJ1tn1ON4yGauDkZ/eDO3Zj4VBh2DlMYv4zfa+6
 Z8t1gy7fOMRkzwsPoQmJi3sqB6jBuoOPD83gdO7Pnw==
X-Google-Smtp-Source: APXvYqyOV+qMajgujL1ZnUhT/5i+HYiizrcV+RZBGO/EpSCa9X8F8143Pct1qwA+SxxRp1H6OvOStCg/EzXoXYMk7qs=
X-Received: by 2002:ac2:5305:: with SMTP id c5mr9157574lfh.55.1573506568166;
 Mon, 11 Nov 2019 13:09:28 -0800 (PST)
MIME-Version: 1.0
References: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com>
 <20191111203743.GA25876@lst.de>
In-Reply-To: <20191111203743.GA25876@lst.de>
From: Alan Mikhak <alan.mikhak@sifive.com>
Date: Mon, 11 Nov 2019 13:09:17 -0800
Message-ID: <CABEDWGyMrDnuR+AzazHqpiHC9NrHFoVcW5iFREOey04Hv7xLqw@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: endpoint: Add NVMe endpoint function driver
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_130930_936227_A18CC643 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 11, 2019 at 12:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 11, 2019 at 09:38:09AM -0800, Alan Mikhak wrote:
> > A design goal is to not modify the Linux NVMe target driver
> > at all.
>
> As I told you before that is not a "goal" but a fundamental mistake and
> against the design philosophy of all major Linux subsystems.  Please fix
> your series to move all command parsing to the code based on flags for
> fabrics vs PCIe in the few places where they significantly differ.

Thanks Christoph. Let me repeat what I think your comment is saying to me.
You prefer all parsing for nvme command received from host over PCIe
to be removed from nvme function driver and added to existing fabrics
command parsing in nvme target code with new flags introduced to
indicate fabrics vs. PCIe.

Any more thoughts?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
