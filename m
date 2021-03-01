Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E7C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:25:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A9E601FA
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A9E601FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uUZVN5K4QCPw3c1pbUW8hdf/gd+Vw5IoM3C71q+FBb0=; b=aktyYJ+Tbo24gSeht2ce6moTfi
	TclhTXwx6ySMxng2AvPNuokNyfN1Nk9ADE0Sgxej87AOrXSTTj+RtMQIC5WuUEUJANWQ6ZBZ2ZkM9
	MWL0rPiPyfET+2YxqCIACied4w7072K7o7VaI5q6mz8yvO4bClhrDD0YwAhB0+l8AvBgIZ244v4f6
	rjtIJQPDqr+lHYBJjfxA7dZb1Q6SXH7aepiJsy7zCW8+6fHnCf0S7yNne9mRV2wBw1RyvgXkEG1Zm
	ModRhufCLfNdDM+SJiSKcd2iB6hSGgFnKb25A92V/DPdnug0ZXUjZh0du++wFGh1+qUEN/IzsryAB
	eMqQAuEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGoAC-0004Qx-AB; Mon, 01 Mar 2021 19:25:04 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGoA8-0004PD-4h
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 19:25:01 +0000
Received: by mail-ej1-x630.google.com with SMTP id jt13so30433892ejb.0
 for <linux-nvme@lists.infradead.org>; Mon, 01 Mar 2021 11:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5l1F+wGO5Nb1bwNWSiP0iexmLFzCMcNx6yWjh9GDkl8=;
 b=1CoUBdIYvIuaC0DQg7GZmUY56DBIHEmIF+T/PlfBojIM4jnZIo2xmPoKJewZcF9QaE
 GAO2tvPHeZ1PkZDK8l6PTi5+YtaNDVKj0eNZqzNw5aSP6di8DP6YYOsMb0pdvKJs//V9
 lTAmzvu8DUkYZckNQivK8yS99XxFIRt0fICKuurfH1UNLI0VTWABsBdtpEf8FJ+GFi1F
 RdTbjUscmxCDeRe+h1NR8s4hLuLGNt1wBNONM3Km77CpFNC+Ge8oj9jwAy7wJCvmNA0S
 Pni72/MHv/recoWifuObzqjCtzYIXy4NI4aeHfzQFMa0DRSuO7BFMSMxqgix8QTgSHjS
 Mkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5l1F+wGO5Nb1bwNWSiP0iexmLFzCMcNx6yWjh9GDkl8=;
 b=Y1eFNhanrPmHVhFzB3hg3UGgYUe9KFOuPcx2NglWxpG8TVSnjPF9OkBg9gyCQPtdTB
 X33A+Swo00XoyMo3UxmW7TnY8tMsW7ix/zMGBwcnS9T/3qwBHzQIYqEk/1NGvlGPombR
 8d7Lyoa7AQGgd/IQPrD0qxs5cnm3RB6/ouBAxT3p+IdR7nSB8KfxxdCtKf1qs/IEVs70
 23+D6F2GbKLoHduZIycpFJEGp4rrcJp8pIA2MUlIwoQ/UX5zPT00GI1ViL3zeCwoPlXU
 0VlpxTe6J5R+2dTADIgohn7T0wb9XqgsVYuWKc5Eh+wrg5Hs/tW7V2WxJ+yvIzNxtPeE
 zYPg==
X-Gm-Message-State: AOAM532HOMKaIFmuvgJGn3Lbe3spA6RQNCwtBbi63p/iM/XzNDLMucp/
 SmZvoxyskfMBxsl1XbPR5OJka8dV/vNWhtGe5m0=
X-Google-Smtp-Source: ABdhPJwYFsDUaeZgzUEyiNQ3NKvuH1vsSYZBWEEH8kFW6WSW79+Va11Wf2oNdKBtftXLumXMStVEcw==
X-Received: by 2002:a17:906:22d4:: with SMTP id
 q20mr751162eja.54.1614626696497; 
 Mon, 01 Mar 2021 11:24:56 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id i4sm14107110eje.90.2021.03.01.11.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 11:24:56 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH V6 0/2] nvme: enable char device per namespace
