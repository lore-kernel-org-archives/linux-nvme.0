Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF08ECAAD6
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 18:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XnP47D2a+NfTs/kKZwaTdIdxwiCYCTPoKf3Nst+QNqM=; b=XGCTlu0diy6NXlJYD6D471pGCy
	LZ865LXg3NMwe6G/q7GdehL60y3tekVa+Dc38FOe7QJqenwlmsmE1y1vi78jOWg+Z+xv68vE2dTMb
	ozk0FWiXp6UgihzkOT/bqvGMFddjv7YiLIS9+1lBfbTQIu0SoPx2wJCSMbK8wCoyGJKs29VfN8TA+
	IMhqGlHnUvNHMzvmK8CH5zlgtkRs2x1OZgFyBII4xBSpuyVhXy1Kfu8EJeV0FTAfEt2orIsPjybHG
	10wKEA9tXP1y1gPBIzclZPv179uP4IE5x2JXJtsggQaQBeqTpkgQo7tpTFVER21wQAhBKPGpG/mkJ
	tlJQ6hSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRdtE-009qlO-Dc; Fri, 26 Aug 2022 18:17:08 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRdtB-009qjD-9j
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 18:17:06 +0000
Received: by mail-ed1-x52c.google.com with SMTP id z2so3089064edc.1
        for <linux-nvme@lists.infradead.org>; Fri, 26 Aug 2022 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XnP47D2a+NfTs/kKZwaTdIdxwiCYCTPoKf3Nst+QNqM=;
        b=MJccE0t6UXng4JnP+czJWRP/siy5ayy03+Ez+0NNbsvQizm+awEbThpgN9ow4KbUoK
         ZFvbNdkR8HtTVUXE0cULcfDZdg/S2X3m1kwyP+vtJcDjfgH8VNiL6ePm2CFX8D4xiAn7
         u3i3a2MqU4YJ71SZsSRiBuckf80cBMQXe/6r989HTxkdLpKoLQDAKPCEft5CHiSMfom6
         CCvtry2Tm2AwyewqahV+Q4DRjgeeRxqWl5B04qUO/L4UIgbCcKT5OBwIr8r8t3I/pidj
         copqlXuXFCRP/k5wSA79EcFTx7fhvjY/UrSOYIJDwKkMPfs7PYmFNkcWZJFbQH1XGRj/
         iR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XnP47D2a+NfTs/kKZwaTdIdxwiCYCTPoKf3Nst+QNqM=;
        b=2Q1vVUJYjmfSmJRTrzmM5wfH3QZ1cFATpW4UHQKnFqc9Q8uCzPtHd2JUjdoS0HgGvw
         DIn7bVHq9Hcyapb9bDsnJA9GTmULiWGz4k02O4qqt+Wp1TqLB7h7ETjuqMoyM1WgedGj
         o5ghROXcNmxRAnS2oYLBY2/GZ63Tk8uVIAJem9AXV8WqLpP0rNT5AiDXwQn6MGyEuWr/
         0VP7+0eka3nD7sWCo+alUhXYlqMCRR5r/sqw/rNh1ufJZ33NTmf8J/qo+luUAbZiZS1D
         9Sj62Qhbxqw8dhFkKqKGtFzkLkdK/GRaQN/mdFqQeoFRQk2GlOaMq3NvPW/dIlF7wPHg
         cwgw==
X-Gm-Message-State: ACgBeo0a/gXC1bI+jvuEwFjwiTrH3EG+3G45gpKTZC7x4yEVuO81moA5
	gJS/SxwlscO8ZvZ0SzMrXo9Le4t4y4A=
X-Google-Smtp-Source: AA6agR4E6ZpdSAyC1bg3h1uG81oJplLP4E6Oe+c1BC7qlmZr7SCAj4LjCsevF5NflhRLZVl4ReP6CA==
X-Received: by 2002:a05:6402:448b:b0:43b:5ec6:8863 with SMTP id er11-20020a056402448b00b0043b5ec68863mr7522282edb.377.1661537823830;
        Fri, 26 Aug 2022 11:17:03 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id y3-20020aa7c243000000b004479ef996b8sm1640963edo.11.2022.08.26.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:17:02 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>, Ira Weiny <ira.weiny@intel.com>, "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Fri, 26 Aug 2022 20:16:59 +0200
Message-ID: <2887364.VdNmn5OnKV@opensuse>
In-Reply-To: <YwVjpTW6vWvdVQTK@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com> <20220822142438.5954-2-fmdefrancesco@gmail.com> <YwVjpTW6vWvdVQTK@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_111705_358973_9578C5E8 
X-CRM114-Status: GOOD (  18.05  )
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

On mercoled=C3=AC 24 agosto 2022 01:32:53 CEST Al Viro wrote:
> On Mon, Aug 22, 2022 at 04:24:38PM +0200, Fabio M. De Francesco wrote:
> > Therefore, replace the kmap() of sg_page(sg) with a page_address() and
> > delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
> > local variable to iov_iter_kvec() from the call site in
> > nvmet_tcp_map_pdu_iovec().
>=20
> I'd suggest looking into switching to ITER_BVEC...

Hello Al,

It's interesting that, for the second time in a few days, I've been suggest=
ed=20
to switch to the use of BVEC. Christoph asked for first[1]

I responded to Christoph and, in the same email, I also asked Sagi
(the author of nvmet_tcp_map_pdu_iovec()) if he wanted to add something to=
=20
that discussion.

As you may have already read, I'm so new to kernel development that I still
know very little about many subsystems and drivers. I am not currently
able to tell the difference between BVEC and KVEC. I could probably try to=
=20
switch from one to the other (after learning from other code), however I wo=
n't=20
be able to explain in the commit message why users should better use BVEC i=
n=20
this case.

My task is to remove as many kmap() call sites I can from the entire kernel=
,=20
and this is all I did in nvmet-tcp. After doing many tens of call sites=20
removals or conversions to kmap_local_page(), I learned to not go deep into=
=20
those details which aren't needed to accomplish the task I've been given.

However, since you and Christoph suggested doing more (I suppose in a separ=
ate
patch), I did some research which seems to confirm that iov_iter_kvec() may=
 be=20
good for what it is supposed to do.

Since you are talking again about BVEC, soon after Christoph did the same, =
I'd
like to understand better which improvements do we expect from BVEC and why
and when should developers prefer this or KVEC.

Can you please provide further information or links to documentation?

Thanks for your time,

=46abio

[1]   https://lore.kernel.org/all/8107517.T7Z3S40VBb@opensuse/




