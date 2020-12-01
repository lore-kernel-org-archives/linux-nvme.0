Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94888C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:56:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3F420857
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HugYUZDt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="RWoTNTSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3F420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ReC7nYZa57wjrXOvaZCgzrhldjhbQkM4sJmreNSxtZo=; b=HugYUZDtCLLvLMb+ud4z2ug/xc
	/JIiQNdJpjGqnrHMKWDLPqt83pbYl1i0NbQJWAOgg//O69V/E0eumzzUVPHwhaemluu4kj73Q9fRD
	zIxlkczeRmITo3FhT4hALB3a7MajzhCtwneUKelH2FxFcoTYEnOMjIjb3Acc3L3NQWqzQK3JVq1qZ
	rFsngpTMaH1uWkvSCNXId0wvlhKyIsC345IWniXG0H/g/VrqhuucFXYVvjduBprm+Irb0jqqc1hjc
	8tMkDJHSZFv1JfJDR0pJG6/MYs10lMn1XcrlNQGNcfN+L/wIrRqxj9HZRq21ribwWrIlMNvvvR3R/
	sDGHAwcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk5Cc-0005Qs-7w; Tue, 01 Dec 2020 12:56:18 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk5CZ-0005Q9-Ti
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 12:56:16 +0000
Received: by mail-ej1-x642.google.com with SMTP id lt17so3904209ejb.3
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 04:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xHTwekTMHBxnzJvZgFr7Rrub1GZfhNFwsQwlD3O2K1U=;
 b=RWoTNTSW1M042+k5M7VQxKEO4QG+Tv5qRlOcyxZfamL01nFTX4xiLQMWhJ0PVjgbdq
 2J6AROcEYP4pl1Ebfk69Fwch3z8Y94mwwUB82UaYTtols0RJ6oYCQxuqB0hHOSKiCSnS
 +Rk6LIGSSCxSPh0L+o8biy2Na55HtHAsj0h0ONRVlPOYWbxY91cU85UWWxq+KWz2ioFf
 U9NxNHDnHvZzkh12DHwhYUj0w/mBrJb7Cb1+11PAggL+KhpVQpgB/gE8gWmY9JmGPLLX
 d/PB+7UGRfCkFdqQ6ivgiOwUgcBRWrZFdAy0uQBeDbEx/3nIecx20Jn9WKylQCi5ghvj
 1m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xHTwekTMHBxnzJvZgFr7Rrub1GZfhNFwsQwlD3O2K1U=;
 b=map8FC6NfvHxS6JK0CYGrJ8GyNW1qNn283RbAiAR6wmyHz+CYF/gTdC1VpXlbxXS7k
 qA2kpbE5AEc7Mx7C998k2sC28RpM9wpvicUkMKYdRimMSjwD0sahYklJf6RkvjJp3W8c
 vyFrajlwgL92DYjpDuYDXZjcqcevCKVw/9lX8WEzzi/pfaH2xWF0t1oPXtGni9cZXKS7
 1JsY8dsR5m7tpX9suSSlt/BKN8cwpHt0Uo/sHAUdMwfer4gaVsPwg0HOFqUfcG96sxIi
 SV03lttVXhCUE6LhWzLRn4NUTRduKQjLm/jhfouU4H68KCehB/kuAaXW8lCp3oNZPgV9
 LGgQ==
X-Gm-Message-State: AOAM530aKCtReRb1AKYcjBCJzAMOzIsd44Yk2uu+P311sXQpznbmzobH
 bdat8OJ8Nfi5EI3L4XnN0ygQy1/HVmLke+CeU4M=
X-Google-Smtp-Source: ABdhPJyNIkNoBljyczIcLAxluT/ncJslz82vRxuNdgyl0p0COQRoENkoyaekMBGw5TpbyXVtmyxQnQ==
X-Received: by 2002:a17:906:c1c6:: with SMTP id
 bw6mr2783569ejb.199.1606827373837; 
 Tue, 01 Dec 2020 04:56:13 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 04:56:13 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/4] nvme: enable per-namespace char device
