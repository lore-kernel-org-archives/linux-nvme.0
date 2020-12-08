Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CD9C4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:28:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F4123A79
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F4123A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sQBN1vKTCqeG4fIf2djOr3ev6z4mCpdJwuG7S++AkRE=; b=vL1gcENx9e7uSMximdgOBtzXE
	LhchEGr51dofDL0hRzWJ1T2qToa472+W4u2xqIDuYfjHEGTBLep58kJj9IjcLN6rpmdw7D4cB7qH0
	RhbeekiTd0KXnvOCmPn2E2J2bgVb/6d9yY6guCRZyLBP8SLi6YN447Uyu+7JlHZwhDj2sGicH082F
	qiO/vp7QTktqZLUDcX9bKtEgEm6SxKF7x8qObZaNgJtCRSl2/ODSQrGvq6uTwBvXqu8A78iLReuMf
	UsGPqOyjrbByrnyh7FMTj0F94bVWsKZM7Lc4zgrWx8mgPpEvwoVfePKSAuVCBg//+NxtGmCJasZEZ
	rCcDMEfRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmd2b-0002nB-Rx; Tue, 08 Dec 2020 13:28:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmd2Y-0002mN-LW
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 13:28:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607434104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2swnuExTam8u7GVLjq0iYQux5MEpwmMv1mUSlqTX+lc=;
 b=F6I1ku5aHhP2f4AQJ634lkkubUQ48+t0AGKOeGUygUHYmt4YL/xU3e0wk1OS6LNOdBBmEw
 4oH0EksiHBroWR+4Og+0+yDUuR1us/dnWHIg+CtUqq9JtR+BLGKJ99IyFHXQ72gPTIR8z1
 3gHZs0SIwzPgWWQlSkvpBY8ToE/rJOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-XYDj9umZPqWvXLmNK1zGxA-1; Tue, 08 Dec 2020 08:28:20 -0500
X-MC-Unique: XYDj9umZPqWvXLmNK1zGxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C23D19CC0D;
 Tue,  8 Dec 2020 13:28:19 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8FE760636;
 Tue,  8 Dec 2020 13:28:19 +0000 (UTC)
Received: from zmail20.collab.prod.int.phx2.redhat.com
 (zmail20.collab.prod.int.phx2.redhat.com [10.5.83.23])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id AEFF418095FF;
 Tue,  8 Dec 2020 13:28:19 +0000 (UTC)
Date: Tue, 8 Dec 2020 08:28:19 -0500 (EST)
From: Gopal Tiwari <gtiwari@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <989787074.23631599.1607434099327.JavaMail.zimbra@redhat.com>
In-Reply-To: <20201207140428.GA31159@lst.de>
References: <20201204161657.16421-1-gtiwari@redhat.com>
 <20201207140428.GA31159@lst.de>
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a
MIME-Version: 1.0
X-Originating-IP: [10.64.242.69, 10.4.195.4]
Thread-Topic: nvme: Added QUIRK for Samsung PM1725a
Thread-Index: cNzjcQ/48+rjNe+RPQL4EeVf5WCx3A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_082826_776013_28AB3990 
X-CRM114-Status: GOOD (  11.83  )
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
Cc: kbusch@kernel.org, dmilburn@redhat.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph,

Please find output for both the device .. 

