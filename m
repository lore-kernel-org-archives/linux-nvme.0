Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D7AC433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 15:22:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A4D221E8
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 15:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OnboFH+C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj5WRDLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A4D221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eN+uSUgivycodXsZLEoeaMqkP7opyaEGrEAntdkSUY4=; b=OnboFH+CIvGZQTeQZdOzx20DK
	4hZj/9FiKT/20CLe3ppLMUBii180w638oK3QQL9KIouNpk19ZJ5JMrEchSaBV2WF9faM7/hGXU5Ye
	UWhY0Yqnzn4O3wlY3rU62ICyMMLv8EVqMs8ll/bakbuq3Y+OirlRsiCzb9dxmgi/m6SHrFUb2ZeIB
	sU8ncz2OugxeJEXLSTwoTW9mfZUJfknPCBHpEGYb7DAiaE1C/0TudesYK6OlIWpfVIOdDq7NdSqvU
	Ol0UYjB7NoR+m8dtZUVcmEtxlVhzy1smR0UukIueigpAbG2wMS389+2WXnDSjy8yb63YRZZhmEqCU
	2Qfh/78eA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvMkl-0001g9-BX; Tue, 14 Jul 2020 15:21:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvMki-0001fd-8Y
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 15:21:53 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 460B6221E8;
 Tue, 14 Jul 2020 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594740110;
 bh=dXCm++N5FXJaaakr6Yka+af48tTS4bhZDDsrXlSSD8s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kj5WRDLquf7CtMGYC/j4kGBSJWjmebEPvVcjbygEcewvF7bGWnI1qu/RTS7VZKpEg
 ySsgc+pugZewf5NPMp1hfiu2Lo9aLOQK4xYjSXCU0Igla9dhoKauQNeYPDHFW/QU+J
 kYXxZmSaUDzF9OqnuXHzolh6eRyKVci8UC6RLyw4=
Date: Tue, 14 Jul 2020 08:21:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ingo Brunberg <ingo_brunberg@web.de>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
Message-ID: <20200714152148.GA2771736@dhcp-10-100-145-180.wdl.wdc.com>
References: <d163890a-a469-e71c-45b7-f63e1efee04e@intel.com>
 <m3k0z9nkpl.fsf@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m3k0z9nkpl.fsf@web.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_112152_369491_A1104145 
X-CRM114-Status: GOOD (  11.74  )
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
Cc: "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
 chaitanya.kulkarni@wdc.com, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jul 12, 2020 at 11:31:18AM +0200, Ingo Brunberg wrote:
> If I got it right, NVME_SC_DNR is not set for my drive, so this test is
> not the right solution for that problematic controller.

So your controller claims v1.3 spec compliance, but does not implement a
required command type, then tells the host that we should retry that
command...

I did mention the DNR reliance seemed a bit fragile considering the check
was supposed to be for non-compliant controllers. The check as it exists
is fixing real issues, though. I don't have an idea off the top of my
head for a generic solution that will work with your controller and the
issue the existing code addresses, but will think about it a bit more.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
