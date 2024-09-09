Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1229ECE577
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:In-Reply-To:Message-ID:To:From:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=EEdzXASna0qsCsTF0xjX6X/QD5g++UXp3SOzRNxuMl4=; b=APbscGHmN3tY/5bMXDKJSAbRdP
	tsi+/RRdQSul1NGXbchr6jXOgqmJIQjqXwEBBNXPH+tuV1TTQW9bFnUAJIoa9/vQae3O/j5Hf3pEL
	oGaJYxRXOKLcQN3sxanA5+3Evmn4iYaqlI+YaY2+/PDkZm1BL7Gv6E4N2tr4LsznJ3D+8QdPnN0cg
	rWoMR/RX2+Ozw1JdhtLXshFGrBOLT2h4oOHjqFWElPrjWVlzIO+tF5xzxB3G3D5HCjb9td+iyVg5B
	/xItgh32a2mgF+BMpb5hVi/8HXgo6HJpAGIfD2MhdpKXDzHpSo3nZ1SbsG0JNAFZ5sU1u9TNvNgAV
	LoaAXMDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snjDy-00000002yQL-0S5b;
	Mon, 09 Sep 2024 18:34:54 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snjDv-00000002yPn-116L
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 18:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1725906887; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IYI6w6QSgiZUOWribNQn6NGg0tVUXDYjvVgoWKU4lolmJBpMTcdhFTGAoUF8Yg/CMSd6avTS/sN/h3Gm0rDw58eajqFuAMo93vhs+yIBbXrlSX4VR7Tm8fKfyG20HRVb3Bo+hpqXNSsP+W77oG7JI7Hfpfiy4I1BAeO4vf4L3Lg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725906887; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=EEdzXASna0qsCsTF0xjX6X/QD5g++UXp3SOzRNxuMl4=; 
	b=eL+q6XjID8cceyvN0qDIxwHZE7rapLCAdsqk3oDmhqiRv1Hp2i8DWknwoD6MyvIq8QEtx9a4Oai/Uox/aDAQIr8JZkJ/B3STpDjwHxcagSkZdvt6syIpInpHQzNHyTHUayS29n4EoSMsieMSawBt8RfEAU/o8cBzNFb9fZDmJ2k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725906887;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=EEdzXASna0qsCsTF0xjX6X/QD5g++UXp3SOzRNxuMl4=;
	b=Dz6s+mYUglgYIG8X+dOuoIYjtOuQ2VznUrq5Qw4Vdlv0yIZgfDvRITuDVfaZ6Eg/
	vKKFfl1tDerXgwDNr3Wt0toe0FUNsQYErS9RJc4OifzhXG/9frJGGp9c3YWCEoL0Nx9
	1gzCSezaMuq/rb33SJUTxQdEHImECraSQQxsoAeg=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1725906855223915.0124836657466; Mon, 9 Sep 2024 11:34:15 -0700 (PDT)
Date: Mon, 09 Sep 2024 19:34:15 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "linux-nvme" <linux-nvme@lists.infradead.org>,
	"Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@fb.com>,
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"linux-mm" <linux-mm@kvack.org>
Message-ID: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
In-Reply-To: 
Subject: possible regression fs corruption on 64GB nvme
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_113451_383838_D86F955F 
X-CRM114-Status: GOOD (  25.39  )
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

Hi all,

We have been chasing an occasional fs corruption seen on 64GB NVME devices and would like to ask for advice and ideas as to what could be going on.
The devices in question are small cheap NVME devices which are eMMC behind an NVME bridge. They appear to be quite basic compared to other devices [1]

After a lot of testing, we managed to get a repro case that would trigger within 2-3 tests using the desync tool [2], reducing the repro time from a day or more to minutes. For repro steps see [3].
We bisected the issue to 

da9619a30e73b dmapool: link blocks across pages
https://lore.kernel.org/all/20230126215125.4069751-12-kbusch@meta.com/T/#u

With this patch we fail to verify the image within 2-3 attempts.
When we revert this patch it verifies every time.

This appears to be a concurrent read issue. The desync tool we use for testing fires off many threads.
If I first cat the file to /dev/null to prime the page cache with the file, it verifies fine.

I am currently attempting root cause analysis. As yet I don't know whether it is directly related to that dmapool patch or whether it is just exposing in underlying issue with the nvme driver.
For now, we are shipping with that patch reverted as a temporary fix while we work towards a root cause.

It was originally observed in the field after updating from 6.1 to 6.5 based kernels. Upon further testing this seems to hold true with the easily reproducible test scenario. This seems like a regression.
Testing on torvalds' latest tree shows the issue is still there as of 88fac17500f4ea49c7bac136cf1b27e7b9980075

I thought I'd let you all know in case you want issue a revert out of abundance of caution.

Some other thoughts about the issue:

- we have received reports of occasional filesystem corruptions on btrfs and ext4 filesystems on the same disk, this doesn't appear fs related
- it only seems to affect these 64GB single queue simple disks. Other devices with more capable disks have not showed this issue.
- using simple dd or md5sum testing does not sow the issue. desync seems to be very parallel in it's attack patterns.
- I was investigating a previous potential regression that was deemed not an issue https://lkml.org/lkml/2023/2/21/762 . I assume nvme doesn't need it's addresses to be ordered. I'm not familiar with the spec.


I'd appreciate any advice you may have on why this dmapool patch could potentially cause or expose an issue with these nvme devices.
If any more info would be useful to help diagnose, I'll happily provide it.

Thanks

Bob



[1]
$ sudo nvme list
Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            NCE777D00B21D        E2M2 64GB                                0x1         61.87  GB /  61.87  GB    512   B +  0 B   10100080

$ sudo nvme get-feature /dev/nvme0n1
get-feature:0x01 (Arbitration), Current value:00000000
get-feature:0x02 (Power Management), Current value:00000000
get-feature:0x04 (Temperature Threshold), Current value:00000000
get-feature:0x05 (Error Recovery), Current value:00000000
get-feature:0x06 (Volatile Write Cache), Current value:0x00000001
get-feature:0x07 (Number of Queues), Current value:00000000
get-feature:0x08 (Interrupt Coalescing), Current value:00000000
get-feature:0x09 (Interrupt Vector Configuration), Current value:00000000
get-feature:0x0a (Write Atomicity Normal), Current value:00000000
get-feature:0x0b (Async Event Configuration), Current value:00000000
get-feature:0x0c (Autonomous Power State Transition), Current value:00000000
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
00f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "................"
get-feature:0x11 (Non-Operational Power State Config), Current value:00000000


[2]
https://github.com/folbricht/desync


[3]
$ dd if=/dev/urandom of=test_file bs=1M count=10240
$ sudo bash -c "echo 3 > /proc/sys/vm/drop_caches"
$ desync verify-index test_file.caibx test_file





