Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921E5C47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v8nzw6L2hnfafcJOFMAVg+FtIg/MTraZtM/mKXOUFBk=; b=4oWN4AiV2Xfsq3MqMZCvLCXQ+3
	vA4/shbuPNwMZtbZ6ID6CoQrd0XpSgEkzjAWV3SZrrcN2CkPgcVxDOoZ+xZjL8AuAy8clYZ6MfRoV
	lmKbm1sKFBLTJFHNPjXHdD5vPWD4jpKB+FbgN8hKTGJpIjeA6NFhSk25niJX4yks1cawC20Nz8z7I
	wLmQVvP66jtNKmmyp1OQ5FkSZzUb7Pryhf9Bfp1hx3THswsoA+WDdAn4Xxsm1US+jAEW4WWeZ0bqR
	35sBB5D8antvbfdInMF9TW6vL/j3htwDEu2c9KQKaS1krtHIpMppWNoxCohJH4b3bkP++jTQRpek1
	i52Ogo7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLRVO-00Epk0-2b;
	Thu, 04 Jan 2024 17:27:42 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLRVL-00Ephp-1G
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 17:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=v8nzw6L2hnfafcJOFMAVg+FtIg/MTraZtM/mKXOUFBk=; b=2H9ND0ZGCvPzDuXmuln/AJLBFx
	Yj9NXFWjK4V7EtsPvZmyQ9e16sTo4mTkI8Yvc3bpnededAMJ/oocE/SDJ+d32oLOuICWJVSntgz7P
	Cds8fqyDmorWY71/+inJGl89A+Jff23E4MTPGvZ+TJRY4V9GXk79ncYMoq8QOT/rPqBi4zlewSux/
	04AqZSvBXeThP2A1yFlNxHtT5ZuHpZEdRszOVN1dldI8ptF947GV/LhXsv8aoMuzDalVp2r+Jofo9
	hIEolmXlhKNsyNnDi9BwY7Gz/Hgh7LVWn/WTv9+NaFgY2hdgAi9SyMrrvAdUmH/7z0ZG9FGIFOrK+
	IsfGD4pZENoFsQYxomHVX3UX+tWlqPsqzS6U2N9nxuNJ4pkQw6o5s4K4cFJXb8yGdoX2uL40qwbDw
	GCG4G3RISfRZu5YEgciZRAOYbi5csFXCvpIO68z82GQgRmTTGk3JNGy3rh+CIPxSYHLXhizCCRlhl
	3fH/f2+dZcuZ9tqo0xjOq08m;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rLRVA-006THW-0K;
	Thu, 04 Jan 2024 17:27:28 +0000
Date: Thu, 4 Jan 2024 09:27:24 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 1/5] driver core: Support two-pass driver shutdown
Message-ID: <ZZbqfOKohoOY64GX@jeremy-HP-Z840-Workstation>
References: <20240103210405.3593499-1-jallison@ciq.com>
 <20240103210405.3593499-2-jallison@ciq.com>
 <7c797813-40fb-49c6-baf0-2029e9177939@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7c797813-40fb-49c6-baf0-2029e9177939@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_092739_450079_9B5C7FD6 
X-CRM114-Status: GOOD (  15.74  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 04, 2024 at 03:12:11PM +0200, Sagi Grimberg wrote:
>
>
>On 1/3/24 23:04, Jeremy Allison wrote:
>>From: Tanjore Suresh <tansuresh@google.com>
>>
>>This changes the bus driver interface with an additional entry point
>>to enable devices to implement two-pass shutdown. The existing
>>synchronous interface to shutdown is called, and if a shutdown_wait
>>method is defined the device is moved to an alternate list.
>>
>>Once the shutdown method is called for all devices, the
>>shutdown_wait method is then called synchronously for
>>all devices on the alternate list.
>>
>>Signed-off-by: Tanjore Suresh <tansuresh@google.com>
>>Signed-off-by: Jeremy Allison <jallison@ciq.com>
>>---
>>  drivers/base/core.c        | 37 +++++++++++++++++++++++++++++++++++++
>>  include/linux/device/bus.h |  6 +++++-
>>  2 files changed, 42 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/base/core.c b/drivers/base/core.c
>>index 67ba592afc77..e1f4c54de3e1 100644
>>--- a/drivers/base/core.c
>>+++ b/drivers/base/core.c
>>@@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>>  void device_shutdown(void)
>>  {
>>  	struct device *dev, *parent;
>>+	LIST_HEAD(shutdown_wait_list);
>>  	wait_for_device_probe();
>>  	device_block_probing();
>>@@ -4769,10 +4770,17 @@ void device_shutdown(void)
>>  				dev_info(dev, "shutdown_pre\n");
>>  			dev->class->shutdown_pre(dev);
>>  		}
>>+
>>  		if (dev->bus && dev->bus->shutdown) {
>>  			if (initcall_debug)
>>  				dev_info(dev, "shutdown\n");
>>  			dev->bus->shutdown(dev);
>>+			/*
>>+			 * Only put the device on the shutdown_wait_list
>>+			 * if a shutdown_wait() method is also defined.
>>+			 */
>>+			if (dev->bus->shutdown_wait)
>>+				list_add(&dev->kobj.entry, &shutdown_wait_list);
>>  		} else if (dev->driver && dev->driver->shutdown) {
>>  			if (initcall_debug)
>>  				dev_info(dev, "shutdown\n");
>>@@ -4789,6 +4797,35 @@ void device_shutdown(void)
>>  		spin_lock(&devices_kset->list_lock);
>>  	}
>>  	spin_unlock(&devices_kset->list_lock);
>>+
>>+	/*
>>+	 * Second pass only for devices that have configured
>>+	 * a shutdown_wait() method.
>>+	 */
>>+	while (!list_empty(&shutdown_wait_list)) {
>>+		dev = list_entry(shutdown_wait_list.next, struct device,
>>+				kobj.entry);
>>+		parent = get_device(dev->parent);
>>+		get_device(dev);
>>+		/*
>>+		 * Make sure the device is off the  list
>>+		 */
>>+		list_del_init(&dev->kobj.entry);
>>+		if (parent)
>>+			device_lock(parent);
>>+		device_lock(dev);
>>+		if (dev->bus && dev->bus->shutdown_wait) {
>
>How can dev->bus or dev->bus->shutdown_wait be null at this
>point?

It's a fair cop :-). That's just paranoia. I'll remove :-).