[~]# nvme id-ctrl /dev/nvme0
NVME Identify Controller:
vid       : 0x144d
ssvid     : 0x1014
sn        : S3RWNA0JC00089
mn        : PCIe3 3.2TB NVMe Flash Adapter II x8
fr        : MN12MN12
rab       : 8
ieee      : 002538
cmic      : 0x3
mdts      : 8
cntlid    : 0x21
ver       : 0x10201
rtd3r     : 0xe4e1c0
rtd3e     : 0x989680
oaes      : 0x300
ctratt    : 0
rrls      : 0
cntrltype : 0
fguid     :
crdt1     : 0
crdt2     : 0
crdt3     : 0
oacs      : 0xe
acl       : 7
aerl      : 15
frmw      : 0x16
lpa       : 0x2
elpe      : 255
npss      : 0
avscc     : 0x1
apsta     : 0
wctemp    : 353
cctemp    : 360
mtfa      : 130
hmpre     : 0
hmmin     : 0
tnvmcap   : 3200631791616
unvmcap   : 0
rpmbs     : 0
edstt     : 0
dsto      : 0
fwug      : 0
kas       : 0
hctma     : 0
mntmt     : 0
mxtmt     : 0
sanicap   : 0
hmminds   : 0
hmmaxd    : 0
nsetidmax : 0
endgidmax : 0
anatt     : 0
anacap    : 0
anagrpmax : 0
nanagrpid : 0
pels      : 0
sqes      : 0x66
cqes      : 0x44
maxcmd    : 0
nn        : 32
oncs      : 0x3e
fuses     : 0
fna       : 0x4
vwc       : 0
awun      : 65535
awupf     : 0
nvscc     : 1
nwpc      : 0
acwu      : 0
sgls      : 0x70001
mnan      : 0
subnqn    : nqn.1994-11.com.samsung:nvme:PM1725a:HHHL:170818P00RC15
ioccsz    : 0
iorcsz    : 0
icdoff    : 0
ctrattr   : 0
msdbd     : 0
ps    0 : mp:25.00W operational enlat:100 exlat:100 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-

[ ~]# nvme id-ctrl /dev/nvme1
NVME Identify Controller:
vid       : 0x144d
ssvid     : 0x1014
sn        : S3RWNA0JC00053
mn        : PCIe3 3.2TB NVMe Flash Adapter II x8
fr        : MN12MN12
rab       : 8
ieee      : 002538
cmic      : 0x3
mdts      : 8
cntlid    : 0x21
ver       : 0x10201
rtd3r     : 0xe4e1c0
rtd3e     : 0x989680
oaes      : 0x300
ctratt    : 0
rrls      : 0
cntrltype : 0
fguid     :
crdt1     : 0
crdt2     : 0
crdt3     : 0
oacs      : 0xe
acl       : 7
aerl      : 15
frmw      : 0x16
lpa       : 0x2
elpe      : 255
npss      : 0
avscc     : 0x1
apsta     : 0
wctemp    : 353
cctemp    : 360
mtfa      : 130
hmpre     : 0
hmmin     : 0
tnvmcap   : 3200631791616
unvmcap   : 0
rpmbs     : 0
edstt     : 0
dsto      : 0
fwug      : 0
kas       : 0
hctma     : 0
mntmt     : 0
mxtmt     : 0
sanicap   : 0
hmminds   : 0
hmmaxd    : 0
nsetidmax : 0
endgidmax : 0
anatt     : 0
anacap    : 0
anagrpmax : 0
nanagrpid : 0
pels      : 0
sqes      : 0x66
cqes      : 0x44
maxcmd    : 0
nn        : 32
oncs      : 0x3e
fuses     : 0
fna       : 0x4
vwc       : 0
awun      : 65535
awupf     : 0
nvscc     : 1
nwpc      : 0
acwu      : 0
sgls      : 0x70001
mnan      : 0
subnqn    : nqn.1994-11.com.samsung:nvme:PM1725a:HHHL:170818P00RC15
ioccsz    : 0
iorcsz    : 0
icdoff    : 0
ctrattr   : 0
msdbd     : 0
ps    0 : mp:25.00W operational enlat:100 exlat:100 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-


Thanks 
Gopal 

----- Original Message -----
From: "Christoph Hellwig" <hch@lst.de>
To: "Gopal Tiwari" <gtiwari@redhat.com>
Cc: kbusch@kernel.org, dmilburn@redhat.com, hch@lst.de, linux-nvme@lists.infradead.org
Sent: Monday, December 7, 2020 7:34:28 PM
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a

Can you send me a dump of nvme id-ctrl /dev/nvmeN for this device?
I'm mostly curious on what spec version it claims compliance to,
and what is stored in the subnqn field.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
