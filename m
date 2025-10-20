Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6889BCCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:CC:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cheXoOOiS2gvHnYLS7Mw7StPPuqgKOzmf8SzUVnio1I=; b=cfDR3Pn4imY19uKYqFKH7jH0OX
	cuRmXaDguMGQMwbRGyfltigQA2yavwJ9/jT1shn6i1LyqHI2jdloBos6akPShPZaeRLcYlPBlq4Js
	4sqhm7isLswgCxOtH00Ds8zTOwxdseD/vfQBBqNSYW66pHuFmeP5nfOwr80LxKKUwDKnAlUv0uCoU
	EsYEEloegn96xGcgI4nIVPpSmXGK3lSYGcoTSpG8V21fVbX92e3H/QP3PBiWqEU5207sUQvwSI2VM
	QXkE6rCaNDBIuYbSXNZgs6eSyPG+JQSLPifapzJ/M93YtUK7tF7KUQ/EuoDj1wf7PC9+jB2AP0Gg8
	TBoqwTdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAm4v-0000000CYWK-3sYi;
	Mon, 20 Oct 2025 09:21:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAm4u-0000000CYVp-2nDo
	for linux-nvme@bombadil.infradead.org;
	Mon, 20 Oct 2025 09:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:CC:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=cheXoOOiS2gvHnYLS7Mw7StPPuqgKOzmf8SzUVnio1I=; b=HR5Waj0joUnXUoVOpvV4AKOWiV
	Gfyl0CT/xXmN45+w1fX0jfkGqpywfUWoXu3DHpZsZV2J7fK/TNXMkbX4APzNnR7q8WJT4HN3hizCR
	t3yXUNjM8vycxMNZSC4a5Yve+70bii+JF/yQfRVou89nzKI2C8s3ASg4by5sAWhaqKYNtQ5ILiDSZ
	BBoULuL+Dsn86DVe96Hc49WN/gO+/jcoXsficKVz2GzW6wqyork4JyppsN6rHIiQNTWFp+3uCC/5U
	5Go/NWZx95KSKrWbV9lYllYd0Q/9oRyWPJVB2ywXgk7JNvK2m2Gq5xXTjCMWPHkh0JECIfBj5TD7e
	E0hKqbNw==;
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAm4o-00000009fLH-031I
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 09:21:18 +0000
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cheXoOOiS2gvHnYLS7Mw7StPPuqgKOzmf8SzUVnio1I=;
	b=gYsWNXzCDiU2EFfnprMRKNY3tyNxk+bccWg0HOfhh8O0DRzdAevI7LBzQe9WvC6ICl8KFdW4Y
	2ZF7uepDDCJJrM6Ccv2w742aFYof6nLcLcnIOnQoiGtqmwyvAt+jz4KKgfA9haAsfyVFj7k0YN5
	ys7ZfdHW4135VY38/2hTqIY=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cqqd16r8HzcZyT
	for <linux-nvme@lists.infradead.org>; Mon, 20 Oct 2025 17:19:33 +0800 (CST)
Received: from kwepemh100002.china.huawei.com (unknown [7.202.181.84])
	by mail.maildlp.com (Postfix) with ESMTPS id 6671E1402DA
	for <linux-nvme@lists.infradead.org>; Mon, 20 Oct 2025 17:20:41 +0800 (CST)
Received: from [10.174.185.38] (10.174.185.38) by
 kwepemh100002.china.huawei.com (7.202.181.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 17:20:40 +0800
Message-ID: <a9a1cfdb-f41f-b2ff-80a2-5e47471b8007@h-partners.com>
Date: Mon, 20 Oct 2025 17:20:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: <linux-nvme@lists.infradead.org>
From: "wangzhiqiang (Q)" <wangzhiqiang95@h-partners.com>
Subject: [DISCUSSION] NVMe firmware_rev not updated after firmware commit when
 AEN is not supported
CC: <jingsixiang1@h-partners.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.38]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100002.china.huawei.com (7.202.181.84)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_102114_734534_E5294377 
X-CRM114-Status: GOOD (  10.89  )
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

Hi all

I encountered an issue while working with the NVMe driver on kernel v6.6.

When I use ioctl with NVME_IOCTL_ADMIN_CMD to passthrough Firmware Image Download(CA=3) and Firmware Commit commands
to upgrade the firmware image on an NVMe drive, if the drive does not support the Asynchronous Event Notice (AEN)
for Firmware Activation Notices, the kernel does not receive the NVME_AER_NOTICE_FW_ACT_STARTING event. As a result,
ctrl->subsys->firmware_rev in the kernel is not updated, and the corresponding /sys/class/nvme/nvme0/firmware_rev still
shows the outdated firmware revision.

According to the NVMe specification, a Commit Action (CA) = 3 indicates that the firmware image should be activated
without performing a controller reset (even though a reset would normally cause the controller to be re-identified).
However, since most vendor drives currently either do not support Firmware Activation Notices or have not enabled it,
leads to an inconsistency between the actual firmware version on the device and the value exposed by the kernel.

Would it make sense to add a userspace interface that allows applications to query the latest firmware revision in real time?
For example, this could be implemented via an ioctl or by providing a mechanism to refresh or read the updated value through sysfs.

Best regards
wangzhiqiang
jingsixiang

