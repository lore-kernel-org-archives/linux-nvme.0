Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AA0C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 07:13:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A630664E57
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 07:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A630664E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0RGBT7Bn2yV/yAsfKGimcPjTayPqLYz7C0f5ADguhQc=; b=PSCcLalYmyPV2SgQ6iZw/badKg
	twVR17248Y7xMUDmYzbrLYYDYesO6YFYVi3AW8ms4Otjam/Np+xui9jCckOz/OaG4EYW7DBAN3Hv2
	o6KIqq6Bp1lxdCm04JNrpEHibtnsheUTWM4dil7ItgrPIhc7aN/j0m/uWVuwIttdMlmBEF54Frlp6
	su7vZpVfOFlp0+AKhQTuB5pTu5sZ5/Gq+TOGaOYDd/OHuak+rVdjS0MmlGbnRm2HyYYsXWyyEVb2a
	L9o4q2ak4cKCIIpCqomSD9zC3Z7hJIpyr9Y+sNJ6wJcbSEmZvXu92ht4yTFcWlIrPgVBW8Ypr0snr
	B2pGQ+uw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lASde-0005gw-32; Fri, 12 Feb 2021 07:13:14 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lASda-0005g0-V3
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 07:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613113992; x=1644649992;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lcv1KXPBSJS6P/Gf9KFga6dzEpB9HLtTr0GA0Rc2DFE=;
 b=rMzd6MzD8clzaw2SYhM9qqARwx2pqFJz0NecCbC8nEXhuL1pHrf+YepF
 2RA1SEeIUqi2WArO8bJA2rdtyT3p+Aj5mcxLDwaQEtDUdd8zu6D2lwAkY
 +Qyw5cPWjLXAII3nJEHjWnb/Df6G9l6nFake7ntc6deJ9ee8C+ht6MqnP
 trIg8zWjbZAXhfBRziEWmTpgtp3UD1ZTCu0slp9frkE32S/dku1281S9M
 vebThoR/2kEftWuUYCcRHijf1FIgPwlBa/gFbHTybrQd6xmvnOC+Oot/B
 h+9gpx8LTWb6omC17oEgqfqvBaQw88VQ+7+Pz7OdSOY8pzCqM2y48nQ/G Q==;
IronPort-SDR: bkd9prq3GWvsB6GRPw6wEk4JcbUPUWQWM6qDLI+ISFWBMceDXXIdz+lrVV+vp+m4hjAtDqnfnO
 kTvctCAkiE8/JZX3TyGM16EQMDW2LZHBsR8/Pi6+cPWItmB4BnyVO5Ye71qAPdrFTvGEfn1pt2
 eE85PPtMQS80bgI2ZVdUB2EgRZYoPiojyTn9LTmwvztXqX9vMx8fOVxzUzkSmAMx2vCHKU+C3z
 olJIXzYa8Kqb1sClLQKcyC+ErkBuUVCHkQoIbcjlraTKt27z1yEadLDPY0Ej2afYofWiq9Owo5
 QxA=
X-IronPort-AV: E=Sophos;i="5.81,173,1610380800"; d="scan'208";a="160992137"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2021 15:13:09 +0800
IronPort-SDR: 0y+rIfkwYG5NK0RZIhOpQ8KIm9hwudVyCrQoXXTHmen7nVLyx1V3n8k6o2YtQj039GcTcUxalz
 Fz39RV9LtFuuVqLfoiF82QUhGswHjHuct//ZB8/dkEArOoLbLoFnjDISQsGxZuCZTIskU7hK+/
 sM6qFCZB9LeJS5vV1VOkO7h3WhP8HwifV58Aq39q8jtNtkuQMG3++ePSPmX/I14JQaaPlxqGEI
 IUDedQEyHMpwP83YJ05jIiveBYAD97NwOH7SWNIapmmhwQzsvfEqkHs+GNlQ3VAIPzxYcGw5B6
 y2uKEqXmf6wfY5SfwERrW4n/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2021 22:54:58 -0800
IronPort-SDR: ClAXeR+bHXPW/8Z63JwkRU6uG+1O+zM2WkmDsfnwF6Zz55suGFmCb920IkdR2qI/xv3KKDpGTK
 ZNahfpfntY/9AsQWTEMyKOfBtblGnIdiC6/HU8UXzN28AY/DtTnG/jFYXPRyjsu3vdgsmcz0mU
 44Q8IYd4ChjC6YJURDA/O6Z0gkI0I6DmhoMJT6NCqSJqI20Bm+aBghbTM7CrUK7l5zdqmcsTUQ
 Dx3a3AOVFqfFhVSb1vmxeQ82JSttd/pf+pj9f6nW24yrS4CyBihYRZe+He+0x20UFy7rk/NAnG
 864=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2021 23:13:09 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: resync nvme-cli and align values
Date: Thu, 11 Feb 2021 23:13:03 -0800
Message-Id: <20210212071305.39901-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_021311_205264_2EF738D8 
X-CRM114-Status: GOOD (  10.07  )
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
Cc: mgurtovoy@nvidia.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Resync the nvme-cli headers and align the enum values which matches the
rest of the enum definitions.

I've tested this patch with backporting the require commit that needed
nvme repo with nvme-5.12 branch to be in working condition.

-ck

Chaitanya Kulkarni (1):
  nvme: aligned all enum values

Max Gurtovoy (1):
  nvme: resync header file with common nvme-cli tool

 include/linux/nvme.h | 173 ++++++++++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 69 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
