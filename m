Return-Path: <SRS0=bcs0=GC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63981C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 13:23:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6A22220B
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 13:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6A22220B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fv5MYmE+RN3LLf6mjdRn5zyY6AoRQrauT+uOxzfdjXI=; b=Ht0cmBzDG0iRX+KFZbBc+uysB
	Wjv2KYr5g85kPHWygIKtVyEACL9R6pYrCGmCP0Q8+JQUej014MVMrmmPOmzOBXfcxQNwxUqV0RX/f
	qg60Iq7JFFcWywz8G+pOLCk+Tz1YuXXM2Hgl35QX6IAmr3MxQsc1yiWEzBolTfODAIJhzrxBlHNs4
	pM3ag0QkPVCexgEzkaLa3xkHOpoTEkbkfObfiU1uJjV2BM+fttZoyAOc/8UIW68FlH2Ak9Ib4OY/y
	jRJ9DVmY0mu81srUBbxCbefhfeDOpcKXcplJ4jLwLCz6tBLSbG7d5Mwqu95NM92PCe9n7DBOlw8Ru
	dM3saOH/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kubS6-0003T9-NZ; Wed, 30 Dec 2020 13:23:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kubS3-0003SR-Ld
 for linux-nvme@lists.infradead.org; Wed, 30 Dec 2020 13:23:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 77B2BABA1;
 Wed, 30 Dec 2020 13:23:38 +0000 (UTC)
Date: Wed, 30 Dec 2020 14:23:37 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20201230132337.svr2rlygfeofd45q@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <BYAPR04MB4965A005E5CED1890293ED7A86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965A005E5CED1890293ED7A86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201230_082343_823440_D6F8A84F 
X-CRM114-Status: GOOD (  17.51  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Enzo Matsumiya <ematsumiya@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Chaitanya,

On Thu, Dec 10, 2020 at 04:35:14AM +0000, Chaitanya Kulkarni wrote:
> Enzo,
> On 12/9/20 13:39, Enzo Matsumiya wrote:
> > Fix a possible NULL pointer dereference when trying to read
> > hwmon sysfs entries associated to NVMe-oF devices that were
> > hot-removed or disconnected.
> >
> > Unregister the NVMe hwmon device upon controller teardown
> > (nvme_stop_ctrl()).
> >
> > Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> (Without looking into the code)
> 
> Do you have blktests testcases for NVMeOFhot-removed and disconnected
> device scenario to produce the problem ?

Here is a rough blktests' test to reproduce the problem. There is
clearly a race as the crash not always happens at the same iteration. On
my system I was able to hit consistently within 50 iterations. Maybe you
need to tweak it on your system to reproduce it.

Thanks,
Daniel



#!/bin/bash
# SPDX-License-Identifier: GPL-2.0+
# Copyright (c) 2020 SUSE LLC
#
# Test NVMeOF read hwmon device info
. tests/nvme/rc

DESCRIPTION="read hwmon device info"

requires() {
	_nvme_requires
	_have_modules loop
	_require_nvme_trtype_is_fabrics
}

_get_nvme_hwmon_devs() {
	echo "/sys/devices/virtual/nvme-fabrics/ctl/hwmon*"
}

_read_nvme_hwmon_attr() {
	hwmon_devs="$(_get_nvme_hwmon_devs)"
	for hwmon in "${hwmon_devs}"; do
		cat ${hwmon}"/name"
		cat ${hwmon}"/temp1_label"
		cat ${hwmon}"/temp1_alarm"
		cat ${hwmon}"/temp1_input"
	done
}

test() {
	echo "Running ${TEST_NAME}"

	_setup_nvmet

	local port
	local loop_dev
	local file_path="$TMPDIR/img"
	local subsys_name="blktests-subsystem-1"

	truncate -s 1G "${file_path}"

	loop_dev="$(losetup -f --show "${file_path}")"

	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
	port="$(_create_nvmet_port "${nvme_trtype}")"
	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"

	for i in $(seq 1 50); do
		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
		_read_nvme_hwmon_attr
		_nvme_disconnect_subsys "${subsys_name}"
		_read_nvme_hwmon_attr
	done

	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
	_remove_nvmet_subsystem "${subsys_name}"
	_remove_nvmet_port "${port}"

	losetup -d "${loop_dev}"

	rm "${file_path}"

	echo "Test complete"
}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
