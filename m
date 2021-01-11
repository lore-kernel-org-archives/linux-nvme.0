Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A8C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:31:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9BD22795
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9BD22795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=c2GyxUaFBSas2SkfnYEulOkvsbzYqfvmuqOfKusXyw0=; b=Gfl9DIsAThLdmSniWEGUlS2wU
	6HnH9/4t01n5GmolEwbYRPzhrrF+is82GcO/2c96+qVxxvVk0s+KCy9tcPbi9n26NykEn250tcrvd
	dzYaq7Ym0Qe+h9YFAPgnZMZMQ+PoNbngwHIkGF1pvO+6uhDVWbVhYkqwhvfWTudf6CYbQxnngvi6p
	1BOuZFUUjaUtUdXGOunsuXn4BZTzBb7+QUoPwmxCipkSSjvzDrStgNtqD4T9dPJa8VdrMCiMfVx/a
	YWV1POLNx0nQw0WwVhPchZ9UPUf2LsFMtxqXu7SU57eSxIrkld/oPuj1H9J17Sf91DemGnCRdUQYB
	NHqfqNkWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyrfy-0005YU-Px; Mon, 11 Jan 2021 07:31:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyrfw-0005XJ-M9
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 07:31:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3416BAF7F;
 Mon, 11 Jan 2021 07:31:39 +0000 (UTC)
Subject: Re: [PATCH v7 03/16] nvme: Added a newsysfs attribute appid_store
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
 <1609970430-19084-4-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <de704af8-8419-76c6-c1f5-419406b2f807@suse.de>
Date: Mon, 11 Jan 2021 08:31:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1609970430-19084-4-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_023140_835810_ECE9C107 
X-CRM114-Status: GOOD (  20.55  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, emilne@redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS82LzIxIDExOjAwIFBNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gQWRkZWQgYSBuZXcgc3lzZnMg
YXR0cmlidXRlIGFwcGlkX3N0b3JlIHVuZGVyCj4gL3N5cy9jbGFzcy9mYy9mY191ZGV2X2Rldmlj
ZS8qCj4gCj4gV2l0aCB0aGlzIG5ldyBpbnRlcmZhY2UgdGhlIHVzZXIgY2FuIHNldCB0aGUgYXBw
bGljYXRpb24gaWRlbnRmaWVyCj4gaW4gIHRoZSBibGtjZyBhc3NvY2l0ZWQgd2l0aCBjZ3JvdXAg
aWQuCj4gCj4gT25jZSB0aGUgYXBwbGljYXRpb24gaWRlbnRpZmVyIGhhcyBzZXQgd2l0aCB0aGlz
IGludGVyZmFjZSBpdCBhbGxvd3MKPiBpZGVudGlmaWNhdGlvbiBvZiB0cmFmZmljIHNvdXJjZXMg
YXQgYW4gaW5kaXZpZHVhbCBjZ3JvdXAgYmFzZWQKPiBBcHBsaWNhdGlvbnMgKGV4OnZpcnR1YWwg
bWFjaGluZSAoVk0pKWxldmVsIGluIGJvdGggaG9zdCBhbmQKPiBmYWJyaWMgaW5mcmFzdHJ1Y3R1
cmUoRkMpLgo+IAo+IEJlbG93IGlzIHRoZSBpbnRlcmZhY2UgcHJvdmlkZWQgdG8gc2V0IHRoZSBh
cHBfaWQKPiAKPiBlY2hvICI8Y2dyb3VwaWQ+OjxhcHBpZD4iID4+IC9zeXMvY2xhc3MvZmMvZmNf
dWRldl9kZXZpY2UvYXBwaWRfc3RvcmUKPiBlY2hvICI0NTdFOjEwMDAwMDEwOWI1MjFkMjciID4+
IC9zeXMvY2xhc3MvZmMvZmNfdWRldl9kZXZpY2UvYXBwaWRfc3RvcmUKPiAKPiBTaWduZWQtb2Zm
LWJ5OiBNdW5lZW5kcmEgPG11bmVlbmRyYS5rdW1hckBicm9hZGNvbS5jb20+Cj4gCj4gLS0tCj4g
djc6Cj4gTm8gY2hhbmdlCj4gCj4gdjY6Cj4gTm8gY2hhbmdlCj4gCj4gdjU6Cj4gUmVwbGFjZWQg
QVBQSURfTEVOIHdpdGggRkNfQVBQSURfTEVOCj4gCj4gdjQ6Cj4gTm8gY2hhbmdlCj4gCj4gdjM6
Cj4gUmVwbGFjZWQgYmxrY2dfc2V0X2FwcF9pZGVudGlmaWVyIGZ1bmN0aW9uIHdpdGggYmxrY2df
c2V0X2ZjX2FwcGlkCj4gCj4gdjI6Cj4gTmV3IFBhdGNoCj4gLS0tCj4gICBkcml2ZXJzL252bWUv
aG9zdC9mYy5jIHwgNzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
Cj4gICAxIGZpbGUgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IApS
ZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5u
ZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2Ug
QXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5
MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUs
IDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xo
cmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
