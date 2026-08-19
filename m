Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F28DC5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 21:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+TzkIkXJy7hGwyp9eR+gqjG98fv/6iQ4VO/4i7ImQRQ=; b=t45giFwuR2O+SCHhhBVd79MhP3
	ndgTuaf+laJn+T1D/ksQlKNA8XWUJ0E8oeiGYaeqfvrxKFPozAROo3DcD7S4sVgf5QfxEKFPr/uUv
	3Rew8LD53e7McqAkB/1zenIGKA0IhGG+w1XXKvKONQcpgnbHqknLoWb8HIzgpjY8pfpcz7gn19LYt
	CIo3V9mQ4kVVMdrDE3twEbqzeiK8nJFE+T/Q/02TeIZz5BzStfQYyehLUxC4HN7duZTzS3NKpjzkg
	qJMMc6mq48/ZrBsCaVd9cPJDHCXB1jxRmaH5rIWqt7eufhijW0F76I4BLtjHef2UiLHBNkDj7INTZ
	ZYmXoppg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwoBL-0000000AZwJ-2c23;
	Wed, 19 Aug 2026 21:50:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwoBI-0000000AZv8-3CWZ
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 21:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787176242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TzkIkXJy7hGwyp9eR+gqjG98fv/6iQ4VO/4i7ImQRQ=;
	b=OWtnjtPkzh+EhdCuaq+4IuBPLRcLdeotO5TB59FLVWvZLPhRjHLiPLL0HcH2ngkjav27tM
	BFmYU369RaCzc397eNoGQgICr0qXFOG/YUt1t7MwPPnci2epSeqJYMI5eLsE+W8d0s8zUr
	bov7s//k9QcTRYiS+iZvotKAIyDxR30=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-fUnlG3QFNg6XXCeSxXtZ2g-1; Wed,
 19 Aug 2026 17:50:39 -0400
X-MC-Unique: fUnlG3QFNg6XXCeSxXtZ2g-1
X-Mimecast-MFC-AGG-ID: fUnlG3QFNg6XXCeSxXtZ2g_1787176238
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D00E0192053E;
	Wed, 19 Aug 2026 21:49:57 +0000 (UTC)
Received: from [10.22.80.117] (unknown [10.22.80.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C65CB18005B1;
	Wed, 19 Aug 2026 21:49:54 +0000 (UTC)
Message-ID: <0d3cb83e-a4b6-414d-8756-fafd4a8238bc@redhat.com>
Date: Wed, 19 Aug 2026 17:49:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Test multipath and marginal ports
To: Jesse Taube <jtaubepe@redhat.com>, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
 Daniel Wagner <dwagner@suse.de>
References: <20260819200425.194743-1-jtaubepe@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20260819200425.194743-1-jtaubepe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: IPHG6FSFhhg-uviXBm4ckjCJxyTMSTrp8Z_HpGMUp7k_1787176238
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_145044_890923_FA658797 
X-CRM114-Status: GOOD (  23.50  )
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

This is a great improvement and we now have a functioning blkstest 070 to test the FPIN LI kernel patches.

The problem is: I don't think we are done yet.  In my own private testing and development with these patches I've been working on a next-version test that combines the ANA states from test/nvme/057 with test/nvme/070. So I am working on a test 071.

The good news is: everything now works with test/nvme/070.  The bad news is: the kernel patches are not done.

What I've found is: a long as the ANA states are all optimized or non-optimized everything works.  However, once we throw in an inaccessible state to the mix, we run into serious problems.

At this point in development I don't care about the test failures in my test/nvme/071 script. I expect the script to bug out because it doesn't understand the inaccessible state. The test sill continues flipping rports in and out of the marginal state and keeps going. That's what it is designed to do. That means it is testing all of the code paths in the kernel patches.

The problem is: when turning marginal paths on and off with controllers that are in the inaccessible state, the path selection algorithm in the kernel fails and we end up with the following:

[Wed Aug 19 16:25:42 2026] nvme_ns_head_submit_bio: 6 callbacks suppressed
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
[Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O

At this point the fio jobs are still running but there is no progress.  This means no path was found and ALL of the IOs got re-queued. And if we flip the marginal state off on all of the controllers IO continues to be hung.  The IO scheduler is hung and there is no possibility of getting it restarted again.

So this is a really serious bug in the kernel patches and we can't ship this stuff until we fix the problem.

This IO re-requeing problem should NEVER happen - no matter what the state of the marginal paths.

So I can recommend that Shinichiro test these patches with the current upstream kernel patches:

   https://lore.kernel.org/linux-nvme/20260812181300.3712426-1-jtaubepe@redhat.com/
   
But there will be another version of Kernel patches and a V3 of this patch set will be forth coming.
  
John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com

On 8/19/26 16:04, Jesse Taube wrote:
> Tests for the upcoming nvme-fc: FPIN link integrity handling set.
> It tests for various multipath and marginal port
> scenarios, while confirming the port usage and state. The test is
> intended to emulate receiving an FPIN event in a multipath environment.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220329
> Link: https://github.com/linux-blktests/blktests/pull/264
> 
> Jesse Taube (2):
>    nvme: Add _setup_nvmet_port_marginal
>    nvme/070: Test multipath and marginal ports
> 
>   common/nvme        |  31 +++
>   tests/nvme/070     | 613 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/070.out |  43 ++++
>   3 files changed, 687 insertions(+)
>   create mode 100755 tests/nvme/070
>   create mode 100644 tests/nvme/070.out
> 


