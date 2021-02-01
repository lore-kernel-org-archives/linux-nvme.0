Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D54C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 21:22:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B088D64E31
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 21:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B088D64E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Hra/ckkEljrsJ8oExyFxDTPfB0uWbcA07yk04cNE+n8=; b=eg13nJsH8Pkod3CPIdWIEnDjE
	1NIlyfcb9JSDruDj7y8JJC8LE8okcYPE9vi2TXIGkO+QQYWFl7dG0fr6owSQoJ2gOHuPl62qhgV4X
	5I7mQI9QurIuIEDluOlRKcazW/QIRtFnznAGGG1/0H0n7s9tAPBGilR3Ody3zOneM0sCV15c0c1x9
	WAgX7nRT9/9K88wKxZE1dXi4Y9m+4d5Q5A2x1WsBbE1JvpOkhCHjz8MUWpT8Nh3CQUAOCOlFoIY4Q
	SgCMU8BSUgp0Zzks7mOw/M6/QwBi+Mu8Q4lLecRyHeyz2LAkWeyPu+QXMwaYFViKTi5vT5m9Mjz9m
	VPBDYwIaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6geQ-0002t5-LG; Mon, 01 Feb 2021 21:22:26 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6geN-0002sb-Vb
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 21:22:24 +0000
Received: by mail-lj1-x236.google.com with SMTP id y14so8835514ljn.8
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=M1E08qwktNjxft9Hur0mDOy+OuwJr7U81/I0mSsJNSE=;
 b=D1H9U0FCQjqa7e6gyRQ3OWAuHC8vULWan7gF4zYpWbgLZKoeuT2vHLOmRfdIRuZwR0
 gO1z8CYCmkUhR2cdsNGgTd7AH0ZYm+QbWEjtSIpZ2As2+Qhura0bxfDDONmFIgqecxp5
 I/i99LpkwIadCmh2QAkC5xxvpvQRunSS1OOmjzJsWjyroM4fG3Ns3DH/8ItDk+cJUY/X
 whgZSBFAiViIt1ahZDXc6BVP3cY0t+92TUJ2lZM2q88jDHBgp+w0e6DCKgT4GcQs7Wlr
 4RTiV9uRIL6VUQmNrE8HKyXVPFiKYQbJ7r9EYemKLB9mU6r0Zm8BzNPhWAYqPiOOUU+D
 g0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=M1E08qwktNjxft9Hur0mDOy+OuwJr7U81/I0mSsJNSE=;
 b=g3SCTvJoIiWkTFVMtZ/bwVv6Uud8VsjwZU59Zl0D2jbQdPYN/Ykl2VQawxOGGGx+nw
 BhNDvu9Ok3A5u/vq+clqGbrPd/WPI58j+Govy8KeiNJO1mLhCEgTgCxprF/f8Z5on6MN
 gPpwD0Ah72nFZk5TE9FNlYZSd9yDGwRV+p52XR98mUV1uA6zqEbNok+cgdH2WpYSxz1s
 +1EUtFGZJ9Bc/VJyA1zm9vpFXezALM5HiOddIbuPy9mZf7Js6drygeerspx0O6QKN7xE
 1oYjilCv45CKQ1b11+Bk1KtqQ2SIRms63wEts6VdO/pDaPgEknPKAGT584nYEMRCRCWj
 m+rg==
X-Gm-Message-State: AOAM530WhnIxGO+sx5kaedmhOvIxzA1u3+v9bvz1Zh1GR10yaGurB6hY
 2yZkt4TORFq3bbNrdfIptkw=
X-Google-Smtp-Source: ABdhPJwlozNFkTA1rdHdgzDdMKM4I2U2ZU0YNFr37/+CjYf0aARwjUI2Z9Bz+xHvXsnvLgjUH7AGsQ==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr11316601ljn.441.1612214542167; 
 Mon, 01 Feb 2021 13:22:22 -0800 (PST)
Received: from nova (2-108-107-206-static.dk.customer.tdc.net. [2.108.107.206])
 by smtp.gmail.com with ESMTPSA id p22sm3088143lfe.187.2021.02.01.13.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 13:22:21 -0800 (PST)
Message-ID: <7dce6c69b48d97b467bb558c3d13ec134d44964b.camel@gmail.com>
Subject: Re: Missing or invalid SUBNQN on Corsair MP600 1TB device
From: Claus Stovgaard <claus.stovgaard@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Date: Mon, 01 Feb 2021 22:22:21 +0100
In-Reply-To: <20210125175827.GA1732047@dhcp-10-100-145-180.wdc.com>
References: <04fdb6a116bbc4d9eadc3f9434d8b6f2426e3c57.camel@gmail.com>
 <20210125175827.GA1732047@dhcp-10-100-145-180.wdc.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_162224_148588_146F1DEC 
X-CRM114-Status: GOOD (  19.02  )
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

On Mon, 2021-01-25 at 09:58 -0800, Keith Busch wrote:
> On Mon, Jan 25, 2021 at 05:00:57PM +0100, Claus Stovgaard wrote:
> > So I guess that Corsair MP600 is a candidate for the same quirk.
> > 
> > Considered to add the Corsair to the list of drives with
> > NVME_QUIRK_IGNORE_DEV_SUBNQN, but would just ask here first, if it
> > would be the correct use and understanding.
> 
> Yes, that is the correct quirk to use with devices reporting spec
> revision 1.2.1 compatibility but are not compliant with the subsys
> nqn
> field. The device should continue to work without the quirk, but
> you'll
> get the warning.

Thanks for the reply Keith. I have just created a patch with this quirk
for the Phison E16 (Corsair MP600). Being a simple change, I figured it
was a good start for novice in submitting kernel patches.

Regards
Claus


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
