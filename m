Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36259C47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 08:02:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BB3613AC
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 08:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BB3613AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PRNx0X4ZztfQTTLwuQPMq9UXulnsil6yph9elJ/lkgU=; b=rOWq8eetCpbd7n
	jI/oHJDPzwp2RtbaPMdFFaHLMk6ZXTZ2Z6iTcqb46kqU2DKjZ1yPD8y+E4kDRAZWNv0YXqgNPOJ84
	GFyDiVqREE31o5YdkXIrjHnRDIumcYTJnJLdZ80E3P1ReED08Wp+8mCwiX62ph9S1nGyvltkpR3lv
	LUNOVpvY4MLikdv8r4jMWG7iYhThGrsRO6eunTd5KQ0W2sM2qRoNdtnU6w8DZcaloqkskWjVTlqqH
	MReoNt6w/GoBupIFpHOqBgLWqvH7sCfW77RrGR7OaOVxD40Y1zcsfLKEpKl2yJ4hxUf3xK+Bq4UkZ
	jG1p8KKFjV00WkDczeGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmAyC-003cV0-Mg; Thu, 27 May 2021 08:02:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmAx8-003bis-Ls
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 08:01:16 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71FAA218DD;
 Thu, 27 May 2021 08:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622102471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XiaoSC6yYiEgHrMWEHB8sKET+jJd2RbBFq8b0Rhw20A=;
 b=fZP/BjUp3zio0QQ5e/hsVy1rIPFCbD5tneyyzVMWd5dsLDyQOCQ7hFDJl3kdS2HS3KfuoL
 +4eenJEi/A4OkIcUOHO+sqbI5EDgcwZ3x8M2NLalSCgEMMfsNZoQXlzacVDgwMwcASVhKo
 2HFA11aeee8Lmnj/5i6pD1tfopqkbLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622102471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XiaoSC6yYiEgHrMWEHB8sKET+jJd2RbBFq8b0Rhw20A=;
 b=AVN0AoaaVsTMciS7K2HV1IX6rYmzxRy0vT8f61PLQ10IVXzAS9OtzUhkfX6LFG9l0/S9sj
 9Km1W6lx4RXTedAg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id 62FA511CD8;
 Thu, 27 May 2021 08:01:11 +0000 (UTC)
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: [LSF/MM/BPF TOPIC] block namespaces
Message-ID: <a189ec50-4c11-9ee9-0b9e-b492507adc1e@suse.de>
Date: Thu, 27 May 2021 10:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_010114_907195_A3ACD01B 
X-CRM114-Status: GOOD (  13.61  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgYWxsLAoKSSBndWVzcyBpdCdzIHRpbWUgdG8gdGljayBvZmYgeWV0IGFub3RoZXIgaXRlbSBv
biBteSBsb25nLXRlcm0gdG8tZG8gbGlzdDoKCkJsb2NrIG5hbWVzcGFjZXMKLS0tLS0tLS0tLS0t
LS0tLQoKSWRlYSBpcyBzaW1pbGFyIHRvIHdoYXQgbmV0d29yayBhbHJlYWR5IGRvZXM6IGFsbG93
aW5nIGVhY2ggdXNlcgpuYW1lc3BhY2UgdG8gaGF2ZSBhIGRpZmZlcmVudCAndmlldycgb24gdGhl
IGV4aXN0aW5nIGJsb2NrIGRldmljZXMuCkVHIGlmIHRoZSBhZG1pbiBjcmVhdGVzIGEgcmFtZGlz
ayBpbiBvbmUgbmFtZXNwYWNlIHRoaXMgZGV2aWNlIHNob3VsZApub3QgYmUgdmlzaWJsZSB0byBv
dGhlciBuYW1lc3BhY2VzLgpCdXQgZm9yIG1lIHRoZSBtb3N0IGltcG9ydGFudCB1c2UtY2FzZSB3
b3VsZCBiZSBxZW11OyBjdXJyZW50bHkgdGhlCmRldmljZXMgbmVlZCB0byBiZSBzZXQgdXAgaW4g
dGhlIGhvc3QsIGV2ZW4gdGhvdWdoIHRoZSBob3N0IGhhcyBubwpidXNpbmVzcyB0b3VjaGluZyBp
dCBhcyB0aGV5IHJlYWxseSBiZWxvbmcgdG8gdGhlIHFlbXUgaW5zdGFuY2UuIFRoaXMgaXMKY2F1
c2luZyBxdWl0ZSBzb21lIGlycml0YXRpb24gZWcgd2hlbiB0aGlzIGRldmljZSBoYXMgTFZNIG9y
IE1EIG1ldGFkYXRhCmFuZCB1ZGV2IGlzIHRyeWluZyB0byBhY3RpdmF0ZSBpdCBvbiB0aGUgaG9z
dC4KCk92ZXJhbGwgcGxhbiBpcyB0byByZXN0cmljdCB2aWV3cyBvZiAnL2RldicsICcvc3lzL2Rl
di9ibG9jaycgYW5kCicvc3lzL2Jsb2NrJyB0byBvbmx5IHByZXNlbnQgdGhlIGRldmljZXMgJ3Zp
c2libGUnIGZvciB0aGlzIG5hbWVzcGFjZS4KSW5pdGlhbGx5IHRoZSBkcml2ZXJzIHdvdWxkIGtl
ZXAgdGhlaXIgZ2xvYmFsIGVudW1lcmF0aW9uLCBidXQgcGxhbiBpcwp0byBtYWtlIHRoZSBkcml2
ZXJzIG5hbWVzcGFjZS1hd2FyZSwgdG9vLCBzdWNoIHRoYXQgZWFjaCBuYW1lc3BhY2UgY291bGQK
aGF2ZSBpdHMgb3duIGRyaXZlci1zcGVjaWZpYyBkZXZpY2UgZW51bWVyYXRpb24uCgpHb2FsIG9m
IHRoaXMgdG9waWMgaXMgdG8gZ2V0IGEgY29uc2Vuc3VzIG9uIHdoZXRoZXIgYmxvY2sgbmFtZXNw
YWNlcyBhcmUKYSBmZWF0dXJlIHdoaWNoIHdvdWxkIGZpbmQgaW50ZXJlc3QsIGFuZCBhbHNvIHRv
IGRpc2N1c3Mgc29tZSBkZXNpZ24KZGV0YWlscyBoZXJlOgotIE9ubHkgaW4gY2VydGFpbiBjYXNl
cyBjYW4gYSBuYW1lc3BhY2UgYmUgYXNzaWduZWQgKGVnIGJ5IGNhbGxpbmcKJ21vZHByb2JlJywg
c3RhcnRpbmcgaXNjc2lhZG0sIG9yIGNhbGxpbmcgbnZtZS1jbGkpOyBob3cgZG8gd2UgaGFuZGxl
CmRldmljZXMgZm9yIHdoaWNoIG5vIG5hbWVzcGFjZSBjYW4gYmUgaWRlbnRpZmllZD8KLSBTaGFs
bCB3ZSBhbGxvdyBmb3IgZGlmZmVyZW50IGRldmljZSBlbnVtZXJhdGlvbiBwZXIgbmFtZXNwYWNl
PwotIEludG8gd2hpY2ggbGV2ZWwgc2hvdWxkIHdlIGdvIHdpdGggaGlkaW5nIHN5c2ZzIHN0cnVj
dHVyZXM/CiAgSXMgYmxhbmtpbmcgb3V0IHRoZSBoaWdoZXItbGV2ZWwgaW50ZXJmYWNlcyBpbiAv
ZGV2IGFuZCAvc3lzL2Jsb2NrCiAgZW5vdWdoPwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFu
bmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2Uu
ZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBI
UkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
