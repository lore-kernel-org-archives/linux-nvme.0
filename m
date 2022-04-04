Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576BFC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VcPjK2xIshaSha7P/73c4uJIeEh9LCIV9h696014eSY=; b=f+WP2P7gNbwzPMdxxMwQaBiPsC
	Vd+o5hSpdr2QLuav29NtFVgz0lwB7yax0YnZ6CIUKaTzAiXMiKK+Qbx5iWLnLOqBqtcGjO5gmvz7q
	VhDbS18nR4bn05nhxGtuwXfhJKQUPJNXjPWYQ5VXWB/xmAFVaOExnuRqTtg6ql7nHB1q9hl82yXS2
	4bFqdUS/ryshrz1WuVbR5e5vS8IIfuawop3K5+SIrPzEOheqVnyDO4bxDYaEUTzqz+/zHCcSFqWrm
	UeRqxYLXvn8jIWDmLKNcKgSx2zX0An2xvH7nTTojEjoZFNgK42vK4MJ13+zT1bhvH1m5uO5tvzgAo
	ShB1uqFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbQE7-00FwZj-Nq; Mon, 04 Apr 2022 17:10:51 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbQCl-00Fw44-JT
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 17:09:29 +0000
Received: by mail-qv1-xf33.google.com with SMTP id cs16so2229716qvb.8
 for <linux-nvme@lists.infradead.org>; Mon, 04 Apr 2022 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :content-transfer-encoding;
 bh=VcPjK2xIshaSha7P/73c4uJIeEh9LCIV9h696014eSY=;
 b=0/1W3PtmahDM2zaiwQOfAOI7x0n7aJlY78Edx82FG8yn3sBRYT/xK8rwyUWlSIPkVk
 FbhTcMOufB5eBtNbzu+A7OVMx2KouPMqLL4fqMN5fXrX9FdDb+g8E/WNbt7rmfNyOJqQ
 3yTps2pezT8XzRvoiqVDfU0khY6BzaT9b9y+qgU1cNgUC5dLdbyJ926rZhqt1ZSdlvB7
 wu1tox0qINOoXy+nUe+Na9v9dWOAA/GUbXFNkrYHSwHS3aWbXTRBR4ZEacGNaIi8qzUK
 oh7jsSFehuBrZbWoTHGlWiHmYACJyn+L1iSBP/T8RxtxXRT0rUV4Sb16jlJtGgFKMGWg
 lnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=VcPjK2xIshaSha7P/73c4uJIeEh9LCIV9h696014eSY=;
 b=zHONpl3idurhvs3ZmgME3b69ihAZH14lhjbQNlXOq76UtMECD+1F1uk8NEPHtWwMQ3
 G9vrAt639xYofC4CFHstHE6xL6zmCgLYfJwgnPs7DhXs1/HQuwXUvHkpWuolugaExwD4
 yhsf8u2WmsXU/K9gN+IMegevy5efzt66YUYRbunnRxUdJTekClmSxwVfSKnDFyqN2qTA
 lq4YFNYGkSZmPLrf9Rm3ZXkkiNgO1zk9asmR+vWKDD/FdJz7z+scTfHbNivCZrO9sIYV
 NGYofdokDsVK/cmvI6RTA4QjuIMfRW81GmDmPUDolw9nBJcN3sllcaRWxWT+5cE2Zhxb
 z2aw==
X-Gm-Message-State: AOAM530L6axUWlBCG4UYMG5Y0v3aWVFvp0bsgyf1EdGOH7lDvvKDsY+5
 aUpZnZuR7G+Q2PAbsN571/KDYg==
X-Google-Smtp-Source: ABdhPJw975xdZtFy73BXNqDffuAX0xg4/F4udCpxsEE662P0gVWTk/Y3sjsyhUGgB9jNpu/nvzm/zA==
X-Received: by 2002:ad4:5f0f:0:b0:441:1e3a:dbc with SMTP id
 fo15-20020ad45f0f000000b004411e3a0dbcmr485180qvb.99.1649092162831; 
 Mon, 04 Apr 2022 10:09:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a05620a0bcd00b0067afe7dd3ffsm7312292qki.49.2022.04.04.10.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Apr 2022 10:09:22 -0700 (PDT)
Date: Mon, 4 Apr 2022 13:09:21 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF: 2022: Call for Proposals VIRTUAL OPTION
Message-ID: <YksmQSfuIx/OiNA8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_100927_918000_6B0CB4E1 
X-CRM114-Status: UNSURE (   7.36  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a follow up to the original CFP, you can find here

https://lore.kernel.org/all/YfGnDRM%2FPe4jzbSr@localhost.localdomain/

This is for those who have been waiting for a virtual option.  Those plans have
solidified and now we have an actual process we would like you to follow.

IF YOU WANT A VIRTUAL INVITE PLEASE FILL OUT THE GOOGLE FORM AND INDICATE YOU
WOULD LIKE TO ATTEND VIRTUALLY

https://forms.gle/uD5tbZYGpaRXPnE19

The track leaders will send out individual invites for the virtual component of
LSF/MM/BPF.  From there you will register like normal, making sure to select the
virtual option during registration, and then the Linux Foundation will email you
with the connection details closer to the conference.

The virtual component will be hosted on Zoom.  We will attempt to make this as
seamless as possible, but anticipate it being essentially a glorified
live-stream.

Those who already filled out the form indicating you want the virtual option
don't need to re-submit, we've got you on our lists already.  We will be sending
these invites out as quickly as possible as we need to make sure we have an
accurate count for the Linux Foundation.

Thank you on behalf of the program committee:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)

