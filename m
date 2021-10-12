Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ED6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 18:35:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C230560EDF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 18:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C230560EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:Content-ID:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jhih2Z981j336pEs7wjjvF/2/vcj5GfA50z4QdE76sg=; b=RQHYPNKjbHO9Gc
	Y9JfweAWwMkrP3ZRphAFk1Thm9UL2AbVDXbgvA2Yt4CBr6TfxyQPuQ/VpIpJy1BO83pupZg2zDssB
	Jr3YzaaVgh7JvDVza5cbX4HW6vM7NvAc4kxyln+qRP8MbWRaHhJ6q5QMnChuhUGV6fYQffFovwboR
	DsrfADlCZaPxeMZtfWWHOE7Qf8WECeAiqgTDDz1ENu3DRehmrTOEBtqD0IJzQ23Q7j5e3W8Rq8X7u
	OKNTzjf1XGwWuSKc8UlrFJxklPZ/J+E/I5oSP6sTR35dv7Je/b76GUAdHsOWlB3CIMb1cu0IoXP6F
	3r9zpuDp/N/n85SVaqWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maMcH-00DlQg-Re; Tue, 12 Oct 2021 18:35:09 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maMcE-00DlOy-DQ
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 18:35:09 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20211012183502usoutp023359a0e9d036ef9b434acc430715158a~tXEeuaFFz1653316533usoutp02T;
 Tue, 12 Oct 2021 18:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20211012183502usoutp023359a0e9d036ef9b434acc430715158a~tXEeuaFFz1653316533usoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1634063702;
 bh=feq3ixV5aaCHJ+rcNWXB+vpUs0rDLIVOtDW6V1QlgII=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Yn5Pafp/f2O2ldgeZCFlwWskjeg+UiWq2F78nNQRn/OI9+9pPHXvwZcJLj/iH0mRB
 /nVOfvhI7pIVJ+hp8+BVnZwTICYo/V9iBhXeegpe65HUd9PhkutgHaFYqsWKPf0Fn+
 eojaQnrH3AsSM7DzBVx25GT6MErzw77jPdKL7vCk=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20211012183502uscas1p1e2d6542837b22dcabc0544c46fe138c2~tXEei1X4B1168011680uscas1p1t;
 Tue, 12 Oct 2021 18:35:02 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id 83.04.19318.655D5616; Tue,
 12 Oct 2021 14:35:02 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20211012183502uscas1p151459fbf8e4b2ba429226445b6d856b8~tXEeJrFlq2605926059uscas1p1L;
 Tue, 12 Oct 2021 18:35:02 +0000 (GMT)
X-AuditID: cbfec370-c4fff70000014b76-a2-6165d556f336
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 04.54.47905.555D5616; Tue,
 12 Oct 2021 14:35:01 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Tue, 12 Oct 2021 11:35:01 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::ed94:2e33:daa5:4d68]) by
 SSI-EX1.ssi.samsung.com ([fe80::ed94:2e33:daa5:4d68%13]) with mapi id
 15.01.2242.008; Tue, 12 Oct 2021 11:35:01 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Yi Zhang <yi.zhang@redhat.com>, "minwoo.im.dev@gmail.com"
 <minwoo.im.dev@gmail.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
