Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D588CC10DCE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 03:56:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A7A208E4
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 03:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VINSiuxF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsFCg+UR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A7A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cBIysv5fD6zJK426KgP3YqeZbK/SMIboRkLoWdL5WtE=; b=VINSiuxFrs/Y7h
	5J6J1xKRR6as7YhZVaG5kuGLcg4zYxfiGIg4+aeaNPtkEdtmCGZHAW3mIaKqy32cTYaPz2GpaJlNU
	YdNpa8fp/aYITIGe1qmCnFHiu0dRf5CLXx31Igtn9PSUj8qpemIGWzjhCbxSJpsiy/cbQ89r2Koao
	c299ZTHdGpfwHmXRGtfINV4FwoJN0zkjS+/Z0J/eJrSWARCsvRh6s2lfAmutp/9f4RRkKid5btjSg
	bI9/dMfMVrUwqR9ODXerWMCfPNQYe2Dqx8k1Og/LgOZV1kkrJHA8cQwcgFv/cp6TxvhuaVKVoKLFI
	UJvbJ9mMoBT7/BhDXPNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBW0Y-0005x9-5t; Tue, 10 Mar 2020 03:56:42 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBW0W-0005wp-51
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 03:56:41 +0000
Received: by mail-wr1-x441.google.com with SMTP id v9so13982300wrf.10
 for <linux-nvme@lists.infradead.org>; Mon, 09 Mar 2020 20:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3vg8jq91TH35gngkv+8OZOxui1QZCEqYFri+Ba5t02Q=;
 b=qsFCg+URFyNflM2jJn3vtTIf6+M7O9dESpIatA+5zgsLg/461vCfcVnoc1GHXaOI5c
 L7Tl8rNKEDdfKD2UypjXIMLqoq8v7IuHuxWSCMtkm97+3/lRMFx7xgh1m+AKE7YZtoxK
 4Wfyz3Avp4KvcVfbkAbaRiONLgT8lVuVYiBV3OOYl50Rvcc4ZdUbqgaRMCjDL9jVsZZ+
 zSSXYqRONYdfNfHZwmf3Fu3jqLj4safmQz07DKd3ytAVqpYf+miu5eNs3lRKmI3Pl1xG
 EFPU8qRx9jhwMePptkBjp3UYd37A+FF01ncG8TPqiA7uwJFZAhJKplCf/rkuMTyYHISf
 ULCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3vg8jq91TH35gngkv+8OZOxui1QZCEqYFri+Ba5t02Q=;
 b=IcGihLL/VqIC6MhQ54IIoumWyYiY9p/b/7xnDE65OtvVUyPC3aub2z/Oi9qGxRrMP3
 U+KDaZDx0GBsr+XXk+RaoEsggNYBT9v+BxAzXrRWLJdpmKZiBaqurZ3JcDpB//iKfPIQ
 hoOxRhgX8RSZ6n1h/eA1LW/cZ7lMXcTt6QDaMIYJJJ8MZydiEQhq4LVa6iWWydmSZt4Y
 eJWsHXfzy38N+6Keeb/50MkCRsy0IibUpGiLD4iQ9DW8pRPkDDpgd1GWsPA65W4sLQA4
 Oi66hMRvRHBLGYHlfjMHYqVNNQwyFvoYdyfCtl+Sc+eN5uoPiPs0nbBUPkHCpr2zd7tk
 Sgiw==
X-Gm-Message-State: ANhLgQ1c9JGGACVuOsNRtAieP/cpKF/AUd3oIPEGIU3kNi7DhKcmuiMV
 xjOl+5xIZZGRGGEv7Y4NAFXnsxv/x1OblLJ/74M=
X-Google-Smtp-Source: ADFU+vswG9IWZKlHO59ToOfxrzLOwf1u6m7DsL91v53h3L8Y1K6QMIWjh39qPO1+HHuz677WiMsa81Y8O7So38NWT8Q=
X-Received: by 2002:adf:f74b:: with SMTP id z11mr1493351wrp.124.1583812596781; 
 Mon, 09 Mar 2020 20:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <321f0a4b-8a75-8cae-2d77-34ad712225d3@oracle.com>
 <20200309224737.GA15411@redsun51.ssa.fujisawa.hgst.com>
 <e580e915-e042-fc1a-3f45-160c12d38f8f@oracle.com>
In-Reply-To: <e580e915-e042-fc1a-3f45-160c12d38f8f@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 10 Mar 2020 11:56:25 +0800
Message-ID: <CACVXFVOzyDzj0sk622oM6yJ8oTJNKATU+bHf4D=yF3C3KzeL_Q@mail.gmail.com>
Subject: Re: I/O performance with block sizes > 128k
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_205640_218531_B68FBAD6 
X-CRM114-Status: GOOD (  17.50  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 10, 2020 at 7:11 AM Bijan Mottahedeh
<bijan.mottahedeh@oracle.com> wrote:
>
> On 3/9/2020 3:47 PM, Keith Busch wrote:
> > On Mon, Mar 09, 2020 at 02:49:10PM -0700, Bijan Mottahedeh wrote:
> >> I'm seeing a sizeable drop in perf with polled fio tests for block sizes >
> >> 128k:
> >>
> >> filename=/dev/nvme0n1
> >> rw=randread
> >> direct=1
> >> time_based=1
> >> randrepeat=1
> >> gtod_reduce=1
> >>
> >> fio --readonly --ioengine=io_uring --iodepth 1024 --fixedbufs --hipri
> >> --numjob
> >>
> >> The problem seems to be related to switching from prp_small_pool to
> >> prp_page_pool; the former is optimized for I/O between 4k and 128k.
> >>
> >> Expanding the small pool size to cover up to 256k increases the
> >> performance.  I'm not sure however if this is the proper and general fix.
> >> For one thing, expanding the pool size bumps the numbers for a short burst
> >> test (10 sec) but the numbers drop again significantly during a longer
> >> test.  The behavior is not unique to io_uring either.  Included below are a
> >> couple of 256k fio pvsync2 tests as well.
> > I am surprised you're seeing such a drop just from the prp pool used.
> >
> > What CPU architecture are you using? Reason I ask: the driver allocates
> > PAGE_SIZE for the large prp pool, but we really want ctrl->page_size
> > (always 4k). If your CPU architecture has a PAGE_SIZE larger than 4k,
> > could you try the following?
>
> It's an x86_64 vm with 8GB of memory.  Is the 4k pool size meant to
> support up to a 2MB i/o size then?
>
> The main seems to be a lock contention, this what I see with the 256k
> test after running a while.  However,  I can't pinpoint the lock with
> perf lock; is there a better way to do that?
>
>      65.08%  [kernel]       [k] __pv_queued_spin_lock_slowpath
>       2.43%  [kernel]       [k] mutex_spin_on_owner

It should be figured out by 'perf record -g'.

>
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              16
> On-line CPU(s) list: 0-15
> Thread(s) per core:  1
> Core(s) per socket:  1
> Socket(s):           16

Looks processor emulation is weird,  it said you have 16 sockets, and each
socket has just one CPU core. Maybe this is the real problem.


Thanks,
Ming Lei

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
