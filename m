Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CF4C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 12:47:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1589A611BD
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 12:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1589A611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hNHWEOboW9sypCX5vj5FYoipTtrapp7s8HhrZI6na4k=; b=k3lKWhAAdHCXIDT4AiaJJajqI
	K64sEUuz8byJWSjrhT2ZYX/FUiZ94E3WfHhBkUXa7du68AhO6gdjB84RvYLMZLV1QZ5BeMTrkaeWq
	veth0HrtCWk2PJkezex7vLBLI0fF+LS0kI+kw4iTu2r7fq8xg5EfX1ZATE0nAIf+t74Xo8aeD+ypE
	LTDrk7SEJMtMnsrsiIUzASxDD9Bek//3Xs+6CRz9X8cwPtJGstqyR6nhijDKlPK//dXLEuhbDNXnZ
	MhqneQaYdbBNcFkxJSvBo0oT9zob2jV6bqqeK1FwqNKkhW4dRbh2+vFXB0qOizr384jz/PIvKLIH1
	qfjv/U8cQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU7aN-004z7j-HK; Wed, 07 Apr 2021 12:47:07 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU7a6-004z3P-Rl
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 12:47:03 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210407124639epoutp044845f651c956252e1008842002b03e07~zlCn_TmZV0278702787epoutp04h
 for <linux-nvme@lists.infradead.org>; Wed,  7 Apr 2021 12:46:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210407124639epoutp044845f651c956252e1008842002b03e07~zlCn_TmZV0278702787epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1617799599;
 bh=VfJueQj55Ca+FjgwDc1rjukcst+corCiDZXH+8CUmXc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZK9NiMMP7xI7M1PxvlbSGopM6lqpIMGCkL/71FFpZnmci2ThjLf+KuJiXxbpZBD6z
 i6MjR7v2menOL1GajKRMGqF/MlS5zgP4geY31Ly88vPjjs00ugq9cr5PfnDKAVioaP
 VUTfwn8IThf+SCeDwbo3xKsJZj9IctYs6J3xU6/4=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210407124638epcas5p3d87f4a1ebf728da6586e6dbb51617d84~zlCnknHnx2980929809epcas5p37;
 Wed,  7 Apr 2021 12:46:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 EE.2C.39068.EA9AD606; Wed,  7 Apr 2021 21:46:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20210407123854epcas5p48217db953741a57d651a8a8bf240ee23~zk73MRC6r2354823548epcas5p49;
 Wed,  7 Apr 2021 12:38:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210407123854epsmtrp1338f0de875cac456cdec792bcc09b227~zk73LegXK2278722787epsmtrp1o;
 Wed,  7 Apr 2021 12:38:54 +0000 (GMT)
