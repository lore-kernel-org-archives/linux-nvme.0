Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965A1CCD1BF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iy+SobKVZdrxwSQt7kS1HzTgiCHzIKxGG8+D7RVX7es=; b=jlD1jMLyR0vhS6NrsiwqKj7Bmp
	mg+2+/YTF4J4OgpDX2Of98q2hrSCRw5KJEFoUmITCTgVUA5Jqj0fnxJorqWd5ouv3Gwi3I398SD2U
	mnz+lvh92C70o9Mzv2P7LRFhdZz6vBpYkFJ+zZ21bbai7wdck3mkE0UVzWbIow7L9PM6yjxkI1pGh
	13HTCTdy94+lY4YGG+esZ4+ZCAHTSilolpVV+JnqORtWwerfEeG9Bvq0QFl0NeiHkdJ9HRXxQY34A
	GJtewyR6ZRhF7iwhYAYJU4Ll6A2rQPnUId+ynOz+6WQDCf8nyN4TVtxfRf87pstCvXWi6QQXpNoP+
	YgJ9IDtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE18S-00000000BkJ-2EDK;
	Wed, 29 Oct 2025 08:02:24 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE18K-00000000Bi2-0QH2
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 08:02:19 +0000
Received: from localhost (<unknown> [192.168.3.39])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 6e8b3d82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Oct 2025 09:02:13 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 09:02:12 +0100
Message-Id: <DDUND9A6HFVR.14U2BRGS72CEP@bsdbackstore.eu>
Subject: Re: [PATCH] nvme-pci: expose active quirks in sysfs
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Chaitanya Kulkarni" <chaitanyak@nvidia.com>, "Bart Van Assche"
 <bvanassche@acm.org>, "Maurizio Lombardi" <mlombard@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Cc: "bgurney@redhat.com" <bgurney@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <20251028142916.700438-1-mlombard@redhat.com>
 <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
 <DDU46S76MOXJ.XX5QODFDZTZN@bsdbackstore.eu>
 <08f479ed-9817-4806-bf68-c929c8a844a6@nvidia.com>
In-Reply-To: <08f479ed-9817-4806-bf68-c929c8a844a6@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_010216_494206_E676E1DE 
X-CRM114-Status: GOOD (  12.59  )
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

On Wed Oct 29, 2025 at 6:47 AM CET, Chaitanya Kulkarni wrote:
> On 10/28/25 10:00, Maurizio Lombardi wrote:
>> On Tue Oct 28, 2025 at 5:32 PM CET, Bart Van Assche wrote:
>>> On 10/28/25 7:29 AM, Maurizio Lombardi wrote:
>>>> Currently, there is no straightforward way for a user to inspect
>>>> the quirks value from userspace.
>>>> Add a new read-only sysfs attribute "quirks";
>>>> reading this file will display the hexadecimal
>>>> value of the ctrl->quirks bitmask for the given NVMe device.
>>> This patch changes the constants in enum nvme_quirks from
>>> kernel-internal constants into an ABI. I'm not sure that's what we
>>> want.
>> I understand your concern.
>> I could respin it to export the names of the active quirks
>> rather than the raw bitmask, if there is an interest in having
>> this feature.
>>
>> Maurizio
>>
> question here: do we need to care about some kind of security before we=
=20
> expose controller information that is internal to the driver ?=20
> CAP_SYS_ADMIN ? -ck

IMO I don't think it's an information that needs to be hidden.
After all, any user could run "lscpi -nn", get the vendor and device
id and cross-reference them with the pci table in the source code
to get the enabled quirks, this sysfs entry would just make it faster.

Maurizio

