Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D311DC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 18:28:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51DC212CC
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 18:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BWsxPAxJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="W3TtD5kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51DC212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bvdl1bTBkALm/wSCOv6f2FDQYgCms0VcrOGSGkk+CV8=; b=BWsxPAxJRiXNE33EALock60/A
	Rl4ruLpYXr9eokODkvsLxHKs0Gpqwuswwj1lxZaWP3iIksTygdrvS7zI90ZEcfmP+AO1h3ssJiV+n
	iDovaufOJArIRrCmztfsreCW+b/R9UudX+IdFDwC1Xk46aXXnSj2XAXBRJUpBMIraQm1RuYWjEX99
	H5bbp1h16YEYSGApwhcnTFpT1gDZI5xN8qb8UAXwKuF59vwqj9VfKHccW4kF8m9+/sEgsEcYZrGiI
	dXSi1Ul5OWQ1ntrkh5SIYzvfV98qZPqjPd0yMGyKA0YCCiPjJbm7H/EGCLNLvLvQnRCNsfRfK/OEV
	Gp4XQSu/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlcnq-0001xk-4m; Wed, 17 Jun 2020 18:28:50 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlcnn-0001ww-4r
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 18:28:48 +0000
Received: by mail-ej1-x643.google.com with SMTP id o15so3522316ejm.12
 for <linux-nvme@lists.infradead.org>; Wed, 17 Jun 2020 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=j/V1hr10ITS8yidyCmaznz+Ljxp2V68wF9QK22/RMEk=;
 b=W3TtD5kzoXuIbeeO1mrGtVOk1wATd49f9OYQH03fq+G7uVQ6x8RPt+o1ArMX2np76y
 G7Ux6yoDJX98vFUo3OVj6gjBQR410flTKkT41lSdzjSEd38jyXy1kucc5R7dT361/8tg
 RXFFNB8rZ3U5xs+1x7S8PMESWyyMA4L7TgzWV+d8zmndJmUTADrQ+7Mu6BLo6DF1pzOC
 LjQoIdJchLb+xpMfzE2fogUHuvukW0qS3YQ2hbbsZZ57rIN3jTyuhf8SoIX/BnKBs+mG
 NYizivxfsevMZAZQ/BODqtqkvyLBCalu54l+g5jJsUHv2n3U+40rKb+PBMzpD2iBLC14
 II1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=j/V1hr10ITS8yidyCmaznz+Ljxp2V68wF9QK22/RMEk=;
 b=tJAiOXHEURCNo7xD4v8h17AUqodtteQ+ewXEMBREaQHFJ33MHs9VTzlwSGmhz6qIb5
 QLC1oDUXm0iOR8StradmGcitQEFjzziOZ064djfaNNF4HIfWn54B2jBOFuLohIEr26bs
 WEnWKA3lGYNvP7iocQ1Hhjycw57Ph5p0GvfrYQhBs5R5BDKM9p1HTUVGAB/uAWUKq21d
 mW2nq1LZ+/fH53JqgyjpokneDO+CAhMrMkAKyn7fQOjzrfJ9aUneyZQhSQ34jRz+Zdn4
 myoChqfueoGn227LiWcSD8Ss/Idvn/gIaJYAXZGUYxnf91oHhS0yzDYrZGKTG3F3OWva
 0/1w==
X-Gm-Message-State: AOAM532vW+nXgwNsJ1/KeN8X2t7FYukbzo19OcGoFUUhP4UzBNw27W2U
 dcwKrW7j8RelW4rB4zTsiJoyGA==
X-Google-Smtp-Source: ABdhPJxnxSFCdIJ/HsoQh4E9pWuoJ9049b1UC/dDe6gfWPEpcOoZ0wzAzGSnT5EgF068irB0iWnutA==
X-Received: by 2002:a17:906:1a06:: with SMTP id i6mr469085ejf.9.1592418522888; 
 Wed, 17 Jun 2020 11:28:42 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id p4sm273990edj.64.2020.06.17.11.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 11:28:41 -0700 (PDT)