Thread-Topic: [bug report] kmemleak observed with blktests nvme-tcp tests
Thread-Index: AQHXtcGhQNsZtuBti0+ykcyTuiTmO6u8mgEAgAAFI4CAAAu0AIAALSsAgAAoXICAABJ+AIAArReAgAMM/ACAD2ybgA==
Date: Tue, 12 Oct 2021 18:35:01 +0000
Message-ID: <20211012183446.GA264712@bgt-140510-bm01>
In-Reply-To: <05d2844e-81fb-0180-03cc-423cedfd7ac7@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-ID: <132FEA5F797CA84FAC72A98B4B26F978@ssi.samsung.com>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMcRTH/fY+9rZmuW25HZrGWBpDSnmMNVjGc814ZAxDmLp0tdGu2lte
 M9FIjVYhwtisipRNorwKMT2IqJBi8kgqeiw7mtFWStwuo/8+55zv+f6+Z+ZHYYoUYhQVrA/n
 DHo2REnK8FuPflR6rq3hWO8ndkZlK2okVCkZzVJVT9xQVU67DVe9rjxFziM0Bab3Uk3Vh1xc
 cz19vyYh+hupsd2vIX0JP9nsQC4keCdnmKwOkGmTOkukoWbf3TUHe6VR6PR8I3KggJ4GCWmJ
 mMAK2oLg3bU9RiT7wzESSIrrwY2IGhBVdy0W+1cQVJt7pGLxHUFD/0NMLIoQxL/rlwhWJO0N
 P8tyMWHbmR4HVqtO0GB0OYKP1UdJQeNEa+Bh+1GpwM70Uui+afnL2yA369CAD067Q/2RLlxg
 OT0dEmLOEYKnAz0XbnQPpEY0A/by7AE5RrtAXVOKRLzMEc4n38NEZuDXnQZS5DFQb2+VivpJ
 kHq3gxQsMVoN0V8cxbYHZKS1Y+KrjvDkTBMuro6EoktvcOEUoJ9T8LOglBAHC+FW3FmpyK5Q
 8/okJopqEWR+OkuIRT2CmPg+JKpmQVrvVckxNM40KLhpUCjT/1CmQaFMg0KlIiILuUTwvC6I
 46fquV1ePKvjI/RBXlt26PLQnz/09FdJaD6qq/vuVYwkFCpGQGFKZ7mPlmMV8kB2z17OsMPf
 EBHC8cXIlcKVLnLz+kR/BR3EhnPbOS6UM/ybSiiHUVGSfWGxPrhtTuGxExvMymyebCHnPCv5
 HCabGtCjmD3UobmxtuzFg9GtxycGXKu4aHSr6x2zQrLepXbNhcbxGwwT7Bv93dpWDunoU3gl
 Zqtvfr27Lv/ToU61M9NvSa9KLhzeH73ZGl5VZLVappd3duvT75VO6fjobjxQsV27fOuiyMTK
 rraxmlbbi3PlvgWnTaGRI24v+PqS2dZiNjHBb2e4v0omw1ZxxUvr2zMZMLa5VVvyehn7prIV
 B3Ics2Izkv0CtR4zM/iR+cN0k1nsDfF5WXPsq4steTaqYVNqZOHjQPvlsL4KPmJtfFYOmXT4
 y+j9TuGpmVEzPNWrl8QyVFqTq1yJ81rWZyJm4NnfCZ5MjbIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWS2cA0UTf0amqiwbM7VhbvDz5mtZi/7Cm7
 xa9Obot1r9+zWFw/N43NgdVj56y77B7n721k8di8pN6jt/kdm8f7fVfZAlijuGxSUnMyy1KL
 9O0SuDKmfDvMXjA3oOJqyx/2BsbpTl2MHBwSAiYSl3+4dTFycQgJrGaU2Ln2AzuE85FR4nfz
 F1YI5yCjxOnfG4EcTg42AQOJ38c3MoN0iwioSLx5kwtSwyxwilHiweV+NpAaYQEPiaOv+9lB
 bBEBT4mfW1dC2VkSG1d1MIHYLAKqEvf7frCA2LwCphK9rfOglk1mlTh0YA4TyAJOAXuJLT+Z
 QWoYBcQkvp9aA9bLLCAucevJfDBbQkBAYsme88wQtqjEy8f/WCFsRYn731+yQ9TrSCzY/YkN
 ZCSzgJ1E83NBiLC2xLKFr5khThCUODnzCQtEq6TEwRU3WCYwSsxCsm0WkkmzECbNQjJpFpJJ
 CxhZVzGKlxYX56ZXFBvmpZbrFSfmFpfmpesl5+duYgRG8Ol/hyN3MB699VHvECMTB+MhRgkO
 ZiURXsOM1EQh3pTEyqrUovz4otKc1OJDjNIcLErivEKuE+OFBNITS1KzU1MLUotgskwcnFIN
 TA1Sl+TFfsYsSWqQrG7bvdIg9pWY/rXP778e71hdUv+Ey8tzg5ulzRZpp2+7rH0yvuzWm7Bj
 TpHl3LVx2jY6coI7FiVzHtt+YVbV7PqVgi8NhA9PuLaVwXcxs/PqQ8+ti1+3/OXx+6L340Ak
 B/PRTd/MSjd/X79u42M2n6UxVWd73fQrYg5pHpwgz/p4qa/IssSdd7KCI8/K312r6y06yUxy
 4oPIbyt7fUsuX8o/U1pRkmSgPvFrk33z9JMmz97Har2bICsSUiclvafoiP8566+GGg/nLVl4
 r/dt4JM1Iruzi2S07xpZ9YReEezddmCPodiuOLlnm+aerEk9EVrfp7V+vY2A6OWIGfK1zyfx
 3FJiKc5INNRiLipOBABTw+42TwMAAA==
