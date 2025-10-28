Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6A8CCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s9QBDxICyVWQNVNYMto7nHd3GM0wq3n8Mu/ZSKdorAA=; b=zb7kMQ3JUj3uctIA7sXyqLgZCq
	FIyF9A/LXRMisZMvQhskkTUEUwX67BeL6BcBpOX1WF3gHum0LOBmQmRymp2VIRk1BLFGeMPXR7RsI
	u5KatAd/kMhOhh4ShRJdz0Dv0Kw46F0emvClQtTRMCp9iinnL7WlMRgyb4LSEITSKXkJyJd4c1yi6
	Q25aUtjMxEXUI7dfzN8W3JEXlzGBV1SA7MCZj0XFybaM+uArNOYSBpSRdU5t+ctszpitbQSJM4JoK
	rgByQ3OtsNb1wuXRLvA2K+1N+qdh/25jG5V2L8cRZhWNV8/PwzWNCI13zzOIoQh3BB1fSaKOgWsB8
	QwTCrf2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDn3k-0000000GMnc-0YS8;
	Tue, 28 Oct 2025 17:00:36 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDn3d-0000000GMm2-2v6h
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 17:00:32 +0000
Received: from localhost (<unknown> [192.168.3.39])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 2fb3f896 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Oct 2025 18:00:24 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Oct 2025 18:00:24 +0100
Message-Id: <DDU46S76MOXJ.XX5QODFDZTZN@bsdbackstore.eu>
Cc: <bgurney@redhat.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: expose active quirks in sysfs
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Bart Van Assche" <bvanassche@acm.org>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc
References: <20251028142916.700438-1-mlombard@redhat.com>
 <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
In-Reply-To: <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_100030_091618_7AC8A565 
X-CRM114-Status: UNSURE (   9.32  )
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

On Tue Oct 28, 2025 at 5:32 PM CET, Bart Van Assche wrote:
> On 10/28/25 7:29 AM, Maurizio Lombardi wrote:
>> Currently, there is no straightforward way for a user to inspect
>> the quirks value from userspace.
>> Add a new read-only sysfs attribute "quirks";
>> reading this file will display the hexadecimal
>> value of the ctrl->quirks bitmask for the given NVMe device.
>
> This patch changes the constants in enum nvme_quirks from
> kernel-internal constants into an ABI. I'm not sure that's what we
> want.

I understand your concern.
I could respin it to export the names of the active quirks
rather than the raw bitmask, if there is an interest in having
this feature.

Maurizio



