Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9262C07E96
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 14:13:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804F261380
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 14:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804F261380
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxvZfBMdagXO2Hreofg4cWaWAu+PsfvV3JHw1Lir5DM=; b=sfch7z8wWNZTTdpDAXbJp1kVyz
	P962RLTBxNjo1UxDMSFiIGjYd99NhRulm0OTzg8BdsS0tVZ5DP9scaWMGF8DHUYrsyYy8TKYneq1n
	6l5akSWR81fMh8DEHVEwHDkaZnz5wImiPv48Uzgymx6WLkG6iN1UAEeyFKJniaubcH9ZPIQWhuv1h
	7TJC77jUEBtxhQI/PYAOypwGHBrl0xPCGlgnJn/zkMSbJ7JljNp4K7hwKYIoYfzn99pvdaZvcKiiu
	zHEP4GkP3fn/vwvUjDsX8w4y9ZV4dTl5083cH3pnyrGdSZ+GIMmAOIviwsaQ7gIy7iMutTS6UingZ
	ikOvROOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m426d-0012lh-C2; Thu, 15 Jul 2021 14:12:51 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m426a-0012l6-5s
 for linux-nvme@lists.infradead.org; Thu, 15 Jul 2021 14:12:50 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20210715141243epoutp02c945a307c50bf83fd81db4313590f5d3~R-FCXY2ha0285302853epoutp02r
 for <linux-nvme@lists.infradead.org>; Thu, 15 Jul 2021 14:12:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20210715141243epoutp02c945a307c50bf83fd81db4313590f5d3~R-FCXY2ha0285302853epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1626358363;
 bh=XRxxNPW3snq6lSjfDihfRLnwfAj4Rk5H0/CABadrDuA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eSzL9wT98LBhSFTTeEovcv5ixe69GWH3rhtjNyPFUbA9cbEjeht+uZAm752bgu+Qk
 /Hxle+UZjKUIOJV5xwFcw/WjKrkTeX4gyABNVI91GJEkR2PCX48a246LGgeO1yMaWR
 2wJyA+P9q2c94cSRrr2gRJDQuS2ItlVwsQshlVtk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20210715141242epcas5p1c601763dd9b7318ef19be3ae671c6c55~R-FBgDcJ82306123061epcas5p1B;
 Thu, 15 Jul 2021 14:12:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.208]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4GQbtJ0SYJz4x9Ps; Thu, 15 Jul
 2021 14:12:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 73.56.11627.75240F06; Thu, 15 Jul 2021 23:12:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20210715123747epcas5p4a0e74e02a33e2cbadc4fe67010a9efcc~R9yJtbWLQ1375413754epcas5p4A;
 Thu, 15 Jul 2021 12:37:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210715123747epsmtrp2d4d9778076b331627de49365b20e219d~R9yJsXzrN1874518745epsmtrp2H;
 Thu, 15 Jul 2021 12:37:47 +0000 (GMT)
X-AuditID: b6c32a4b-ab7ff70000022d6b-39-60f04257c8c9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 5A.5A.08289.B1C20F06; Thu, 15 Jul 2021 21:37:47 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20210715123745epsmtip1bd8f5d0da44c4847981b420de10ee53c~R9yHdP3Io0656306563epsmtip12;
 Thu, 15 Jul 2021 12:37:45 +0000 (GMT)
Date: Thu, 15 Jul 2021 18:06:40 +0530
From: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 linux-nvme@lists.infradead.org, k.jensen@samsung.com,
 javier.gonz@samsung.com, prakash.v@samsung.com, d.palani@samsung.com,
 u.kishore@samsung.com, mohit.kap@samsung.com, jg123.choi@samsung.com
