Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94FCD18140
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 02:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oQGUWzdlBtxMcgDJkoaLvIOSwHf8LlGnIqjsuVvZNds=; b=dUAqxHc2UY8aZ5UGmztEJym1JD
	26ZdH0+h4WfmwMXMrFbIuSr778QmYGp+0y3+Ja4MNB3acIwM0L9BzmNr0ViCEUg8hLMgAdtBDH7oD
	5JvXx3OHU9T7h/zD/o0fBrSU7rc6csNOCayIE7YNLt+JsU2ysnjkrJTmM8S9WEQULkycHNs9kl5ne
	sSNz0L0OCpRk5DgjGCzntDLIqvZEdn8jTsD5kLSjlbVkKXe19nYSJHJYosuEj/18WTgKC+lOyMlX+
	wcZkiSNZK5pcRxxkF22IfiO/N9JVWpdo+2oqwg4uo4yDkXiKID5+tjWYeB4mw0fi8ZZP4x0vabOib
	8xxsF7wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0XXa-00000006us7-0HpV;
	Tue, 15 Oct 2024 02:44:06 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0XXV-00000006upk-07Ym
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 02:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728960236; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oQGUWzdlBtxMcgDJkoaLvIOSwHf8LlGnIqjsuVvZNds=;
	b=hW0VcEOBOg5u9YqJaBUqgSxTjC6bX/tMyEiCL3in8fRuWvOyu1mipXeXoV0NyfoQw2+H7lZENMdGej5mWW4NTluh4HSDIBRxGdmRy1TnivI8lwia/UnVh8Jcy+V3sJ1zIALTDp4V271W+ZPeAWxy4Iwf+HaAsQUXzFbECQgMaWk=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHBe6tV_1728960230 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 10:43:55 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v5 0/2] Test the NVMe reservation feature
Date: Tue, 15 Oct 2024 10:43:48 +0800
Message-ID: <20241015024350.16271-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_194401_382236_9FF09540 
X-CRM114-Status: UNSURE (   9.14  )
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

Changes from v4 to v5:
- Remove hardcode ns_id.

Changes from v3 to v4:
- Introduce var test_dev="/dev/${nvmedev}n1" instead of using
"/dev/${nvmedev}n1" everywhere.
- Filter the resv-report result.

Changes from v2 to v3:
- Put calling "resv-report --help" to the beginning of test_resv().
- Introduce a hlper resv_report.
- Fit newest blktests version. 

Changes from v1 to v2:
- Add a new patch to add a optinal argument --resv_enable.

- Make resv-report fit the new --eds argument.

- Filter the hosid output to make the new test case independent from
hostid.

- Change the new test case name to "Test the NVMe reservation feature".

Guixin Liu (2):
  nvme/{md/001,rc,002,016,017,030,052}: introduce --resv_enable argument
  nvme: test the nvme reservation feature

 common/nvme        |  89 +++++++++++++++++++++++++++++++++------
 tests/md/001       |   4 +-
 tests/nvme/002     |   3 +-
 tests/nvme/016     |   7 +++-
 tests/nvme/017     |  10 +++--
 tests/nvme/030     |   6 ++-
 tests/nvme/052     |   5 ++-
 tests/nvme/054     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/054.out |  68 ++++++++++++++++++++++++++++++
 tests/nvme/rc      |  11 ++++-
 10 files changed, 278 insertions(+), 26 deletions(-)
 create mode 100644 tests/nvme/054
 create mode 100644 tests/nvme/054.out

-- 
2.43.0


