Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19276C5DF88
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 06:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r0hhbG0RgTFZ04CU2rRbzpIntu+XxhW4ECNqU2drBj4=; b=xoBlflBNcPEE4FsnW/uq6A0eej
	Lghcjn5eri7bmsz0/ioVrNUGg5TVdZIAIvKosdxm0dZidFVOc0jUxvaM8HrHiLNeVkh1u0oewNlKa
	CYUHqsV9XLAMnpq+TNIVVlXVKmgH/ho3DEC9K5H2PrA8GasdaMvhSBQtUo7AMXet5X/0afBItxzIn
	mz2XWci9O405YbbNB9kE1Hj2XLo4sx4lTxvzkIDE2lPt8b7aySmzL976DSNYzNbdE2qCa4U0ngMaO
	jP9nROguRokffNafcM1bFuOKriVlsqrd1aC28U4BQ4WVCSm/PDcFXCAABeiB3cSOhxZMfO9y84npd
	WAXIfNpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIec-0000000CbMV-1SL5;
	Fri, 21 Aug 2026 06:23:02 +0000
Received: from smtpbgsg2.qq.com ([54.254.200.128])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxIeU-0000000CbLG-2oRG
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 06:22:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787293325;
	bh=r0hhbG0RgTFZ04CU2rRbzpIntu+XxhW4ECNqU2drBj4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Ais11P1tLDZURytZoNJD016N6a9h5BNNM0+EchIljKHZCCT7hcw0CHc8U3weCDB0l
	 6nEAikVrO8bKbJDxUF670BO9TCza7WuQDrTJlvUHkWlN4F4tfB0R0LxoWYJSdKe8I8
	 RHneVgTzYu/JHjV+q8QGzXT9LJaX0a1CNTp3aMoc=
X-QQ-mid: zesmtpsz6t1787293306te0aedb42
X-QQ-Originating-IP: RHTXhY/KuAhUN3OhrNXVlzf1LI/cjGhzDmQ2+OFWxMc=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Aug 2026 14:21:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14185790749122321215
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH nvme-7.3 0/4] nvme-fabrics: localize string option parsing
Date: Fri, 21 Aug 2026 14:21:41 +0800
Message-ID: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NKgbhy6RFl+Ac4l8L8SI7FaVrSamHCHKQGf10s+tlFWXfOyB7VPEkN3S
	nM7gRun8crERNG3jwnS9krAClLs5jg5GfmZ5QU++oAv3YPpfJGnOOuMKFcBwYvrlKZ9bChe
	yY8KZeXiBWhLE/HCOs0RaPf+U0ftxnlq2G6WP6nCcj5hEePvsAwL8raoXfjmdO7JU5yPXv9
	m66UYtEH1G1sioAtfng254LIkRIkkD3zLxI5Zk+pZ+jSO1iNIVmU5rweUJNluvc3lHSMLX7
	tD50Ucp5Al9bnX8Xgx+v/jk8WgylUr8hSCKElWV6I4BIxzQd0njCTyEsO2ectITzPZ3WGoa
	NWORBr0DjEsggHsagP7/RzmfbQU/guwxrCCQDem1q3ZLmsPhj6rbfCgFSLeTFslMVZqE3Xn
	C9hhortcE6ofr4/GwBYgi7Fbi9E7w7f9j4Gatd07yj3UdUdOt9iji+PyOFJjlpF3p2r8RTV
	WA6FFJ3QZ6msPUZKwN9a8uXysU20AURJsPpNkyHlrx7o/eFSpWWmcmkeZsK2wp6rhpcAotk
	wCT8hrx6XspKNzM9cdw6bCaNW/p83KOi/ajlF2OOQijTmiq42CsQgPudcaEFDHS8T2FsJp0
	ZPgkyQwAyfp81vc+p/JDGxpzQV/7hVCL0YLzC8Fm/r1IQR2MGZsbhzywJJHLHK1YOWEm/XX
	GpqgQq54+ASJZx0z8tb9YYQF2tis8rKC7TjF9G0a5hw7V515FXGbiDqhXalvUvBlUIwXrZ5
	ci4AGcUKAaAZc4hTWikg8L72SP7zQzhFrDvQvQFlXM4FJQQG598YzLWiP3b4qAHQpvhEvIT
	Delm1kp5f8Te9JmMtFK7P9++IPUBlffgzey4cR4hLpvJSdDMmAFxom0g4VOaJR4j9x9YQOF
	w5ZvsmPutxJAbOTp8ywQ3jHpnruj2Hurd9+cnaE5vnmxMjP+EVMWKRbIq/RZqtenjlf2wtx
	Kor15usb9mkik0r9jPqX5iD6K+UnDVCf0k2ERAVopvjJcyemGmJKmN/oc6L7gEtwIHuEwpj
	lwL8BoLmZ2lEdMTfTF3AJehJfSjcpOL0qbnh7i5UohkBqoXnGu6Bt3pNA12Yg=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_232255_325852_84DBEB69 
