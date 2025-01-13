Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C830C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lpBtrDCior8O34MzUqT/yqPqqHhYm723171PHTvnTNk=; b=RVJ/qtVoa+AZF55vbF5AsaIDXr
	82J1C7N3JHMWSFNu4DzzhMtU91RdWTbIUQgjHS03twGuNcv+Sk2NKfx9JO/htUbv6ky6ZP0v16kIp
	gzMaLblOXvPodWDZj9A0nefUv87XDLJR9WFjT1NZ09kTX5Z5hzlP9U8EPwHn7yVNa12Cq7uTTu50b
	dgiXx8jKWC3rOz7rgANdzlVmV3gIc0OWO5tRB7AsMRFUtJr+0EbraFjXlA6nTxoVeV1ZIetRbN/z6
	ym6J0QExI5MVnEoLAI7oW5mEuWhbKhgK1hvrR9fuDNHKo+Wv3RnLda0vgil/dXc0VdYozv5k0ZyIP
	pDyvY30A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOHp-0000000631k-2DMB;
	Mon, 13 Jan 2025 17:31:37 +0000
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOHn-0000000630d-3nio
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 17:31:37 +0000
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e54bd61e793so7864968276.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jan 2025 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736789494; x=1737394294; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpBtrDCior8O34MzUqT/yqPqqHhYm723171PHTvnTNk=;
        b=XWrvvYkTK4V6BVJTM5NXTP9bIoISvdNFfaCTULQQ9gHy8Tq9VNDxU/jli5CyCxJfwb
         sWzXEj+aEKAp7vizorOGXUk8O0SGHzZx+cEM/wkBfZS2XEI1Zp5YUMUZdRdK6iZVryWr
         94+CZN6zmg83rguAUYg1ONSI9DS/z3KhVz/0Vx0kqa1SxOa+jDYT/tSwAS60rbWMLhic
         C2HqI2YDHGwuKWyeIDm52+Nr3SaADlNKB+Ua9BdPWtPCBYpjyk3vdnG81U1vdul+WEEa
         SgHDSC2ndafY/ztwgP2A432xlD5gUiujnd7Jtk9+OAyMkCeJ17WhpWmdMlUJZPic7FcY
         zkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789494; x=1737394294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpBtrDCior8O34MzUqT/yqPqqHhYm723171PHTvnTNk=;
        b=KvWn0xVHFzmMjeConCbwdAJ5DEh7h/bqA7Gc1QkDT8wWpenVUecqCMqsFTr1JyUSDf
         ok3uKEZr94vDWISmMnBgc9kkVwpYBe7RlM/PrrRcNtcswfS/IYo92jdiDdufMqHuA/+5
         6JYQA4HIMcE++4P44LanZxUgw0XnD+aIjZPM9Or3e42UU1ZlWBMaHxUb699LvZKvVIse
         nPP/eOTXotM/dbD3VOuNMYz922EeZou4FfcBIC8Rr5ZK8VJES6hpvEHsXb+GJoLOL4d7
         VwEEfnITrDJ3pxTdECuBMmoUC2+nX6vznyNsj1uu3OoWuBGFFWWtSCVcNXIDVhK3Mfit
         xe3g==
X-Forwarded-Encrypted: i=1; AJvYcCWujPPd+DCeWjF3aZDRFGv/72bRcpbb89sWMvLaqgiozJyr5QUL9V+XtDXO9/FdXgtU8A9oeTq/chYi@lists.infradead.org
X-Gm-Message-State: AOJu0YzeIKo+A+YpZdqTrDDSdnRY95h53ttvTvIr0aYTh7Xg7eViRDeN
	JPEvAWKguMB7m2lyQrKHHkQffYvtHrZ66hYnMnTmTP8hMe3EtZYJIPaR+ZqF0shkODeprWpvIPS
	ppoDSZKSkozV0PkBnTKXXxMjF1Y0biKwo
X-Gm-Gg: ASbGncsxsjbwankZE+eBMTLbAssPiLhVsf150xinj7BcnvDaSgyhcv/y5zRxERTQLq4
	aSVTCSmBym44rbFlCZTp6+RYoif7Dv2dWU4aT57Y=
X-Google-Smtp-Source: AGHT+IGIYqrqJhbpEwAM5/MQ91bcPCmKZWFG0YoEFTypIrbLLyMAsNZInZc1ueMG8J/fuioNF/gFOXOTG4k8lQAjtnk=
X-Received: by 2002:a05:6902:18d5:b0:e57:4a0d:4716 with SMTP id
 3f1490d57ef6-e574a0d488amr4980639276.38.1736789492541; Mon, 13 Jan 2025
 09:31:32 -0800 (PST)
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com> <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Mon, 13 Jan 2025 23:01:30 +0530
X-Gm-Features: AbW1kvY3SmWXc2HmqTHOHcCdiV_aRXeOTyMqdUtAYuxzDS2HNXhoSW9rgdWo-9g
Message-ID: <CAJHDoJZ5rFhgu-R_N6e82bqkY43S-sXKVs2khnnnZrqJH1vcHw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Dan Williams <dan.j.williams@intel.com>
Cc: Song Liu via Lsf-pc <lsf-pc@lists.linux-foundation.org>, hch@infradead.org, 
	yanjun.zhu@linux.dev, linux-block@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_093135_941492_34898D53 
X-CRM114-Status: GOOD (  15.83  )
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

Thanks everyone for the detailed technical feedback and clarifications
- they've been extremely valuable in understanding the fundamental
challenges and existing solutions.

I appreciate the points about md-cluster and DRBD's network RAID
capabilities. While these are robust solutions for network-based
replication, I'm particularly interested in the point-in-time recovery
capability for scenarios like ransomware recovery, where being able to
roll back to a specific point before encryption occurred would be
valuable.

Regarding blk_filter - I've been exploring it since it was mentioned,
and it indeed seems to be the right approach for what we're trying to
achieve. However, I've found that many of our current requirements can
actually be implemented using eBPF without additional kernel modules.
I plan to create a detailed demonstration video to share my findings
with this thread. Additionally, I'll be cleaning up and open-sourcing
our replicator utility implementation for community feedback.

I would very much like to attend the LSF/MM/BPF summit to discuss
these ideas in person and learn more about blk_filter and proper block
layer fundamentals. Would it be possible for someone to help me with
an invitation?

Thanks again to everyone who took the time to explain the intricacies
of write caching, sector tracking limitations, and data persistence
guarantees. This discussion has been incredibly educational.

Thanks and regards,
Vishnu KS

On Tue, 7 Jan 2025 at 03:48, Dan Williams <dan.j.williams@intel.com> wrote:
>
> Song Liu via Lsf-pc wrote:
> > On Sat, Jan 4, 2025 at 9:52=E2=80=AFAM Vishnu ks <ksvishnu56@gmail.com>=
 wrote:
> > >
> > [...]
> > >
> > > @Song: Our approach fundamentally differs from md/raid in several way=
s:
> > >
> > > 1. Network-based vs Local:
> > >    - Our system operates over network, allowing replication across
> > > geographically distributed systems
> > >    - md/raid works only with locally attached storage devices
> >
> > md-cluster (https://docs.kernel.org/driver-api/md/md-cluster.html)
> > does support RAID in a cluster.
>
> Also,
>
> https://docs.kernel.org/admin-guide/blockdev/drbd/index.html

--=20
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

