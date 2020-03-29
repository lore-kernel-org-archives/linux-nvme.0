Return-Path: <SRS0=sr50=5O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C8C43331
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 14:41:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF3B2073B
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 14:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDQT8FQW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rsc-tech-ru.20150623.gappssmtp.com header.i=@rsc-tech-ru.20150623.gappssmtp.com header.b="kaL7U5nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF3B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rsc-tech.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iQtN9VEa1Px3T/xlgmGe40uKTDj1Kxbg7XUux9TmjfM=; b=mDQT8FQWxvu7UY
	cNVqK5XAkyyCj95mzJOUadP7USkRJ68EMWq23Z4t/Ulpc5l255P6cNCVKMdqm/86xWrHTZEE8MWJg
	/t1xBh1WOcIqZWXbWGkzhvXEmeOJlakf0gzwSWubaFTYlmIu03yyUrTC/7fLVptZc6FaDXfjYEE3G
	mLwP7Lc0WyFLk1mMhyM8QcXPEcK5zgInTdaXrFbdEwu6QGjPZb94FKPabmE714g1XlUkX/KIsHfNF
	x3BRrzW1v8DMv3+V63GIbdGsDK85Bpc43aVgpPWvxwDX/++GDQjuIRxk5I02tG46joclXuX8oofex
	V6+8rbv0XlveNkML6VgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIZ7i-0005hd-Tt; Sun, 29 Mar 2020 14:41:14 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIZ7f-0005Wj-Tv
 for linux-nvme@lists.infradead.org; Sun, 29 Mar 2020 14:41:14 +0000
Received: by mail-lj1-x234.google.com with SMTP id p10so14874948ljn.1
 for <linux-nvme@lists.infradead.org>; Sun, 29 Mar 2020 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rsc-tech-ru.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J8CSEA2PIrFPVAYwmx025ybZnYDwOg6gBsSlne2MzU4=;
 b=kaL7U5nxcRmhFpnttnatEeeKy6Ksw8JIMDlQBNBFJ+m/IQHH4KSt/fQ8mK3PcXrnjo
 luZ1gnCFnidfd9bjUhtZ8T7qt3QoeOxFN/PMw5O6YnayB7ztEqRhlMOECaxTowal9FZj
 e8z3kaB9lIGeqjoeeYnA64fkL7VeQFFkSHoqHthcL94zmr3tGEHAW5jwjWYnnMW5drch
 Ws0SfGhSs0YtkjSArdvtLtBjRRqWs/dH5dTqaUMCdQg9nwEX3jkVAoOK3yWySZI2XIuq
 2o1fvVHXOLMLnZo3mYoxOxj1jFm0QOasI76vfxMqG2wzsoWG2PJQPcsubfBB0qFBfUV2
 qI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J8CSEA2PIrFPVAYwmx025ybZnYDwOg6gBsSlne2MzU4=;
 b=SLHCbmHvFibcUHzx/dYhs+ZOxN4KvMg52tUfRPWzjB/y2jqB4+ItN7A9QtqTIjvb7P
 rWLusKWfdyREwwdCKnn29E7f9L22qy6HkHDVWYPmGc1lAFMk7lRyesiWPC9ki88bucGt
 TdlQlEKP1qAe6YRmySn63kvmBNUAfl4JEm+97SbK8aznrclnySMUZSjbqikelh8clCPo
 ztIqXw7G8wkIhfjXyBxyb0FBkonPARD2i6+GBSkckB0VGFyjN7crindILIdI/2IZs8d2
 XxAEODtG5vXTaZbVxZZ1LmJmPzCOqdztWBQH8u3hY9zLW8oKFZ273L7ioLY26yKLxfxo
 UVBA==
X-Gm-Message-State: AGi0PuZrq4may99ThGfLOZbGkdEK74iIiXjNPwtcdkL8WjIZ62LCE31Q
 Zef7tmDia4B4UFV6Pc2GkQThIP5fZcie4sEmbuiSL2jx4MU=
X-Google-Smtp-Source: APiQypLBhVhRZvAqr+tzcV11vAhhxIzctOHcluutRuTuawY5nUtmw9HBgM2ogY8uN6/bZzX5mzyq6mTQBh4NqQ/u/X0=
X-Received: by 2002:a2e:3c0a:: with SMTP id j10mr4727801lja.205.1585492869603; 
 Sun, 29 Mar 2020 07:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <CABY-YC7eHFjb-TpKf2ioPJNhZ8RccYsrR-oU=wmt26z9AUNebg@mail.gmail.com>
 <a7da72d0-ed3f-ab5c-a72b-1b0518436a2e@grimberg.me>
 <e4f3f68d-a4a7-e799-c3b8-1d600e3888b5@mellanox.com>
 <CABY-YC4jSOZJW2zEx5dS9BRj8+ipNF5aF_0cgkuDo9oaLbhvew@mail.gmail.com>
 <9024d7bc-d55d-06c1-65b3-61027f81fda6@mellanox.com>