X-CRM114-Status: GOOD (  12.01  )
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

From: Xu Rao <raoxu@uniontech.com>

nvmf_parse_options() currently combines option tokenization with string
allocation, validation, conversion, ownership transfer and error cleanup in
one large switch.  The DH-CHAP parse-failure leak showed how easy it is for
a match_strdup() allocation to escape cleanup when those lifetime rules are
spread across the main parser.

This series follows Christoph's suggestion to keep strdup allocations in
the scope that parses the corresponding option and to stop reusing the
pointer used for the option token.  It deliberately does not introduce a
generic parser framework and leaves integer, key and flag options alone.
The goal is only to make the existing string lifetimes local and easy to
audit without changing option semantics.

The series is split by parsing and lifetime semantics:

  1/4 separates tokenization from allocated string storage.  option is the
      current entry returned by strsep() and passed to match_token(); the
      existing p is left only as the temporary match_strdup() pointer and
      disappears as the following helpers are introduced.  Keeping this
      patch mechanical avoids renaming the same temporary variable only to
      delete it again later in the series.

  2/4 adds nvmf_parse_string_option() for the five direct owned-string
      replacements: transport, traddr, trsvcid, host_traddr and host_iface.
      Their complete lifetime is duplicate -> replace old value -> transfer
      ownership, so sharing one helper removes identical code without
      mixing in validation policy.

  3/4 handles non-sensitive identity strings that need additional parsing.
      nvmf_parse_subsysnqn() owns subsystem-NQN replacement, length checking
      and discovery-NQN state; nvmf_parse_hostnqn() validates a temporary
      host NQN and copies it to the host buffer; nvmf_parse_hostid()
      converts the temporary string to uuid_t and frees it on every exit
      path.

  4/4 adds nvmf_parse_dhchap_secret() for dhchap_secret and
      dhchap_ctrl_secret.  These values share DHHC-1 validation and
      sensitive cleanup on rejection, so their resource rules stay out of
      the generic string helper.

The resulting five helpers are intentionally small and self-describing:

  nvmf_parse_string_option()
  nvmf_parse_subsysnqn()
  nvmf_parse_hostnqn()
  nvmf_parse_hostid()
  nvmf_parse_dhchap_secret()

The first helper represents one common ownership operation; the remaining
helpers are named after the exact protocol/identity value they parse.  A
future string option can reuse nvmf_parse_string_option() only if it has the
same direct replacement semantics.  A value with new validation or
conversion rules should get a dedicated helper rather than adding flags to
a generic parser.

This keeps the helpers grouped by ownership and validation semantics rather
than adding one helper per token, avoiding duplication for identical direct
string replacement while still keeping validation and sensitive cleanup local
to the options that need them.

This series is intended to be applied after the recently accepted
"nvme-fabrics: fix DHCHAP secret leak on parse failure" change.

No functional changes are intended.

Xu Rao (4):
  nvme-fabrics: separate option tokenizer pointer
  nvme-fabrics: add helper for owned string options
  nvme-fabrics: add helpers for subsystem and host identity options
  nvme-fabrics: add helper for DH-CHAP secret options

 drivers/nvme/host/fabrics.c | 229 +++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 108 deletions(-)

-- 
2.50.1