Subject: Re: [RFC PATCH 1/2] hw/nvme: add mi device
Message-ID: <20210715123640.GB8970@test-zns>
MIME-Version: 1.0
In-Reply-To: <YOwhf59Xb/9IkZ9K@stefanha-x1.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmhm6404cEg+/9FhZvvz5gs7iy/zyj
 xf6D31gtHt/5zG6xdL6+xcnGPawWkw5dY7RYcjHVYv6yp+wWa14oW8y7pWxxZcoiZotZ79rZ
 LI737mCxeD3pP6vFzeanbA4CHj/OtbN5nNtxnt1j06pONo/NS+o9nlzbzOTxft9VNo++LasY
 A9ijcmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgC5X
 UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhXoFSfmFpfmpesl5+daGRoYGJkC
 VSbkZNz/2cFa8EGuovHTc+YGxj2SXYwcHBICJhIXfyl3MXJxCAnsZpT4dPAGaxcjJ5DziVFi
 9xcRiMRnRonPr5eygCRAGj4/W8gOkdjFKLFu1y1WCOcZo8TRG6+YQKpYBFQlHv7Zxgaygk3A
 SOJ7qy2IKSKgKXGjWxCknFngKpPEqxPtjCDlwgLGEnP7F7OD2LwCOhIdmyayQNiCEidnPmEB
 6eUUMJe4tlMRJCwqoCxxYNtxJpA5EgJnOCQmtTxkhzjOReLM1k5WCFtY4tXxLVBxKYnP7/ay
 QTQ0M0rs+3KFBcKZwCgxZf47Jogqe4mLe/6C2cwCmRKLLm1nhIjLSkw9tQ4qzifR+/sJVD2v
 xI55MLaqxOMLB9kgbGmJ2Ss/QcU9JHq3voOG0BpGiZ7jHewTGOVnIfluFpJ9ELaVROeHJtZZ
 QF8zA81a/o8DwtSUWL9LfwEj6ypGydSC4tz01GLTAuO81HLkCN/ECE7ZWt47GB89+KB3iJGJ
 g/EQowQHs5II71KjtwlCvCmJlVWpRfnxRaU5qcWHGE2BkTWRWUo0OR+YNfJK4g1NjczMDCwN
 TI0tzAyVxHmXsh9KEBJITyxJzU5NLUgtgulj4uCUamBaJSP8aGnghPObn/vYazN8WyL199c6
 UwZL9qx3OZpxNkqubqaPy4Me70rjsFi4bV1uReixSftD/LZrbN7xIuDWEVnnSusCpvUuyZUx
 bL4XKjfZ3nl+yPf+m963GX2HNrCJ3f++Ub1976IZjH+3H7iSKXpfof5W5/73N/2rtUq35mwO
 P6/0/91B9tM3Fik6W/N2lr5hOL0472fKytjTDmclNxVcEv2qfYNzb6Dmt/vRmbvZ5yh9uM0u
 zJuzTGzt2ja28j/f2fZ3/mc/Xnzj3bTHHf//7Tt7X1F8yoraBtO5zWHfgk4GSgV+vMUmfzz6
 fGysSeyMD16qmddf1bEfco5cPcfpeeW8A6ckLRa0m1/dqcRSnJFoqMVcVJwIAOqbtpxiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTlda50OCQUubqsXbrw/YLK7sP89o
 sf/gN1aLx3c+s1ssna9vcbJxD6vFpEPXGC2WXEy1mL/sKbvFmhfKFvNuKVtcmbKI2WLWu3Y2
 i+O9O1gsXk/6z2pxs/kpm4OAx49z7Wwe53acZ/fYtKqTzWPzknqPJ9c2M3m833eVzaNvyyrG
 APYoLpuU1JzMstQifbsEroyW7m9sBfNlKhZ0ejQwtop3MXJySAiYSHx+tpC9i5GLQ0hgB6NE
 1+yb7BAJaYl9D6+zQNjCEiv/PQeLCwk8YZR4+zsExGYRUJV4+GcbWxcjBwebgJHE91ZbEFNE
 QFPiRrcgyEhmgetMEo1vfrGBlAsLGEvM7V8MNoZXQEeiY9NEFoi96xgl9vd8ZYVICEqcnPkE
 bC+zgJnEvM0PmUGGMgPds/wfB4jJKWAucW2nIkiFqICyxIFtx5kmMArOQtI8C0nzLITmBYzM
 qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgmNMS2sH455VH/QOMTJxMB5ilOBgVhLh
 XWr0NkGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpisB
 25MdnucXpZ/x/ffMdO7J6S3/tvifWXPGQfj9/prd2tlx3ovMF4cXL/bf985tyWz9Q3bXNokX
 ca+a47R+xopZM5NeWlzzenDM9ZZ1t3xKg53puzwW67pJN34qFOw784+9rPDT84g//I3+6oay
 DMvur3nFsHsV35J8MYcfa2VVLn/L+MVcbPp+0XEbrZ0ykZXNf3+fK90i3+1qPPF4y/3u7Bn/
 kjXznmwUnrAvcM19B83e53bT5766EDzn+6waQ4GDJ1/LOGayr1W9MEFopv0kpdlXcjccWN/b
 vvf2+WCmDZFb/1jLPd1z4372sykzNp/YNdfUvORliaZL4u02dYdKJ6/r6fLz78r+nXHrlWOK
 EktxRqKhFnNRcSIAQGfBOSADAAA=
