Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F7EC5DF81
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vkje+WcI90XXZJszwfsZINqXivEVUz5h4rfXYkDZQcQ=; b=ABg5CuDrBcWmaRrIg/OLa3NrVd
	s5Ba2Gilkd1Bvz6+nCm9ZI2K7O330JIlBOTeV2c6qoBuz4/m7SbYXkrLUSuK7XdJKUXJ7hgSTyPkr
	9QOlk9LcK8Bpiqhb3pyDjzezJXW68aLG+D2IqQ9No+FV4JmI5pRE4Ew0jMq7r/lAw65QWvbmMdEEN
	KyvknkE0Q4PnrPjOfW95CIuesgXPHirS3n3Qy+Ag4nuWPddlVGht0qHy/glZxppWynCUnTRyKprp5
	G6AOQtuj1yt+fay+fTRCScBFQETHVbHoSN5Sp69CNFpPEiLcd7TPwArNyTll0ATmszsNM1w6jTfFx
	53GoARZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx3Se-0000000Bg3K-4AYE;
	Thu, 20 Aug 2026 14:09:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx3Sa-0000000Bg2H-3Zwt
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 14:09:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787234975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkje+WcI90XXZJszwfsZINqXivEVUz5h4rfXYkDZQcQ=;
	b=FzTnplHSezEKp/bzfxubf8x7q5gjWYDR46Y0a3wVd/HfC6cnYddpxrAMO2i8YXLOS+qoAk
	mp0ey6SvfLYwPOcfXkJvHqDhPnZlW047xiKNFsWNhAdqHJVrEsn0G/3MCTi1mGdCJtfuDf
	ErhvVHdh6Ajtd0MXLgFXiZ+PgEsPmGA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-h6NxSlZrP_OWweTNUzZLzw-1; Thu,
 20 Aug 2026 10:09:33 -0400
X-MC-Unique: h6NxSlZrP_OWweTNUzZLzw-1
X-Mimecast-MFC-AGG-ID: h6NxSlZrP_OWweTNUzZLzw_1787234972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF4AC18007FB;
	Thu, 20 Aug 2026 14:09:31 +0000 (UTC)
