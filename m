Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9796BC61DB3
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jan 2023 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AOF6/bCzdZeONpvcEbuNgJGtcKjz1PvVISQlt8ZFpic=; b=Vm6LQxPfrknAOqsCa3YfhG//co
	8D1LYLOkUJxIZTR4nLnS2QnmJySoE9q5CdCvfLwiPDcC7pR1Q7/9bGtqX78XYIKJWpPS8n3lhLFnP
	pSoSQMmqe9hnb9r3IdB7LC/b/JaLqu2Q/XtWkkNfa3p4Vu1mNhKsZREB6/ZeWSGcB7Bz76cyV+UaI
	a2UdThGzR8gCQCURbEhZmmDUwaKV2gsoFXTWEcS8Xy9cPCXZVXOscdITLiLkgOUH4gKJdERMEYyq6
	egldMoPe/IQZYg+ZPyz9++VqHUceQ5jrOV5QiWhCceR4AzIbyHKkPV1uR5JWxoH09TCT7+LDiXBY2
	/8Xjz5TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGIM1-002EMS-8z; Fri, 13 Jan 2023 11:36:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGICd-0029iU-8L
	for linux-nvme@lists.infradead.org; Fri, 13 Jan 2023 11:26:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 667AA22447;
	Fri, 13 Jan 2023 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1673609182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOF6/bCzdZeONpvcEbuNgJGtcKjz1PvVISQlt8ZFpic=;
	b=akdJdiXOQy9VoluWMKDBoKjG1x7EHi70BWc9m7iiK2ZXJgkRCxGqNWzg0oqCJXVfLfjvlq
	askbUS4t9+KGwapkj2GE6bxY3qs8TVEnD1nJmtWGcQWr0rn57bW7YkcAgaZJui4uGkXyF1
	9qmcGYIz2bnhpqhVXZcqNcebDbTj108=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47AB21358A;
	Fri, 13 Jan 2023 11:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0kDcD94/wWNRMwAAMHmgww
	(envelope-from <mwilck@suse.com>); Fri, 13 Jan 2023 11:26:22 +0000
Message-ID: <a23d94a592026e0d3fb5561329d30d819dd9a2cc.camel@suse.com>
Subject: Re: nvme-fabrics: devices are uninterruptable
From: Martin Wilck <mwilck@suse.com>
To: linux-nvme@lists.infradead.org
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>
Date: Fri, 13 Jan 2023 12:26:21 +0100
In-Reply-To: <BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
References: 	<BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_032631_530147_3FAC2A95 
X-CRM114-Status: GOOD (  33.80  )
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

On Wed, 2023-01-11 at 14:37 +0000, Belanger, Martin wrote:
> POSIX.1 specifies that certain functions such as read() or write()
> can act as cancellation points.
>=20
> Ref:
> https://pubs.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_09.h=
tml#tag_02_09_05_02
>=20
> Cancellation point functions can be forced to terminate before
> completion.

I think you are confusing things here. The page you mention is about
pthreads. pthread cancellation points are points at which a
pthread_cancel() call from another will interrupt a thread that is
using PTHREAD_CANCEL_DEFERRED cancellability, and nothing more. The
"cancellation point" logic applies *only* to the specific signal that
is used for implementing pthread_cancel(). It has nothing to do with
the cancellation of I/O requests. The spec says nothing about the
semantics of cancelling I/O system calls. Usually the thread
cancellation will occur either before entering or after returning from
the system call, rather than interrupting it. The general semantics of
signal delivery apply.

>  Typically, sending a signal to a process/thread will cause
> cancellation point functions to return immediately with an error
> (e.g. -1) and with errno set to EINTR. [...]
>=20
> The nvme driver does not seem to allow cancellation points. In other
> words, processes/threads blocked on read()/write() associated with a
> nvme device (e.g. /dev/nvme-fabrics,
> /sys/class/nvme/nvme0/delete_controller) cannot be interrupted by
> signals. This can be problematic especially for the following cases:=20

What you actually want to refer to is (I think) the section about
"Interruption of system calls and library functions by signal handlers"
in signal(7): "If  a  blocked  call to one of the following interfaces
is interrupted by a signal handler, then [...] the call fails with the
error EINTR: ... read(2), readv(2), write(2), writev(2), and ioctl(2)
calls on 'slow' devices." Note that this paragraph goes on saying that
"a (local) disk is not a slow device according to this definition; I/O
operations on disk devices are not interrupted by signals."=A0I assume
the last sentence applies to NVMe disks, too. nvme-fabrics is a
different topic; one could argue it should have socket-like semantics
(and socket IO _is_ interrupted with EINTR, same man page section).

> 1) When scaling to a large number of connections (N), applications
> may be blocked on /dev/nvme-fabrics for long periods of time.
> Creating a connection to a controller is typically very fast (msec).
> However, if connectivity is down (e.g. networking issues) it takes
> about 3 seconds for the kernel to return with an error message
> indicating that the connection has failed. Let's say we want to
> create N=3D100 connections while connectivity is down. Because
> /dev/nvme-fabrics only allows one connection request at a time, it
> will take 3 * N =3D 300 seconds (5 minutes) before all connection
> requests get processed by the kernel. If multiple processes/threads
> request connections in parallel, they will all be blocked (except for
> 1) trying to write to /dev/nvme-fabrics. And there is no way to
> stop/cancel a process/thread once it is blocked on /dev/nvme-fabrics.
> Signals, including SIGKILL, have no effect whatsoever.

I think that SIGKILL does have an effect; it will at turn the affected
process into a zombie. See above for nvme-fabrics.


> 2) Similarly, deleting a controller by writing "1" to the
> "delete_controller" device while connectivity to that controller is
> down will block the calling process/thread for 1 minute (built-in
> timeout waiting for a response). While blocked, there is no way to
> terminate the process/thread. SIGINT (CTRL-C), SIGTERM, or even
> SIGKILL have no effect.
>=20
> I wanted to ask the community if there is a reason for the nvme
> driver to not support POSIX cancellation points? I also wanted to
> know whether it would be possible to add support for it? Is there a
> downside to doing so?=20

Repeat, this has nothing to do with cancellation points.

Martin


