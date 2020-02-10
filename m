Return-Path: <SRS0=obgt=36=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B3C352A4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2020 19:20:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB61A20661
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2020 19:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PkgwfIfl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="1mQH3RRo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="Xd9kZ/Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB61A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=seagate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=yaiqqVvk+VZamn6Yg2/l+8OzXyOChqnlulpvX4cXma0=; b=Pkg
	wfIfl4pD0gakgLe9+kDQ2qrgeMIb5jrBGUQRjdVNTxqtUmflNgY+3ACKfAaHJDp08XFp1ryflMqVj
	dUPJ9HnBmkCxr6SKZZp/+nJgjSlKtceh1YOlKv0t6NA6uTgbHgCN/EDCfAZqqQKcbL3CaXkFmBaoz
	l/h6VVvhLdYbis/BZHYkfQIMhZqfmPtGj7goQbI9MZydMWANXbRJ2LOivwDsIRV5h1FxG6DPHR3aQ
	nPi4Plkzum23yxsD9yMMhIYEkP0RT0sAAAkuMU5GgnZhToO4pxyiT2dR0682Pk0VVClHbrUDk6ihc
	eqwEYJuKEvBKU206odsVGBCfMG/vQkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1Ebf-00015B-HC; Mon, 10 Feb 2020 19:20:31 +0000