Date: Mon,  1 Mar 2021 20:24:50 +0100
Message-Id: <20210301192452.16770-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_142500_344144_4DF278E0 
X-CRM114-Status: GOOD (  17.86  )
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
YWRlYWQub3JnL3FlbXUtbnZtZS5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9udm1lLW5leHQKCgpP
bmUgcXVlc3Rpb24gdGhhdCBjYW1lIHVwIHdoaWxlIHByZXBhcmluZyBWNiBpcyB3aGF0IHRvIGRv
IHdpdGggdGhlIGJkZXYKc3lzZnMgZW50cmllcyB3aGVuIHRoZSBibG9jayBkZXZpY2UgZmFpbHMu
IE9uIHRoZSBvbmUgaGFuZCwgdGhlc2UgdmFsdWVzCmFyZSB1c2VmdWwgZm9yIHRoZSBjaGFyIGRl
dmljZSwgYnV0IG9uIHRoZSBvdGhlciwgdGhleSBhcmUgaW4gcHJpbmNpcGxlCm9ubHkgdmFsaWQg
Zm9yIHRoZSBibG9jayBkZXZpY2UuIFdlIGhhdmUgMyBvcHRpb25zOiAoaSkgY2xlYXIgc3lzZnMg
d2hlbgpiZGV2IGZhaWxzIGFuZCByZXF1aXJlIHVzZXItc3BhY2UgdG8gcXVlcnkgdGhlIG52bWUg
ZGV2aWNlIGRpcmVjdGx5CnRocm91Z2ggc3lzZnMsIChpaSkgbWFpbnRhaW4gdGhlIGJkZXYgc3lz
ZnMgZW50cmllcywgYW5kIChpaWkpIG1ha2UgY2hhcgpkZXZpY2UgZGVkaWNhdGVkIHN5c2ZzIGVu
dHJpZXMsIHdoaWNoIG1pZ2h0IGJlIHJlZHVuZGFudCB3aGVuIGJvdGggdGhlCmNoYXIgZGV2aWNl
IGFuZCB0aGUgYmxvY2sgZGV2aWNlIGFyZSBicm91Z2h0IHVwLiBUaG91Z2h0cz8KCktlaXRoOiBS
ZWdhcmRpbmcgbnZtZS1jbGkgc3VwcG9ydCwgb25jZSB0aGlzIGlzIGluIHBsYWNlLCB3ZSB3aWxs
IHNlbmQgYQpwYXRjaCB0byBudm1lLWNsaSBzbyB0aGF0IHRoaXMgZGV2aWNlIGlzIHNob3duIGlu
IHZlcmJvc2UgbW9kZS4gRG8geW91CmhhdmUgYW51IHRob3VnaHRzIGFib3V0IHRoaXM/CgpDaGFu
Z2VzIHNpbmNlIFY1CiAgLSBBZGRyZXNzZWQgc3R5bGUgYW5kIG5hbWluZyBjb21tZW50cyBmcm9t
IENocmlzdG9waAogIC0gQ2hhbmdlIHRoZSBsb2dpYyBhcm91bmQgbnZtZV91cGRhdGVfbnNfaW5m
bygpIHRvIChpKSBtYWtlIHRoZQogICAgR0VOSERfRkxfSElEREVOIG1vcmUgZXhwbGljaXQgaW4g
dGhlIGluaXQgbG9naWMsIGFuZCAoaWkpIHRvIHN1cHBvcnQKICAgIGFuIGVycm9yIHBhdGggdGhh
dCBhbHNvIHN0b3BzIHRoZSBjaGFyIGRldmljZSBmcm9tIGJlaW5nIGNyZWF0ZWQuCiAgICBUaGlz
IGVycm9yIHBhdGggaXMgbm90IGV4ZXJjaXNlZCBjdXJyZW50bHkuCgpDaGFuZ2VzIHNpbmNlIFY0
CiAgLSBBZGRlZCBzdXBwb3J0IGZvciBtdWx0aXBhdGggKGZyb20gTWlud29vKQogIC0gRml4ZWQg
dHlwbyBpbiBjb21taXQgbWVzc2FnZSBmb3Igc3lzZnMgbmFtaW5nCiAgLSBSZWJhc2UgaW50byBu
dm1lLTUuMTIKCkNoYW5nZXMgc2luY2UgVjMKICAtIFVzZSBhIGRlZGljYXRlZCBpZGEgZm9yIHRo
ZSBnZW5lcmljIGhhbmRsZQogIC0gRG8gbm90IGFib3J0IG5hbWVzcGFjZSBncmVhdGlvbiBpZiB0
aGUgZ2VuZXJpYyBoYW5kbGUgZmFpbHMKCkNoYW5nZXMgc2luY2UgVjI6CiAgLSBBcHBseSBhIG51
bWJlciBvZiBuYW1pbmcgYW5kIGNvZGUgc3RydWN0dXJlIGltcHJvdmVtZW50cyAoZnJvbQogICAg
Q2hyaXN0b3BoKQogIC0gVXNlIGlfY2RldiB0byBwdWxsIHN0cnVjdCBudm1lX25zIGluIHRoZSBp
b2N0bCBwYXRoIGluc3RlYWQgb2YKICAgIHBvcHVsYXRpbmcgZmlsZS0+cHJpdmF0ZV9kYXRhIChm
cm9tIENocmlzdG9waCkKICAtIENoYW5nZSBjaGFyIGRldmljZSBhbmQgc3lzZnMgZW50cmllcyB0
byAvZGV2L252bWUtZ2VuZXJpYy1YY1luWiB0bwogICAgZm9sbG93IHRoZSBoaWRkZW4gZGV2aWNl
IG5hbWluZyBzY2hlbWUgKGZyb20gQ2hyaXN0b3BoIGFuZCBLZWl0aCkKCkNoYW5nZXMgc2luY2Ug
VjE6CiAgLSBSZW1vdmUgcGF0Y2hlcyAxLTMgd2hpY2ggYXJlIGFscmVhZHkgcGlja2VkIHVwIGJ5
IENocmlzdG9waAogIC0gQ2hhbmdlIHRoZSBjaGFyIGRldmljZSBhbmQgc3lzZnMgZW50cmllcyB0
byBudm1lWG5ZYyAvIGMgc2lnbmFscwogICAgY2hhciBkZXZpY2UKICAtIEFkZHJlc3MgTWlud29v
J3MgY29tbWVudHMgb24gaW5saW5lIGZ1bmN0aW9ucyBhbmQgc3R5bGUKCgpKYXZpZXIgR29uesOh
bGV6ICgxKToKICBudm1lOiBlbmFibGUgY2hhciBkZXZpY2UgcGVyIG5hbWVzcGFjZQoKTWlud29v
IEltICgxKToKICBudm1lOiBhbGxvdyBvcGVuIGZvciBudm1lLWdlbmVyaWMgY2hhciBkZXZpY2UK
CiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAxOTggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tCiBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAgIDUgKwogMiBmaWxl
cyBjaGFuZ2VkLCAxODIgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCgotLSAKMi4xNy4x
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
