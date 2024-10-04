Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C911BCFA758
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w6BtqbixkMt3iGyDE5rnVOJGMCoRq8y4Cacq6XkkJc4=; b=DRQhcYpUSgNWepKgE5OJJZMVNF
	eG3KNJciti/owxhH4P62I3DaQrgpGD91YWFmfrRIH8D0Isnr8TK3BKRF8t+0sTIKids0D18EZSBv5
	yPYwDp4s9inq/PBNp/dnMfel0sw+m1fVVYlSPf+iujZjj/9GGVsQ76wvpnDHI1MPDiaSSbEpbg2is
	3VIvQ29ut3cHjVW7a1Uacd5dycTNNdq6jl0qWwG0hanYYjJ9eVL+AaFuMtkElW7HXHmEPbBEYo/fd
	mAHc+81q8Gb0/atSS7Z+ANgZdLWh46hQXkjvHxCTkxTuKf/iBnM3aTlscY1DPIopp+dKTNXRbw7fS
	uaFHPEvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swfGZ-0000000BmNu-0kd5;
	Fri, 04 Oct 2024 10:10:31 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swfGX-0000000BmN0-0cfM
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 10:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728036629; x=1759572629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h2bSgynWcUsopXYpmzcf49SKdBw2+LEG49P5EMZD3Ms=;
  b=S13O7o2nMurBzvxv/XtTw26BAUVFVmjjQrb/Xj+H8Z3uu+lxf+dvv0cj
   OJzrs3aYsdt7Kc91lbSaT6klCpCoodMEiodeCxjFy9I75hRXBNtn6nZhz
   TA/CKT8Q06ukcn7vlhF455PlagF2ZYsS+fnTaRZKchXA2QseHixgjOsDB
   l/kaBh6Cw06HqrVMu18pDi/hWP9mAcSRxyUXqwS/CTLGv+sxZQAfU+uCv
   GkCniFSjXhxQbmqjHaTBAewU6ksLy9HhL5OwOjyFsuFeRn47BPZzU2oR9
   Ag2yufa7xr76SPaXxcgyspIxtjF/wGP0G7DOvW3dRtemTOY5GhRZwJ0Qs
   w==;
X-CSE-ConnectionGUID: ngel3FuRQvmV0oxICYAc1w==
X-CSE-MsgGUID: 3gTrh/LDSSuKUEouOhiqeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="44784882"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="44784882"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:10:28 -0700
X-CSE-ConnectionGUID: ZTq54FNWQyC0edJNNdCoZw==
X-CSE-MsgGUID: EtJaNfB0S9GfF+c2GSwsTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74658805"
Received: from olympicsflex1.amr.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.245.54])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:10:26 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	kbusch@kernel.org
Subject: [PATCH 0/1] nvme-pci: Add CPU latency pm-qos handling
Date: Fri,  4 Oct 2024 13:09:27 +0300
Message-ID: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_031029_226007_C4E3C275 
X-CRM114-Status: UNSURE (   6.45  )
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

Hello,

Re-posting this as the 6.12-rc1 is out, and the previous RFC didn't
receive any feedback. The patch hasn't seen any changes, but I included
the cover letter for details.

The patch adds mechanism for tacking NVME latency with random workloads.
A new sysfs knob (cpu_latency_us) is added under NVME devices, which can
be used to fine tune PM QoS CPU latency limit while NVME is operational.

Below is a postprocessed measurement run on an Icelake Xeon platform,
measuring latencies with 'fio' tool, running random-read and read
profiles. 5 random-read and 5 bulk read operations are done with the
latency limit enabled / disabled, and the maximum 'slat' (start latency),
'clat' (completion latency) and 'lat' (total latency) values shown for each
setup; values are in microseconds. The bandwidth is measured with the
'read' payload of fio, and min-avg-max values are shown in MiB/s. c6%
indicates the time spent in c6 state as percentage during the test for
the CPU running 'fio'.

==
Setting cpu_latency_us limit to 10 (enabled)
  slat: 31, clat: 99, lat: 113, bw: 1156-1332-1359, c6%: 2.8
  slat: 49, clat: 135, lat: 143, bw: 1156-1332-1361, c6%: 1.0
  slat: 67, clat: 148, lat: 156, bw: 1159-1331-1361, c6%: 0.9
  slat: 51, clat: 99, lat: 107, bw: 1160-1330-1356, c6%: 1.0
  slat: 82, clat: 114, lat: 122, bw: 1156-1333-1359, c6%: 1.0
Setting cpu_latency_us limit to -1 (disabled)
  slat: 112, clat: 275, lat: 364, bw: 1153-1334-1364, c6%: 80.0
  slat: 110, clat: 270, lat: 324, bw: 1164-1338-1369, c6%: 80.1
  slat: 106, clat: 260, lat: 320, bw: 1159-1330-1362, c6%: 79.7
  slat: 110, clat: 255, lat: 300, bw: 1156-1332-1363, c6%: 80.2
  slat: 107, clat: 248, lat: 322, bw: 1152-1331-1362, c6%: 79.9
==

As a summary, the c6 induced latencies are eliminated from the
random-read tests ('clat' drops from 250+us to 100-150us), and in the
maximum throughput testing the bandwidth is not impacted negatively
(bandwidth values are pretty much identical) so the overhead introduced
is minimal.

-Tero


