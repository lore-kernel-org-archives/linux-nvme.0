Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24702C07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 15:07:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC73F61C1F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 15:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC73F61C1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kvLKDOzy/YVYXMHRXrXj3RuLOhBJgT+YbcVofccL7uQ=; b=a0KbvcEBz6sdHz
	BW+Ft8fHsIYTtRNTa3+T+fYN8Bg0OEIsAHMTuV1CRfFhqgdCUAozLhC6IUjP9vGg4UnK42W0eEhKD
	a0B4iuk1cNRtyOmbuzKsI0C59DvAVj5NY2QeKO4iFA3YEsPr8OH9ZJ4EXcuUEKDu2oQHThh+Z4Vzn
	VnNehHBdQazLILttTRLkXPOiy2zZhO+tdWmDULSK+AABRv1rPS9k2QbVeAt4290LRUMOAJKFQp9IY
	qlLvtppInaH67NPjKAilx3jN9ujkEfkLXW0OeRdh0MyRDq2k79d6fQ6DTyZb9hjENjwfAyaNhDwT8
	6sja4krbL9FkqB1ytczA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0mfN-00C76r-MX; Tue, 06 Jul 2021 15:07:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0mfK-00C75T-MS
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 15:07:16 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70F0661C21;
 Tue,  6 Jul 2021 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625584034;
 bh=OaOtGlYd/ajyQ9/+XQVhEEAgkcRDMXj2QiJgTH5ai5o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nq1KVNwHS1Rz/rXhLOhklUOzoOJm++F158VpelOJG5XH1XI3paCdgzHR924eb5+77
 kgBMLUVgXVmIRcINY9bE90fZ40oPOXVQLXQVGeEf9xUV1YdQFykFNMf+sE3Mt45JQJ
 8j2qFvF3wtuZEvtcNkwujKAdncGaZSGsQOyVrwJZwPuHnUGB+GtDJ8BDgeKp3xlI64
 PVPBlJ3yXjN9q9O2YnIDO7Xz6q7vasHHYIclHkK7MzzDNcfr3A56P2sn+CyMZyPOPH
 swNGd8ZBH0E5pSAMo5jeZRR2V3lPOx+HzX8k0EmuYkkFtGmryNkl9O+5BX1cmaWYNZ
 kO+47xPFVkVrA==
Date: Tue, 6 Jul 2021 08:07:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc: Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Message-ID: <20210706150711.GA241231@dhcp-10-100-145-180.wdc.com>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
 <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705104208.GA14891@lst.de>
 <BLAPR08MB690003D5D175FC784DE844F8B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705115349.GA20266@lst.de>
 <20210705130456.GA239714@dhcp-10-100-145-180.wdc.com>
 <BLAPR08MB690035C831CF24DE356DEF6FB81B9@BLAPR08MB6900.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BLAPR08MB690035C831CF24DE356DEF6FB81B9@BLAPR08MB6900.namprd08.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_080714_853315_939FDA6B 
X-CRM114-Status: GOOD (  20.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 06, 2021 at 08:14:45AM +0000, Shivamurthy Shastri (sshivamurthy) wrote:
> > Is it the device that wants an abrupt shutdown or the platform? If the
> > platform's power is running on limited back-up supply, and could inform
> > the kernel's power management subsystem of this, then a driver could use
> > that to determine if the quick shutdown is appropriate.
> 
> Yes, the platform is running on limited back-up supply. In this case, abrupt shutdown
> option will help to achieve shutdown with relatively low back-up requirements.
> 
> Please let me know if you want to include the abrupt shutdown as part of 
> 
> static const struct dev_pm_ops nvme_dev_pm_ops = {
> 	.suspend	= nvme_suspend,
>                .....

Are you suggesting creating a new pm callback just for this? I don't
think that's necessary.

I was considering just adding a bit to the pm_suspend_global_flags,
something like the patch below. You just have to fill in the platform
specific parts to set the flag.

---
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8af13ba60c7e..f43c0b2313d0 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -210,9 +210,10 @@ extern int suspend_valid_only_mem(suspend_state_t state);
 
 extern unsigned int pm_suspend_global_flags;
 
-#define PM_SUSPEND_FLAG_FW_SUSPEND	BIT(0)
-#define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
-#define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
+#define PM_SUSPEND_FLAG_FW_SUSPEND		BIT(0)
+#define PM_SUSPEND_FLAG_FW_RESUME		BIT(1)
+#define PM_SUSPEND_FLAG_NO_PLATFORM		BIT(2)
+#define PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT	BIT(3)
 
 static inline void pm_suspend_clear_flags(void)
 {
@@ -234,6 +235,11 @@ static inline void pm_set_suspend_no_platform(void)
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_NO_PLATFORM;
 }
 
+static inline void pm_set_power_loss_imminent(void)
+{
+	pm_suspend_global_flags |= PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT;
+}
+
 /**
  * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
  *
@@ -291,6 +297,21 @@ static inline bool pm_suspend_no_platform(void)
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_NO_PLATFORM);
 }
 
+/**
+ * pm_power_loss_imminent - Check if platform is running on limited backup
+ * 			    power source
+ *
+ * To be called during system-wide power management transitions to sleep states.
+ *
+ * Return 'true' if power loss may be imminent due to platform running on
+ * limited backup supply. If set during a shutdown, drivers should use any
+ * available shortcuts to prepare their device for abrupt power loss.
+ */
+static inline bool pm_power_loss_imminent(void)
+{
+	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT);
+}
+
 /* Suspend-to-idle state machnine. */
 enum s2idle_states {
 	S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
