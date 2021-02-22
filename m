Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82334C433E9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:01:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71D06186A
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71D06186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/r82byiD4ynxfp2sF/Cqqu59fJQviP/QX7PusKpXZP0=; b=0K7avNdWeJRBq0qF5O45MdmXK0
	3mx+kxYrG2XSoNvS1gblKXEy+yxi1asGoFWO4IFSiMLjsXz8abhzSU3co7lx52uj0GVogprPkdvnY
	fyR+z0QJmpLnllwbDSDe6/feM5zt205X1io2HHM8RYUpzF+VWVM+rdSO8EkDTJbhgj702rgDe9f7+
	aNzpEoTzsmg+L+eb1JLMn5XCIrrQRFJQ9X6fn6pHQPbosyySLwAC5TjHjQ4HhXC7hUHVGCkgi1ewr
	QA3CYdolBGFL5mowDi8GBCVkWwjleNyvz3o0fvIRqjwp1+G1UeBbJriUBl5FSTZtBps3FfaWJhuMr
	Ly0QSuCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEGSM-00062v-Pz; Mon, 22 Feb 2021 19:01:18 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEGSH-00061c-Qz
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 19:01:16 +0000
Received: by mail-ej1-x62d.google.com with SMTP id u20so30362129ejb.7
 for <linux-nvme@lists.infradead.org>; Mon, 22 Feb 2021 11:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cO0n+kDhRqglr/P/GbTAppuURUzykOPvLpaYKMcFMqQ=;
 b=wk3heYfrGUh3a5PY/WRnJ0DxEgvvMc3H8hKd9TgphqPTsJ6VcWStQsJ+PADWxWPGDC
 RIv6tRYLHa2MeZomyhNRfuHvkcNpeDftzJx3LVQ1bBpTeKFL6Y7mzkJNMP2IMvFTJhVp
 sRVdcf6iafFetLwICd3BMM9DGI6qOwhLgFZjJbBTi300//4znvzk6dGRirITQvsG7wRv
 NX328lshVh6hNq8b7um4DxuXPjVuzlRn8DIEKbd0futCjYEPbd7/J+ZvugqYSuMEmkTl
 lj3BynOSVR8kvlSwacIdPxaLvR26JJjsB5yj206wcp+Q9e6eK/B2peJ1vjtaqEcH4HFH
 JQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cO0n+kDhRqglr/P/GbTAppuURUzykOPvLpaYKMcFMqQ=;
 b=Bjj2cRmCeR9TL2W5wa8z+ezPgd2CxnouOdnSDWw4Y56m8+mNvticlA8BFdEJ9/HliS
 ckNGeDGyleHXB1r4KASP6IguEWc982fjr3t1hluPg9+z50Yu/9Cqql08IafJhBBnEDB9
 oNq3HjGGYwhvx/r5dzZx6lLmeI9wJeC29fY9CD49tqbR6BHVv1r9wH/FgCBzSi+6Hh5L
 lvh8lwj+j0mtKtgRkcTgJPUfoj9dSHYU0wVTsq4mW+3TB+aJlMJZ4Eah0ht7cB2vcIh/
 +dam9IkAJ9E0fx9YIoeOU+zWwpXnQJ4yNvZPanDZjRNDcwrjKVXel8S1RBfzN8YkYQ7V
 6QDA==
X-Gm-Message-State: AOAM533nowVbQYunlB/xo/J9twuhK5umjnOrA+acNlNQl/4rb+FsIXHp
 4TJ+1OubMgJKxJrF+krR+IHMAFLLy3hTZ1wa+ns=
X-Google-Smtp-Source: ABdhPJyN1wRP4Y/RqGqZEEEabE+0WmBvUNR3R808wxGUQPJSR/YsPm0jPxCc4WgO59u4tzItIKLgpA==
X-Received: by 2002:a17:906:2bc2:: with SMTP id
 n2mr21304233ejg.381.1614020470723; 
 Mon, 22 Feb 2021 11:01:10 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id d23sm9204528ejw.109.2021.02.22.11.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 11:01:10 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 0/2] nvme: enable char device per namespace
Date: Mon, 22 Feb 2021 20:01:05 +0100
Message-Id: <20210222190107.8479-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_140114_022058_13279348 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: sagi@grimberg.me, linux-block@vger.kernel.org, minwoo.im.dev@gmail.com,
 kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpUaGVzZSB0