X-CMS-MailID: 20211012183502uscas1p151459fbf8e4b2ba429226445b6d856b8
CMS-TYPE: 301P
X-CMS-RootMailID: 20211002230919uscas1p1bc872acda3a68abc1438443d78ac921b
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
 <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
 <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
 <CAHj4cs9QBFXca-rnP05ZmWBKDJv4aviiDQ=q2_JihMQuESE7OA@mail.gmail.com>
 <1b992460-26a6-cff6-bee4-b81ac28e93f5@grimberg.me>
 <CAHj4cs8Vff_C8FnFciHtYdnifoOHBrNtaGN1Fvpg5m2gV8JpZw@mail.gmail.com>
 <CGME20211002230919uscas1p1bc872acda3a68abc1438443d78ac921b@uscas1p1.samsung.com>
 <05d2844e-81fb-0180-03cc-423cedfd7ac7@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_113506_819348_2EE22DE8 
X-CRM114-Status: GOOD (  30.93  )
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

On Sun, Oct 03, 2021 at 02:02:20AM +0300, Sagi Grimberg wrote:
> 
> > > > Bisect shows it was introduced from the below commit:
> > > > 
> > > > commit 2637baed78010eeaae274feb5b99ce90933fadfb
> > > > Author: Minwoo Im <minwoo.im.dev@gmail.com>
> > > > Date:   Wed Apr 21 16:45:04 2021 +0900
> > > > 
> > > >       nvme: introduce generic per-namespace chardev
> > > > 
> > > 
> > > Makes sense as both leaks relate to the nshead cdev...
> > > 
> > > I think another put on the cdev_device is missing?
> > > --
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 1d103ae4afdf..328e314af199 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -3668,6 +3668,7 @@ void nvme_cdev_del(struct cdev *cdev, struct
> > > device *cdev_device)
> > >    {
> > >           cdev_device_del(cdev, cdev_device);
> > >           ida_simple_remove(&nvme_ns_chr_minor_ida,
> > > MINOR(cdev_device->devt));
> > > +       put_device(cdev_device);
> > >    }
> > > 
> > >    int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> > > --
> > > 
> > 
> > Hi Sagi
> > 
> > This introduced one new issue, here is the log:
> 
> Hmm, looks like a use-after-free. I thought that
> there was a missing put on the cdev_device paired to
> device_initialize() call on it...
> 
> Minwoo?

Hello all,

Does the following patch fix the issue for you. 


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e486845d2c7e..587385bc82b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3548,10 +3548,15 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
 	return 0;
 }
 
+static void nvme_cdev_rel(struct device *dev)
+{
+	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
+}
+
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
 {
 	cdev_device_del(cdev, cdev_device);
-	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt));
+	put_device(cdev_device);
 }
 
 int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
@@ -3564,14 +3569,14 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 		return minor;
 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
 	cdev_device->class = nvme_ns_chr_class;
+	cdev_device->release = nvme_cdev_rel;
 	device_initialize(cdev_device);
 	cdev_init(cdev, fops);
 	cdev->owner = owner;
 	ret = cdev_device_add(cdev, cdev_device);
-	if (ret) {
+	if (ret)
 		put_device(cdev_device);
-		ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
-	}
+
 	return ret;
 }
 
