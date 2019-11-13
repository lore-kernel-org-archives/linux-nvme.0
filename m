Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CECC43331
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 00:44:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28842196E
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 00:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LNHILSPl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BSifOkj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28842196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zoiXITC7t+IjOscOFmI+KseYipYuii4XS53UlWrheAU=; b=LNHILSPlLCgEdBsSI09Si8gdF
	WfBtiFoVsb5zMfLu7cv+uuDljV0vf593B4/63NkkuKWDGzG+vN9nevqLQtq2qZeouI4txdc07uz3m
	Xq8B+uK09HauuQJ7Tleb9e3WHsLd+JN/vmXZEAKYyzHdDn6956xOF2U0KJ5JfnLbsj77LPT4HppwN
	x400gyR3YUwAw5+X72RCjMUAdQ2snETVPWGLCyE7YKV0G3RwZthGI+fPsost7OPQeHZg4SOG0dsj2
	6PCJd2kZCkVFca8w4BIXypsOJ65ai5xyY8cWaP1EvMjPjhkAm2fM/OB+/iuMskyoZpkcjJYe+n6z0
	c/an5HCgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUglj-0002NE-F0; Wed, 13 Nov 2019 00:44:23 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUglg-0002Mk-0u
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 00:44:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so302719wrm.8
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 16:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=EOK9haHg7xqaB6Zobn1tky794ikBtrhWO4vSrTZ7ytk=;
 b=BSifOkj44PNRhAigUrObcIqGOqtAQLrkVL/11clUXtZm0SJvB2fSkQeHpKNoX/M9Ae
 yFifFSbKl4WosBbECb9yIq31zMW3RJE42XJuXqb95ngjPbqPwgQberxME9yJuooyXYKo
 TUAJsBHKmoFntM7wnx3pjJ1VKZe06y4GAlqQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=EOK9haHg7xqaB6Zobn1tky794ikBtrhWO4vSrTZ7ytk=;
 b=MVK8h61g/GmMKdZ1X+pAZKhYDILl8m92AV++Z/4DLItjmCAFDhb7olQQYQgLk1njtn
 nlPjE1oRQLtN9pfmP5AxHckjSfUHEb0tKbYtr1aKsR2MVw7KKymRpiXoUR/b2V5pfze+
 ixoUd83hSLUZG9mO2qbciGe9GS0jtGdfePX/jXEC8zJCTL4NFOcfWCa8vBJul7n6HhON
 bX2NXul10x6QJXAEzoGpHIF7+SktSMl7YzcdEDsW16RQnCA9ys8lJ6NNuu62Tm04gYWe
 PvVJtbZKaeug7WlluDkI/PemW/jJ15L7D9cn/bxDgU3lJkTwvBHFBTskvZm751zHbntd
 r95w==
X-Gm-Message-State: APjAAAVkoHizN19TPdz+etB870ZqDESJDapeoTGfv7Uu7Cn8+rAdWGq5
 6aRTBs/AImA1quShCZJ9NUFWmQq/W7BSoz0qeCL+G+hy3HXbxCjBw+M3O4qiwCCOexf9p7Efqhj
 Ujg4BoZPKMcVBcSC0nV6lup5b22fQSFdVnMf8qSrny/Zg7E3NHBEIEYWudikzN/3q1rhn3OS/Wx
 5tDzMBAw==
X-Google-Smtp-Source: APXvYqz/uTVOoWJXjvOMdklOCJo5JtBMrps4r72O8bg8ULj6PtR8GbBWMuqSnZL5nEHZsb0wx/rZ+w==
X-Received: by 2002:adf:a51c:: with SMTP id i28mr110483wrb.147.1573605857989; 
 Tue, 12 Nov 2019 16:44:17 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id o5sm695619wrx.15.2019.11.12.16.44.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 16:44:17 -0800 (PST)
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
To: Mark Ruijter <MRuijter@onestopsystems.com>,
 Sagi Grimberg <sagi@grimberg.me>
References: <2f3ea2c4-f59a-22e3-ed09-91cf737818ea@grimberg.me>
 <81646D07-6C44-427C-B959-F87F7F1B57AC@onestopsystems.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <ccb5809a-e34e-ae69-4659-4b420d1e8c8d@broadcom.com>
Date: Tue, 12 Nov 2019 16:44:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <81646D07-6C44-427C-B959-F87F7F1B57AC@onestopsystems.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_164420_068474_E2DC55A2 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxMS8xMi8yMDE5IDE6MTkgUE0sIE1hcmsgUnVpanRlciB3cm90ZToKPj4+IEkgdGhpbmsg
d2UgbmVlZCBhIGNudGxpZF9tYXguCj4gSSBpbml0aWFsbHkgdGhvdWdodCBhYm91dCB0aGF0IGFu
ZCBkZWNpZGVkIGl0IHdhcyBub3Qgd29ydGggaXQuIFdoZW4gYSB1c2VyIHNlbGVjdHMgdGhlIG1p
bmltdW0gaXQgaXMgaGlnaGx5IHVubGlrZWx5IHRoYXQgYSBjb2xsaXNpb24gd2lsbCBvY2N1ci4K
CndoeSB3b3VsZCB5b3UgbGVhdmUgdGhhdCB0byBjaGFuY2UgPwoKPgo+IFdpdGggYSBzeW1tZXRy
aWNhbCBjb25maWd1cmF0aW9uIGV2ZW4gYW4gb2Zmc2V0IG9mIDEgd291bGQgYmUgZW5vdWdoIHRv
IHByZXZlbnQgdGhhdD8KCmFoaC4uIGl0IHNlZW1zIHlvdSBhcmUgYW5zd2VyaW5nIHdpdGggeW91
ciBzcGVjaWZpYyBzb2x1dGlvbiBpbiBzaWdodC4gSSAKdGhpbmsgd2Ugd291bGQgd2FudCBpdCBi
ZSBtb3JlIGdlbmVyaWMgaW4gc2NvcGUuCgo+Cj4gSSBkb27igJl0IG1pbmQgYWRkaW5nIGl0IGlm
IHRoZSBjb25zZW5zdXMgaXMgdGhhdCBpdOKAmXMgd29ydGggdGhlIGVmZm9ydC4KPgo+IE1hcmsK
PgoKSSBzZWNvbmQgdGhlIGNudGxpZF9tYXggYWRkLgoKLS0gamFtZXMKCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
