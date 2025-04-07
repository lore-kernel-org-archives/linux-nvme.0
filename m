Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B21C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3FHjMfdpTYlcm45wcj0nyNNnJTv4LB+NxGp+WLEBqZk=; b=j6CJ/TJaPfN7KhdtNDgRgNrXl+
	b2Izb6Oyp3hN/a7AvakLfpc5zdaQSROTQi01q5UNVfJd58uNJq8JjWLYA/lTocf0sgkFHlL+/XK7U
	c0ZzlmFixDP0mFL8Ijv69f1AuoCRjTJeHeD/zk3+NkqIRSxLLEHi+Aw5gfXbiYjM8UVPphgKzMnJp
	WLAAHQNpoVFFvzy/hO1IqqRRDY9RlCxSY/yrX8dWDNcSj2lBKG/HQpCyEpKndr/q9jmXMMZ6z/pis
	wumwmTwSCU5fZ+Q9TuLBYhm7/0SXY1F0LBpgf7PigrT9Wt084DVGo7tjfb/3M8gHGXB90c4lPHsW8
	Wen5wWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iMV-0000000H7L1-1unH;
	Mon, 07 Apr 2025 09:01:47 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iLs-0000000H7Ee-0b83
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 09:01:12 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id a03981eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 11:01:02 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Apr 2025 11:01:00 +0200
Message-Id: <D90A8LHPMZ6O.27N5MIVWHKIE3@bsdbackstore.eu>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 <bluca@debian.org>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes Reinecke"
 <hare@suse.de>, "Keith Busch" <kbusch@kernel.org>
Subject: Re: nvme-cli connect regression
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Caleb Sander Mateos"
 <csander@purestorage.com>
X-Mailer: aerc
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <CADUfDZoa8sVX2D599k=kaWTwc7sWdbqCyOo9ov4QiJ_P_1G+rg@mail.gmail.com>
 <e5fb8a06-d427-4332-ada2-8bb121827811@flourine.local>
In-Reply-To: <e5fb8a06-d427-4332-ada2-8bb121827811@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_020108_524301_AD166994 
X-CRM114-Status: UNSURE (   9.88  )
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

On Mon Apr 7, 2025 at 10:34 AM CEST, Daniel Wagner wrote:
> On Tue, Apr 01, 2025 at 02:40:54PM -0700, Caleb Sander Mateos wrote:
>> I am not sure what an error code of EINTR means in the kernel. It
>> looks like the kernel_recvmsg() is performed on the thread that writes
>> to /dev/nvme-fabrics, so it's possible that there is a signal pending
>> for the userspace thread (i.e. nvme-cli)?
>
> nvme-cli has only on place where signals are used (to interrupt a self
> test). libnvme doesn't use signals at all. No idea where the signal is
> coming from but it looks very unlikely to be from nvme-cli/libnvme.

Maybe an operation on a socket that has been closed by the other side (SIGP=
IPE) ?

Maurizio

