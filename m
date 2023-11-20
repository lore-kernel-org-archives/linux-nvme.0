Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9483CC5ACB3
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 02:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=929ihoyEoADD4fH8atUPdhqYQk/ZcwZcfXah4PbVtig=; b=GH5speGs1qnKZqb7CToOp/1PJR
	l9tYMv1ayWnm6H+lm6AiC8sxbYYmnw+H3yIdInRl3IGU0wC/V2GhkjDz8Egn7qwIyAZ3BisWm+9CZ
	lANAvwOdkLmqlE5qLnzI00gNxMEfEF7F1jY0rBRVmlZOlzLgWSQZq29VWb2Cg0a1WLA+l0EWabQX/
	2xbci63186VdwWoXu8QVtjUnEx7sH6kVsJGwIqHgnFh4mPTiVLqNdD7sPFDr9maGC6kyHzuQjuYxJ
	jrvplg4ixv+yHzedGz3RFcol9qBY9xPhr/FZtD/typRPtERsqvxJHdp7ujxemKhDErzPGzDzST7xZ
	xEUTGxIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r4uLz-00AyTO-1j;
	Mon, 20 Nov 2023 02:49:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r4uLw-00AyQa-20
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 02:49:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700448576; x=1731984576;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EJjx07eaa3eOPS2MmLCRFA0098DB9H/f5+N2JcKQMLo=;
  b=lm4uqeMrAS+raNSh3GjDENvlo0kdY9fVROxrPb3Dj5JEYDiBLZt7QTXB
   LVbRLqKe0FJd4TbHhbAxNSp820/cK51nDNKlucTuzOiY+2pn82C/uvyme
   Lb4UhYg+oHYOBzyal44omEY5QEbLbt+xLvw4PNY2AhZ65w89xnQq1nm1e
   TM4l40k9PzU0mkNWHqyUOdCFHKGQjsG6KZLZ0VCtn9HQdzGnAi3mD1vnW
   ffEGJWBcwFoPhhHWTZtTm4X2AiubhTxGKGQ7YgtpE/kJtJ6r8tm24V5P6
   CgW8ub2jVrBpJTHMo65dA7nYpQLlsugQUOlNOGqWIFaOLdPDE/Rr7MYJa
   Q==;
X-CSE-ConnectionGUID: r/Q/fFUBTlScnpCERkaUow==
X-CSE-MsgGUID: hhsBup+xQbyBarTlc+Ow7g==
X-IronPort-AV: E=Sophos;i="6.04,212,1695657600"; 
   d="scan'208";a="2663715"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2023 10:49:33 +0800
IronPort-SDR: Jq2UQLTjH05s+aiTWAOOZnuCtg0HM4adnNmyOgxVsVVgqTDk9u/ZX/saiNo4zkdXPuYhYwWZxE
 mnwqucJLPKnSs4ush5N48WX4ih0yTmPcrRAsDQiwQCAfiHlgTQg1JxowyjdD9O/HwDmqbTfJs1
 wMz2c+9X/EUw1g994VknD3V0/gmZ3gJ/yCe2gJoq2iJjiHo13FBqK9lJHDjSXgud4ekWqeJYvx
 lKJ7LLfW0nVn6kHbzIWUK88/1n0lFNQWjIvpv2lapRyEPskpBiPGrcF1XXnR37gWg3//7QMt8+
 rUg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2023 18:00:54 -0800
IronPort-SDR: wnUDoEhcIpZYbVJ9SHvH8Lg0lW3RA+bgddTHpZO5ooRQ1nVtFbemp0FXh5NkNksHOWIq4egR7/
 NCUOXD2DTray/rFGM2rQ4DL9r5e3o9f93e0M1HjGJ56aHqBRHkcL0lPegBHpOJf0VBbtN1ccoa
 fUhOpAOhZVo3yBwBL/vKPvKp4kdUA7o1V+cF6RRXXmdcp2vi45mp9x2OghPtdDmPV+KZFEjB5R
 FkXrPjI3cqpMJM4JkFaFvpo8IKkzbPUicF4Mm8uD79I/I/GpSu5YGuOyvsKTcQ18BZnwrX7gzF
 3AM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2023 18:49:32 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagern@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/1] nvme: require kernel config NVME_HOST_AUTH
Date: Mon, 20 Nov 2023 11:49:30 +0900
Message-ID: <20231120024931.3076984-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231119_184936_717342_2DC7D316 
X-CRM114-Status: UNSURE (   8.92  )
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

Yi Zhang reported test cases for nvme authentication feature fail with
linux-block/for-next kernel [1]. I observed the failures with kernel v6.7-rc1.
Chris Leech pointed out that the test cases require kernel config option
NVME_HOST_AUTH. This fix patch modifies the test cases to ensure the
requirement. I added a Reviewed-by tag by Daneil per record on GitHub [2].

[1] https://lore.kernel.org/linux-block/CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com/
[2] https://github.com/kawasaki/blktests/commit/81110ce8056f16716d09774e6f237ea0393579e1

Changes from v1:
* Refer nvme-fabrics sysfs attribute to not rely on kernel version

Shin'ichiro Kawasaki (1):
  nvme/{041,042,043,044,045}: check dhchap_ctrl_secret support by
    nvme-fabrics

 tests/nvme/041 |  1 +
 tests/nvme/042 |  1 +
 tests/nvme/043 |  1 +
 tests/nvme/044 |  1 +
 tests/nvme/045 |  1 +
 tests/nvme/rc  | 16 ++++++++++++++++
 6 files changed, 21 insertions(+)

-- 
2.41.0