Date: Tue,  1 Dec 2020 13:56:06 +0100
Message-Id: <20201201125610.17138-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_075615_995224_A893D829 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpUaGlzIHNl
cmllcyBlbmFibGVzIGEgcGVyLW5hbWVzcGFjZSBjaGFyIGRldmljZSB0aGF0IGlzIGFsd2F5cyBw
cmVzZW50ZWQKdG8gdGhlIGhvc3QsIGluZGVwZW5kZW50bHkgb2YgdGhlIGJsb2NrIGRldmljZSBh
c3NvY2lhdGVkIHdpdGggdGhlCm5hbWVzcGFjZS4gVGhpcyBhbGxvd3MgdXNlci1zcGFjZSB0byB1
c2UgdGhlIGNoYXIgZGV2aWNlJ3MgSU9DVEwKaW50ZXJmYWNlIHdoZW4gdGhlIGtlcm5lbCByZWpl
Y3RzIHRoZSBibG9jayBkZXZpY2UgZHVlIHRvIHVuc3VwcG9ydGVkCmZlYXR1cmVzLiBFeGFtcGxl
cyBvZiB0aGVzZSBmZWF0dXJlcyBpbmNsdWRlIHVuc3VwcG9ydGVkIFBJCmNvbmZpZ3VyYXRpb25z
LCBaTlMgZmVhdHVyZXMgc3VjaCBhcyB6b2MsIG9yIHVuc3VwcG9ydGVkIGNvbW1hbmQgc2V0cwpz
dWNoIGFzIEtWLgoKT25lIG9mIHRoZSB0aGluZ3MgdGhhdCBJIHdvdWxkIGFwcHJlY2lhdGUgbW9y
ZSBpbnB1dCBvbiBpcyB0aGUgbmFtaW5nCmNvbnZlbnRpb24uIFRoaXMgc2VyaWVzIGZvbGxvd3Mg
dGhlIGhpZGRlbiBkZXZpY2UgbmFtaW5nIG52bWVYY1luWiwgYnV0CkkgYW0gbm90IHN1cmUgaG93
IHRoaXMgd2lsbCB3b3JrIG91dCB3aXRoIG11bHRpcGF0aC4gVGhlIGNvbmNlcm4gaXMgaWYKd2Ug
d2lsbCBoYXZlIHVuZml4YWJsZSBuYW1pbmcgY29sbGlzaW9ucyB0aGF0IHdpbGwgamVwYXJkaXpl
IHVzZXItc3BhY2UKdG9vbHMgZGVwZW5kaW5nIG9uIHRoaXMgbmFtaW5nLgoKVGhhbmtzIHRvIENo
cmlzdG9waCBmb3IgcHJvcG9zaW5nIHRoaXMgaW4gdGhlIGZpcnN0IHBsYWNlIGFuZCBDaHJpc3Rv
cGgKYW5kIEtlaXRoIGZvciBlYXJseSByZXZpZXdzIG9mIHRoaXMgcGF0Y2hzZXQhCgpKYXZpZXIK
CkphdmllciBHb256w6FsZXogKDQpOgogIG52bWU6IHJlbW92ZSB1bm5lY2Vzc2FyeSByZXR1cm4g
dmFsdWVzCiAgbnZtZTogcmVuYW1lIGNvbnRyb2xsZXIgYmFzZSBkZXZfdCBjaGFyIGRldmljZQog
IG52bWU6IHJlbmFtZSBiZGV2IG9wZXJhdGlvbnMKICBudm1lOiBlbmFibGUgY2hhciBkZXZpY2Ug
cGVyIG5hbWVzcGFjZQoKIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDE3MiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0KIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8
ICAgMyArCiAyIGZpbGVzIGNoYW5nZWQsIDE0NiBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMo
LSkKCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
