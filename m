Return-Path: <SRS0=0+fG=2Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8A3C3276C
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2020 00:23:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0117D222C3
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2020 00:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RbE+JNoD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GatwfDiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0117D222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hcrrRPwuvdTZqokmkIZw3p/o7CkyE9J/gLORih1TLL0=; b=RbE+JNoDcIU8wb
	OiA9qh44GFjrp1VC/PVXFnNoTQcPYgBnnUZp4BQCu+PhYgOE26TJ0YjylOU1Jpidg5WLMJ7+VnKp6
	zJ63+2LSCEiKIiOwvAL3AiSP8fDy0lV5RLGXUXTDfEzbYT6AbzxcLSeG1wYUSlM0UDsmpJFzFuDke
	oLxgF77o0WgS3dXF0tl8Sqwfn+wSGeAHh/A0rTUcVeOM4Ej7ax9+OBn+u5CG7aiMeUtXBNxc2PvT2
	CVA7l/AWPR2x9ZG3CcoOdzIaqHQ4FZvPO/8ecDxbK3nohvuTVQjMWbXvyXG3CHgc72K9QZ9Oq3OE6
	3fOVUm4K7rehm+WwlD0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1inAkT-0007xr-4O; Fri, 03 Jan 2020 00:23:29 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1inAkR-0007xP-2J
 for linux-nvme@lists.infradead.org; Fri, 03 Jan 2020 00:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1578011007; x=1609547007;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nxNZvIi52VletypUSupLtShqS3EDyEFQMmbPqmMqXZ8=;
 b=GatwfDiHpe91AYDXIq4zkcpInrPgLuBb42uIMkhQSI5EX/MpyiAeRbaw
 reWGMYWZvUkxkXeh6CJYniU916xrAma7TQd9aemiEUg+NgDMDr0UdNHd7
 dKsPhLv8C2AU4fgjSswAc1F/qADfVTs0l/KlkFHGXf87uD7J3ixdrOa6a M=;
IronPort-SDR: OD7PnJDvlniTzMV0V0Hj/1cIoEAOJpJQCZL8f6Wz3oOiOrbnPC9FRXpTKY/XKr6gCm4ZubRc2I
 ys6RXunBn6JA==
X-IronPort-AV: E=Sophos;i="5.69,388,1571702400"; d="scan'208";a="17920676"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 03 Jan 2020 00:23:14 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS
 id C518EA209A; Fri,  3 Jan 2020 00:23:11 +0000 (UTC)
Received: from EX13D11UWB001.ant.amazon.com (10.43.161.53) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 Jan 2020 00:23:11 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB001.ant.amazon.com (10.43.161.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 Jan 2020 00:23:10 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Fri, 3 Jan 2020 00:23:10 +0000
From: "Singh, Balbir" <sblbir@amazon.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Topic: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Index: AQHVwUG2bzD2dJjWXU+Xwn7M8hFup6fYFXCA
Date: Fri, 3 Jan 2020 00:23:10 +0000
Message-ID: <804eef7a517fb93f5bdc3986515bb8f2b845681f.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-6-sblbir@amazon.com>
 <BYAPR04MB57496B5D29688B7DA14F53DB86200@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB57496B5D29688B7DA14F53DB86200@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.133]
Content-ID: <02240C7601AC7C4CA288FB856F429E7A@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200102_162327_158523_A63DC7CD 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "Sangaraju,
 Someswarudu" <ssomesh@amazon.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2020-01-02 at 22:21 +0000, Chaitanya Kulkarni wrote:
> On 01/01/2020 11:53 PM, Balbir Singh wrote:
> > block/genhd provides disk_set_capacity() for sending
> > RESIZE notifications via uevents. This notification is
> > newly added to scsi sd.
> 
> nit :-
> 
> The above commit messages in this series are looking odd from
> the ones we have in the tree and is it possible to fold it in
> two lines ?
> 
> [Can be done at the time of applying series.]
> 

Sounds good! I'll request the maintainer or repost if needed

Balbir Singh.
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