d28gcGF0Y2hlcyBlbmFibGUgYSBjaGFyIGRldmljZSBwZXIgbmFtZXNwYWNlLCBhbHNvIHRocm91
Z2gKbXVsdGlwYXRoLiBJdCBpcyBwb3NzaWJsZSB0byB0ZXN0IHRoaXMgaW4gUUVNVSB1c2luZyBL
ZWl0aCdzIGFuZCBLbGF1cycKdHJlZSBpbiBudm1lLW5leHQKCiAgICAgaHR0cDovL2dpdC5pbmZy
YWRlYWQub3JnL3FlbXUtbnZtZS5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9udm1lLW5leHQKCktl
aXRoOiBSZWdhcmRpbmcgbnZtZS1jbGkgc3VwcG9ydCwgb25jZSB0aGlzIGlzIGluIHBsYWNlLCB3
ZSB3aWxsIHNlbmQgYQpwYXRjaCB0byBudm1lLWNsaSBzbyB0aGF0IHRoaXMgZGV2aWNlIGlzIHNo
b3duIGluIHZlcmJvc2UgbW9kZS4gRG8geW91CmhhdmUgYW51IHRob3VnaHRzIGFib3V0IHRoaXM/
CgpDaGFuZ2VzIHNpbmNlIFY0CiAgLSBBZGRlZCBzdXBwb3J0IGZvciBtdWx0aXBhdGggKGZyb20g
TWlud29vKQogIC0gRml4ZWQgdHlwbyBpbiBjb21taXQgbWVzc2FnZSBmb3Igc3lzZnMgbmFtaW5n
CiAgLSBSZWJhc2UgaW50byBudm1lLTUuMTIKCkNoYW5nZXMgc2luY2UgVjMKICAtIFVzZSBhIGRl
ZGljYXRlZCBpZGEgZm9yIHRoZSBnZW5lcmljIGhhbmRsZQogIC0gRG8gbm90IGFib3J0IG5hbWVz
cGFjZSBncmVhdGlvbiBpZiB0aGUgZ2VuZXJpYyBoYW5kbGUgZmFpbHMKCkNoYW5nZXMgc2luY2Ug
VjI6CiAgLSBBcHBseSBhIG51bWJlciBvZiBuYW1pbmcgYW5kIGNvZGUgc3RydWN0dXJlIGltcHJv
dmVtZW50cyAoZnJvbQogICAgQ2hyaXN0b3BoKQogIC0gVXNlIGlfY2RldiB0byBwdWxsIHN0cnVj
dCBudm1lX25zIGluIHRoZSBpb2N0bCBwYXRoIGluc3RlYWQgb2YKICAgIHBvcHVsYXRpbmcgZmls
ZS0+cHJpdmF0ZV9kYXRhIChmcm9tIENocmlzdG9waCkKICAtIENoYW5nZSBjaGFyIGRldmljZSBh
bmQgc3lzZnMgZW50cmllcyB0byAvZGV2L252bWUtZ2VuZXJpYy1YY1luWiB0bwogICAgZm9sbG93
IHRoZSBoaWRkZW4gZGV2aWNlIG5hbWluZyBzY2hlbWUgKGZyb20gQ2hyaXN0b3BoIGFuZCBLZWl0
aCkKCkNoYW5nZXMgc2luY2UgVjE6CiAgLSBSZW1vdmUgcGF0Y2hlcyAxLTMgd2hpY2ggYXJlIGFs
cmVhZHkgcGlja2VkIHVwIGJ5IENocmlzdG9waAogIC0gQ2hhbmdlIHRoZSBjaGFyIGRldmljZSBh
bmQgc3lzZnMgZW50cmllcyB0byBudm1lWG5ZYyAvIGMgc2lnbmFscwogICAgY2hhciBkZXZpY2UK
ICAtIEFkZHJlc3MgTWlud29vJ3MgY29tbWVudHMgb24gaW5saW5lIGZ1bmN0aW9ucyBhbmQgc3R5
bGUKCgpKYXZpZXIgR29uesOhbGV6ICgxKToKICBudm1lOiBlbmFibGUgY2hhciBkZXZpY2UgcGVy
IG5hbWVzcGFjZQoKTWlud29vIEltICgxKToKICBudm1lOiBhbGxvdyBvcGVuIGZvciBudm1lLWdl
bmVyaWMgY2hhciBkZXZpY2UKCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAxNzMgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCiBkcml2ZXJzL252bWUvaG9zdC9udm1l
LmggfCAgIDkgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTY1IGluc2VydGlvbnMoKyksIDE3IGRlbGV0
aW9ucygtKQoKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