@@ -3603,11 +3608,9 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
 			   ns->ctrl->instance, ns->head->instance);
 	if (ret)
 		return ret;
-	ret = nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
-			    ns->ctrl->ops->module);
-	if (ret)
-		kfree_const(ns->cdev_device.kobj.name);
-	return ret;
+
+	return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
+			     ns->ctrl->ops->module);
 }
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8ccdd398f78..fba06618c6c2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -431,8 +431,6 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 		return ret;
 	ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
 			    &nvme_ns_head_chr_fops, THIS_MODULE);
-	if (ret)
-		kfree_const(head->cdev_device.kobj.name);
 	return ret;
 }
 


> 
> > 
> > [  250.764659] run blktests nvme/004 at 2021-09-30 20:23:39
> > [  250.938913] loop0: detected capacity change from 0 to 2097152
> > [  250.963292] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [  250.976418] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [  251.003499] nvmet: creating controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> > [  251.020277] nvme nvme0: creating 32 I/O queues.
> > [  251.050637] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> > [  251.091232] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> > 127.0.0.1:4420
> > [  252.179608] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> > [  252.228383] ------------[ cut here ]------------
> > [  252.234400] Device 'ng0n1' does not have a release() function, it
> > is broken and must be fixed. See Documentation/core-api/kobject.rst.
> > [  252.246498] WARNING: CPU: 10 PID: 2086 at drivers/base/core.c:2198
> > device_release+0x189/0x210
> > [  252.255029] Modules linked in: nvme_tcp nvme_fabrics nvme_core
> > nvmet_tcp nvmet loop rfkill sunrpc vfat fat dm_multipath iTCO_wdt
> > iTCO_vendor_support ipmi_ssif intel_rapl_msr intel_rapl_common
> > isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp
> > kvm_intel mgag200 i2c_algo_bit kvm drm_kms_helper dell_smbios
> > irqbypass crct10dif_pclmul crc32_pclmul syscopyarea sysfillrect
> > sysimgblt dcdbas fb_sys_fops ghash_clmulni_intel cec rapl intel_cstate
> > drm intel_uncore mei_me dell_wmi_descriptor wmi_bmof pcspkr i2c_i801
> > mei acpi_ipmi i2c_smbus lpc_ich ipmi_si ipmi_devintf ipmi_msghandler
> > dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core
> > acpi_power_meter xfs libcrc32c sd_mod t10_pi sg ahci libahci libata
> > tg3 megaraid_sas crc32c_intel wmi nfit libnvdimm dm_mirror
> > dm_region_hash dm_log dm_mod [last unloaded: nvmet]
> > [  252.327704] CPU: 10 PID: 2086 Comm: nvme Tainted: G S        I
> >   5.15.0-rc3.v1.fix+ #4
> > [  252.335974] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
> > 2.11.2 004/21/2021
> > [  252.343635] RIP: 0010:device_release+0x189/0x210
> > [  252.348262] Code: 48 8d 7b 50 48 89 fa 48 c1 ea 03 80 3c 02 00 0f
> > 85 88 00 00 00 48 8b 73 50 48 85 f6 74 13 48 c7 c7 60 cb 18 af e8 dc
> > fb c5 00 <0f> 0b e9 0b ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 89 da
> > 48 c1
> > [  252.367015] RSP: 0018:ffffc90003d5fb00 EFLAGS: 00010282
> > [  252.372249] RAX: 0000000000000000 RBX: ffff8882a5474a48 RCX: ffffffffad731d52
> > [  252.379393] RDX: 0000000000000004 RSI: 0000000000000008 RDI: ffff888e259e3b2c
> > [  252.386533] RBP: ffff8882e390ec00 R08: ffffed11c4b3d9b9 R09: ffffed11c4b3d9b9
> > [  252.393675] R10: ffff888e259ecdc7 R11: ffffed11c4b3d9b8 R12: ffff8882e328b500
> > [  252.400812] R13: ffff88852e9ee500 R14: 0000000000000000 R15: ffffc90003d5fbf8
> > [  252.407946] FS:  00007f6f3cad2780(0000) GS:ffff888e25800000(0000)
> > knlGS:0000000000000000
> > [  252.416040] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  252.421795] CR2: 000055c593c2e6b0 CR3: 00000002a1aec006 CR4: 00000000007706e0
> > [  252.428937] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  252.436078] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  252.443221] PKRU: 55555554
> > [  252.445941] Call Trace:
> > [  252.448403]  kobject_release+0x109/0x3a0
> > [  252.452338]  nvme_mpath_shutdown_disk+0x92/0xe0 [nvme_core]
> > [  252.457929]  nvme_ns_remove+0x4a3/0x7f0 [nvme_core]
> > [  252.462824]  ? up_write+0x14d/0x460
> > [  252.466324]  nvme_remove_namespaces+0x242/0x3a0 [nvme_core]
> > [  252.471914]  ? nvme_execute_passthru_rq+0x5a0/0x5a0 [nvme_core]
> > [  252.477852]  ? del_timer_sync+0xab/0xf0
> > [  252.481699]  nvme_do_delete_ctrl+0xaa/0x108 [nvme_core]
> > [  252.486941]  nvme_sysfs_delete.cold.100+0x8/0xd [nvme_core]
> > [  252.492532]  kernfs_fop_write_iter+0x2d0/0x490
> > [  252.496984]  ? trace_hardirqs_on+0x1c/0x150
> > [  252.501180]  new_sync_write+0x3b2/0x620
> > [  252.505026]  ? rcu_read_lock_held_common+0xe/0xa0
> > [  252.509742]  ? new_sync_read+0x610/0x610
> > [  252.513677]  ? rcu_tasks_trace_pregp_step+0xe1/0x170
> > [  252.518651]  ? rcu_read_lock_held_common+0xe/0xa0
> > [  252.523368]  ? rcu_read_lock_sched_held+0x5f/0xd0
> > [  252.528082]  ? rcu_read_unlock+0x40/0x40
> > [  252.532016]  ? rcu_read_lock_held+0xb0/0xb0
> > [  252.536212]  vfs_write+0x4b5/0x950
> > [  252.539626]  ksys_write+0xf1/0x1c0
> > [  252.543039]  ? __ia32_sys_read+0xb0/0xb0
> > [  252.546975]  do_syscall_64+0x37/0x80
> > [  252.550563]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  252.555621] RIP: 0033:0x7f6f3c1bb648
> > [  252.559209] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> > 00 00 f3 0f 1e fa 48 8d 05 55 6f 2d 00 8b 00 85 c0 75 17 b8 01 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
> > d4 55
> > [  252.577965] RSP: 002b:00007fff4826bb88 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000001
> > [  252.585537] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6f3c1bb648
> > [  252.592679] RDX: 0000000000000001 RSI: 000055c593c70da5 RDI: 0000000000000004
> > [  252.599821] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > [  252.606962] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c5945d7540
> > [  252.614102] R13: 00007fff4826e0fc R14: 0000000000000008 R15: 0000000000000003
> > [  252.621246] irq event stamp: 0
> > [  252.624310] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [  252.630585] hardirqs last disabled at (0): [<ffffffffac9d68f3>]
> > copy_process+0x2023/0x6b20
> > [  252.638854] softirqs last  enabled at (0): [<ffffffffac9d6932>]
> > copy_process+0x2062/0x6b20
> > [  252.647121] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [  252.653396] ---[ end trace 96526c0d562adac3 ]---
> > 
> > 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=c4623b75-9bf90238-c463b03a-0cc47aa8f5ba-4705d26d62157aef&q=1&e=e8f1e635-f4b8-4b35-af63-85700ecd6dd3&u=http*3A*2F*2Flists.infradead.org*2Fmailman*2Flistinfo*2Flinux-nvme__;JSUlJSUl!!EwVzqGoTKBqv-0DWAJBm!GNcPQ8XAKsCJJcCcuc6fY9-radUDLzK6DGiO1Js8mf_-Jg1XVAfs30Cd7G7YXqwtPRdh$
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
