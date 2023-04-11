Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDA6C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 01:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+djj8E2EfQ1BdgmqIQjeoDHOm1x7gpXZl9vOkKv3HaA=; b=qBN57Fk5xROlxHCTU5hmR+LrUu
	bk65IyEI9zH0kCj5TADjRYouBv5heLdwg8JwHAcI+0o1eOKoRAn/ko3r1fAD7B1+XkJWBxmgDVUUi
	kZcHCaMy0oxMCj7YqEe4m3krYhkDuU+xFySJq0ujCUwuCfjtaU7SY/SQToq3WnZMde1qoQgOiT6PD
	/cR4mzOmhGe4oXVqvqYJ9yGUHNHrpC6rUCkqzzZJtKDAS82/XtZkr0BhSEjrogHJsStRmXeB054Cg
	Ireu21DItkeSPglnjM9MZbrIfv9drtD7Dd4/7z8ok6mLQvYYpLS5XMglBci6cfmtuIAt/F5KSY3NH
	qkFagodw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm2nX-00GCms-25;
	Tue, 11 Apr 2023 01:27:51 +0000
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm2nV-00GCm8-2Y
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 01:27:51 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.west.internal (Postfix) with ESMTP id 0628C2B066FC;
	Mon, 10 Apr 2023 21:27:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 10 Apr 2023 21:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1681176461; x=1681177061; bh=+djj8E2EfQ1BdgmqIQjeoDHOm1x7gpXZl9v
	OkKv3HaA=; b=onwl2IiDr2QHgPAoZS8WPDPzj60b+GcxtmhqTHhVtIYFIqTD5/p
	CPIMcalX5SOO0ble3ugNPWE2jNE5tCR+z0G6ALTm6ZOs3ACv/3gxbtZqWGt8qBRk
	djdKZoLFr9BXWjTuXglvMt3nvQlx8Je5EVTM6irpQ23Lwy27v2FZex8FRk/Bu5uH
	KaEazKPc5TuQJ/tz2anEmOMYAs6HGDgv1jKCJ8LJOR2ino4oVkX/sbsQAVu1DLIu
	3A0EeXHmcldAq9PNQMpw6zTmqhArnHsZyHx1g+Z3pdw8T/vCYeNGs2KOP2FwG2DG
	Yg7x1gN+CEUCk6wIqeq9l3aCAhjpUxVuivg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=ie1e949a3.fm2;
	 t=1681176461; x=1681177061; bh=+djj8E2EfQ1BdgmqIQjeoDHOm1x7gpXZ
	l9vOkKv3HaA=; b=Oqazz89E9PuvNgsMWX6ORBRvEAUwIXSvr8qyEEKF9f1scb9T
	9x49jXw7JeRO0lv+RqL9bTEOoczQjglklSiTNJjum29ZCUWdZSTlLzSAOUmqawNl
	4G/XMxpr6ru0Uc6r6FBvPWEeg+EVYb+esvecYbMhVuhz2ls4RcxD+WtxXlLgJ9aB
	Umv1AX5kHjxt4gORNXrsnhAL0flzRHEQpERaiuEZ9utsC/Tn88P3zJ7KjRax90pG
	6vQVKwHwrGM+5B/Gba0FQ8Y8lQjmYHP9olMIGbByL1uqdGI1D+o2Re7M8M64TZYa
	a+BF/rRhxyA3CUnFCHQAXlS/nPu9NepYkzFeZA==
X-ME-Sender: <xms:jbc0ZNHFZncHYXzatA4qkgI3vFvrGpvU_IZ4rQJKaQtlS1-qAxTtDw>
    <xme:jbc0ZCUcHg_4zqM-MrpYp2FAhgKdkanlt7CC8HZt0CDbQoEiK8L5hbjWLmaUL3jEb
    humMhpgeXUcMrDqihM>
X-ME-Received: <xmr:jbc0ZPKRl3xKds0ye68C8Ul0juUHGVhfK7fY1Sly7Kzhg7b9ACWvnRw9755fgeWvtMZRyRnD-dZ2KcJGjohbJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekfedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    eksfdttddtudenucfhrhhomhepufhhihhnkdhitghhihhrohcumfgrfigrshgrkhhiuceo
    shhhihhnihgthhhirhhosehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    ephfekkeeuueekfeeiueegtdehheegfeektdegtdfgudffvdeuvdeljeekteetgeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhihhnih
    gthhhirhhosehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:jbc0ZDH8o-Wsj8pd0aVJB7F9zuuxLu1e8Q8dJ9e-23SOQYqnqnwmIQ>
    <xmx:jbc0ZDUr1lImSNt4TZYw_SRMJwD1pfeG3Bi6AJjPncE2gMY4Mz4XPQ>
    <xmx:jbc0ZOOfxPvaGsZiQuXNUdyJ2DKz0DdnlgQAGDcVSInAmjB1J4ZKdg>
    <xmx:jbc0ZKf8MXHjmFeHb5MHCYMiKEclbfpqeHGpwqmjX3n1GkriwHSi3aR61zSjVI00>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 21:27:40 -0400 (EDT)
Date: Tue, 11 Apr 2023 10:27:36 +0900
From: Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To: alan.adamson@oracle.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: blktests nvme/039 failure
Message-ID: <acu2ak5fwyjnsino5i4ilaeh3xawlkygbxwjjm5tu3ntzxmgbh@zawuclpnlwiu>
References: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
 <76983b72-b954-5865-1b34-c88161a7dec9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76983b72-b954-5865-1b34-c88161a7dec9@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_182749_865334_5496E00E 
X-CRM114-Status: UNSURE (   9.05  )
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

On Apr 10, 2023 / 16:06, alan.adamson@oracle.com wrote:
[...]
> I've been able to reproduce it.  The sleep .1 helps but doesn't eliminate
> the issue.  I did notice whenever there was a failure, there was also a
> "blk_print_req_error: 2 callbacks suppressed" in the log which would break
> the parsing the test needs to do.

Ah, I see. The error messages were no printed because pr_err_ratelimited()
suppressed them. AFAIK, there is no way to disable or relax the rate limit from
userland. I think sleep for 5 = DEFAULT_RATE_LIMIT seconds at the beginning of
the test will ensure the error message printed. It will also avoid the "x
callbacks suppressed" messages.

With the change below, I observe no failure on my system.

diff --git a/tests/nvme/039 b/tests/nvme/039
index 11d6d24..5d76297 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -139,6 +139,9 @@ test_device() {
 
 	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
 
+	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed
+	sleep 5
+
 	inject_unrec_read_on_read "${ns_dev}"
 	inject_invalid_status_on_read "${ns_dev}"
 	inject_write_fault_on_write "${ns_dev}"


