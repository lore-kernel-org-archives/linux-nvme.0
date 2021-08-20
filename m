Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D94C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 18:35:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690FF60F8F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 18:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 690FF60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=OIc/5MVzzoduyY/t9Xl1j1gBOT4NJqzOjmOOaJIPBPg=; b=Z28
	afPtDtOiHU92sVdFcaJkbpVtF+1nvIPZrcNeCSOnnRng2xDhxy5YvfDTCXoMeTsz/8YyboeNjJ7O8
	IUmXtJCHioyNrewNx5M+UA7fm6kIENVJbobhaHfulDeFiNP3dZaM8QvdTlV960uecGAx30JqIzLxB
	PZ1uksoDVCYSeF/XsbEzKtcibSItQcIG/QVwSeNBPSogpwCh/3YKH3OPzpT0TfiYfq0vzOAOs4h9N
	i3+ur8I61iSxvQjIMUqxuuksgI9rbtZr1kbIChvDFRgkRnrlNp+6rslmHyR+7xSsCY6Xv9DR5dAcg
	IYivjcFvUb8X3jvtecvfFm/GHGfxIIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mH9MK-00BtUe-Uq; Fri, 20 Aug 2021 18:35:17 +0000
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mH9MH-00BtSL-R5
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 18:35:15 +0000
Received: by mail-qk1-x72e.google.com with SMTP id e14so11816967qkg.3
 for <linux-nvme@lists.infradead.org>; Fri, 20 Aug 2021 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:to:cc:subject;
 bh=20/a0sZ2dzFKeddKBSkNEVtv2AMo9NoJrHJmvABR31k=;
 b=iraa4Yg2ZIyDuLWjWxoz7XhaITVgAYkL2+UmLSFrqzMB3Uvs29V23Zg5ZWoo3nSrSZ
 b0dXIrjTqoCGqlt1bugRacT5AbM7T5760fHd5UgMw48rJMdz4pQCKgkQqu+1q6icd7Lh
 tR4z5xVyYZXDdAyNdKWuDuKWkAVefKGJAU+UbRIwopG6QmTsWlPBx9e+xAAOzGooNbGA
 /5NPhzg0yAMk99xz4CasbFUmtvV3ciy4mALUH8pW1BZ0fEBCJlOUuEc8VXFVTaPaSSfd
 lX0gEIIFctA+XwIkf/dWjE4RhQP77SJUbdLGVanMyBnf0sf3Vbd62+dQ9ux2O4jgxyRK
 V1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:to:cc:subject;
 bh=20/a0sZ2dzFKeddKBSkNEVtv2AMo9NoJrHJmvABR31k=;
 b=UJs5GhQZPRKyVdgMeD198vpZ7FdtFqEbrO9mkNXG5Ighz12gs9jXXNuj9FUcY93sEt
 3gp0yliQQZBjM46KqxIiAzu5iHPXl+5s8KMq89e6UjkSypAFeYS9Jt1IJAczLvEed970
 vVGbKJ9XaKZ+D/Jvca04WhfWOkJryN267HTHkhp0Q0vD07TADND6e88zanjs7/5k9iLK
 Pj+QCuDslM4Drb3Wnd1gw9U/IAqlHgUxHcS6vXmUXPx0KACzlTGjnmRAhsLV+2XFvIjf
 FSsak/v3+97W7t4gIkPabtm36oDYMSw+9bH7U5MdUql/E25RVSZaTKC5VKG5OklDSb7C
 IJIg==
X-Gm-Message-State: AOAM530zg/Dd+3ST9YSHx2Uaw2ilwotCGxML5Doz/L5fWvB7reaEAayp
 u90ipC95aP1I4Xldw1PmuyMgSQ==
X-Google-Smtp-Source: ABdhPJyu6VME/MSR6isTYWyYplihN92JlMd+BYrZuko4mFZdVnneppsOXB+uYbKpE5mJc8NKjPKd6A==
X-Received: by 2002:a37:9481:: with SMTP id w123mr10382554qkd.75.1629484511800; 
 Fri, 20 Aug 2021 11:35:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
 by smtp.gmail.com with ESMTPSA id p187sm3584045qkd.101.2021.08.20.11.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Aug 2021 11:35:11 -0700 (PDT)
Message-ID: <611ff5df.1c69fb81.43234.a478@mx.google.com>
Date: Fri, 20 Aug 2021 14:35:09 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [REMINDER] LSF/MM/BPF: 2021: Cancellation announcement
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_113513_959551_E8517A3C 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2665040941510920715=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============2665040941510920715==
Content-Type: text/plain

Due to the continal assessments and growing concerns around the spiking COVID-19
infections worldwide we have made the decision to cancel the Linux Storage,
Filesystem, Memory Management, and BPF summit this year.

We are investigating dates for 2022 with the hopes that we can finally hold a
safe and productive conference.  When we have finalized those plans and are
ready to begin planning again we will send out a new call for participation.
The current board will stay in place until we can successfully host the next
conference.

We thank you for your patience and understanding while we continue to work
through this very unpredictable situation.

The linux plumbers conference is being held virtually, and there are several
micro conferences that cover the various topics that we cover at LSF.  If you
have the desire to still talk with your fellow colleagues I encourage you to
look into participating in linux plumbers and possibly submitting talks for the
appropriate micro conference.

Thank you again for your support.  Our sincere sympathies are with all those
who continue to be affected by this pandemic and wish for good health and safety
for all.

Thank you on behalf of the program committe:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)


--===============2665040941510920715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2665040941510920715==--
