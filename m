Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C8C388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 20:26:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B655620882
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 20:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tv0bziwM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l2Y47q44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B655620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kzd/S00Zsgic5rwBzNPjhO+Ytuda9PVt/c+L3zih8DE=; b=Tv0bziwM/0/M4XGV2RLi/petW1
	6oNHXf4OXJW4l838L8JAT8QG6qPcN20Aye7ESWdLTT7jVuYysclUl3iad2geqhT3bDvgw9Z5mbfcQ
	/SYkP/32eruxa7vCQ2j7e4s6XrzKOBGnEKE26QOxuDa4FIJWfX5tagQ437njIxUX4OPm/ner/6Lc1
	lqUX8xMweBDorGSYSBzXWGrvXkhA2IjxJV1WJkB04srrUIFvaiy+PIeRDLJm7cx4/EckbdFd+7WzQ
	DRQ1NY4f29SSnXL6JPVvdOYR40FqiEp5Isu/DzabQ4YuihnaWhSJRJg8n7mu5TYCCMYOkNUGJbhqp
	yGre5F9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW3eB-0004Vp-Td; Fri, 23 Oct 2020 20:26:48 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW3ct-0003hZ-Ej
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 20:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603484727; x=1635020727;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6b4ayyks4TKOMcjy6skYbBYAYqDVai/2a8borgvYpfQ=;
 b=l2Y47q44duwS6VKrndMeGsqNBVzVlI0gaEOIIRdmSqW10RLoLk0WRWEi
 DbHg4xSXj5MO5Ge6bxCY7IDLOaOjn2fkQ0CW0NQOaN0Ugxm96QbAxj2zz
 1TnN2/C6AGFn9wxd5iCeWtq4rcdThel0xY0po4GvhETVNfEMsq12WPeZ0
 MF8fnfU4rGoRs0aLePj77u80uYCj+TILkCbjLKFXPHN1CD7+3bugzofGE
 xeT5tsCbZlA+jrpHncgfTWd6dTuehemlavYAafzZWOhmSs1E3Z0PCAWCV
 macnbX7FZBaEAFP7x2V8LMsI9aHviIXgBStesNK1wx51UGPKJE7ytb20m A==;
IronPort-SDR: cQfKTMZgGEVx2xF/h308ufKwfUqgdRCtGaddgHu3+vNDooB1DQn0EOB1ecBABGSeYk+wxshLd8
 3IR+RgtFTcz/9LbIRuNcW5vadBVgDOv6viOOjBeiHWvikGOHBCN3/WoubniWkjagL1V7InhlM9
 vM8121ObxARhwd2a9zy7JKPQONKUrCgyhaqQuvMhZzr9VW3YsvNRixHp2jC8SP29UydnR/fWDm
 3E7pKYFSx9/allr/5VJdkaSp7/nbtLaJc7S73xSxkFJkE9b3/vljTt330siRGeUtn7UYJ7o6QU
 cWU=
X-IronPort-AV: E=Sophos;i="5.77,409,1596470400"; d="scan'208";a="260657645"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2020 04:25:24 +0800
IronPort-SDR: GHfSRQI8SDB4MiuYFSGw8x+7ntA1nlgK2W4P4JhYVCqa3ryLo5Kj9B7lNEUUgfe2ttfKLCabHm
 IjRB1qO5XwOom9S3RyOgLVdYxfHLMLGY7fEo3QqHduoV2jWyxw3lL5PZ8xrPqShK9olf2AaEhk
 CdHTO12xfkKxaU4qt5+Tx4fbBLZhB8nGm5Qq74qLGw3OSkxCZt6OJNL78PPVgH/pMhMHw0Nm7+
 lPvoAYQ4mTc+1jXmsKJaiODE6xR39jdhxplh+L3UrLqibGEiqSvjSVNmZGHcolbKq2R28Lkv1V
 xM/qWyHCcpobhjTyIbwEfSDl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 13:10:39 -0700
IronPort-SDR: W57PiOajCWuv0NbFMP8RJATT1HEmWxJ1QAYsHUhqxVZboU3ltx8oLCm90QypH0bmeCNaeWyvFu
 fOJeE0uB7LIvzya7+UmYoEsffmpr77vz9yJh/yZjRABEgnhYZ1Ck3g1c6VeiBg4QUnhOG7fU0a
 w/zkOWE0H3EEyj9WM91gXB0d9gKQyG1wJOq+K8rnDLYU8h/wy16MftGkIKEaxJ4/E/Usa4Gorn
 ppNj81ixA5s34eXFuMFeLCIMMmpUBuKAID+o0mygc7WQnALinx0LUD6llKLn5VoOYVs9AqGOkG
 eZY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2020 13:25:25 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-cli: remove default ctrl_loss_tmo for connect
Date: Fri, 23 Oct 2020 13:25:21 -0700
Message-Id: <20201023202521.9610-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_162527_854730_C80A6A79 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since nvme-cli adds a default ctrl_loss_tmo for connect command
all the testcases in the blktests are failing. Thjs addition of
the parameter breaks the nvme-cli command-line compatibility with older
versions.

Remove the default ctrl loss tmo parameter addition for the connect
command user can specify that from the command line.

Without this patch :-

# ./check tests/nvme/008
nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
    runtime  0.157s  ...  0.165s
    --- tests/nvme/008.out	2019-09-13 21:45:10.353000000 -0700
    +++ /root/blktests/results/nodev/nvme/008.out.bad	2020-10-23 10:08:16.910000000 -0700
    @@ -1,5 +1,7 @@
     Running nvme/008
    -91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +Failed to write to /dev/nvme-fabrics: Invalid argument
    +cat: /sys/class/nvme/nvme*/subsysnqn: No such file or directory
    +cat: /sys/block/n1/uuid: No such file or directory
    ...
    (Run 'diff -u tests/nvme/008.out /root/blktests/results/nodev/nvme/008.out.bad' to see the entire diff)

With this patch :-

# ./check tests/nvme/008
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  0.165s  ...  2.857s


Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fabrics.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index f8a055b..9c33c02 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -896,8 +896,6 @@ static int build_options(char *argstr, int max_len, bool discover)
 				cfg.keep_alive_tmo, false)) ||
 	    add_int_argument(&argstr, &max_len, "reconnect_delay",
 				cfg.reconnect_delay, false) ||
-	    add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
-				cfg.ctrl_loss_tmo, true) ||
 	    add_int_argument(&argstr, &max_len, "tos",
 				cfg.tos, true) ||
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