Received: from mx0a-00003501.pphosted.com ([67.231.144.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1Ebc-00014K-BR
 for linux-nvme@lists.infradead.org; Mon, 10 Feb 2020 19:20:30 +0000
Received: from pps.filterd (m0075553.ppops.net [127.0.0.1])
 by mx0a-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01AJIb5P026795
 for <linux-nvme@lists.infradead.org>; Mon, 10 Feb 2020 14:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 h=mime-version : from
 : date : message-id : subject : to : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=32cRl0psfZlFIfgYEJUg/zrSsrp5gweGrD+uloloHgg=;
 b=1mQH3RRoEWlGJjZymsCSC4xv3W6N/R6hdUiPatdQd5pwAeQv8VhYBndggHd34iF2xpYR
 CCp4bd5CiAgRm8GRN5MhWgJPzjwauDNbVWYGRAnOlcwlPjH11xmTwI6VgOBYYF3r6vk+
 hS+bmztQ+otfVpPu4AyYHhoY4hC4vVmxcRG+OksTwUdoUfRUDYGtt7MwnMCHn7E4KZYl
 6DyOr9OP6c96Nk1GY0jhTNK1VjgG4CeDwEpHU8ZnPkIYtpYyIexNrh3FhfxyzT9+K3i/
 8vuhNKmfVjktPMNjnn5zDV3+rR/PJeEvYxsHrIdvSRBs5k8FFo/+diJuHsmZT03pGeWC 6A== 
Authentication-Results: seagate.com;
 dkim=pass header.s=google header.d=seagate.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by mx0a-00003501.pphosted.com with ESMTP id 2y2b9yevdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 10 Feb 2020 14:20:24 -0500
Received: by mail-wm1-f71.google.com with SMTP id f66so154440wmf.9
 for <linux-nvme@lists.infradead.org>; Mon, 10 Feb 2020 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; s=google;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=32cRl0psfZlFIfgYEJUg/zrSsrp5gweGrD+uloloHgg=;
 b=Xd9kZ/SqKLDIWcPnfJQIgsPgcBCHbkQ/WeU9lluDf6gS51rNgiyGCuuTWnc33o3ywP
 XwF6aqDwi7KCs6V0rxnse0jSI+80WwP+TtgGxQAwUwafels9QZ6814iuPfzCFPLurW/L
 tVxNhPLr9DOgoX8i5yLlQKlXKgpGynrksBOklASKIoFjVbHmaQI5XdgrL5J/lhQlBqGG
 LCbeC/MvxP/L2lJpaLiXjGvIcYqnVVWZ/Dd3F3qwc5yLKqQxRfk55gAqWFkg16svVQVW
 rw8FwP6LEkX1ins9JvRe1MLyOsjE5XPJlg/RmkMM1zNStcidfQhSKaJC2sC/dRiT4diP
 KX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=32cRl0psfZlFIfgYEJUg/zrSsrp5gweGrD+uloloHgg=;
 b=rikb8PmW9/nS+rFDs5na9lEc1+0uhYXu8ctdIWRzfg8/zcEW0sPNnScFdeDemJaXKs
 dY1w+xq3iyNE54pf3q1rkBhCLYYQ5ZmQVfJdog8mwJMpbwHM5RhCK8wIw7uiqYP0+H03
 AubcIugYqjIEtMF3H+rT7N+Ct6Cy8wPtrZD+RQnz4ixjx2B/dmYdRPCXvcXEWHfggswB
 vGf0FCssM3aeYIN1z7mvNOJO5Azkz0H5szbx/X6JNxpKNudgUMb4NqxJ49riWJwnXgwV
 vDDRkxup7ZjDtNPnBc+b+CSG9mmOjg2tc6Qw6x2iSk2zlufyzUqA2b6QuIDeZLcm43by
 drMQ==
X-Gm-Message-State: APjAAAV+N2e0KcEsLmmagqMLQGkxJxvojSRXxMs2xGtwwYcXdXjLFA0D
 UWU0kGVM9/W0v6yqsNLbn+OuXA5jF6+MYuYvshD2BLKqZFfYvnXSzBpFayx/orb+yIBpVvEDcz1
 0tzodP7kAVshJBTicfgYrrPQbIv9HEPYl7ohGjx6mO0frLGEqlnEdGgo31JkszXnZeS+0
X-Received: by 2002:a05:600c:2058:: with SMTP id
 p24mr460533wmg.96.1581362422473; 
 Mon, 10 Feb 2020 11:20:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhho0hM0btYOROp4KxprD57xotc9dLtYEXfb79Mb66f6GNtPbrW35WAKNR4Bou5GMAW+EvJ4NgI1qm/L1c9iY=
X-Received: by 2002:a05:600c:2058:: with SMTP id
 p24mr460504wmg.96.1581362422072; 
 Mon, 10 Feb 2020 11:20:22 -0800 (PST)
MIME-Version: 1.0
From: Tim Walker <tim.t.walker@seagate.com>
Date: Mon, 10 Feb 2020 14:20:10 -0500
Message-ID: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] NVMe HDD
To: linux-block@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
 linux-nvme@lists.infradead.org
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-10_07:2020-02-10,
 2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1011
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=1 spamscore=0 adultscore=0 mlxlogscore=923 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100143
X-Proofpoint-Spam-Policy: Default Domain Policy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200210_112029_245688_CF97A36C 
X-CRM114-Status: UNSURE (   9.44  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QmFja2dyb3VuZDoKCk5WTWUgc3BlY2lmaWNhdGlvbiBoYXMgaGFyZGVuZWQgb3ZlciB0aGUgZGVj
YWRlIGFuZCBub3cgTlZNZSBkZXZpY2VzCmFyZSB3ZWxsIGludGVncmF0ZWQgaW50byBvdXIgY3Vz
dG9tZXJz4oCZIHN5c3RlbXMuIEFzIHdlIGxvb2sgZm9yd2FyZCwKbW92aW5nIEhERHMgdG8gdGhl
IE5WTWUgY29tbWFuZCBzZXQgZWxpbWluYXRlcyB0aGUgU0FTIElPQyBhbmQgZHJpdmVyCnN0YWNr
LCBjb25zb2xpZGF0aW5nIG9uIGEgc2luZ2xlIGFjY2VzcyBtZXRob2QgZm9yIHJvdGF0aW9uYWwg
YW5kCnN0YXRpYyBzdG9yYWdlIHRlY2hub2xvZ2llcy4gUENJZS1OVk1lIG9mZmVycyBuZWFyLVNB
VEEgaW50ZXJmYWNlCmNvc3RzLCBmZWF0dXJlcyBhbmQgcGVyZm9ybWFuY2Ugc3VpdGFibGUgZm9y
IGhpZ2gtY2FwIEhERHMsIGFuZApvcHRpbWFsIGludGVyb3BlcmFiaWxpdHkgZm9yIHN0b3JhZ2Ug
YXV0b21hdGlvbiwgdGllcmluZywgYW5kCm1hbmFnZW1lbnQuIFdlIHdpbGwgc2hhcmUgc29tZSBl
YXJseSBjb25jZXB0dWFsIHJlc3VsdHMgYW5kIHByb3Bvc2VkCnNhbGllbnQgZGVzaWduIGdvYWxz
IGFuZCBjaGFsbGVuZ2VzIHN1cnJvdW5kaW5nIGFuIE5WTWUgSERELgoKCkRpc2N1c3Npb24gUHJv
cG9zYWw6CgpXZeKAmWQgbGlrZSB0byBzaGFyZSBvdXIgdmlld3MgYW5kIHNvbGljaXQgaW5wdXQg
b246CgotV2hhdCBMaW51eCBzdG9yYWdlIHN0YWNrIGFzc3VtcHRpb25zIGRvIHdlIG5lZWQgdG8g
YmUgYXdhcmUgb2YgYXMgd2UKZGV2ZWxvcCB0aGVzZSBkZXZpY2VzIHdpdGggZHJhc3RpY2FsbHkg
ZGlmZmVyZW50IHBlcmZvcm1hbmNlCmNoYXJhY3RlcmlzdGljcyB0aGFuIHRyYWRpdGlvbmFsIE5B
TkQ/IEZvciBleGFtcGxlLCB3aGF0IHNjaGVkdWxhciBvcgpkZXZpY2UgZHJpdmVyIGxldmVsIGNo
YW5nZXMgd2lsbCBiZSBuZWVkZWQgdG8gaW50ZWdyYXRlIE5WTWUgSEREcz8KCi1BcmUgdGhlcmUg
TlZNZSBmZWF0dXJlIHRyYWRlLW9mZnMgdGhhdCBtYWtlIHNlbnNlIGZvciBIRERzIHRoYXQgd29u
4oCZdApicmVhayB0aGUgSERELVNTRCBpbnRlcm9wZXJhYmlsaXR5IGdvYWxzPwoKLUhvdyB3b3Vs
ZCB1cGNvbWluZyBtdWx0aS1hY3R1YXRvciBIRERzIGltcGFjdCBOVk1lPwoKClJlZ2FyZHMsClRp
bSBXYWxrZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