X-AuditID: b6c32a4a-60fff7000000989c-c6-606da9ae658d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 93.51.08745.ED7AD606; Wed,  7 Apr 2021 21:38:54 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
 [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210407123852epsmtip27d78219689f9acbd31fdc5d9507e79c6~zk71j9Ypi2060320603epsmtip2E;
 Wed,  7 Apr 2021 12:38:52 +0000 (GMT)
From: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
To: kbusch@kernel.org
Cc: Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org,
 tasleson@redhat.com, tbzatek@redhat.com, prakash.v@samsung.com,
 d.palani@samsung.com, javier.gonz@samsung.com, k.jensen@samsung.com,
 mohit.kap@samsung.com, krish.reddy@samsung.com
Subject: libnvme questions
Date: Wed,  7 Apr 2021 18:08:06 +0530
Message-Id: <20210407123806.23253-1-p.kalghatgi@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7bCmhu66lbkJBiu2aFnMuv2axeLt1wds
 Fo/vfGa3ONm4h9Vi0qFrjBYLNy5jspi/7Cm7xZoXyhZXpixitrh47ya7xbw/H9kduD02repk
 89i8pN7j/b6rbB59W1YxerQf6GYKYI3isklJzcksSy3St0vgyphz7QRTQTNPxe3ek8wNjJs4
 uxg5OSQETCTaH51j6WLk4hAS2M0oMXHtcVYI5xOjxN+HbUwQzmdGicWdn5hhWlZtXsQOkdjF
 KPFz7TE2CKeVSWLKstNA/RwcbAJGEt9bbUFMEQFRiUfTxEBKmAV+Mkose3GNDSQuLCAl8e9K
 GchMFgFVicO9D9lBbF4BG4n5R+ZB7VKWWPjwINhETgFnicXTSyBKBCVOznzCAmIzC8hLNG+d
 zQwyXkJgKofEza+noHpdJG7NPcQGYQtLvDq+hR3ClpJ42d/GDtHQzCix78sVFghnAqPElPnv
 mCCq7CUu7vnLBLKZWUBTYv0ufYiwrMTUU+uYIDbzSfT+fgJVziuxYx6MrSrx+MJBqMXSErNX
 foKKe0hsbv0MDatpjBIP989hncCoMAvJR7OQfDQLYfUCRuZVjJKpBcW56anFpgVGeanlesWJ
 ucWleel6yfm5mxjBiUnLawfjwwcf9A4xMnEwHmKU4GBWEuHd0ZudIMSbklhZlVqUH19UmpNa
 fIhRmoNFSZx3h8GDeCGB9MSS1OzU1ILUIpgsEwenVAOTtSjziqZVi37e1WuwnexzY+rnMOnq
 5qvXm18nPRerWiTHGS0XqNZ9VsynZcWSC4r3Q0U3zSyXSRWc5SXItqr27DnZdsb5v2ff7yvU
 zGE0lBI589N0Ft+9wKV5qSenLiq8k2ld/nS36S1mw+MTdrNO+3zsd7flmqkbrrj8uf93drHY
 77zsKdcc50VN+LW1Q0TEe3JQbMuds+eSHBIePDCWNItpVZD3snulEH5op4rDw4OeTD8Ozlz2
 O7u7K6ki4/T2/SXOL+acNvgYIph4bZ3Y5fQ5f6Mlajkz7cw6zBdrhioam5z19GbZ+02Io1q0
 w0xUY3upWEeFo+gjzccbuu1YzJ93+bjE7zYV4FGexqvEUpyRaKjFXFScCAACf7rguwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvO695bkJBu/fiVvMuv2axeLt1wds
 Fo/vfGa3ONm4h9Vi0qFrjBYLNy5jspi/7Cm7xZoXyhZXpixitrh47ya7xbw/H9kduD02repk
 89i8pN7j/b6rbB59W1YxerQf6GYKYI3isklJzcksSy3St0vgyphz7QRTQTNPxe3ek8wNjJs4
 uxg5OSQETCRWbV7EDmILCexglDjQbQARl5bY9/A6C4QtLLHy33OgGi6gmmYmiYPTvwElODjY
 BIwkvrfagpgiAqISj6aJgZQwC7QySbz6uZwRJC4sICXx70oZyBgWAVWJw70PwVbxCthIzD8y
 jxlivLLEwocHWUHKOQWcJRZPL4G4xkmi6cUnFohyQYmTM5+ALWUWUJdYP08IJMwsIC/RvHU2
 8wRGwVlIqmYhVM1CUrWAkXkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwhGhp7WDc
 s+qD3iFGJg7GQ4wSHMxKIrw7erMThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliS
 mp2aWpBaBJNl4uCUamDSWDOB9/P/0OU51xLPRjvOvDvvosT2PSa+S/vWvrypYa5kkMDuxmUZ
 Gbx77p6u0wm/ufiO7twpuzZF6fCSDtOzk1wOJM4o1v5itEx6+c2sv7kbfIK+ZwfO7J30+KJI
 85a4mmCnw9pqT3apPzMqFo7c6rigMsj4VkWrwf5r39kVvVjWXm5YZ1Yyc37Sya7+mTZvp/5U
 NP5abLf2cuUFKYtT+bm/j/6tmWF1VeTNaYav5VJW+mERR7/Payw0fLJs+kyFz3undkxPC5pU
 o8bH80igfOWGTS+lTzxxi3zi6PN91ukL8w/y2yzq4f8W+exe8gHti6e6hEp2nnpn2KR15Oar
 PPXvUz/Xb7i0L3F6+6FD3kosxRmJhlrMRcWJAIRruHP/AgAA
X-CMS-MailID: 20210407123854epcas5p48217db953741a57d651a8a8bf240ee23
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210407123854epcas5p48217db953741a57d651a8a8bf240ee23
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_134654_885848_B5818937 
X-CRM114-Status: GOOD (  11.89  )
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

IFdlIHdvdWxkIGxpa2UgdG8gcHJvcG9zZSBhbiBpbXBsZW1lbnRhdGlvbiBvZiBzaWRlYmFuZCBu
dm1lLW1pIGNvbW1hbmQgc2V0ICBpbiBudm1lLWNsaSAmIFFFTVUgU3Vic3lzdGVtLiAKCiAgIFdo
YXQgYXJlIHdlIGdvaW5nIHRvIHRhcmdldD8KCsK3ICBOVk1lLUNMSSBwbHVnLWluIGZvciBNSSAo
c2lkZWJhbmQpCgogICAgICBJbXBsZW1lbnRhdGlvbiBvZiBNSSBjb21tYW5kcyBhcyBwZXIgTlZN
ZSBNSSBzcGVjaWZpY2F0aW9uLgogICAgICBFbmFibGluZyAgdG8gc2VuZCB0aGUgTUkgY29tbWFu
ZHMgdmlhIFNNQnVzXEhhcmR3YXJlc1xFbXVsYXRpb24uCiAgICAgIEltcGxlbWVudCB0aGlzIGFz
IGEgcGx1Z2luIHdoaWNoIHdpbGwgYmUgc2ltaWxhciB0byB0aGUgWk5TIGFuZCBvdGhlciBwbHVn
aW5zLiAKICAgICAgUHJvdmlkZSBwbGFjZWhvbGRlcnMgZm9yIHVzZXJzIHRvIHBsdWcgaW4gdGhl
IGhhcmR3YXJlIGxpYnJhcnkgb2YgdGhlaXIgY2hvaWNlLgoKIApBbG9uZyB3aXRoIHRoaXMsIHdl
IHBsYW5uZWQgdG8gaW1wbGVtZW50IHRoZSBzaWRlYmFuZCBNSSBjb21tYW5kIGhhbmRsaW5nIGlu
IFFFTVUuCklmIHRoaXMgZmVhdHVyZSBpcyB1c2VkIGFzIGEgcGx1Z2luLCBpdCB3b250IGhhdmUg
YW55IGltcGFjdCBvbiB0aGUgZXhpc3RpbmcgaW50ZXJmYWNlcyB3aGljaCB0aGUgbnZtZSBjb21t
YW5kIHVzZXMuCiAgClBsZWFzZSBzaGFyZSB5b3VyIHRob3VndGhzIHdoZXRoZXIgdG8gaGF2ZSB0
aGlzIGZlYXR1cmUgYXMgYSBwbHVnaW4gb3IgYXMgYSBzdGFuZGFsb25lIHRvb2wsIGFsc28gcHJv
dmlkZSBmZWVkYmFjayBvbiBvdXIgcGxhbiB0byBoYXZlIHRoZSBzaWRlYmFuZCBNSSBmdW5jdGlv
bmFsaXR5LgpXZSBhcmUgb3BlbiB0byBjby13b3JrIGFuZCBjb2xsYWJvcmF0ZSBvbiB0aGlzIGZl
YXR1cmUgZGV2ZWxvcG1lbnQuCgpTaW5jZSBtb3N0IG9mIHRoZSBjb21wYW5pZXMgd2hvIGRldmVs
b3AgU1NEcywgdXNlIE1JKHNpZGViYW5kKSBjaGFubmVsLCB3ZSB0aGluayB0aGlzIHdpbGwgYmUg
YSBnb29kIGVuaGFuY2VtZW50IHRvIHRoZSBleGlzdGluZyBmdW5jdGlvbmFsaXR5IHdoaWNoIHRo
ZSBudm1lLWNsaSBwcm92aWRlcy4KCkhlcmUgaXMgYSBsaXN0IG9mIFNTRHMgcmVsZWFzZWQgd2hp
Y2ggdXNlcyBzaWRlYmFuZCBNSToKcmVmOiBodHRwczovL3d3dy5pb2wudW5oLmVkdS9yZWdpc3Ry
eS9udm1lLW1pICAgICAKCldEQyBTTjYzMCAKV0RDIFNONjQwCldEQyBTTjY0MApXREMgVWx0cmFz
dGFyIERDIFNONjMwIAoKSEdTVCBVbHRyYXN0YXIgU04yMDAgCgpJbnRlbCBENy1QNTUwMApJbnRl
bMKuIE9wdGFuZeKEoiBTU0QgREMgUDQ4MDBYIApJbnRlbMKuIFNTRCBEQyBQNDUwMCBTZXJpZXMK
SW50ZWzCriBTU0QgREMgUDQ2MDggU2VyaWVzCkludGVswq4gU1NEIERDIFA0NjAwIFNlcmllcwpJ
bnRlbMKuIFNTRCBEQyBQNDUwMSBTZXJpZXMKClNhbXN1bmcgTlZNZSAxNzJYIFNlcmllcyAKClRo
YW5rcywKUGFkbWFrYXIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