Received: from [10.22.80.117] (unknown [10.22.80.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC3193001DAF;
	Thu, 20 Aug 2026 14:09:29 +0000 (UTC)
Message-ID: <94eaddfb-36a0-4ac6-9ea4-6eaad46aaf61@redhat.com>
Date: Thu, 20 Aug 2026 10:09:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Test multipath and marginal ports
From: John Meneghini <jmeneghi@redhat.com>
To: Jesse Taube <jtaubepe@redhat.com>, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
 Daniel Wagner <dwagner@suse.de>
References: <20260819200425.194743-1-jtaubepe@redhat.com>
 <0d3cb83e-a4b6-414d-8756-fafd4a8238bc@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <0d3cb83e-a4b6-414d-8756-fafd4a8238bc@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: uvF_JFXhjeEXs3KAfwBa4J1DfOuNPigl1jr1VtOWab8_1787234972
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_070936_971031_1A8A1188 
X-CRM114-Status: GOOD (  31.60  )
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

Further analysis shows that this is a preexisting issue with test/nvme/057.  So I will be trying to fix that test before I combine it with test/nvme/070.

target-vm:blktests(fpin_tests10) > sudo NVMET_TRTYPES=fc ./check tests/nvme/057
nvme/057 (tr=fc) (test nvme fabrics controller ANA failover during I/O) [passed]
     runtime  25.421s  ...  25.411s
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 8210 vs 8210
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 49169 vs 49169
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 45075 vs 45075
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 16404 vs 16404
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 28693 vs 28693
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 32790 vs 32790
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 28695 vs 28695
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: transport association event: transport detected io error
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: resetting controller
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000003: NQN "blktests-subsystem-1"
[Thu Aug 20 10:06:04 2026] (NULL device *): {2:1} Association created
[Thu Aug 20 10:06:04 2026] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[Thu Aug 20 10:06:04 2026] nvme nvme5: NVME-FC{3}: controller connect complete
[Thu Aug 20 10:06:04 2026] (NULL device *): {2:0} Association deleted
[Thu Aug 20 10:06:04 2026] (NULL device *): {2:0} Association freed
[Thu Aug 20 10:06:04 2026] (NULL device *): Disconnect LS failed: No Association
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 45084 vs 45084
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 16413 vs 16413
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 8222 vs 8222
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: transport association event: transport detected io error
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: resetting controller
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 45087 vs 45087
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 24608 vs 24608
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 4113 vs 4113
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 40978 vs 40978
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 53267 vs 53267
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 24596 vs 24596
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 53269 vs 53269
[Thu Aug 20 10:06:16 2026] nvme nvme2: NVME-FC{0}: io failed due to bad NVMe_ERSP: iu len 8, xfr len 4096 vs 0, status code 0, cmdid 8214 vs 8214
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O
[Thu Aug 20 10:06:16 2026] block nvme2n1: no usable path - requeuing I/O

On 8/19/26 17:49, John Meneghini wrote:
> This is a great improvement and we now have a functioning blkstest 070 to test the FPIN LI kernel patches.
> 
> The problem is: I don't think we are done yet.  In my own private testing and development with these patches I've been working on a next-version test that combines the ANA states from test/nvme/057 with test/nvme/070. So I am working on a test 071.
> 
> The good news is: everything now works with test/nvme/070.  The bad news is: the kernel patches are not done.
> 
> What I've found is: a long as the ANA states are all optimized or non-optimized everything works.  However, once we throw in an inaccessible state to the mix, we run into serious problems.
> 
> At this point in development I don't care about the test failures in my test/nvme/071 script. I expect the script to bug out because it doesn't understand the inaccessible state. The test sill continues flipping rports in and out of the marginal state and keeps going. That's what it is designed to do. That means it is testing all of the code paths in the kernel patches.
> 
> The problem is: when turning marginal paths on and off with controllers that are in the inaccessible state, the path selection algorithm in the kernel fails and we end up with the following:
> 
> [Wed Aug 19 16:25:42 2026] nvme_ns_head_submit_bio: 6 callbacks suppressed
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> [Wed Aug 19 16:25:42 2026] block nvme2n1: no usable path - requeuing I/O
> 
> At this point the fio jobs are still running but there is no progress.  This means no path was found and ALL of the IOs got re-queued. And if we flip the marginal state off on all of the controllers IO continues to be hung.  The IO scheduler is hung and there is no possibility of getting it restarted again.
> 
> So this is a really serious bug in the kernel patches and we can't ship this stuff until we fix the problem.
> 
> This IO re-requeing problem should NEVER happen - no matter what the state of the marginal paths.
> 
> So I can recommend that Shinichiro test these patches with the current upstream kernel patches:
> 
>    https://lore.kernel.org/linux-nvme/20260812181300.3712426-1-jtaubepe@redhat.com/
> But there will be another version of Kernel patches and a V3 of this patch set will be forth coming.
> 
> John A. Meneghini
> Senior Principal Platform Storage Engineer
> RHEL SST - Platform Storage Group
> jmeneghi@redhat.com
> 
> On 8/19/26 16:04, Jesse Taube wrote:
>> Tests for the upcoming nvme-fc: FPIN link integrity handling set.
>> It tests for various multipath and marginal port
>> scenarios, while confirming the port usage and state. The test is
>> intended to emulate receiving an FPIN event in a multipath environment.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220329
>> Link: https://github.com/linux-blktests/blktests/pull/264
>>
>> Jesse Taube (2):
>>    nvme: Add _setup_nvmet_port_marginal
>>    nvme/070: Test multipath and marginal ports
>>
>>   common/nvme        |  31 +++
>>   tests/nvme/070     | 613 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/070.out |  43 ++++
>>   3 files changed, 687 insertions(+)
>>   create mode 100755 tests/nvme/070
>>   create mode 100644 tests/nvme/070.out
>>
> 


