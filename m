Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0E0C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 15 May 2022 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:To:From
	:Date:Message-Id:Mime-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iSKnjL5EIYm6H68qejtmsWoy9aQTUXQkSpbKmiJrw7s=; b=dw53+0imG3fG/FFnLGwJnQaXy6
	oYFfd/Z2aYVrUC62LJw8b4mb6WR2boE2dzy783pyUfcsDuojk+d6F8MKJVAtFwWrazdxEpou/9BN3
	grrJZpVLdPk65x7MIGvPt/zrbYNPzx3bgKpOpBwUMV1vqvGj71vRNJKCRNhiZn3bqaIQ+UAVpRC0Z
	ClX6oFsHsitiUv/338gGysQ0Dr3T0tvKPsEi3C7nYlQeaeh1nytbSpZm9c9AYCGjW0drXGq6ZmSfd
	QPh2FV82FXcRugTZpvW33Ay+AKgf5kE1RyCv3yXq64wSMBZFSeim09es9YPCeVd+zlYTau/5H1in6
	9qCxFwUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqGgF-004MYa-SI; Sun, 15 May 2022 16:01:15 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqGgC-004MY8-HH
 for linux-nvme@lists.infradead.org; Sun, 15 May 2022 16:01:14 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id D4FB23200392
 for <linux-nvme@lists.infradead.org>; Sun, 15 May 2022 12:01:05 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
 by compute2.internal (MEProxy); Sun, 15 May 2022 12:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scriven.org; h=
 cc:content-type:date:date:from:from:in-reply-to:message-id
 :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
 1652630465; x=1652716865; bh=iSKnjL5EIYm6H68qejtmsWoy9aQTUXQkSpb
 KmiJrw7s=; b=yjTzv6c95/ty6b/iPAAR9TLg0xbWoPtBTZ8XbtkZgYgEMbBsMKC
 bFMRDFKZiGakmwcfJy2jpYpPZ1eDCtq7SzQDiQXLoTlCGJoKqVcW0EHvs4Vxhljb
 T+H1rhTJfQ9AEpewRPWec0Ag/PWYtSjJv61uof4e/L8T2xF8ZOwhUUURRbEcQevh
 o4h35friu3abtIsC+VNK7lZeTBJGxsKu+DqcieFqhpBpL3rPAlbwfKnsD6uiciDe
 9If12xHe6eD5dVrGhIqV1yxaSZ1cyBP4F+uUUJevamXKWAv+RFfIg9ed3d4n0z+g
 Gty+WRIxwzutKfRqikXu0MpDvkkVDOmd6aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1652630465; x=1652716865; bh=iSKnjL5EIYm6H
 68qejtmsWoy9aQTUXQkSpbKmiJrw7s=; b=PLutBKNXqD3wkougRAIyz2JxvQQvI
 bPrq/fmvdLZfGLd/GrsQBgY5HV/VrFdng4Q26yPAJvKLbgvVanq7P0fNDWUP4Aw6
 tNvz7RgAG2C2uNxbEyaUG9/PBBkmT0+H+zkv6H/BzEUR8nZgh8X2cI2OrVWRLeoX
 pwkf2d3Fl1PeNzd8Ie0U2sZzMA1XBRZY+cb+wqY6aHILnAY7sJg0sVXiZ3eRNWUX
 4jRxUFEwVm+9mCKyyEY5ZOcdC/rHDQhKNCVrEPcl+bubt61sFO8i9NsWTZdBCbNY
 THr1qIPTySrtCA5+nrmXDlew+zDl/7vvykuU6HC/JB4lER1gT514SQ+xw==
X-ME-Sender: <xms:wSOBYlPsi9nwXccU9HpzJFb9ykSZGrNhOW8wagAbuULFBNwp4NlwFQ>
 <xme:wSOBYn9NYHXh9K2bDVBTg_jrbXk5BT6Wmp5yd46IFWYHAC9PjXXT-EIEjOFQW6MBy
 9ea_BS3gnsFS_KE_1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheefgdelhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
 ertdenucfhrhhomhepfdforghrtghoshcuufgtrhhivhgvnhdfuceomhgrrhgtohhssehs
 tghrihhvvghnrdhorhhgqeenucggtffrrghtthgvrhhnpedtffduvdettdffveduvdefie
 dtgeefvdfgffekteetfefggefhtedukeeiheetueenucffohhmrghinhepkhgvrhhnvghl
 rdhorhhgpdhlrghunhgthhhprggurdhnvghtpdhgihhthhhusgdrtghomhenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrtghoshesshgt
 rhhivhgvnhdrohhrgh