In-Reply-To: <9024d7bc-d55d-06c1-65b3-61027f81fda6@mellanox.com>
From: Anton Brekhov <anton.brekhov@rsc-tech.ru>
Date: Sun, 29 Mar 2020 17:40:58 +0300
Message-ID: <CABY-YC7yGBk5xLpxYHUW_sRO6LspRWG6sMc4To1uggkXPjBvWQ@mail.gmail.com>
Subject: Re: NVMe Over Fabrics Disconnect Kernel error
To: Max Gurtovoy <maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200329_074112_036985_9C5C0868 
X-CRM114-Status: GOOD (  17.29  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Konstantin Ponomarev <k.ponomarev@rsc-tech.ru>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhlbiBJJ20gYWZyYWlkIHRoYXQgd2UgY2FuJ3QgcmVwcm9kdWNlIHRoaXMsIGNhdXNlIHdlIHVz
ZSBJbnRlbCBvbW5pCnBhdGggZHJpdmVycyB0aGF0IGlzIG5vdCBjb21wYXRpYmxlIHdpdGggdGhl
IGxhdGVzdCB2ZXJzaW9uIG9mIHRoZQprZXJuZWwuClRvZGF5IHdlJ3ZlIHRyaWVkIHRvIGluc3Rh
bGwgbmV3IHZlcnNpb24gb2Yga2VybmVsLCB1cGdyYWRlIHRvIENlbnRvcwo4IGFuZCA4LjEuIEhv
d2V2ZXIgbm90aGluZyBpcyBjb21wYXRpYmxlIHdpdGggb3VyIHRlY2hub2xvZ2llcyBpbiBvdXIK
SFBDIGNsdXN0ZXIuCklmIHRoZXJlIGlzIGFueSBvdGhlciB3b3JrYXJvdW5kcyBvciBpZGVhcyB3
ZSB3b3VsZCBiZSBoYXBweSB0byBoZWFyCml0IGZyb20geW91LgpJZiBubywgd2UnbGwgc3RheSBp
biB0b3VjaCB3aGVuIHdpbGwgYmUgdXBncmFkaW5nIHdob2xlIGNsdXN0ZXIuCgpBbnRvbgoK0LLR
gSwgMjkg0LzQsNGALiAyMDIwINCzLiDQsiAxNDo1NiwgTWF4IEd1cnRvdm95IDxtYXhnQG1lbGxh
bm94LmNvbT46Cgo+Cj4KPiBPbiAzLzI5LzIwMjAgMjozOCBQTSwgQW50b24gQnJla2hvdiB3cm90
ZToKPiA+IE1heCwKPiA+IFRoaXMgZXJyb3Igd2UndmUgb2J0YWluZWQgd2hpbGUgdXNpbmcgdGhl
IGxhdGVzdCByZWxlYXNlIG9mIG52bWUtY2xpOgo+ID4gW3Jvb3RAczAycDAwNSB+XSMgbnZtZSB2
ZXJzaW9uCj4gPiBudm1lIHZlcnNpb24gMS4xMC4xCj4gPgo+ID4gT3IgdGhlcmUgd2VyZSBzb21l
IG1ham9yIGNoYW5nZXMgYWZ0ZXIgbGF0ZXN0IHJlbGVhc2U/Cj4KPiBJIHJlZmVycmVkIHRvIHRo
ZSBrZXJuZWwgdmVyc2lvbi4KPgo+IENhbiB5b3UgY2hlY2sgeW91ciBzY2VuYXJpbyB3aXRoIGdp
dDovL2dpdC5pbmZyYWRlYWQub3JnL252bWUuZ2l0Cj4gKGJyYW5jaCBudm1lLTUuNyBvciBudm1l
LTUuNy1yYzEpLgo+Cj4gLU1heC4KPgo+Cj4gPiBUaGFua3MuCj4gPgo+ID4g0LLRgSwgMjkg0LzQ
sNGALiAyMDIwINCzLiDQsiAxMTo1MSwgTWF4IEd1cnRvdm95IDxtYXhnQG1lbGxhbm94LmNvbT46
Cj4gPj4KPiA+PiBPbiAzLzI5LzIwMjAgNzoxNCBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiA+
Pj4+IEdyZWV0aW5ncyEKPiA+Pj4+Cj4gPj4+PiBXZSdyZSB1c2luZyBudm1lLWNsaSB0ZWNobm9s
b2d5IHdpdGggWkZTIGFuZCBMdXN0cmUgRmlsZXN5c3RlbSBvbiB0b3AKPiA+Pj4+IG9mIGl0Lgo+
ID4+Pj4gQnV0IHdlIGNvbnN0YW50bHkgY29tZSBhY3Jvc3MgYSBrZXJuZWwgZXJyb3Igd2hpbGUg
ZGlzY29ubmVjdGluZwo+ID4+Pj4gcmVtb3RlIGRpc2tzIGZyb20gc3dpdGNoZWQgb2ZmIG5vZGVz
Ogo+ID4+Pj4gYGBgCj4gPj4+PiBbICArMCwwMDAwODldIElORk86IHRhc2sga3dvcmtlci91NTkz
OjA6ODIyOTMgYmxvY2tlZCBmb3IgbW9yZSB0aGFuCj4gPj4+PiAxMjAgc2Vjb25kcy4KPiA+Pj4+
IFsgICswLDAwMTk1OV0gImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVv
dXRfc2VjcyIKPiA+Pj4+IGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KPiA+Pj4+IFsgICswLDAwMTk0
MV0ga3dvcmtlci91NTkzOjAgIEQgZmZmZjkwZTg0OTNmZTJhMCAgICAgMCA4MjI5MyAgICAgIDIK
PiA+Pj4+IDB4MDAwMDAwODAKPiA+Pj4+IFsgICswLDAwMDAzMV0gV29ya3F1ZXVlOiBudm1lLWRl
bGV0ZS13cSBudm1lX2RlbGV0ZV9jdHJsX3dvcmsKPiA+Pj4+IFtudm1lX2NvcmVdCj4gPj4+PiBb
ICArMCwwMDAwMDNdIENhbGwgVHJhY2U6Cj4gPj4+PiBbICArMCwwMDAwMDhdICBbPGZmZmZmZmZm
ODE3N2YyMjk+XSBzY2hlZHVsZSsweDI5LzB4NzAKPiA+Pj4+IFsgICswLDAwMDAxMF0gIFs8ZmZm
ZmZmZmY4MTM1OGU4NT5dIGJsa19tcV9mcmVlemVfcXVldWVfd2FpdCsweDc1LzB4ZTAKPiA+Pj4+
IFsgICswLDAwMDAwN10gIFs8ZmZmZmZmZmY4MTBjNjFjMD5dID8gd2FrZV91cF9hdG9taWNfdCsw
eDMwLzB4MzAKPiA+Pj4+IFsgICswLDAwMDAwNl0gIFs8ZmZmZmZmZmY4MTM1OWNiND5dIGJsa19m
cmVlemVfcXVldWUrMHgyNC8weDUwCj4gPj4+PiBbICArMCwwMDAwMDldICBbPGZmZmZmZmZmODEz
NGUwZWY+XSBibGtfY2xlYW51cF9xdWV1ZSsweDdmLzB4MWIwCj4gPj4+PiBbICArMCwwMDAwMTJd
ICBbPGZmZmZmZmZmYzAzMTE1OGU+XSBudm1lX25zX3JlbW92ZSsweDhlLzB4YjAgW252bWVfY29y
ZV0KPiA+Pj4+IFsgICswLDAwMDAxMV0gIFs8ZmZmZmZmZmZjMDMxMTc0Yj5dIG52bWVfcmVtb3Zl
X25hbWVzcGFjZXMrMHhhYi8weGYwCj4gPj4+PiBbbnZtZV9jb3JlXQo+ID4+Pj4gWyAgKzAsMDAw
MDEyXSAgWzxmZmZmZmZmZmMwMzExN2UyPl0gbnZtZV9kZWxldGVfY3RybF93b3JrKzB4NTIvMHg4
MAo+ID4+Pj4gW252bWVfY29yZV0KPiA+Pj4+IFsgICswLDAwMDAwOF0gIFs8ZmZmZmZmZmY4MTBi
ZDBmZj5dIHByb2Nlc3Nfb25lX3dvcmsrMHgxN2YvMHg0NDAKPiA+Pj4+IFsgICswLDAwMDAwNl0g
IFs8ZmZmZmZmZmY4MTBiZTM2OD5dIHdvcmtlcl90aHJlYWQrMHgyNzgvMHgzYzAKPiA+Pj4+IFsg
ICswLDAwMDAwNl0gIFs8ZmZmZmZmZmY4MTBiZTBmMD5dID8gbWFuYWdlX3dvcmtlcnMuaXNyYS4y
NisweDJhMC8weDJhMAo+ID4+Pj4gWyAgKzAsMDAwMDA1XSAgWzxmZmZmZmZmZjgxMGM1MGQxPl0g
a3RocmVhZCsweGQxLzB4ZTAKPiA+Pj4+IFsgICswLDAwMDAwNl0gIFs8ZmZmZmZmZmY4MTBjNTAw
MD5dID8gaW5zZXJ0X2t0aHJlYWRfd29yaysweDQwLzB4NDAKPiA+Pj4+IFsgICswLDAwMDAwNl0g
IFs8ZmZmZmZmZmY4MTc4Y2QxZD5dIHJldF9mcm9tX2Zvcmtfbm9zcGVjX2JlZ2luKzB4Ny8weDIx
Cj4gPj4+PiBbICArMCwwMDAwMDZdICBbPGZmZmZmZmZmODEwYzUwMDA+XSA/IGluc2VydF9rdGhy
ZWFkX3dvcmsrMHg0MC8weDQwCj4gPj4+PiBgYGAKPiA+Pj4+IE5vZGVzIGNoYXJhY3RlcmlzdGlj
czoKPiA+Pj4+IFtyb290QHMwMnAwMDUgfl0jIHVuYW1lIC1zcm0KPiA+Pj4+IExpbnV4IDMuMTAu
MC0xMDYyLjEuMS5lbDcueDg2XzY0IHg4Nl82NAo+ID4+Pj4gW3Jvb3RAczAycDAwNSB+XSMgY2F0
IC9ldGMvcmVkaGF0LXJlbGVhc2UKPiA+Pj4+IENlbnRPUyBMaW51eCByZWxlYXNlIDcuNy4xOTA4
IChDb3JlKQo+ID4+Pj4KPiA+Pj4+IFdoZXJlJ3JlIHVzaW5nIG52bWV0X3JkbWEuCj4gPj4+PiBJ
cyB0aGVyZSBhbnkgd29ya2Fyb3VuZCBmb3Igc3VjaCBlcnJvcj8KPiA+Pj4gSXQgc2VlbXMgbGlr
ZSBxdWV1ZSBmcmVlemUgaXMgc3R1Y2suIENhbiB5b3Ugc2hhcmUgbW9yZSBvZiB0aGUKPiA+Pj4g
dHJhY2Ugc28gd2UgY2FuIHNlZSB3aGF0IGVsc2UgaXMgYmxvY2tpbmc/IElmIG5vdCwgd2hlbgo+
ID4+PiBpdCByZXByb2R1Y2VzIHJ1biBlY2hvIHQgPiAvcHJvYy9zeXNycS10cmlnZ2VyIGFuZCBz
aGFyZSB0aGUKPiA+Pj4gbG9nLgo+ID4+IEFudG9uLAo+ID4+Cj4gPj4gQ2FuIHlvdSByZXBybyB0
aGlzIHdpdGggbGF0ZXN0IG52bWUgYnJhbmNoID8gb3Igb25seSBpbmJveCBDZW50b3M3LjcgPwo+
ID4+Cj4gPj4KPiA+Pj4gVGhhbmtzLgo+ID4+Pgo+ID4+PiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4+PiBsaW51eC1udm1lIG1haWxpbmcgbGlzdAo+
ID4+PiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+Pj4gaHR0cHM6Ly9ldXIwMy5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZsaXN0cy5p
bmZyYWRlYWQub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGbGludXgtbnZtZSZhbXA7ZGF0YT0w
MiU3QzAxJTdDbWF4ZyU0MG1lbGxhbm94LmNvbSU3QzE0NDcxYjBmMWJhYjRiZTJhNjgxMDhkN2Qz
ZDVjODliJTdDYTY1Mjk3MWM3ZDJlNGQ5YmE2YTRkMTQ5MjU2ZjQ2MWIlN0MwJTdDMCU3QzYzNzIx
MDc4NzQ2NDc3NTcwNyZhbXA7c2RhdGE9eG13Z2s1bGpGdCUyRjclMkJzWlJRbVA2bWZ3dVIwaGhq
b1lzdk5yckxVQmF5cUklM0QmYW1wO3Jlc2VydmVkPTAKPiA+Pj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0Cmxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