Date: Wed, 17 Jun 2020 20:28:41 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_112847_213675_1C33C716 
X-CRM114-Status: GOOD (  19.26  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ajay Joshi <ajay.joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Aravind Ramesh <aravind.ramesh@wdc.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTcuMDYuMjAyMCAxOTo1NywgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDE3LzA2LzIw
MjAgMTYuNDIsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+T24gMTcuMDYuMjAyMCAwOTo0Mywg
Q2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+Pk9uIFR1ZSwgSnVuIDE2LCAyMDIwIGF0IDEyOjQx
OjQyUE0gKzAyMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+Pj5PbiAxNi4wNi4yMDIwIDA4
OjM0LCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+Pj5BZGQgc3VwcG9ydCBmb3IgTlZNIEV4cHJlc3Mg
Wm9uZWQgTmFtZXNwYWNlcyAoWk5TKSBDb21tYW5kIFNldCBkZWZpbmVkCj4+Pj4+aW4gTlZNIEV4
cHJlc3MgVFA0MDUzLiBab25lZCBuYW1lc3BhY2VzIGFyZSBkaXNjb3ZlcmVkIGJhc2VkIG9uIHRo
ZWlyCj4+Pj4+Q29tbWFuZCBTZXQgSWRlbnRpZmllciByZXBvcnRlZCBpbiB0aGUgbmFtZXNwYWNl
cyBOYW1lc3BhY2UKPj4+Pj5JZGVudGlmaWNhdGlvbiBEZXNjcmlwdG9yIGxpc3QuIEEgc3VjY2Vz
c2Z1bGx5IGRpc2NvdmVyZWQgWm9uZWQKPj4+Pj5OYW1lc3BhY2Ugd2lsbCBiZSByZWdpc3RlcmVk
IHdpdGggdGhlIGJsb2NrIGxheWVyIGFzIGEgaG9zdCBtYW5hZ2VkCj4+Pj4+em9uZWQgYmxvY2sg
ZGV2aWNlIHdpdGggWm9uZSBBcHBlbmQgY29tbWFuZCBzdXBwb3J0LiBBIG5hbWVzcGFjZSB0aGF0
Cj4+Pj4+ZG9lcyBub3Qgc3VwcG9ydCBhcHBlbmQgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgZHJp
dmVyLgo+Pj4+Cj4+Pj5XaHkgYXJlIHdlIGVuZm9yY2luZyB0aGUgYXBwZW5kIGNvbW1hbmQ/IEFw
cGVuZCBpcyBvcHRpb25hbCBvbiB0aGUKPj4+PmN1cnJlbnQgWk5TIHNwZWNpZmljYXRpb24sIHNv
IHdlIHNob3VsZCBub3QgbWFrZSB0aGlzIG1hbmRhdG9yeSBpbiB0aGUKPj4+PmltcGxlbWVudGF0
aW9uLiBTZWUgc3BlY2lmaWNzIGJlbG93Lgo+Pj4KPj4+QmVjYXVzZSBBcHBlbmQgaXMgdGhlIHdh
eSB0byBnbyBhbmQgd2UndmUgbW92ZWQgdGhlIExpbnV4IHpvbmVkIGJsb2NrCj4+PkkvTyBzdGFj
ayB0byByZXF1aXJlZCBpdCwgYXMgc2hvdWxkIGhhdmUgYmVlbiBvYnZpb3VzIHRvIGFueW9uZQo+
Pj5mb2xsb3dpbmcgbGludXgtYmxvY2sgaW4gdGhlIGxhc3QgZmV3IG1vbnRocy7CoCBJIGFsc28g
aGF2ZSB0byBzYXkgSSdtCj4+PnJlYWxseSB0aXJlZCBvZiB0aGUgc3R1cGlkIHBvbGl0aWNzIHRo
YSB5b3VyIGNvbXBhbnkgc3RhcnRlZCBpbiB0aGUKPj4+TlZNZSB3b3JraW5nIGdyb3VwLCBhbmQg
d2lsbCBzYXkgdGhhdCB0aGVzZSBkbyBub3QgbWF0dGVyIGZvciBMaW51eAo+Pj5kZXZlbG9wbWVu
dCBhdCBhbGwuwqAgSWYgeW91IHRoaW5rIGl0IGlzIHdvcnRod2hpbGUgdG8gc3VwcG9ydCBkZXZp
Y2VzCj4+PndpdGhvdXQgWm9uZSBBcHBlbmQgeW91IGNhbiBjb250cmlidXRlIHN1cHBvcnQgZm9y
IHRoZW0gb24gdG9wIG9mIHRoaXMKPj4+c2VyaWVzIGJ5IHBvcnRpbmcgdGhlIFNDU0kgWm9uZSBB
cHBlbmQgRW11bGF0aW9uIGNvZGUgdG8gTlZNZS4KPj4+Cj4+PkFuZCBJJ20gbm90IGV2ZW4gZ29p
bmcgdG8gcmVhZCB0aGUgcmVzdCBvZiB0aGlzIHRocmVhZCBhcyBJJ20gb24gYQo+Pj52YWNhdGlv
biB0aGF0IEkgYmFkbHkgbmVlZGVkIGJlY2F1c2Ugb2YgdGhlIFNhbXN1bmcgVFdHIGJ1bGxzaGl0
Lgo+Pgo+Pk15IGludGVudGlvbiBpcyB0byBzdXBwb3J0IHNvbWUgU2Ftc3VuZyBaTlMgZGV2aWNl
cyB0aGF0IHdpbGwgbm90IGVuYWJsZQo+PmFwcGVuZC4gSSBkbyBub3QgdGhpbmsgdGhpcyBpcyBh
biB1bnJlYXNvbmFibGUgdGhpbmcgdG8gZG8uIEhvdyAvIHdoeQo+PmFwcGVuZCBlbmRlZCB1cCBi
ZWluZyBhbiBvcHRpb25hbCBmZWF0dXJlIGluIHRoZSBaTlMgVFAgaXMgb3J0aG9nb25hbCB0bwo+
PnRoaXMgY29udmVyc2F0aW9uLiBCdWxsc2hpdCBvciBub3QsIGl0IGVuZHMgdXAgb24gZGV2aWNl
cyB0aGF0IHdlIHdvdWxkCj4+bGlrZSB0byBzdXBwb3J0IG9uZSB3YXkgb3IgYW5vdGhlci4KPgo+
SSBkbyBub3QgYmVsaWV2ZSBhbnkgb2YgdXMgaGF2ZSBzYWlkIHRoYXQgaXQgaXMgdW5yZWFzb25h
YmxlIHRvIAo+c3VwcG9ydC4gV2UndmUgb25seSBhc2tlZCB0aGF0IHlvdSBtYWtlIHRoZSBwYXRj
aGVzIGZvciBpdC4KPgo+QWxsIG9mIHVzIGhhdmUgY29tbXVuaWNhdGVkIHdoeSBab25lIEFwcGVu
ZCBpcyBhIGdyZWF0IGFkZGl0aW9uIHRvIHRoZSAKPkxpbnV4IGtlcm5lbC4gQWxzbywgYXMgQ2hy
aXN0b3BoIHBvaW50cyBvdXQsIHRoaXMgaGFzIG5vdCBiZWVuIGEgCj5zZWNyZXQgZm9yIHRoZSBw
YXN0IGNvdXBsZSBvZiBtb250aHMsIGFuZCBhcyBNYXJ0aW4gcG9pbnRlZCBvdXQsIGhhdmUgCj5i
ZWVuIGEgd2FudGVkIGZlYXR1cmUgZm9yIHRoZSBwYXN0IGRlY2FkZSBpbiB0aGUgTGludXggY29t
bXVuaXR5LgoKPgo+SSBkbyB3YW50IHRvIHBvbGl0ZWx5IHBvaW50IG91dCwgdGhhdCB5b3UndmUg
Z290IGEgdmVyeSBjbGVhciBzaWduYWwgCj5mcm9tIHRoZSBrZXkgc3RvcmFnZSBtYWludGFpbmVy
cy4gRWFjaCBvZiB0aGVtIGlzIHBhcnQgb2YgdGhlIHBsYW5ldCdzIAo+YmVzdCBvZiB0aGUgYmVz
dCBhbmQgbW9zdCB3ZWxsLXJlc3BlY3RlZCBzb2Z0d2FyZSBkZXZlbG9wZXJzLCB0aGF0IAo+bGl0
ZXJhbGx5IGhhdmUgYnVpbHQgdGhlIHN0b3JhZ2Ugc3RhY2sgdGhhdCBtb3N0IG9mIHRoZSB3b3Js
ZCBkZXBlbmRzIAo+b24uIFRoZSBzdG9yYWdlIHN0YWNrIHRoYXQgcmVjZW50bHkgc2VudCBtYW5u
ZWQgcm9ja2V0cyBpbnRvIHNwYWNlLiAKPlRoZXkgZWFjaCB1bmFuaW1vdXNseSBzYWlkIHRoYXQg
dGhlIFpvbmUgQXBwZW5kIGNvbW1hbmQgaXMgdGhlIHJpZ2h0IAo+YXBwcm9hY2ggZm9yIHRoZSBM
aW51eCBrZXJuZWwgdG8gcmVkdWNlIHRoZSBvdmVyaGVhZCBvZiBJL08gdHJhY2tpbmcgCj5mb3Ig
em9uZWQgYmxvY2sgZGV2aWNlcy4gSXQgbWF5IGJlIHdvcnRoIGJyaW5naW5nIHRoaXMgaW5mb3Jt
YXRpb24gdG8gCj55b3VyIGVuZ2luZWVyaW5nIG9yZ2FuaXphdGlvbiwgYW5kIGFsc28gcG90ZW50
aWFsbHkgY29uc2lkZXIgWm9uZSAKPkFwcGVuZCBzdXBwb3J0IGZvciBkZXZpY2VzIHRoYXQgeW91
IGludGVuZCB0byB1c2VkIHdpdGggdGhlIExpbnV4IAo+a2VybmVsIHN0b3JhZ2Ugc3RhY2suCgpJ
IHVuZGVyc3RhbmQgYW5kIEkgaGF2ZSBuZXZlciBzYWlkIHRoZSBvcHBvc2l0ZS4gQXBwZW5kIGlz
IGEgZ3JlYXQKYWRkaXRpb24gdGhhdCB3ZSBhbHNvIGhhdmUgYmVlbiB3b3JraW5nIG9uIGZvciBz
ZXZlcmFsIG1vbnRocyAoc2VlCnBhdGNoZXMgYWRkaXRpb25zIGZyb20gdG9kYXkpLiBXZSBqdXN0
IGhhdmUgYSBjb3VwbGUgb2YgdXNlIGNhc2VzIHdoZXJlCmFwcGVuZCBpcyBub3QgcmVxdWlyZWQg
YW5kIEkgd291bGQgbGlrZSB0byBtYWtlIHN1cmUgdGhhdCB0aGV5IGFyZQpzdXBwb3J0ZWQuCgpB
dCB0aGUgZW5kIG9mIHRoZSBkYXksIHRoZSBvbmx5IHRoaW5nIEkgaGF2ZSBkaXNhZ3JlZWQgb24g
aXMgdGhhdCB0aGUKTlZNZSBkcml2ZXIgcmVqZWN0cyBaTlMgU1NEcyB0aGF0IGRvIG5vdCBzdXBw
b3J0IGFwcGVuZCwgYXMgb3Bwb3NlZCB0bwpkb2luZyB0aGlzIGluc3RlYWQgd2hlbiBhbiBpbi1r
ZXJuZWwgdXNlciB3YW50cyB0byB1dGlsaXplIHRoZSBkcml2ZQooZS5nLiwgZm9ybWF0dGluZyBh
IEZTIHdpdGggem9uZWQgc3VwcG9ydCkgVGhpcyB3b3VsZCBhbGxvdyBfdG9kYXlfCmlvY3RsKCkg
cGFzc3RocnUgdG8gd29yayBmb3Igbm9ybWFsIHdyaXRlcy4KCkkgc3RpbGwgYmVsaWV2ZSB0aGUg
YWJvdmUgd291bGQgYmUgYSBtb3JlIGluY2x1c2l2ZSBzb2x1dGlvbiB3aXRoIHRoZQpjdXJyZW50
IFpOUyBzcGVjaWZpY2F0aW9uLCBidXQgSSBjYW4gc2VlIHRoYXQgdGhlIGdlbmVyYWwgY29uc2Vu
c3VzIGlzCmRpZmZlcmVudC4KClNvIHdlIHdpbGwgZ28gYmFjaywgYXBwbHkgdGhlIGZlZWRiYWNr
IHRoYXQgd2UgZ290IGFuZCByZXR1cm4gd2l0aCBhbgphcHByb2FjaCB0aGF0IGJldHRlciBmaXRz
IHRoZSBlY29zeXN0ZW0uCgo+Cj5Bbm90aGVyIGFwcHJvYWNoLCBpcyB0byB1c2UgU1BESywgYW5k
IGJ5cGFzcyB0aGUgTGludXgga2VybmVsLiBUaGlzIAo+bWlnaHQgZXZlbiBiZSBhbiBhZHZhbnRh
Z2UsIHlvdXIgY3VzdG9tZXJzIGRvZXMgbm90IGhhdmUgdG8gd2FpdCBvbiAKPnRoZSBMaW51eCBk
aXN0cmlidXRpb24gYmVpbmcgcmVsZWFzZWQgd2l0aCBhIGxvbmcgdGVybSByZWxlYXNlLCBiZWZv
cmUgCj50aGV5IGNhbiBldmVuIGdldCBzdGFydGVkIGFuZCBkZXBsb3kgaW4gdm9sdW1lLiBJLmUu
LCB0aGV5IHdpbGwgCj5hY3R1YWxseSBnZXQgZmFzdGVyIHRvIG1hcmtldCwgYW5kIHlvdXIgY29t
cGFueSB3aWxsIGJlIGFibGUgdG8gc2VsbCAKPm1vcmUgZHJpdmVzLgoKSSB0aGluayBJIHdpbGwg
cmVmcmFpbiBmcm9tIGRpc2N1c3Npbmcgb3VyIGJ1c2luZXNzIHN0cmF0ZWd5IG9uIGFuIG9wZW4K
bWFpbGluZyBsaXN0LiBBcHByZWNpYXRlIHRoZSBmZWVkYmFjayB0aG91Z2guIFZlcnkgaW5zaWdo
dGZ1bC4KClRoYW5rcywKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
