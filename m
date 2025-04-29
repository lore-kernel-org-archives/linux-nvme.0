Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8971BC3ABA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Reu8quFzfIk3PDBhseb0c38gdBeN3aa/4QPg2QcShuE=; b=XK1e119AqXlEgpQqAgPg4Tplkj
	DvVZWBDSWBHLgfsfIlyx0fP3oLQJ+AZHh0Jqm3i2IMjw0bpdFgBq9FcwBIEmn0MrzmaYhfq5Qmv6o
	k0Jyn4e6q1vf20aJ7/UyrWBx+xgJP1aSPqBUxqGhnV54r4V17E4k4VYsyEg60flyLQb0nJ9TVUO1d
	FyKVoxLn+HG4Va9DI0MfFA3j5Pl90uLtqVdZuuE2S5037Fy+JyeVcRAEdjvDlFh3J3U+MELlFyC1D
	erx3tFnuhIT1cGlWerkkpLlK+tzSNDg1tiklJVf1ZG4Db8qUvltswPhwXpQCd7uwiIwtnCMm8lIJa
	+SNXyq5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbg-0000000AWF2-0BTE;
	Tue, 29 Apr 2025 18:23:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9cEl-00000008GBV-2rSo
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Apr 2025 04:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=Reu8quFzfIk3PDBhseb0c38gdBeN3aa/4QPg2QcShuE=; b=O64AHcONdyP1u3EGDE1jq2NuAh
	hZTy+jpFzrHj1IThgYRalHWgeMqWBkdBM7te8McNtPFO29sVsnhMkU6K0xc36W2mRmA8kgl2G5sgs
	WY6MzGJwUrsjywhac6ghA5j9x1Em96Rojy5ElfNy8yJ1naleFdAPYtLM4eXr5I1yFNX/3G/IX/RLP
	UzmM6xfsLg4LrNw8Tl4pmLuvgm6MFK0o53Am/ZOXzpFeWBhxdCYkJsQZTC8/NaT45kWvFcd+DWMcD
	ipxFg6N+7nkd+M8gXl/q6X8F+NR2IBnaJ/OqAHL5J/Jz2qMo5kD9q5gHAPZVYjN08wBhnQ1W04klN
	wZAoms2A==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9cEg-0000000DBYg-3EgX
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 04:06:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5FDD04A2BA;
	Tue, 29 Apr 2025 04:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32BAAC16AAE;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745899577;
	bh=k2PRcTC3BnKrnGtxiZbpr39EydncBfZx8pWBXCBrn+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sl1R/QSSKs05tUYWMQq/uiCadkREGBOU5tVJHGA66P2EkOFGfCC1JLNOssSpJjpfv
	 i1N3YAK7hTIvrT9evYzjPTpMtl9av07WHvpZFrJXHyBHKvQWjn/JhigCD6fkfMAGPH
	 JkY8VguW7fzhxvQAMEhDofx3SSxc7yjIqdbHjB9Zr5KEaqG9hWmkcjzjao55vtZ/NI
	 q8WnG0Bz6jZ+4e+KKoj5E4dzgyIM5z1gqx+F00UJmhuUlydMRP5jx4WNva+ZnwM6YJ
	 EGWX7EYVTkC+hr3arTlEqZN+KPB4ASUlbCDvZNZIqqfe80t6+0KxhgB0ir2HqOqYyq
	 ONp6bMmilIzFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25755C3ABA5;
	Tue, 29 Apr 2025 04:06:17 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Tue, 29 Apr 2025 12:06:10 +0800
Subject: [PATCH RFC v3 6/8] kcov: add __always_inline for canonicalize_ip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-noautoinline-v3-6-4c49f28ea5b5@uniontech.com>
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
In-Reply-To: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Kevin Tian <kevin.tian@intel.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Juergen Gross <jgross@suse.com>, 
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 llvm@lists.linux.dev, Winston Wen <wentao@uniontech.com>, 
 kasan-dev@googlegroups.com, xen-devel@lists.xenproject.org, 
 Chen Linxuan <chenlinxuan@uniontech.com>, 
 Changbin Du <changbin.du@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=bu46wuQGrDj6kBvEdZGeSh/hu1kfUprs2xtOHC9YvDM=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoEFAzBVNZPkSl6Omnu5oU34AQK+1mpqi/WLkNr
 0NEvxK8dUyJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBBQMwAKCRB2HuYUOZmu
 i8g1D/40bhkDUMn5ZsiK4TnuOugcii2OnZKhTkti9V/LWWRvgzRyIsQwQx4FtXYSoLWNriV0VjO
 CyBhHFDEFDn9Qz/M965AcIUUmKLR5grVtMB9zo5zCc6a91HPJy6GMCb7vQWZAzb4+pWGKnhvAMx
 Ov0wOqEkIfqqFMjOVcO8Vm4hfpv/gUj81gfM3GBjvGd2OHSGu5Pij0pZYLJpk1zPwPTmvDqrsz4
 oYuo8iGnQFrGPoCp8bulBU2twHYxidXZqedbEM/1LtFaKcmn/lXQC7zQRnMoVVJw/VWRJEm3H/r
 ZAZEvQW29nAzq7hH4vvQnts2FtjI834A3qFtxQn63CS2Sfr4r+Cq1EuVsao/7MSVIED9IWykpk7
 4zxistnA1wTl+9FGo+ICJdWpP4NFZYJXYzFIo2tProekWZDMySQIIR8PlepBYAhmPBM4brAn4p+
 6EeroMTKyY8ruNjdDNz7d2T4eCWNT79QPnCWQnqqQnu6en7oxsQ2nWq0yCWUgq6PiInxlG1IrOp
 ws0NDutFTcctb93F/sUKWR8fxwjFNCr2kJf2YNiq9h6vsJ5kJf0v5kwbgfSvV4AJmDUqbWsjulX
 AA7Pwu8V0FCWq4C/mflHXRlVyt5MBdGeteRJDx/xMeppywk4M4UANlKUX+SDfpwBq2fbdtOztNl
 do0e6Yl/yQUEHnA==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_050623_355159_39987EBD 
X-CRM114-Status: GOOD (  13.17  )
X-Mailman-Approved-At: Tue, 29 Apr 2025 11:22:51 -0700
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
Reply-To: chenlinxuan@uniontech.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chen Linxuan <chenlinxuan@uniontech.com>

Presume that kernel is compiled for x86_64 with gcc version 13.3.0:

  make allmodconfig
  make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once"

This results a objtool warning:

  vmlinux.o: warning: objtool: __sanitizer_cov_trace_pc+0xc: call to canonicalize_ip() with UACCESS enabled

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 187ba1b80bda169d2f7efead5c6076b8829522ca..a2e2d3c655406b5a1f53e4855c782727b0541935 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -194,7 +194,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
 	return mode == needed_mode;
 }
 
-static notrace unsigned long canonicalize_ip(unsigned long ip)
+static __always_inline notrace unsigned long canonicalize_ip(unsigned long ip)
 {
 #ifdef CONFIG_RANDOMIZE_BASE
 	ip -= kaslr_offset();

-- 
2.43.0