X-ME-Proxy: <xmx:wSOBYkRxFQqQc4Mhg3ydwXnar1f_zag7Y5w_gxTgJ3WYl-QszeJC8w>
 <xmx:wSOBYhu-dzZRCs-pqDFRvXv1UCsq-yMbPIrbDHRoBYh0ivqaD5m4OA>
 <xmx:wSOBYtf376yBrUnjf2xkIBwLKalXPvpgi5rE0VE1TV5ixZfn08zu4g>
 <xmx:wSOBYnpuIDQiE0d58YdrZK5BGLlJ0EcGt_78tAnw-FQdBg1JG0oa1Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1766E2A20069; Sun, 15 May 2022 12:01:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <5ea81a6a-b510-40d2-9b32-036f263f75f3@www.fastmail.com>
Date: Sun, 15 May 2022 17:00:44 +0100
From: "Marcos Scriven" <marcos@scriven.org>
To: linux-nvme@lists.infradead.org
Subject: My Western Digital SN850 appears to suffer from deep power state
 issues - considering submitting quirk patch.
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220515_090112_992069_FB1613D6 
X-CRM114-Status: GOOD (  18.03  )
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

I've been experiencing issues with my system freezing, and traced it down to the nvme controller resetting:

[268690.209099] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
[268690.289109] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[268690.289234] nvme nvme0: Removing after probe failure status: -19
[268690.313116] nvme0n1: detected capacity change from 1953525168 to 0
[268690.313116] blk_update_request: I/O error, dev nvme0n1, sector 119170336 op 0x1:(WRITE) flags 0x800 phys_seg 14 prio class 0
[268690.313117] blk_update_request: I/O error, dev nvme0n1, sector 293367304 op 0x1:(WRITE) flags 0x8800 phys_seg 5 prio class 0
[268690.313118] blk_update_request: I/O error, dev nvme0n1, sector 1886015680 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0

Only a reboot resolves this.

The vendor/product id:

01:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Black SN850 [15b7:5011] (rev 01)

This is installed in a desktop machine (the details of which I can give if relevant). I only mention this as the power profile is much less frugal than a laptop.

There are several bug reports on various distros about this, but to give just a couple:

https://bugzilla.kernel.org/show_bug.cgi?id=195039
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1705748

It's also clearly a know quirk. Here's a couple of examples:

https://github.com/torvalds/linux/commit/dc22c1c058b5c4fe967a20589e36f029ee42a706
https://github.com/torvalds/linux/commit/538e4a8c571efdf131834431e0c14808bcfb1004

On my particular system there seems to be two power state settings.

One from nvme id-ctrl /dev/nvme0:

ps    0 : mp:9.00W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:0.6300W active_power:9.00W
ps    1 : mp:4.10W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:0.6300W active_power:4.10W
ps    2 : mp:3.50W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:0.6300W active_power:3.50W
ps    3 : mp:0.0250W non-operational enlat:5000 exlat:10000 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:0.0250W active_power:-
ps    4 : mp:0.0050W non-operational enlat:5000 exlat:45000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:0.0050W active_power:-

The other from nvme get-feature -f 0x0c -H /dev/nvme0

get-feature:0xc (Autonomous Power State Transition), Current value:0x000001
	Autonomous Power State Transition Enable (APSTE): Enabled
	Auto PST Entries	.................
	Entry[ 0]
	.................
	Idle Time Prior to Transition (ITPT): 750 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 1]
	.................
	Idle Time Prior to Transition (ITPT): 750 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 2]
	.................
	Idle Time Prior to Transition (ITPT): 750 ms
	Idle Transition Power State   (ITPS): 3
	.................
	Entry[ 3]
	.................
	Idle Time Prior to Transition (ITPT): 2500 ms
	Idle Transition Power State   (ITPS): 4
	.................

I don't really know how those two interact, or are related, if at all? The timings don't seem to match up.

Anyway, with all that background, I'm happy to try NVME_QUIRK_NO_DEEPEST_PS for 15b7:5011 locally, and submit here if it works.

However, the main problem is how to reproduce this issue reliably/deterministically, in order to be confident in the patch. It can happen with in minutes or days at the moment.

So, my questions:

1) How can I reproduce the issue deterministically?
2) Are there any other causes of this I'd need to rule out? E.g BIOS, PSU, broken drive rather than a power state quirk.

I also have a couple of more fundamental questions, the answer to which is probably way beyond my understanding:

3) Why are so many drives needing this qurik in Linux? Could it be that Windows also avoids these power states?
4) I looked at the code around the message, and it seems to be this is about an attempt to reset the controller, rather than just accept it's timed out an operation. Is that correct? And if so, could there be a problem with the way resetting is working - or is it again a quirk with these NVMEs?
5) On that note, some Googling yielded this patch, that I think was rejected https://patchwork.kernel.org/project/linux-block/patch/20180516040313.13596-12-ming.lei@redhat.com/. I'm unclear on the details, but felt it might be relevant.

Thanks to the maintainers of the NVME drivers.

Marcos