X-CMS-MailID: 20210715123747epcas5p4a0e74e02a33e2cbadc4fe67010a9efcc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----hb-dvdiRZtWrjeusMudXEerT0TTrvs-OGX_88iZ4NSx451yS=_122f68_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210709135651epcas5p1c544dec5377413bfa4b2eeab6ee43f26
References: <CGME20210709135651epcas5p1c544dec5377413bfa4b2eeab6ee43f26@epcas5p1.samsung.com>
 <20210709135545.GA11148@test-zns> <YOwhf59Xb/9IkZ9K@stefanha-x1.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_071248_688318_A38A3DB9 
X-CRM114-Status: GOOD (  30.16  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

------hb-dvdiRZtWrjeusMudXEerT0TTrvs-OGX_88iZ4NSx451yS=_122f68_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Jul 12, 2021 at 12:03:27PM +0100, Stefan Hajnoczi wrote:
>On Fri, Jul 09, 2021 at 07:25:45PM +0530, Padmakar Kalghatgi wrote:
>> The enclosed patch contains the implementation of certain
>> commands of nvme-mi specification.The MI commands are useful
>> to manage/configure/monitor the device.Eventhough the MI commands
>> can be sent via the inband NVMe-MI send/recieve commands, the idea here is
>> to emulate the sideband interface for MI.
>>
>> Since the nvme-mi specification deals in communicating
>> to the nvme subsystem via. a sideband interface, in this
>> qemu implementation, virtual-vsock is used for making the
>> sideband communication, the guest VM needs to make the
>> connection to the specific cid of the vsock of the qemu host.
>>
>> One needs to specify the following command in the launch to
>> specify the nvme-mi device, cid and to setup the vsock:
>> -device nvme-mi,bus=<nvme bus number>
>> -device vhost-vsock-pci, guest-cid=<vsock cid>
>>
>> The following commands are tested with nvme-cli by hooking
>> to the cid of the vsock as shown above and use the socket
>> send/recieve commands to issue the commands and get the response.
>>
>> we are planning to push the changes for nvme-cli as well to test the
>> MI functionality.
>
>Is the purpose of this feature (-device nvme-mi) testing MI with QEMU's
>NVMe implementation?
>
>My understanding is that instead of inventing an out-of-band interface
>in the form of a new paravirtualized device, you decided to use vsock to
>send MI commands from the guest to QEMU?
>
>> As the connection can be established by the guest VM at any point,
>> we have created a thread which is looking for a connection request.
>> Please suggest if there is a native/better way to handle this.
>
>QEMU has an event-driven architecture and uses threads sparingly. When
>it uses threads it uses qemu_create_thread() instead of
>pthread_create(), but I suggest using qemu_set_fd_handler() or a
>coroutine with QIOChannel to integrate into the QEMU event loop instead.
>
>I didn't see any thread synchronization, so I'm not sure if accessing
>NVMe state from the MI thread is safe. Changing the code to use QEMU's
>event loop can solve that problem since there's no separate thread.
>
vsock mimcs the sideband communication hence we used it. 
However we are working the smbus/i2c implementation for nvme-mi in 
qemu/nvme-cli, we will send the patch in few days. to communicate with 
nvme-mi over smbus/i2c, nvme-mi device needs to inherit from the i2c class 
which has callbacks for sending and recieving messages, this approach 
would get rid of the threads.

>> This module makes use of the NvmeCtrl structure of the nvme module,
>> to fetch relevant information of the nvme device which are used in
>> some of the mi commands. Eventhough certain commands might require
>> modification to the nvme module, currently we have currently refrained
>> from making changes to the nvme module.
>
>Why did you decide to implement -device nvme-mi as a device on
>TYPE_NVME_BUS? If the NVMe spec somehow requires this then I'm surprised
>that there's no NVMe bus interface (callbacks). It seems like this could
>just as easily be a property of an NVMe controller -device
>nvme,mi=on|off or -device nvme-subsys,mi=on|off? I'm probably just not
>familiar enough with MI and NVMe architecture...
>
>Stefan
since nvme communication happens over pcie and nvme-mi happens over
smbus/i2c nvme-mi cannot be a property of nvme rather it should be a separate
device which will be on the smbus/i2c.



------hb-dvdiRZtWrjeusMudXEerT0TTrvs-OGX_88iZ4NSx451yS=_122f68_
Content-Type: text/plain; charset="utf-8"


------hb-dvdiRZtWrjeusMudXEerT0TTrvs-OGX_88iZ4NSx451yS=_122f68_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------hb-dvdiRZtWrjeusMudXEerT0TTrvs-OGX_88iZ4NSx451yS=_122f68_--

